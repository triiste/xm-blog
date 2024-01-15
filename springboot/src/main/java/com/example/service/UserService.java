package com.example.service;
import cn.hutool.core.util.ObjectUtil;
import com.example.common.Constants;
import com.example.common.enums.ResultCodeEnum;
import com.example.common.enums.RoleEnum;
import com.example.entity.Account;
import com.example.entity.Admin;
import com.example.entity.User;
import com.example.exception.CustomException;
import com.example.mapper.UserMapper;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

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
        if(ObjectUtil.isEmpty(user.getName())) {
            user.setName(user.getUsername());
        }

        //4.默认用户角色
        user.setRole(RoleEnum.USER.name());

        userMapper.insert(user);


    }

    public void deleteById(Integer id) {
        userMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for(Integer id:ids){
            this.deleteById(id);
        }
    }

    public void updateById(User user) {
        userMapper.updateById(user);
    }

    public User selectById(Integer id) {

        return userMapper.selectById(id);
    }

    public List<User> selectAll(User user) {
        return userMapper.selectAll(user);
    }

    public PageInfo<User> selectPage(User user, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<User> list = userMapper.selectAll(user);
        return PageInfo.of(list);
    }

    public Account login(Account account) {
        Account dbUser = userMapper.selectByUsername(account.getUsername());
        if (ObjectUtil.isNull(dbUser)) { //判断是否为空
            throw new CustomException(ResultCodeEnum.USER_NOT_EXIST_ERROR); //为空输出用户不存在
        }
        if (!account.getPassword().equals(dbUser.getPassword())) { //对比密码是否正确
            throw new CustomException(ResultCodeEnum.USER_ACCOUNT_ERROR); //密码错误
        }
        //  //在登录的过程中生成了token,登录放行token
        String tokenData = dbUser.getId() + "-" + RoleEnum.USER.name();
        String token = TokenUtils.createToken(tokenData, dbUser.getPassword());
        dbUser.setToken(token);
        return dbUser;
    }


    /**
     * 注册
     */
    public void register(Account account) {
        User user = new User();
        BeanUtils.copyProperties(account, user);
        this.add(user);
    }

    /**
     * 修改密码
     */
    public void updatePassword(Account account) {
        User dbUser = userMapper.selectByUsername(account.getUsername());
        if (ObjectUtil.isNull(dbUser)) {
            throw new CustomException(ResultCodeEnum.USER_NOT_EXIST_ERROR);
        }
//        判断原始密码是否一致
        if (!account.getPassword().equals(dbUser.getPassword())) {
            throw new CustomException(ResultCodeEnum.PARAM_PASSWORD_ERROR);
        }
        dbUser.setPassword(account.getNewPassword());
        this.updateById(dbUser);
    }
}
