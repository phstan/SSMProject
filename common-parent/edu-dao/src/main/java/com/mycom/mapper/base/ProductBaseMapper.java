package com.mycom.mapper.base;

import com.mycom.model.Product;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProductBaseMapper<T> {
    public List<T> findHotProduct();

    public List<T> findNewProduct();

    public int findCategoryCount(String cid);

    public List<T> findCategoryProduct(@Param("cid") String cid, @Param("startIndex") int startIndex, @Param("currentCount") int currentCount);

    public Product findOneProduct(String pid);

    public List<T> findCartAll(@Param("username") String username);

    public List<T> OfindOne(String[] array);

}
