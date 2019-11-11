package com.mycom.mapper.base;

import com.mycom.model.Order;

public interface OrderBaseMapper<T> {

    public int add(Order oder);

    public T selectOne(Order oder);

    public int update(int num, String username, String pid);

    public int delete(String[] array);

    public int deleteAll(String username);


}
