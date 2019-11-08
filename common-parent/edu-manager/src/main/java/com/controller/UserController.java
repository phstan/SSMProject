package com.controller;

import com.mycom.model.User;
import com.mycom.service.base.IUserBaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.UUID;

@Controller
@RequestMapping("user")
public class UserController {

    @Autowired
    private IUserBaseService iu;

    @RequestMapping("login")
    public String login(@RequestParam(value = "username")String username,
                        @RequestParam(value = "password")String password,
                        HttpServletRequest request){
        boolean boo = iu.login(username, password);
        if (boo){
            request.getSession().setAttribute("session_username", username);
            return "redirect:/shop/index.do";
        }else {
            return "redirect:/login.jsp?message=login_error";
        }

    }
    @RequestMapping("checkName")
    public void checkName(String username, HttpServletResponse response) throws IOException {
        String result = iu.checkName(username);
        response.getWriter().write(result);
    }

    @RequestMapping("register")
    public String registerSure(User user){
        System.out.println(user);
        user.setUid(UUID.randomUUID().toString());
        user.setState(1);
        user.setCode(UUID.randomUUID().toString());
        String result = iu.register(user);
        if("success".equals(result)){
            return "redirect:/head/login.do";
        }else {
            return "redirect:/head/register.do";
        }

    }
}
