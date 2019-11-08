package com.mycom.service.base;

import com.mycom.mapper.ProductMapper;
import org.springframework.beans.factory.annotation.Autowired;

public abstract class ProductBaseServiceImpl<T> implements IProductBaseService<T> {

    //统一管理dao
    @Autowired
    protected ProductMapper productMapper;
}
