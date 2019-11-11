<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta name="view	port" content="width=device-width, initial-scale=1">
<title>会员登录</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css" />
<script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
<!-- 引入自定义css文件 style.css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css" />

<style>
body {
	margin-top: 20px;
	margin: 0 auto;
	width: 100%;
}

.carousel-inner .item img {
	width: 100%;
	height: 300px;
}
</style>
</head>

<body>


	<!-- 引入header.jsp -->
	<jsp:include page="/header.jsp"></jsp:include>


	<div class="row" style="width: 1210px; margin: 0 auto;">
		<div class="col-md-12">
			<ol class="breadcrumb">
				<li><a href="/shop/index.do">首页</a>&nbsp;&nbsp;&gt;&gt;&nbsp;&nbsp;${category.cname }${inputMeg}</li>
			</ol>
		</div>
		
		<!-- 使用EL表达式将request作用域中的pageBean里面的productList集合遍历 -->
		<c:forEach items="${pageBean.productList }" var="pro">
			<div class="col-md-2" style="height: 240px ; width: 200px">
				<a href="/info/product.do?pid=${pro.pid }"> <img src="${pageContext.request.contextPath}/${pro.pimage }"
					width="170" height="170" style="display: inline-block;">
				</a>
				<p>
					<a href="/info/product.do?pid=${pro.pid }" style='color: green'>${pro.pname }</a>
				</p>
				<p>
					<font color="#FF0000">商城价：&yen;${pro.shop_price }</font>
				</p>
			</div>
		</c:forEach>

		

	</div>

	<!--分页 -->
	<div style="width: 380px; margin: 0 auto; margin-top: 50px;">
		<ul class="pagination" style="text-align: center; margin-top: 10px;">
			<c:if test="${pageBean.currentPage == 1}">
				<li class="disabled"><a href="javascript:void(0);">
			</c:if>
			<c:if test="${pageBean.currentPage != 1}">
				<li><a href="/page/product.do?cid=${cid }&inputMeg=${inputMeg}&currentPage=${pageBean.currentPage -1}" aria-label="Previous">
			</c:if>
			 
			<span aria-hidden="true">&laquo;</span></a></li>
					
			<c:forEach begin="1" end="${pageBean.totalPage }" varStatus="vs">
				<c:if test="${vs.count == pageBean.currentPage }">
					<li class="active"><a href="/page/product.do?cid=${cid }&inputMeg=${inputMeg}&currentPage=${vs.count}">${vs.count}</a></li>
				</c:if>
				<c:if test="${vs.count != pageBean.currentPage }">
					<li><a href="/page/product.do?cid=${cid }&inputMeg=${inputMeg}&currentPage=${vs.count}">${vs.count}</a></li>
				</c:if>				
			</c:forEach>
			
			<c:if test="${pageBean.currentPage == pageBean.totalPage }">
				<li class="disabled"><a href="javascript:void(0);">
			</c:if>	
			<c:if test="${pageBean.currentPage != pageBean.totalPage }">
				<li><a href="/page/product.do?cid=${cid }&inputMeg=${inputMeg}&currentPage=${pageBean.currentPage +1}" aria-label="Next">
			</c:if>		
							
			<span aria-hidden="true">&raquo;</span></a></li>
			
		</ul>
	</div>
	<!-- 分页结束 -->

	<!--商品浏览记录-->
	<div
		style="width: 1210px; margin: 0 auto; padding: 0 9px; border: 1px solid #ddd; border-top: 2px solid #999; height: 246px;">

		<h4 style="width: 50%; float: left; font: 14px/30px 微软雅黑">浏览记录</h4>
		<div style="width: 50%; float: right; text-align: right;">
			<a href="">more</a>
		</div>
		<div style="clear: both;"></div>

		<div style="overflow: hidden;">

			<ul style="list-style: none;">
				<li
					style="width: 150px; height: 216px; float: left; margin: 0 8px 0 0; padding: 0 18px 15px; text-align: center;"><img
					src="${pageContext.request.contextPath}/products/1/cs10001.jpg" width="130px" height="130px" /></li>
			</ul>

		</div>
	</div>


	<!-- 引入footer.jsp -->
	<jsp:include page="/footer.jsp"></jsp:include>

</body>

</html>