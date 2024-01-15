package com.example.service;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONUtil;
import com.example.common.enums.LikesModuleEnum;
import com.example.common.enums.RoleEnum;
import com.example.entity.*;
import com.example.mapper.BlogMapper;
import com.example.mapper.UserMapper;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;

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
     * 删除
     */
    public void deleteById(Integer id) {
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
        User user = userService.selectById(blog.getUserId());
        List<Blog> userBlogList = blogMapper.selectUserBlog(user.getId());//查找出这个人的所有博客
        user.setBlogCount(userBlogList.size());
        //  当前用户收到的点赞和收藏的数据
        int userLikesCount = 0;
        int userCollectCount = 0;
        for (Blog b : userBlogList) {
            Integer fid = b.getId();
            int likesCount = likesService.selectByFidAndModule(fid, LikesModuleEnum.BLOG.getValue());
            userLikesCount += likesCount; //对这个人的每一篇博客进行累加

            int collectCount = collectService.selectByFidAndModule(fid, LikesModuleEnum.BLOG.getValue());
            userCollectCount += collectCount; //对这个人的每一篇收藏进行累加
        }
        user.setLikesCount(userLikesCount);
        user.setCollectCount(userCollectCount);


        blog.setUser(user);  // 设置作者信息
        // 查询当前博客的点赞数据
        int likesCount = likesService.selectByFidAndModule(id, LikesModuleEnum.BLOG.getValue());
        blog.setLikesCount(likesCount);
        Likes userLikes = likesService.selectUserLikes(id, LikesModuleEnum.BLOG.getValue()); //查询该博客-是否被当前用户点过赞
        blog.setUserLike(userLikes != null);

        // 查询当前博客的收藏数据
        int collectCount = collectService.selectByFidAndModule(id, LikesModuleEnum.BLOG.getValue());
        blog.setCollectCount(collectCount);
        Collect userCollect = collectService.selectUserCollect(id, LikesModuleEnum.BLOG.getValue());
        blog.setUserCollect(userCollect != null);

//        // 更新博客浏览数据
//        blog.setReadCount(blog.getReadCount() + 1);
//        this.updateById(blog);
        return blog;
    }

    /**
     * 查询所有
     */
    public List<Blog> selectAll(Blog blog) {
        return blogMapper.selectAll(blog);
    }

    /**
     * 分页查询
     */
    public PageInfo<Blog> selectPage(Blog blog, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Blog> list = blogMapper.selectAll(blog);
        for(Blog b:list){
            int likesCount = likesService.selectByFidAndModule(b.getId(), LikesModuleEnum.BLOG.getValue());
            b.setLikesCount(likesCount);
        }
        return PageInfo.of(list);
    }

    public List<Blog> selectTop() {

        List<Blog> blogList = this.selectAll(null);

        //这个是包含最多20个元素的新列表，这个列表中的元素按照阅读次数降序排列。 stream流中的Lambda 表达式降序
        blogList = blogList.stream().sorted((b1, b2) -> b2.getReadCount().compareTo(b1.getReadCount()))
                .limit(20)
                .collect(Collectors.toList());
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
            int likesCount = likesService.selectByFidAndModule(b.getId(), LikesModuleEnum.BLOG.getValue());
            b.setLikesCount(likesCount);
        });
        return blogSet;
    }

    public void updateReadCount(Integer blogId) {
        blogMapper.updateReadCount(blogId);
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
        Account currentUser = TokenUtils.getCurrentUser();
        if (RoleEnum.USER.name().equals(currentUser.getRole())) {
            blog.setUserId(currentUser.getId());
        }
        PageHelper.startPage(pageNum, pageSize);
        List<Blog> list = blogMapper.selectLike(blog);
        PageInfo<Blog> pageInfo = PageInfo.of(list);
        List<Blog> blogList = pageInfo.getList();
        for (Blog b : blogList) {
            int likesCount = likesService.selectByFidAndModule(b.getId(), LikesModuleEnum.BLOG.getValue());
            b.setLikesCount(likesCount);
        }
        return pageInfo;
    }

    public PageInfo<Blog> selectCollect(Blog blog, Integer pageNum, Integer pageSize) {
        Account currentUser = TokenUtils.getCurrentUser();
        if (RoleEnum.USER.name().equals(currentUser.getRole())) {
            blog.setUserId(currentUser.getId());
        }
        PageHelper.startPage(pageNum, pageSize);
        List<Blog> list = blogMapper.selectCollect(blog);
        PageInfo<Blog> pageInfo = PageInfo.of(list);
        List<Blog> blogList = pageInfo.getList();
        for (Blog b : blogList) {
            int likesCount = likesService.selectByFidAndModule(b.getId(), LikesModuleEnum.BLOG.getValue());
            b.setLikesCount(likesCount);
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
}