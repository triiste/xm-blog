package com.example.mapper;

import com.example.entity.Activity;
import com.example.entity.ActivitySign;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * 操作activity相关数据接口
 */
public interface ActivityMapper {

    /**
     * 新增
     */
    int insert(Activity activity);

    /**
     * 删除
     */
    int deleteById(Integer id);

    /**
     * 修改
     */
    int updateById(Activity activity);

    /**
     * 根据ID查询
     */
    Activity selectById(Integer id);

    /**
     * 查询所有
     */
    List<Activity> selectAll(Activity activity);

    @Update("update activity set read_count = read_count+1 where id = #{activityId}")
    void updateReadCount(Integer activityId);

    List<Activity> selectUser(Activity activity);

    List<Activity> selectLike(Activity activity);

    List<Activity> selectCollect(Activity activity);

    List<Activity> selectComment(Activity activity);

    //查找这个活动的所有报名信息
    @Select("select * from activity_sign where activity_sign.activity_id = #{id}")
    List<ActivitySign> selectActivitySign(Integer id);
}