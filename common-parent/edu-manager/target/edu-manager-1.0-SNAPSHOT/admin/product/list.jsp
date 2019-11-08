<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<HTML>
<HEAD>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath}/css/Style1.css" rel="stylesheet" type="text/css" />

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css" />
<script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
<!-- 引入自定义css文件 style.css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css" />

<script type="text/javascript">

/* 当点击添加按钮时 ， 触发的点击事件 */
function addProduct(){
	window.location.href = "${pageContext.request.contextPath}/AdminProductAddUIServlet";		
}		

//单个删除

function delOne(pid , pname) {
	
	if(confirm("确定删除" + pname + "吗？")){
		location.href = "${pageContext.request.contextPath}/AdminProductDelOneServlet?pid="+pid
		+"&currentPage=${pageBean.currentPage}&currentCount=${pageBean.currentCount}"	
	}
}		
		
		
/* 页面加载完成事件 */

$(function() {

	$("#allCheck").click(function(){
		/* 点击事件产生之后的操作
		1 ，获得最上面复选框的状态（当前元素） 
		2,获得下面所有的复选框 ， 并把下面所有的复选框的状态设置与上面复选框状态一致
		*/
		var allCheckStatus = $(this).prop("checked")
		/* console.log(allCheckStatus) */
		$(".aloneCheck").prop("checked" , allCheckStatus)		
	});
	
	/* 给下面的所有复选框点击绑定时间 
		只要有一个未选择，最上面为空
	*/
	$(".aloneCheck").click(function(){
		
		/* 下面所有复选框的个数与下面被选复选框的股数进行比对
		如果个数相同，则为全选
		如果不相同，则不为全选 */
		var flag = $(".aloneCheck").length == $(".aloneCheck:checked").length
		$("#allCheck").prop("checked" , flag)
		
	})
	
	//多个删除
	$("#del").click(function() {
		
		var pnames = ''
		//遍历所有选择的复选框 ， 拿到复选框中的pname属性值()
		
		
		$.each( $(".aloneCheck:checked") , function(){
			
			var pname = $(this).attr("pname") 
			
			pnames += pname + " , "
		});
		
		if(!confirm("确认删除  " + pnames + "吗?")){
			return
		}
		
		
		/* 遍历所有选中的复选框 ， 拿到复选框中的值(pid) 
		拼接URI ,将多个删除的pid传递到后台服务器
		*/
		var ids = '' ;
		$.each( $(".aloneCheck:checked") , function(){
			
			var pid = $(this).val() ;
			
			ids += "ids="+pid+"&"
		});
		//未处理前ids=1&ids=10&
		ids = ids.substring(0 , ids.length-1)
		location.href = "${pageContext.request.contextPath}/AdminProductDelMoreServlet?currentPage=${pageBean.currentPage }&currentCount=${pageBean.currentCount }&" + ids
	})

})
</script>



</HEAD>
<body>
	<br>
	<form id="Form1" name="Form1"
		action="${pageContext.request.contextPath}/user/list.jsp"
		method="post">
		<table cellSpacing="1" cellPadding="0" width="100%" align="center" bgColor="#f5fafe" border="0">
			<TBODY>
				<tr>
					<td class="ta_01" align="center" bgColor="#afd1f3"><strong>商品列表</strong>
					</TD>
				</tr>
				<tr>
					<td class="ta_01" align="right">
						<button type="button" id="add" name="add" value="添加" class="button_add" onclick="addProduct()"> &#28155;&#21152;</button>
						<button type="button" id="del" name="del" value="删除" class="button_add" >删除</button>

					</td>
				</tr>
				<tr>
					<td class="ta_01" align="center" bgColor="#f5fafe">
						<table cellspacing="0" cellpadding="1" rules="all" bordercolor="gray" border="1" id="DataGrid1"
							style="BORDER-RIGHT: gray 1px solid; BORDER-TOP: gray 1px solid; BORDER-LEFT: gray 1px solid; 
							WIDTH: 100%; WORD-BREAK: break-all; BORDER-BOTTOM: gray 1px solid; 
							BORDER-COLLAPSE: collapse; BACKGROUND-COLOR: #f5fafe; WORD-WRAP: break-word">
							<tr style="FONT-WEIGHT: bold; FONT-SIZE: 12pt; HEIGHT: 25px; BACKGROUND-COLOR: #afd1f3">
								<td align="center" width="5"><input type="checkbox" id="allCheck"/></td>
								<td align="center" width="10%">序号</td>
								<td align="center" width="10%">商品图片</td>
								<td align="center" width="23%">商品名称</td>
								<td align="center" width="17%">商品价格</td>
								<td align="center" width="17%">是否热门</td>
								<td width="7%" align="center">编辑</td>
								<td width="7%" align="center">删除</td>
							</tr>
							
							<c:forEach items="${pageBean.productList }" var="pro" varStatus="vs">
								<tr onmouseover="this.style.backgroundColor = 'white'" onmouseout="this.style.backgroundColor = '#F5FAFE';">
									<td align="center" width="5"><input type="checkbox" class="aloneCheck" value="${pro.pid }" pname="${pro.pname }" /></td>
									<td style="CURSOR: hand; HEIGHT: 22px" align="center" width="10%">${vs.count }</td>
									<td style="CURSOR: hand; HEIGHT: 22px" align="center" width="10%"><img width="40" height="45" src="${pro.pimage }"></td>
									<td style="CURSOR: hand; HEIGHT: 22px" align="center" width="25%">${pro.pname }</td>
									<td style="CURSOR: hand; HEIGHT: 22px" align="center" width="17%">${pro.shop_price }</td>
									<td style="CURSOR: hand; HEIGHT: 22px" align="center" width="17%">${pro.is_hot==1?'是':'否'}</td>
									<td align="center" style="HEIGHT: 22px">
										<a href="${pageContext.request.contextPath }/AdminProductEditUIServlet?pid=${pro.pid }">
											<img src="${pageContext.request.contextPath}/images/i_edit.gif" border="0" style="CURSOR: hand">
										</a>
									</td>
	 
									<td align="center" style="HEIGHT: 22px">
										<a href="javascript:void(0);" onclick ="delOne('${pro.pid}' , '${pro.pname}')"> 
											<img src="${pageContext.request.contextPath}/images/i_del.gif" width="16" height="16" border="0" style="CURSOR: hand">
										</a>
									</td>
								</tr>
							</c:forEach>
						</table>
						
						<!--分页 -->
	<div style="width: 380px; margin: 0 auto; margin-top: 50px;">
		<ul class="pagination" style="text-align: center; margin-top: 10px;">
			<c:if test="${pageBean.currentPage == 1}">
				<li class="disabled"><a href="javascript:void(0);">
			</c:if>
			<c:if test="${pageBean.currentPage != 1}">
				<li><a href="AdminProductListPageServlet?cid=${cid }&currentPage=${pageBean.currentPage -1}" aria-label="Previous">
			</c:if>
			 
			<span aria-hidden="true">&laquo;</span></a></li>
					
			<c:forEach begin="1" end="${pageBean.totalPage }" varStatus="vs">
				<c:if test="${vs.count == pageBean.currentPage }">
					<li class="active"><a href="AdminProductListPageServlet?cid=${cid }&currentPage=${vs.count}">${vs.count}</a></li>
				</c:if>
				<c:if test="${vs.count != pageBean.currentPage }">
					<li><a href="AdminProductListPageServlet?cid=${cid }&currentPage=${vs.count}">${vs.count}</a></li>
				</c:if>				
			</c:forEach>
			
			<c:if test="${pageBean.currentPage == pageBean.totalPage }">
				<li class="disabled"><a href="javascript:void(0);">
			</c:if>	
			<c:if test="${pageBean.currentPage != pageBean.totalPage }">
				<li><a href="AdminProductListPageServlet?cid=${cid }&currentPage=${pageBean.currentPage +1}" aria-label="Next"> 
			</c:if>		
							
			<span aria-hidden="true">&raquo;</span></a></li>
			
		</ul>
	</div>
	<!-- 分页结束 -->
						
						
						
					</td>
				</tr>

			</TBODY>
		</table>
	</form>
</body>
</HTML>

