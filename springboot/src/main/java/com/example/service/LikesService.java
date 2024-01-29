package com.example.service;

import com.example.entity.Account;
import com.example.entity.Likes;
import com.example.mapper.LikesMapper;
import com.example.utils.TokenUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.SetOperations;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class LikesService {

    @Resource
    LikesMapper likesMapper;

    @Autowired
    private SetOperations setOperations;

    public static final String LIKE_KEY="LIKE_KEY";


    public void set(Likes likes) {


        //当前用户的ID
        Account currentUser = TokenUtils.getCurrentUser();
        likes.setUserId(currentUser.getId());

        String value = likes.getModule() + "::" + likes.getFid() +"::"+currentUser.getId();
        if(setOperations.isMember(LIKE_KEY,value)){  //点过赞就取消
            setOperations.remove(LIKE_KEY,value);
        }else{  //没点过就添加
            setOperations.add(LIKE_KEY,value);
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
