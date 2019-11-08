<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

  <!--   重定向到MainServlet中 
  		因为只有在Servlet中 才能查询数据库中的数据
  
  -->
<% response.sendRedirect(request.getContextPath() + "/shop/index.do") ; %>