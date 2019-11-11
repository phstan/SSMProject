package com.controller;

import com.mycom.model.Category;
import com.mycom.model.Product;
import com.mycom.service.base.ICategoryBaseService;
import com.mycom.service.base.IProductBaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("head")
public class HeaderController {

    @Autowired
    private IProductBaseService ps;
    @Autowired
    private ICategoryBaseService cs;

    @RequestMapping("login")
    public String login(HttpServletRequest request){
        request.getSession().removeAttribute("session_username");
        return "login";
    }
    @RequestMapping("register")
    public String register(){
        return "register";
    }
    @RequestMapping("cart")
    public String cart(HttpServletRequest request){
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("session_username");

        List<Product> cartList = ps.findCartAll(username);
        request.setAttribute("cartList", cartList);
        int count = 0;
        for (int i = 0; i <cartList.size() ; i++) {
            count+=cartList.get(i).getSubtotal();
        }
        //获取商品种类
        List<Category> categoryList = cs.allCategory();
        request.setAttribute("count", count);
        request.setAttribute("categoryList", categoryList);
        return "cart";
    }
    @RequestMapping("order_list")
    public String order_list(){
        return "order_list";
    }
}
