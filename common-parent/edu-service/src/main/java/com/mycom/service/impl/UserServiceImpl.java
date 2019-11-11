package com.mycom.service.impl;

import com.mycom.model.User;
import com.mycom.service.base.UserBaseServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class UserServiceImpl extends UserBaseServiceImpl<User> {

    @Override
    public User login(String username, String password) {
        User user = userMapper.login(username, password);
        return user;
    }

    @Override
    public String checkName(String username) {
        User user = userMapper.findOne(username);
        return user == null ? "false" : "true";
    }

    @Override
    public String register(User user) {
        int a = userMapper.add(user);
        return a == 0 ? "fail" : "success";
    }
}
