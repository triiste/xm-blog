package com.example.mapper;

import com.example.entity.User;

public interface UserMapper {

    void insert(User user);

    User selectByUsername(String username);
}
