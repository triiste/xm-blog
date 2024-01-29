package com.example.mapper;

import com.example.entity.Comment;
import com.example.entity.ImSingle;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;


import java.util.List;


public interface ImSingleMapper{

	@Select("select * from imsingle where (fromuser = #{fromUser} and touser = #{toUser}) or (fromuser = #{toUser} and touser = #{fromUser})")
	List<ImSingle> findByUsername(@Param("fromUser") String fromUser, @Param("toUser")  String toUser);

	@Select("select * from imsingle where touser = #{toUser} and readed = 0")
	List<ImSingle> findByToUsername(@Param("toUser") String toUser);


	void insert(ImSingle imSingle);

	void update(ImSingle x);
}
