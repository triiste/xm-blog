package com.example.service;

import com.example.entity.Account;
import com.example.entity.Collect;
import com.example.mapper.CollectMapper;
import com.example.utils.TokenUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class CollectService {

    @Resource
    CollectMapper collectMapper;

    public void set(Collect collect) {
        //当前用户的ID
        Account currentUser = TokenUtils.getCurrentUser();
        collect.setUserId(currentUser.getId());
        //先看收藏过没有 没有就收藏 有就取消
        Collect dblCollect = collectMapper.selectUserCollect(collect);//查询用户有没有对当前数据进行点赞+
        if (dblCollect == null) {
            collectMapper.insert(collect);
        } else {
            collectMapper.deleteById(dblCollect.getId());
        }
    }

    /**
     * 查询当前博客是否收藏过 收藏过就显示亮一点
     */
    public Collect selectUserCollect(Integer fid, String module) {
        Account currentUser = TokenUtils.getCurrentUser();  //取当前用户
        Collect collect = new Collect();
        collect.setUserId(currentUser.getId());
        collect.setFid(fid);
        collect.setModule(module);
        return collectMapper.selectUserCollect(collect);
    }

    public int selectByFidAndModule(Integer fid, String module) {
        return collectMapper.selectByFidAndModule(fid, module);
    }

}
