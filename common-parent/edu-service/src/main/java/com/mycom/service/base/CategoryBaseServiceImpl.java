package com.mycom.service.base;

import com.mycom.mapper.CategoryMapper;
import org.springframework.beans.factory.annotation.Autowired;

public abstract class CategoryBaseServiceImpl<T> implements ICategoryBaseService<T> {

    //统一管理dao
    @Autowired
    protected CategoryMapper categoryMapper;
}
