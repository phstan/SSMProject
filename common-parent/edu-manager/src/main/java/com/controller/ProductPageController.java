package com.controller;

import com.mycom.model.Category;
import com.mycom.model.PageBean;
import com.mycom.service.base.ICategoryBaseService;
import com.mycom.service.base.IProductBaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("page")
public class ProductPageController {

    @Autowired
    private IProductBaseService ps;
    @Autowired
    private ICategoryBaseService cs;

    @RequestMapping("product")
    public String pageProduct(HttpServletRequest request) {
        String cid = request.getParameter("cid");
        if(!(cid==null||cid=="")){
            int currentPage = 1;
            try {
                currentPage = Integer.parseInt(request.getParameter("currentPage"));
            } catch (Exception e) {

            }
            int currentCount = 12;
            PageBean pageBean = ps.forPage(cid, currentPage, currentCount);
            Category category = cs.findOne(cid);
            List<Category> categoryList = cs.allCategory();
            request.setAttribute("cid", cid);
            request.setAttribute("categoryList", categoryList);
            request.setAttribute("pageBean", pageBean);
            request.setAttribute("category", category);
            return "product_list";
        }else {
            String inputMeg = request.getParameter("inputMeg");
            String inputMegs = "%"+inputMeg+"%";
            int currentPage = 1;
            try {
                currentPage = Integer.parseInt(request.getParameter("currentPage"));
            } catch (Exception e) {
            }
            int currentCount = 12;
            PageBean pageBean = ps.forSearchPage(inputMegs, currentPage, currentCount);
            List<Category> categoryList = cs.allCategory();
            request.setAttribute("inputMeg",inputMeg);
            request.setAttribute("categoryList", categoryList);
            request.setAttribute("pageBean", pageBean);
            return "product_list";
        }

    }

}
