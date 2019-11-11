package com.mycom.service.impl;

import com.mycom.model.Order;

import com.mycom.model.Product;
import com.mycom.service.base.OrderBaseServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;


@Service
@Transactional
public class OrderServiceImpl extends OrderBaseServiceImpl<Order> {

    @Override
    public String add(Order order) {
        Order orderOne = orderMapper.selectOne(order);
        if(orderOne==null){
            int i = orderMapper.add(order);
            return i == 0 ? "fail" : "success";
        }else {
            int i = orderMapper.update(order.getNum(), order.getUsername(), order.getPid());
            return i == 0 ? "fail" : "success";
        }

    }

    @Override
    public String update(Order order) {
        int i = orderMapper.update(order.getNum(), order.getUsername(), order.getPid());
        return i == 0 ? "fail" : "success";
    }

    @Override
    public String delete(String oid) {
        String[] array = oid.split(",");
        int i = orderMapper.delete(array);
        return i==0?"fail":"success";
    }

    @Override
    public String deleteAll(String username) {
        int i = orderMapper.deleteAll(username);
        return i==0?"fail":"success";
    }




}
