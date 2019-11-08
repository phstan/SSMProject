package com.mycom.service.impl;

import com.mycom.model.PageBean;
import com.mycom.model.Product;
import com.mycom.service.base.ProductBaseServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class ProductServiceImpl extends ProductBaseServiceImpl<Product> {


    @Override
    public List<Product> hotProduct() {
        List<Product> hotProductList = productMapper.findHotProduct();
        return hotProductList;
    }

    @Override
    public List<Product> newProduct() {
        List<Product> newProductList = productMapper.findNewProduct();
        return newProductList;
    }

    @Override
    public PageBean forPage(String cid, int currentPage, int currentCount) {
        PageBean pageBean = new PageBean();
        //每页显示条数
        pageBean.setCurrentCount(currentCount);
        //总条数
        int totalCount = productMapper.findCategoryCount(cid);
        pageBean.setTotalCount(totalCount);
        //总页面数
        pageBean.setTotalPage();
        //当前页面
        pageBean.setCurrentPage(currentPage);
        //limit起始参数
        pageBean.setStartIndex();
        //product集合
        Map map = new HashMap();
        map.put("1",cid);
        map.put("2",pageBean.getStartIndex());
        map.put("3",pageBean.getCurrentCount());
        List<Product> productList = productMapper.findCategoryProduct(cid , pageBean.getStartIndex() , pageBean.getCurrentCount());
        pageBean.setProductList(productList);
        return pageBean;
    }

    @Override
    public Product findOne(String pid) {
        Product product = productMapper.findOneProduct(pid);
        return product;
    }

    @Override
    public List<Product> findCartAll(String username) {
        List<Product> productList = productMapper.findCartAll(username);
        for (int i = 0; i < productList.size(); i++) {
            productList.get(i).setSubtotal(productList.get(i).getShop_price()*productList.get(i).getNum());
        }
        return productList;
    }
}


