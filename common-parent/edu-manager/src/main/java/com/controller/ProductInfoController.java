package com.controller;

import com.mycom.model.Category;
import com.mycom.model.Product;
import com.mycom.service.base.ICategoryBaseService;
import com.mycom.service.base.IProductBaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("info")
public class ProductInfoController {

    @Autowired
    private IProductBaseService ps;
    @Autowired
    private ICategoryBaseService cs;
    @RequestMapping("product")
    public String pageProduct(HttpServletRequest request){
        //返回pid对应的product对象
        String pid = request.getParameter("pid");
        Product product = ps.findOne(pid);
        //查询所有的类别
        List<Category> allCategory = cs.allCategory();
        //查询出该商品的类别的名字
        Category category = cs.findOne(product.getCid());
        request.setAttribute("categoryList", allCategory);
        request.setAttribute("product", product);
        request.setAttribute("category", category);
        return "product_info";
    }

}
