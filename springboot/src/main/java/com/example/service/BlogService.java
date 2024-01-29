package com.example.service;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.lang.TypeReference;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONUtil;
import com.example.common.enums.LikesModuleEnum;
import com.example.common.enums.RoleEnum;
import com.example.entity.*;
import com.example.mapper.BlogMapper;
import org.springframework.data.redis.core.SetOperations;

import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;


import org.springframework.data.redis.core.ZSetOperations;
import org.springframework.stereotype.Service;

import java.sql.SQLOutput;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 博客信息业务处理
 **/
@Service
public class BlogService {

    @Resource
    private BlogMapper blogMapper;

    @Resource
    UserService userService;

    @Resource
    LikesService likesService;
    @Resource
    CollectService collectService;

    @Autowired
    private ZSetOperations zSetOperations;

    @Autowired
    private SetOperations setOperations;



    public static final String BLOG_KEY = "BLOG_READCOUNT";
    public static final int TopN = 20;
    public static final String LIKE_KEY="LIKE_KEY";
    public static final String COLLECT_KEY="COLLECT_KEY";
    /**
     * 新增
     */
    public void add(Blog blog) {
        blog.setDate(DateUtil.today());
        Account currentUser = TokenUtils.getCurrentUser();
        if(RoleEnum.USER.name().equals(currentUser.getRole())){

            blog.setUserId(currentUser.getId());
        }
        blogMapper.insert(blog);

    }

    /**
     * 删除一个博客
     */
    public void deleteById(Integer id) {
        //删除博客前需要删除博客的阅读量
        zSetOperations.remove(BLOG_KEY,id);
//        System.out.println("删除成功了吗"+id+"-------------------------------------");
        //删除博客前需要删除博客的点赞
        removeRedisLike("博客",id,-1,LIKE_KEY);
        //删除博客前需要删除博客的收藏
        removeRedisLike("博客",id,-1,COLLECT_KEY);

        blogMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            blogMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Blog blog) {
        blogMapper.updateById(blog);
    }

    /**
     * 根据ID查询
     */
    public Blog selectById(Integer id) {
        Blog blog = blogMapper.selectById(id);
        User user = userService.selectById(blog.getUserId());//这个博客的主人
        //要用当前用户的id查询了
        Account currentUser = TokenUtils.getCurrentUser();

        List<Blog> userBlogList = blogMapper.selectUserBlog(user.getId());//查找出这个人的所有博客

        //  当前用户收到的点赞和收藏的数据
        int userLikesCount = 0;
        int userCollectCount = 0;
        for (Blog b : userBlogList) {
            Integer fid = b.getId();
            //查每一篇博客的点赞量和收藏量
            Integer likesCount = this.acquireLikeCount(b,LIKE_KEY);
            userLikesCount += likesCount; //对这个人的每一篇博客进行累加

            int collectCount =  this.acquireLikeCount(b,COLLECT_KEY);;
            userCollectCount += collectCount; //对这个人的每一篇收藏进行累加
        }
        //博客里嵌套人的文章点赞收藏
        user.setBlogCount(userBlogList.size());
        user.setLikesCount(userLikesCount);
        user.setCollectCount(userCollectCount);
        blog.setUser(user);  // 设置作者信息

//        注意以下内容都不写入mysql
        //设置点赞量
        blog.setLikesCount(this.acquireLikeCount(blog,LIKE_KEY));
        blog.setUserLike(this.isUserLike(blog.getId(),currentUser.getId(),"博客",LIKE_KEY));

        //设置收藏量
        blog.setCollectCount(this.acquireLikeCount(blog,COLLECT_KEY));
        blog.setUserCollect(this.isUserLike(blog.getId(),currentUser.getId(),"博客",COLLECT_KEY));

        //设置榜单阅读量
        Double score = zSetOperations.score(BLOG_KEY, blog.getId());
        int readCount = (score != null) ? score.intValue() : 0;

        blog.setReadCount(readCount);
        return blog;
    }

    /**
     * 查询所有
     */
    public List<Blog> selectAll(Blog blog) {
        return blogMapper.selectAll(blog);
    }

    //查找目标
    public static String findWordsAround(String input, String targetWord) {
        String[] words = input.split(""); // 拆分字符串为单个字符数组

        // 寻找目标词语的索引
        int targetIndex = input.indexOf(targetWord);
        if (targetIndex == -1) {
            return "未找到目标词语";
        }
        int startIndex = targetIndex -50;
        if(startIndex < 0) startIndex =0;
        int endIndex = targetIndex+200;
        // 构建结果字符串
        StringBuilder result = new StringBuilder();
        for (int i = startIndex; i < endIndex && i<words.length; i++) {
            result.append(words[i]);
        }

        return result.toString();
    }

    /**
     * 分页查询
     */
    public PageInfo<Blog> selectPage(Blog blog, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
//        System.out.println(blog.getTags());
        List<Blog> list = blogMapper.selectAll(blog);
        for(Blog b:list){
            //设置喜欢人数
            int likesCount = likesService.selectByFidAndModule(b.getId(), LikesModuleEnum.BLOG.getValue());
            b.setLikesCount(likesCount);
            Double score = zSetOperations.score(BLOG_KEY, b.getId());
            int readCount = (score != null) ? score.intValue() : 0;
            b.setReadCount(readCount);
        }
        if(!list.isEmpty() && blog.getContent() != null && !blog.getContent().isEmpty()   ){
//            System.out.println("进来了？");
//           说明根据内容了查找到了相应的博客
            for(Blog b:list){
                String result = findWordsAround(b.getContent(), blog.getContent());
                b.setDescr(result);
            }
        }
        return PageInfo.of(list);
    }
    //加入数据时候注意nulL不要加进来
    public List<Blog> selectTop() {
        List<Blog> blogList = new ArrayList<>();
        Long size = zSetOperations.size(BLOG_KEY);
        Set<Object> zset;
        if(size > TopN){
            zset = zSetOperations.reverseRange(BLOG_KEY, 0, TopN - 1);
        }else{
            zset = zSetOperations.reverseRange(BLOG_KEY, 0, - 1);
        }
        for(Object x:zset){
            Blog b = blogMapper.selectById((int)x);
            if(b != null)  blogList.add(b);
        }
        return blogList;
    }
    //设置推荐数据
    public Set<Blog> selectRecommend(Integer blogId) {
        Blog blog = this.selectById(blogId);
        String tags = blog.getTags();
        Set<Blog> blogSet = new HashSet<>();
        if(ObjectUtil.isNotEmpty(tags)){
            //查出所有博客数据
            List<Blog> bLogList = this.selectAll(null);
            JSONArray tagsArr = JSONUtil.parseArray(tags);
            for(Object tag:tagsArr){
                //筛选出其他包含当前博客标签的一个就行
                //去除当前博客
                Set<Blog> collect = bLogList.stream().filter(b -> b.getTags().contains(tags.toString()) && !blogId.equals(b.getId()))
                        .collect(Collectors.toSet());
                blogSet.addAll(collect); //自动去重
            }
            //包含 小白  包含 java 小白筛选了一趟 java筛选了一趟就可能重复
        }
         blogSet = blogSet.stream().limit(5).collect(Collectors.toSet());
         blogSet.forEach(b -> {
             //点赞量
             Integer likesCount = this.acquireLikeCount(b,LIKE_KEY);
             b.setLikesCount(likesCount);
             //阅读量
             Double score = zSetOperations.score(BLOG_KEY, b.getId());
             int readCount = (score != null) ? score.intValue() : 0;
             b.setReadCount(readCount);
        });
        return blogSet;
    }

    public void updateReadCount(Integer blogId) {
        zSetOperations.incrementScore(BLOG_KEY, blogId, 1);
//        blogMapper.updateReadCount(blogId); 不用在数据库更新了
    }

    public PageInfo<Blog> selectUser(Blog blog, Integer pageNum, Integer pageSize) {
        Account currentUser = TokenUtils.getCurrentUser();
        if(RoleEnum.USER.name().equals(currentUser.getRole())){
            blog.setUserId(currentUser.getId());
        }
        return this.selectPage(blog,pageNum,pageSize);
    }

    // 查询用户点赞的数据
    public PageInfo<Blog> selectLike(Blog blog, Integer pageNum, Integer pageSize) {
        Account currentUser = TokenUtils.getCurrentUser(); //当前用户
        PageHelper.startPage(pageNum, pageSize);

        List<Blog> list = this.userLikeBlogList(currentUser.getId(),LIKE_KEY);

        PageInfo<Blog> pageInfo = PageInfo.of(list);


        List<Blog> blogList = pageInfo.getList();
//        System.out.println(blogList.size());
        for (Blog b : blogList) {
            //点赞量
            Integer likesCount = this.acquireLikeCount(b,LIKE_KEY);
            b.setLikesCount(likesCount);
            //阅读量
            Double score = zSetOperations.score(BLOG_KEY, b.getId());
            int readCount = (score != null) ? score.intValue() : 0;
            b.setReadCount(readCount);
        }
        return pageInfo;
    }

    public PageInfo<Blog> selectCollect(Blog blog, Integer pageNum, Integer pageSize) {
        Account currentUser = TokenUtils.getCurrentUser();
        PageHelper.startPage(pageNum, pageSize);

        List<Blog> list = this.userLikeBlogList(currentUser.getId(),COLLECT_KEY);
        PageInfo<Blog> pageInfo = PageInfo.of(list);
        List<Blog> blogList = pageInfo.getList();
//        收藏总数
        for (Blog b : blogList) {
            int collectCount = this.acquireLikeCount(b,COLLECT_KEY);
            b.setCollectCount(collectCount);
            Double score = zSetOperations.score(BLOG_KEY, b.getId());
            int readCount = (score != null) ? score.intValue() : 0;
            b.setReadCount(readCount);
        }
        return pageInfo;
    }

    public PageInfo<Blog> selectComment(Blog blog, Integer pageNum, Integer pageSize) {
        Account currentUser = TokenUtils.getCurrentUser();
        if (RoleEnum.USER.name().equals(currentUser.getRole())) {
            blog.setUserId(currentUser.getId());
        }
        PageHelper.startPage(pageNum, pageSize);
        List<Blog> list = blogMapper.selectComment(blog);
        PageInfo<Blog> pageInfo = PageInfo.of(list);
        List<Blog> blogList = pageInfo.getList();
        for (Blog b : blogList) {
            int likesCount = likesService.selectByFidAndModule(b.getId(), LikesModuleEnum.BLOG.getValue());
            b.setLikesCount(likesCount);
        }
        return pageInfo;
    }


//    获取一个文章的 点赞或者收藏 数量
    public Integer acquireLikeCount(Blog blog,String KEY){

        int Count = 0;
        Set<String>  set = setOperations.members(KEY);
        for(String x :set){
            String[] parts = x.split("::");
            String name = parts[0];
            int blogId = Integer.parseInt(parts[1]);
            if(name.equals("博客") && blogId == blog.getId()) Count++;

        }
       return Count;
    }

// 获取当前用户是否点过赞或者收藏过
    public boolean isUserLike(int blogId,int userId,String module,String KEY){
        String value = module + "::" + blogId + "::"+ userId;
        if(setOperations.isMember(KEY,value)) return true;
        else return false;

    }
    //按照日期降序排序
    public static void sortByDate(List<Blog> blogList) {
        Collections.sort(blogList, new Comparator<Blog>() {
            @Override
            public int compare(Blog blog1, Blog blog2) {
                return blog2.getDate().compareTo(blog1.getDate());
            }
        });
    }

    //获取一个人的点赞列表或者收藏列表
    public List<Blog> userLikeBlogList(int userid,String KEY){
        Set<String>  set = setOperations.members(KEY);
        List<Blog> blogList = new ArrayList<Blog>();
        for(String x :set){
            String[] parts = x.split("::");
            String name = parts[0];
            int userId = Integer.parseInt(parts[2]);
            int blogId = Integer.parseInt(parts[1]);
            if(name.equals("博客") && userId == userid) {
                Blog b = blogMapper.selectById(blogId);
                if(b!=null)  blogList.add(b);
            }
        }
        sortByDate(blogList);
        return blogList;
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