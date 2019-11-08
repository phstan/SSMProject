<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
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
}

.carousel-inner .item img {
	width: 100%;
	height: 300px;
}

.container .row div {
	/* position:relative;
				 float:left; */
	
}

font {
	color: #666;
	font-size: 22px;
	font-weight: normal;
	padding-right: 17px;
}
</style>
	<%
		if("login_error".equals(request.getParameter("message"))){ %>

	<script type="text/javascript">
		alert("用户名或者密码错误！");
	</script>

	<%}else{%>
	<!-- 没有收到任何错误信息 -->
	<% }%>
<script type="text/javascript">

var checkCodeIsTrue = false
var code = false
function checkForm() {
	var flag = checkCodeIsTrue ; 
	console.log(checkCodeIsTrue);
	if(!flag){
		alert("验证码输入错误")
	}
	return flag ;
}

function changeImg(currentObj) {
	//获得图片的src地址
	var imgSrc = $(currentObj).attr("src")
	console.log(imgSrc)
	//重新设置图片的src地址， ？data追加一个参数 ， 放在浏览器缓存
	$(currentObj).attr("src" , imgSrc + "?data=" + new Date())
}
function checkCode(currentObj) {
	//获得用户输入的验证码
	var inputCode = $(currentObj).val();
	
	//使用Ajax发送数据到后台servlet ， 对验证码进行验证
	$.get("/check/img.do",
			{code: inputCode},
			function(data){
				//验证输入正确
				if(data == "true"){
					checkCodeIsTrue = true
					$("#codeLabelId").html("")
				}else{
					checkCodeIsTrue = false
					$("#codeLabelId").html("验证码输入错误")
				} 
			}
		);
}
</script>
</head>
<body>

	<!-- 引入header.jsp -->
	<jsp:include page="/header.jsp"></jsp:include>


	<div class="container"
		style="width: 100%; height: 460px; background: #FF2C4C url('${pageContext.request.contextPath}/images/loginbg.jpg') no-repeat;">
		<div class="row">
			<div class="col-md-7">
			</div>

			<div class="col-md-5">
				<div
					style="width: 440px; border: 1px solid #E7E7E7; padding: 20px 0 20px 30px; border-radius: 5px; margin-top: 60px; background: #fff;">
					<font>会员登录</font>USER LOGIN <font style="color: red">${errorMsg }</font>
					<div>&nbsp;</div>
					<form class="form-horizontal" action="/user/login.do" method="post" onsubmit = "return checkForm()">
						<div class="form-group">
							<label for="username" class="col-sm-2 control-label">用户名</label>
							<div class="col-sm-6">
							<%-- 形如${ } 类型的表达式 ， EL表达式 ， 取出存储在服务器中的数据 --%>
								<input type="text" class="form-control" id="username" value="${session_username }"  name="username"
									placeholder="请输入用户名">
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">密码</label>
							<div class="col-sm-6">
								<input type="password" class="form-control" id="inputPassword3" name="password"
									placeholder="请输入密码">
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">验证码</label>
							<div class="col-sm-3">							<!-- onblur失去焦点 -->
								<input type="text" class="form-control" id="inputPassword3"  onblur="checkCode(this)" name="inputPassword3"
									placeholder="请输入验证码">
							</div><label id = "codeLabelId" style="margin-left: 40px"></label>
							<div class="col-sm-3">
								<img src="/auth/code.do" onclick="changeImg(this)" />
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<div class="checkbox">
									<label> <input type="checkbox"> 自动登录
									</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <label> <input
										type="checkbox"> 记住用户名
									</label>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<input type="submit" width="100" value="登录" name="submit"
									style="background: url('${pageContext.request.contextPath}/images/login.gif') no-repeat scroll 0 0 rgba(0, 0, 0, 0); height: 35px; width: 100px; color: white;">
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- 引入footer.jsp -->
	<jsp:include page="/footer.jsp"></jsp:include>

</body>
</html>