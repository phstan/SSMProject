package com.mycom.service.base;

import com.mycom.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;

public abstract class UserBaseServiceImpl<T> implements IUserBaseService<T> {

    //统一管理dao
    @Autowired
    protected UserMapper userMapper;
}
