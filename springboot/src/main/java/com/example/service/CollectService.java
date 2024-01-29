package com.example.service;

import com.example.entity.Account;
import com.example.entity.Collect;
import com.example.mapper.CollectMapper;
import com.example.utils.TokenUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.SetOperations;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class CollectService {

    @Resource
    CollectMapper collectMapper;

    @Autowired
    private SetOperations setOperations;

    public static final String COLLECT_KEY="COLLECT_KEY";

    public void set(Collect collect) {
        //当前用户的ID
        Account currentUser = TokenUtils.getCurrentUser();
        collect.setUserId(currentUser.getId());
        String value = collect.getModule() + "::" + collect.getFid() +"::"+currentUser.getId();
        if(setOperations.isMember(COLLECT_KEY,value)){
            setOperations.remove(COLLECT_KEY,value);
        }else{
            setOperations.add(COLLECT_KEY,value);
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
