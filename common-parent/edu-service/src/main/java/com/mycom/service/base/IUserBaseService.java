package com.mycom.service.base;

import com.mycom.model.User;

public interface IUserBaseService<T> {
    public User login(String username, String password);
    public String checkName(String username);
    public String register(User user);
}
