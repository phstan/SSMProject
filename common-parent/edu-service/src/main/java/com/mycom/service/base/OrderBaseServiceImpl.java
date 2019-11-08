package com.mycom.service.base;

import com.mycom.mapper.OrderMapper;
import org.springframework.beans.factory.annotation.Autowired;

public abstract class OrderBaseServiceImpl<T> implements IOrderBaseService<T> {

    //统一管理dao
    @Autowired
    protected OrderMapper orderMapper;
}
