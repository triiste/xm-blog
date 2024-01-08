package com.example.service;
import cn.hutool.core.util.ObjectUtil;
import com.example.common.Constants;
import com.example.common.enums.ResultCodeEnum;
import com.example.entity.User;
import com.example.exception.CustomException;
import com.example.mapper.UserMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class UserService {
    @Resource
    private UserMapper userMapper;
    public void add(User user){
        //业务方法
        //1.判断用户账户是否重复
        User dbUser = userMapper.selectByUsername(user.getUsername());
        if(dbUser !=null){
            throw new CustomException(ResultCodeEnum.USER_EXIST_ERROR);
        }
        //2.判断用户密码是不是空
        if(ObjectUtil.isEmpty(user.getPassword())) user.setPassword(Constants.USER_DEFAULT_PASSWORD);
                //3.判断用户名称是不是空
                //4.默认用户角色

        userMapper.insert(user);

    }
}
