package com.controller.checkImg;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
@RequestMapping("/check")
public class CheckCodeController {
    @RequestMapping("/img")
    public void check(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String sessionCode = (String) session.getAttribute("authCode");
        System.out.println(sessionCode);
        String userCode = request.getParameter("code");
        //输出结果到前端
        response.getWriter().write(sessionCode.equalsIgnoreCase(userCode) ? "true" : "false");
    }
}
