<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<HTML>
<HEAD>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath}/css/Style1.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/public.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript">


	/*
	第一种方式，绑定事件
	function checkAll(currentObj) {		
	}		
	*/
	
	/*第二张方式， 绑定事件
		使用jQuery方式 
		1）引入jQuery文件
		2）使用jQuery函数
	*/
$(function() {
	/* console.log("sssss") */
	/*表示页面加载完成时间
		表单提交
		获得焦点
		失去焦点	
	*/
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
		console.log($(".aloneCheck").length , $(".aloneCheck:checked").length)
		var flag = $(".aloneCheck").length == $(".aloneCheck:checked").length
		$("#allCheck").prop("checked" , flag)
		
	})
	
/* 	给删除按钮绑定点击时间
	获得被选择复选框对应的类别ID（cid）
	拼接uri ， 将所有需要删除的类别删除 */
	
	$("#del").click(function(){
		
		var isTrue = confirm("are you sure ?") ;
		if(!isTrue){
			return
		}
		
		var ids = ""
		//遍历所有选择的复选框
		$.each( $(".aloneCheck:checked") , function(){
			
			/* 拼接uri 
				/mail/cartServlet?ids=2&ids=6
			*/
			console.log($(this).val())
			ids += "ids=" + $(this).val() + "&"
		});
		ids = ids.substring(0 , ids.length-1)
		
		/* 访问后台服务器 */
		location.href = "${pageContext.request.contextPath}/AdminCategoryDelMoreServlet?"+ids
		
	})
	
	//添加数据按钮，绑定点击事件
	$("#add").click(function(){
		window.location.href = "${pageContext.request.contextPath}/admin/category/add.jsp";
	})
			
		
	
	
})
</script>
</HEAD>
<body>
	<br>
	<table cellSpacing="1" cellPadding="0" width="100%" align="center"
		bgColor="#f5fafe" border="0">
		<TBODY>
			<tr>
				<td class="ta_01" align="center" bgColor="#afd1f3"><strong>分类列表&nbsp;&nbsp;&nbsp;&nbsp;${errorMsg }</strong>
				</TD>
			</tr>
			<tr>
				<td class="ta_01" align="right">
					<button type="button" id="add" name="add" value="添加" class="button_add"> &#28155;&#21152;</button>
					<button type="button" id="del" name="add" value="删除" class="button_add">删除</button>
				</td>
			</tr>
			<tr>
				<td class="ta_01" align="center" bgColor="#f5fafe">
					<table cellspacing="0" cellpadding="1" rules="all" bordercolor="gray" border="1" id="DataGrid1" style="BORDER-RIGHT: gray 1px solid; BORDER-TOP: gray 1px solid; BORDER-LEFT: gray 1px solid; WIDTH: 100%; WORD-BREAK: break-all; BORDER-BOTTOM: gray 1px solid; BORDER-COLLAPSE: collapse; BACKGROUND-COLOR: #f5fafe; WORD-WRAP: break-word">
						<tr style="FONT-WEIGHT: bold; FONT-SIZE: 12pt; HEIGHT: 25px; BACKGROUND-COLOR: #afd1f3">
							
							<td align="center" width="5%"><input type="checkbox" id="allCheck"/></td>
							
							<td align="center" width="10%">序号</td>
							<td align="center" width="17%">分类名称</td>
							<td width="7%" align="center">编辑</td>
							<td width="7%" align="center">删除</td>
						</tr>
						
						<c:forEach items="${categoryList }" var="category" varStatus="vs">
						<tr onmouseover="this.style.backgroundColor = 'white'" onmouseout="this.style.backgroundColor = '#F5FAFE';">
							
							<td style="CURSOR: hand; HEIGHT: 22px" align="center" width="5%">
								<input type="checkbox" class="aloneCheck" value="${category.cid }"/></td>
							
							<td style="CURSOR: hand; HEIGHT: 22px" align="center" width="10%">${vs.count }</td>
							<td style="CURSOR: hand; HEIGHT: 22px" align="center" width="17%">${category.cname }</td>
							<td align="center" style="HEIGHT: 22px">
								<a href="${pageContext.request.contextPath }/AdminCategoryEditUIServlet?cid=${category.cid}">
										<img src="${pageContext.request.contextPath}/images/i_edit.gif" border="0" style="CURSOR: hand">
								</a>
							</td>

							<td align="center" style="HEIGHT: 22px">
								  <a href="${pageContext.request.contextPath }/AdminCategoryDelServlet?cid=${category.cid }">
										<img src="${pageContext.request.contextPath}/images/i_del.gif" width="16" height="16" border="0" style="CURSOR: hand">
								  </a>
							</td>
						</tr>
						</c:forEach>
					</table>
				</td>
			</tr>
		</TBODY>
	</table>
</body>
</HTML>

