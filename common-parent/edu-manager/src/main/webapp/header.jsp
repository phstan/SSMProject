<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<!-- 登录 注册 购物车... -->
<div class="container-fluid">
	<div class="col-md-4">
	</div>
	<div class="col-md-5">
		<img src="${pageContext.request.contextPath}/img/header.png" />
	</div>
	<div class="col-md-3" style="padding-top:20px">
		<ol class="list-inline">
			<c:if test="${session_username == null }">
				<li><a href="/head/login.do">登录</a></li>
				<li><a href="/head/register.do">注册</a></li>
			</c:if>
			<c:if test="${session_username != null }">
				<li>欢迎你:${session_username }</li>
				<li><a href="/head/login.do">注销</a></li>
			</c:if>
			<li><a href="/head/cart.do">购物车</a></li>
			<li><a href="/head/order_list.do">我的订单</a></li>
		</ol>
	</div>
</div>

<!-- 导航条 -->
<div class="container-fluid">
	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="/shop/index.do">首页</a>
			</div>

			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
				
					<c:forEach items="${categoryList}" var="category">
						<li><a href="/page/product.do?cid=${category.cid }">${category.cname}</a></li>
					</c:forEach>
					
				</ul>
				<form class="navbar-form navbar-right" role="search">
					<div class="form-group">
						<input type="text" class="form-control" placeholder="Search">
					</div>
					<button type="submit" class="btn btn-default">Submit</button>
				</form>
			</div>
		</div>
	</nav>
</div>