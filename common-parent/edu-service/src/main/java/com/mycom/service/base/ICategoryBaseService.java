package com.mycom.service.base;

import com.mycom.model.Category;

import java.util.List;

public interface ICategoryBaseService<T> {
    public List<T> allCategory();
    public Category findOne(String cid);
}
