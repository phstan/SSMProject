package com.mycom.mapper.base;


import com.mycom.model.User;
import org.apache.ibatis.annotations.Param;

public interface UserBaseMapper<T> {
    public T login(@Param("username") String username, @Param("password") String password);
    public T findOne(String username);
    public int add(User user);

}
