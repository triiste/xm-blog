package com.example.service;

import cn.hutool.core.date.DateUtil;
import com.example.common.enums.RoleEnum;
import com.example.entity.Account;
import com.example.entity.Comment;
import com.example.entity.User;
import com.example.mapper.CommentMapper;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.awt.*;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 业务处理
 **/
@Service
public class CommentService {

    @Resource
    private CommentMapper commentMapper;

    /**
     * 新增
     */
    public void add(Comment comment) {
        Account currentUser = TokenUtils.getCurrentUser();
        if(RoleEnum.USER.name().equals(currentUser.getRole())){
            comment.setUserId(currentUser.getId());
        }
        comment.setTime(DateUtil.now());
        commentMapper.insert(comment); //先插入数据 拿到主键ID
        //如果没有传的话就是自己为rootid 传了的话不用更新
        if(comment.getRootId() ==null){
            comment.setRootId(comment.getId());
            commentMapper.updateById(comment);//自己把自己作为根节点 更新一下
        }
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        //删除这里要注意 是批量删除以该id为父结点的所有结点
        //先查询出以该id为父结点的所有结点
        List<Comment> commentList =  commentMapper.selectFatherNode(id);

        if(!commentList.isEmpty() ){
            for(Comment x:commentList){
                commentMapper.deleteById(x.getId());
            }
        }
        commentMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            commentMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Comment comment) {
        commentMapper.updateById(comment);
    }

    /**
     * 根据ID查询
     */
    public Comment selectById(Integer id) {
        return commentMapper.selectById(id);
    }

//    单独写一个方法 为前台用 查询一级的评论
    public List<Comment> selectForUser(Comment comment) {
        List<Comment> commentList = commentMapper.selectForUser(comment);  // 查询一级的评论
        for (Comment c : commentList) {  // 查询回复列表
            Comment param = new Comment();
            param.setRootId(c.getId());//这个节点相当于是根结点，所有的回复列表查出来
            //也会查出当前的id，把当前的id排除掉即可
            List<Comment> children = this.selectAll(param);
            children = children.stream().filter(child -> !child.getId().equals(c.getId())).collect(Collectors.toList());  // 排除当前查询结果里最外层节点
            c.setChildren(children);
        }
        return commentList;
    }


    /**
     * 查询所有
     */
    public List<Comment> selectAll(Comment comment) {
        return commentMapper.selectAll(comment);
    }

    /**
     * 分页查询
     */
    public PageInfo<Comment> selectPage(Comment comment, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Comment> list = commentMapper.selectAll(comment);
        return PageInfo.of(list);
    }

    public Integer selectCount(Integer fid, String module) {
        return commentMapper.selectCount(fid,module);
    }
}