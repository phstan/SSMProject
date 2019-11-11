package com.mycom.service.base;

import com.mycom.model.Order;
import com.mycom.model.Product;

import java.util.List;

public interface IOrderBaseService<T> {
    public String add(Order order);

    public String update(Order order);

    public String delete(String oid);

    public String deleteAll(String username);


}
