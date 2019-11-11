package com.controller;

import com.mycom.model.Category;
import com.mycom.model.Order;
import com.mycom.model.Product;
import com.mycom.service.base.ICategoryBaseService;
import com.mycom.service.base.IOrderBaseService;
import com.mycom.service.base.IProductBaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("shop")
public class ShopController {

    @Autowired
    private IProductBaseService ps;
    @Autowired
    private ICategoryBaseService cs;
    @Autowired
    private IOrderBaseService io;

    @RequestMapping("index")
    public String login(HttpServletRequest request) {
        List<Category> categoryList = cs.allCategory();
        List<Product> hotList = ps.hotProduct();
        List<Product> newList = ps.newProduct();
        request.setAttribute("categoryList", categoryList);
        request.setAttribute("hotList", hotList);
        request.setAttribute("newList", newList);
        return "main";
    }

    @RequestMapping("addCart")
    public String addCart(Order order, HttpServletRequest request) {
        order.setUsername((String) request.getSession().getAttribute("session_username"));
        String result = io.add(order);
        return "redirect:/head/cart.do";
    }

    @RequestMapping("updateCart")
    public String updateCart(Order order, HttpServletRequest request) {
        order.setUsername((String) request.getSession().getAttribute("session_username"));
        String result = io.update(order);
        return "redirect:/head/cart.do";
    }

    @RequestMapping("deleteCart")
    public String deleteCart(String oid) {
        String result = io.delete(oid);
        return "redirect:/head/cart.do";
    }

    @RequestMapping("deleteALLCart")
    public String deleteALLCart(HttpServletRequest request) {
        String username = (String) request.getSession().getAttribute("session_username");
        String result = io.deleteAll(username);
        return "redirect:/head/cart.do";
    }

    @RequestMapping("findOrder")
    public String findOrder(String oid, HttpServletRequest request) {
        List<Product> OList= ps.OfindOne(oid);
        List<Category> categoryList = cs.allCategory();
        request.setAttribute("categoryList", categoryList);
        request.setAttribute("OList",OList);
        System.out.println(OList);
        return"order_info";
    }

}
