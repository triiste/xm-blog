package com.example.service;

import cn.hutool.core.lang.Dict;
import com.example.entity.ImSingle;
import com.example.mapper.ImSingleMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class ImSingleService {

    @Resource
    private ImSingleMapper imSingleMapper;

    public ImSingle add(ImSingle imSingle) {
        //
        imSingleMapper.insert(imSingle);//动态sql插入
        return imSingle;
    }
    public List<ImSingle> findByUsername(String fromUser, String toUser) {
        //查询出两者的所有对话
        List<ImSingle> list = imSingleMapper.findByUsername(fromUser, toUser);

        list.forEach(x -> {
            if (x.getTouser().equals(fromUser) && x.getFromuser().equals(toUser)) {
                x.setReaded(1);//目标用户等于源用户，同时源用户等于目标用户设置为已读 更新到x
                imSingleMapper.update(x);
            }
        });
        return list;
    }

    public Dict findUnReadNums(String toUsername) {
        //设置未读数量
        List<ImSingle> list = imSingleMapper.findByToUsername(toUsername); //到目标用户的所有未读记录

        Map<String, List<ImSingle>> collect = list.stream().collect(Collectors.groupingBy(ImSingle::getFromuser));//根据用户id分类
        Dict dict = Dict.create();
        collect.forEach((k,v) -> dict.set(k, v.size()));//每个人的未读数量
        return dict;
    }
}