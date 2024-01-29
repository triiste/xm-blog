package com.example.service;

import cn.hutool.core.date.DateUtil;
import com.example.common.enums.LikesModuleEnum;
import com.example.common.enums.RoleEnum;
import com.example.entity.*;
import com.example.mapper.ActivityMapper;
import com.example.mapper.ActivitySignMapper;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.SetOperations;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 活动业务处理
 **/
@Service
public class ActivityService {

    @Autowired
    private SetOperations setOperations;

    @Resource
    private ActivityMapper activityMapper;

    @Resource
    ActivitySignService activitySignService;

    @Resource
    LikesService likesService;

    @Resource
    CollectService collectService;

    @Resource
    ActivitySignMapper activitySignMapper;


    public static final String LIKE_KEY="LIKE_KEY";
    public static final String COLLECT_KEY="COLLECT_KEY";
    /**
     * 新增
     */
    public void add(Activity activity) {
        activityMapper.insert(activity);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {

        //删除活动前需要删除活动的点赞
        removeRedisLike("活动",id,-1,LIKE_KEY);
        //删除活动前需要删除活动的收藏
        removeRedisLike("活动",id,-1,COLLECT_KEY);

        //删除用户报名的信息
        //删除这个用户的所有活动报名信息
        List<ActivitySign> activitySigns = this.selectActivityAllSign(id);
        for(ActivitySign acs: activitySigns) activitySignMapper.deleteById(acs.getId());
        activityMapper.deleteById(id);
    }

    private List<ActivitySign> selectActivityAllSign(Integer id) {
        return activityMapper.selectActivitySign(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            activityMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Activity activity) {
        activityMapper.updateById(activity);
    }

    /**
     * 根据ID查询
     */
    public Activity selectById(Integer id) {
        Activity activity = activityMapper.selectById(id);
        this.setAct(activity, TokenUtils.getCurrentUser());
        //要用当前用户的id查询了
        Account currentUser = TokenUtils.getCurrentUser();

        int likesCount = likesService.selectByFidAndModule(id, LikesModuleEnum.ACTIVITY.getValue());
        int collectCount = collectService.selectByFidAndModule(id, LikesModuleEnum.ACTIVITY.getValue());
        activity.setLikesCount(likesCount);
        activity.setCollectCount(collectCount);

        Likes likes = likesService.selectUserLikes(id, LikesModuleEnum.ACTIVITY.getValue());
        activity.setIsLike(likes != null);

        Collect collect = collectService.selectUserCollect(id, LikesModuleEnum.ACTIVITY.getValue());
        activity.setIsCollect(collect != null);


        //设置点赞量
        activity.setLikesCount(this.acquireLikeCount(activity,LIKE_KEY));
        activity.setIsLike(this.isUserLike(activity.getId(),currentUser.getId(),"活动",LIKE_KEY));

        //设置收藏量
        activity.setCollectCount(this.acquireLikeCount(activity,COLLECT_KEY));
        activity.setIsCollect(this.isUserLike(activity.getId(),currentUser.getId(),"活动",COLLECT_KEY));
        return activity;
    }

    /**
     * 查询所有
     */
    public List<Activity> selectAll(Activity activity) {
        return  activityMapper.selectAll(activity);
    }

    /**
     * 分页查询
     */
    public PageInfo<Activity> selectPage(Activity activity, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Activity> list = activityMapper.selectAll(activity);
        PageInfo<Activity> pageInfo = PageInfo.of(list);
        List<Activity> activityList = pageInfo.getList();
        Account currentUser = TokenUtils.getCurrentUser();
        for(Activity act:activityList){
            this.setAct(act,currentUser);
        }
        return pageInfo;
    }
    //设置活动额外信息
    private void setAct(Activity act,Account currentUser){
        act.setIsEnd(DateUtil.parseDate(act.getEnd()).isBefore(new Date())); //活动结束时间在当前时间之前就表示结束了
        ActivitySign activitySign = activitySignService.selectByActivityIdAndUserId(act.getId(),currentUser.getId());
        act.setIsSign(activitySign != null);
    }

    /**
     * 热门活动
     */
    public List<Activity> selectTop() {
        List<Activity> activityList = this.selectAll(null);
        activityList = activityList.stream().sorted((b1, b2) -> b2.getReadCount().compareTo(b1.getReadCount()))
                .limit(2)
                .collect(Collectors.toList());
        return activityList;
    }

    public void updateReadCount(Integer activityId) {
        activityMapper.updateReadCount(activityId);
    }

    // 查询出用户报名的活动列表
    public PageInfo<Activity> selectUser(Activity activity, Integer pageNum, Integer pageSize) {
        Account currentUser = TokenUtils.getCurrentUser();
        if (RoleEnum.USER.name().equals(currentUser.getRole())) {
            activity.setUserId(currentUser.getId());
        }
        PageHelper.startPage(pageNum, pageSize);
        List<Activity> list = activityMapper.selectUser(activity);
        PageInfo<Activity> pageInfo = PageInfo.of(list);
        List<Activity> activityList = pageInfo.getList();
        for (Activity act : activityList) {
            this.setAct(act, currentUser);
        }
        return pageInfo;
    }

    public PageInfo<Activity> selectLike(Activity activity, Integer pageNum, Integer pageSize) {
        Account currentUser = TokenUtils.getCurrentUser();
        if (RoleEnum.USER.name().equals(currentUser.getRole())) {
            activity.setUserId(currentUser.getId());
        }
        PageHelper.startPage(pageNum, pageSize);
        List<Activity> list = this.userLikeActicityList(currentUser.getId(),LIKE_KEY);
        PageInfo<Activity> pageInfo = PageInfo.of(list);
        List<Activity> activityList = pageInfo.getList();
        for (Activity act : activityList) {
            int likesCount = this.acquireLikeCount(act,LIKE_KEY);
            act.setLikesCount(likesCount);
        }
        return pageInfo;
    }

    public PageInfo<Activity> selectCollect(Activity activity, Integer pageNum, Integer pageSize) {
        Account currentUser = TokenUtils.getCurrentUser();
        if (RoleEnum.USER.name().equals(currentUser.getRole())) {
            activity.setUserId(currentUser.getId());
        }
        PageHelper.startPage(pageNum, pageSize);
        List<Activity> list = this.userLikeActicityList(currentUser.getId(),COLLECT_KEY);
        PageInfo<Activity> pageInfo = PageInfo.of(list);
        List<Activity> activityList = pageInfo.getList();
        for (Activity act : activityList) {
            int collectCount = this.acquireLikeCount(act,COLLECT_KEY);
            act.setCollectCount(collectCount);
        }
        return pageInfo;
    }

    public PageInfo<Activity> selectComment(Activity activity, Integer pageNum, Integer pageSize) {
        Account currentUser = TokenUtils.getCurrentUser();
        if (RoleEnum.USER.name().equals(currentUser.getRole())) {
            activity.setUserId(currentUser.getId());
        }
        PageHelper.startPage(pageNum, pageSize);
        List<Activity> list = activityMapper.selectComment(activity);
        PageInfo<Activity> pageInfo = PageInfo.of(list);
        List<Activity> activityList = pageInfo.getList();
        for (Activity act : activityList) {
            this.setAct(act, currentUser);
        }
        return pageInfo;
    }


    //    获取一个活动的 点赞或者收藏 数量
    public int acquireLikeCount(Activity activity,String KEY){
        int Count = 0;
        Set<String> set = setOperations.members(KEY);
        for(String x :set){
            String[] parts = x.split("::");
            String name = parts[0];
            int activityId = Integer.parseInt(parts[1]);
            if(name.equals("活动") && activityId == activity.getId()) Count++;
        }
        return Count;
    }

    // 获取当前活动是否点过赞或者收藏过
    public boolean isUserLike(int activityId,int userId,String module,String KEY){
        String value = module + "::" + activityId + "::"+ userId;
        if(setOperations.isMember(KEY,value)) return true;
        else return false;

    }
    //按照日期降序排序
    public static void sortByDate(List<Activity> activityList) {
        Collections.sort(activityList, new Comparator<Activity>() {
            @Override
            public int compare(Activity activity1, Activity activity2) {
                return activity2.getStart().compareTo(activity1.getStart());
            }
        });
    }

    //获取一个人的点赞列表或者收藏列表
    public List<Activity> userLikeActicityList(int userid,String KEY){
        Set<String>  set = setOperations.members(KEY);

        List<Activity> activityList = new ArrayList<Activity>();
        for(String x :set){
            String[] parts = x.split("::");
            String name = parts[0];
            int userId = Integer.parseInt(parts[2]);
            int activityId = Integer.parseInt(parts[1]);
            if(name.equals("活动") && userId == userid)  activityList.add(activityMapper.selectById(activityId));
        }
        sortByDate(activityList);
        return activityList;
    }



    //删除redis的点赞数据
    public void removeRedisLike(String name,int typeId,int userId,String type){
        //说明是根据人删除
        if(typeId == -1){
            Set<String> set = setOperations.members(type);
            for(String x:set){
                String [] parts = x.split("::");
                String namex  = parts[0];
                int userid = Integer.parseInt(parts[2]);
                if(namex.equals(name) && userid == userId){
                    setOperations.remove(type,x);
                }
            }
        }
        //根据活动或者博客删除
        if(userId == -1){
            Set<String> setType = setOperations.members(type);
            System.out.println(setType);
            for(String x:setType){
                String [] parts = x.split("::");
                String nameActivity  = parts[0];
                int typeid = Integer.parseInt(parts[1]);
                if(nameActivity.equals(name) && typeid == typeId){
                    setOperations.remove(type,x);
                }
            }
        }
    }
}