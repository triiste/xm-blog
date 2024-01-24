package com.example.service;

import com.example.entity.Account;
import com.example.entity.Likes;
import com.example.mapper.LikesMapper;
import com.example.utils.TokenUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class LikesService {

    @Resource
    LikesMapper likesMapper;

    public void set(Likes likes) {
        //当前用户的ID
        Account currentUser = TokenUtils.getCurrentUser();
        likes.setUserId(currentUser.getId());
        //先看点过赞没有 没有就点赞 有就取消
        Likes dblLikes = likesMapper.selectUserLikes(likes);//查询用户有没有对当前数据进行点赞+
        //先取出来没点过赞就点一下
        //点过赞就删除一下 操作两次数据库
        if (dblLikes == null) {
            likesMapper.insert(likes);
        } else {
            likesMapper.deleteById(dblLikes.getId());
        }
    }

    /**
     * 查询当前用户是否点过赞  这个是作为我赞过的博客使用的
     */
    public Likes selectUserLikes(Integer fid, String module) {
        Account currentUser = TokenUtils.getCurrentUser();  //取当前用户
        Likes likes = new Likes();
        likes.setUserId(currentUser.getId());
        likes.setFid(fid);
        likes.setModule(module);
        return likesMapper.selectUserLikes(likes);
    }

    public int selectByFidAndModule(Integer fid, String module) {
        return likesMapper.selectByFidAndModule(fid, module);
    }

}
