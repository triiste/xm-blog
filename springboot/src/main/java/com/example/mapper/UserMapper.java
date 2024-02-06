package com.example.mapper;

import com.example.entity.ActivitySign;
import com.example.entity.Comment;
import com.example.entity.User;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface UserMapper {

    void insert(User user);

    User selectByUsername(String username);

    void deleteById(Integer id);

    void updateById(User user);

    User selectById(Integer id);

    List<User> selectAll(User user);

    //查找这个用户的所有评论
    @Select("select * from comment where comment.user_id = #{id}")
    List<Comment> selectUserAllComment(@Param("id") Integer id);
    //查找这个用户的所有报名信息
    @Select("select * from activity_sign where activity_sign.user_id = #{id}")
    List<ActivitySign> selectUserAllSign(@Param("id") Integer id);

    @Select("select * from user")
    List<User> selectAllonline();
}
