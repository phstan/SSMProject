package com.mycom.service.impl;

import com.mycom.model.Category;
import com.mycom.service.base.CategoryBaseServiceImpl;
import com.mycom.service.base.ICategoryBaseService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class CategoryServiceImpl extends CategoryBaseServiceImpl<Category> {

    @Override
    public List<Category> allCategory() {
        List<Category> categoryList = categoryMapper.findAll();
        return categoryList;
    }

    @Override
    public Category findOne(String cid) {
        Category category = categoryMapper.findOne(cid);
        return category;
    }
}
