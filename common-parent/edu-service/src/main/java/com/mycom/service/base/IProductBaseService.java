package com.mycom.service.base;

import com.mycom.model.PageBean;
import com.mycom.model.Product;

import java.util.List;

public interface IProductBaseService<T> {
    public List<T> hotProduct();
    public List<T> newProduct();
    public PageBean forPage(String cid, int currentPage, int currentCount);
    public PageBean forSearchPage(String inputMeg, int currentPage, int currentCount);
    public Product findOne(String pid);
    public List<T> findCartAll(String username);
    public List<Product> OfindOne(String oid);
}
