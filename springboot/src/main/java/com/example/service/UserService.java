package com.example.service;
import cn.hutool.core.util.ObjectUtil;
import com.example.common.Constants;
import com.example.common.enums.ResultCodeEnum;
import com.example.common.enums.RoleEnum;
import com.example.entity.*;
import com.example.exception.CustomException;
import com.example.mapper.*;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.SetOperations;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Service
public class UserService {
    @Resource
    private UserMapper userMapper;

    @Autowired
    private SetOperations setOperations;
    @Resource
    private CommentMapper commentMapper;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Resource
    private BlogMapper blogMapper;

    @Resource
    private ImSingleMapper imSingleMapper;

    @Resource
    ActivitySignMapper activitySignMapper;

    public static final String LIKE_KEY="LIKE_KEY";
    public static final String COLLECT_KEY="COLLECT_KEY";

    public void add(User user){
        //业务方法
        //1.判断用户账户是否重复
        User dbUser = userMapper.selectByUsername(user.getUsername());
        if(dbUser !=null){
            throw new CustomException(ResultCodeEnum.USER_EXIST_ERROR);
        }

        //2.判断用户密码是不是空
        if(ObjectUtil.isEmpty(user.getPassword())) user.setPassword(Constants.USER_DEFAULT_PASSWORD);

        //3.判断用户名称是不是空
        if(ObjectUtil.isEmpty(user.getName())) {
            user.setName(user.getUsername());
        }

        //4.默认用户角色
        user.setRole(RoleEnum.USER.name());

        userMapper.insert(user);


    }

    public void deleteById(Integer id) {
        //删除用户的所有点赞收藏数据
        removeRedisLike("博客",-1,id,LIKE_KEY);
        removeRedisLike("博客",-1,id,COLLECT_KEY);
        removeRedisLike("活动",-1,id,LIKE_KEY);
        removeRedisLike("活动",-1,id,COLLECT_KEY);
        //查询出这个用户的所有博客 进行删除
        Blog blog =new Blog();blog.setUserId(id);
        List<Blog> list = blogMapper.selectAll(blog);
        for(Blog b:list) blogMapper.deleteById(b.getId());
        //查询出这个用户的所有评论 进行删除
        List<Comment> commentList = this.selectUserAllComment(id);
        for(Comment com:commentList) commentMapper.deleteById(com.getId());

        //删除这个用户的所有活动报名信息
        List<ActivitySign> activitySigns = this.selectUserAllSign(id);
        for(ActivitySign acs: activitySigns) activitySignMapper.deleteById(acs.getId());




        userMapper.deleteById(id);
    }

    private List<ActivitySign> selectUserAllSign(Integer id) {
        return userMapper.selectUserAllSign(id);
    }

    private List<Comment> selectUserAllComment(Integer id) {
        return userMapper.selectUserAllComment(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for(Integer id:ids){
            this.deleteById(id);
        }
    }

    public void updateById(User user) {
        userMapper.updateById(user);
    }

    public User selectById(Integer id) {

        return userMapper.selectById(id);
    }
    public List<User> selectAll(User user) {
        return userMapper.selectAll(user);
    }
    public List<User> selectAllOnline(String userId) {
//        System.out.println("在线ID"+userId);
        List<User> userList = userMapper.selectAllonline();
        List<User> userLastMessage = new ArrayList<>();//最后信息的
        List<User> userOther = new ArrayList<>();//其他用户
        List<Integer> lastMessageUser = imSingleMapper.selectLastMessage(userId);//按照这个顺序排列
        for(int i=0;i<lastMessageUser.size();i++){
            User user = userMapper.selectById(lastMessageUser.get(i));
            if(user != null)
            userLastMessage.add(user);
        }

        // 找出 userList 中不在 lastMessageUser 中的元素，然后添加到 userOther 中
        for (User user : userList) {
            if (!lastMessageUser.contains(user.getId())) {
                userOther.add(user);
            }
        }
        userList.clear();
        userList.addAll(userLastMessage);
        userList.addAll(userOther);

        //评论区查到了但是人被删除了
        for(int i=0;i<userList.size();i++){
            String key = Integer.toString(userList.get(i).getId());
            String value = stringRedisTemplate.opsForValue().get(key);
            if(value != null){
                String info = "在线";
                userList.get(i).setInfo(info);
            }else{
                String info = "离线";
                userList.get(i).setInfo(info);
            }
        }

//        System.out.println(userList);
        return userList;
    }

    public PageInfo<User> selectPage(User user, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<User> list = userMapper.selectAll(user);
        return PageInfo.of(list);
    }

    public Account login(Account account) {
        Account dbUser = userMapper.selectByUsername(account.getUsername());
        if (ObjectUtil.isNull(dbUser)) { //判断是否为空
            throw new CustomException(ResultCodeEnum.USER_NOT_EXIST_ERROR); //为空输出用户不存在
        }
        if (!account.getPassword().equals(dbUser.getPassword())) { //对比密码是否正确
            throw new CustomException(ResultCodeEnum.USER_ACCOUNT_ERROR); //密码错误
        }
        //  //在登录的过程中生成了token,登录放行token
        String tokenData = dbUser.getId() + "-" + RoleEnum.USER.name();
        String token = TokenUtils.createToken(tokenData, dbUser.getPassword());
        dbUser.setToken(token);
        return dbUser;
    }


    /**
     * 注册
     */
    public void register(Account account) {
        User user = new User();
        BeanUtils.copyProperties(account, user);
        this.add(user);
    }

    /**
     * 修改密码
     */
    public void updatePassword(Account account) {
        User dbUser = userMapper.selectByUsername(account.getUsername());
        if (ObjectUtil.isNull(dbUser)) {
            throw new CustomException(ResultCodeEnum.USER_NOT_EXIST_ERROR);
        }
//        判断原始密码是否一致
        if (!account.getPassword().equals(dbUser.getPassword())) {
            throw new CustomException(ResultCodeEnum.PARAM_PASSWORD_ERROR);
        }
        dbUser.setPassword(account.getNewPassword());
        this.updateById(dbUser);
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
