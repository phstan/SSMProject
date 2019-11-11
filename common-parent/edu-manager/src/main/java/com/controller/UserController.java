package com.controller;

import com.mycom.model.User;
import com.mycom.service.base.IUserBaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

@Controller
@RequestMapping("user")
public class UserController {

    @Autowired
    private IUserBaseService iu;

    @RequestMapping("login")
    public String login(@RequestParam(value = "username") String username,
                        @RequestParam(value = "password") String password,
                        HttpServletRequest request) {
        User user = iu.login(username, password);
        if (user!=null) {
            request.getSession().setAttribute("imgPath", user.getImgPath());
            request.getSession().setAttribute("session_username", username);
            return "redirect:/shop/index.do";
        } else {
            return "redirect:/login.jsp?message=login_error";
        }

    }

    @RequestMapping("checkName")
    public void checkName(String username, HttpServletResponse response) throws IOException {
        String result = iu.checkName(username);
        response.getWriter().write(result);
    }

    @RequestMapping("/registerSure")
    public String registerSure(@RequestParam("upload") CommonsMultipartFile partFile, User user) throws IOException {
        String filePath = "F:\\JAVA\\SSMProject\\EduProject2\\common-parent\\edu-manager\\src\\main\\webapp\\upload";//保存图片的路径
        //获取原始图片的拓展名
        String originalFilename = partFile.getOriginalFilename();
        //新的文件名字
        String newFileName = UUID.randomUUID() + originalFilename;
        //封装上传文件位置的全路径
        File targetFile = new File(filePath, newFileName);
        //把本地文件上传到封装上传文件位置的全路径
        partFile.transferTo(targetFile);
        user.setImgPath(newFileName);
        user.setUid(UUID.randomUUID().toString());
        user.setState(1);
        user.setCode(UUID.randomUUID().toString());
        String result = iu.register(user);
        if ("success".equals(result)) {
            return "redirect:/head/login.do";
        } else {
            return "redirect:/head/register.do";
        }

    }
}
