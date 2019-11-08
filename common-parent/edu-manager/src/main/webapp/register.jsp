<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head></head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>会员注册</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css"/>
<script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
<!-- 引入自定义css文件 style.css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css"/>

<style>
    body {
        margin-top: 20px;
        margin: 0 auto;
    }

    .carousel-inner .item img {
        width: 100%;
        height: 300px;
    }

    font {
        color: #3164af;
        font-size: 18px;
        font-weight: normal;
        padding: 0 10px;
    }
</style>
<script type="text/javascript">
    /*
    1 ，控制表单提交 ：
        给变淡个元素定义标记位
        给表单个元素定义标记位
    2 ， 控制表单提交函数


     * 控制表单提交函数
     如果返回值为false ， 则表单不会提交
     如果返回值为true ， 则表单才会提交

    console.log(1111);在控制台打印输出
     */
    //定义标记位

    var usernameIsTrue = false
    var passwordIsTrue = false
    var rePasswordIsTrue = false
    var emailIsTrue = false

    var checkUsernameIsHave = false
    var checkCodeIsTrue = false

    function checkForm() {
        var flag = usernameIsTrue && passwordIsTrue && rePasswordIsTrue && emailIsTrue && checkUsernameIsHave && checkCodeIsTrue;
        if (!flag) {
            alert("请输入合法完整信息")
        }
        return flag;
    }

    /*当输入框获得焦点是 ：输出提示消息
    "请输入4-16位英文用户名"
    "请输入4-16位密码，第一个字符不能位数字"
    通用的打印提示xiaoxi
    */
    function printMsg(currentObj, msg) {

        $(currentObj).next("label").html(msg)
    }

    /* 当用户名输入框失去焦点时：
        1 ， 获得用户输入的用户名
        2， 使用正则表达式进行验证， 满足需求
        3 ， 设置标记位，当验证通过是 ， 将标记为设置位true
    */
    function usernameBlur(currentObj) {

        //获得用户输入的用户名
        var inputValue = $(currentObj).val();

        //创建正则表达式
        var pattern = /^[a-zA-Z_-][a-zA-Z_0-9]{3,15}$/

        if (pattern.test(inputValue)) {

            usernameIsTrue = true

            printMsg(currentObj, "")

            //只有当验证通过之后 ， 才使用Ajax向后台验证用户名是否已被祖册

            /*
            第一个参数：test.cgi ,提交到后台的地址
            第二个参数： {name:"John", time:"2pm"} ： 提交的参数 ， 键值对
            第三个参数：  是一个函数 ， 回调函数 ，当请求成功之后 ， 回调用该函数 ， 其中data ， 后台传过来的数据
            */
            $.get("/user/checkName.do",
                {username: inputValue},
                function (data) {
                    if (data == "true") {
                        checkUsernameIsHave = false
                        printMsg(currentObj, "<p style='color:red; font-size: small'>用户名已存在 ,请重新输入</p>")
                    } else {
                        checkUsernameIsHave = true
                        printMsg(currentObj, "")
                    }
                }
            );
        } else {
            printMsg(currentObj, "<p style='color:red; font-size: small'>用户名输入不合法 ,请重新输入</p>")
        }
    }

    /* 当密码验证框失去焦点时：
    1 ， 获得用户输入的用户名
    2， 使用正则表达式进行验证， 满足需求
    3 ， 设置标记位，当验证通过是 ， 将标记为设置位true
    */
    function passwordBlur(currentObj) {
        var inputValue = $(currentObj).val();
        //创建正则表达式
        var pattern = /^[a-zA-Z_-][a-zA-Z_0-9]{3,15}$/

        if (pattern.test(inputValue)) {
            passwordIsTrue = true
            printMsg(currentObj, "")
        } else {
            printMsg(currentObj, "<p style='color:red; font-size: small'>密码输入不合法</p>")
        }
    }

    function rePasswordBlur(currentObj) {
        /*拿到密码
         拿到重复密码
         进行对比
         $(":input[name='password']").attr("check" , true);
        */
        //使用表单选择器  属性选择器
        var passwordInput = $(":input[name='password']").val();

        //拿到重复输入的密码
        var rePasswordInput = $(currentObj).val();

        if (passwordInput !== rePasswordInput) {
            rePasswordIsTrue = false
            printMsg(currentObj, "<p style='color:red; font-size: small'>密码两次输入不一致</p>")
        } else {

            rePasswordIsTrue = true
            printMsg(currentObj, "")
        }
    }

	function emailBlur(currentObj) {
		var inputValue = $(currentObj).val();
		//创建正则表达式
        var pattern  = /^[A-Za-zd0-9]+([-_.][A-Za-zd]+)*@([A-Za-zd]+[-.])+[A-Za-zd]{2,5}$/;

		if (pattern.test(inputValue)) {
			emailIsTrue = true
			printMsg(currentObj, "")
		} else {
			printMsg(currentObj, "<p style='color:red; font-size: small'>邮箱输入不合法</p>")
		}
	}

    /*不刷新页面与后台交互数据
        京东\淘宝
    */
    function changeImg(currentObj) {
        //获得图片的src地址
        var imgSrc = $(currentObj).attr("src")
        console.log(imgSrc)
        //重新设置图片的src地址， ？data追加一个参数 ， 放在浏览器缓存
        $(currentObj).attr("src", imgSrc + "?data=" + new Date())
    }

    /*验证码证码
        1， 确定时间 ： 验证码输入框失去焦点是
        2， 提高用户的体验好感 , 使用Ajax技术 ， 无刷新页面 ， 验证验证码
        3， 根据验证码验证情况 ， 将验证情况整合到变淡提交函数
    */
    function checkCode(currentObj) {
        //获得用户输入的验证码
        var inputCode = $(currentObj).val();

        //使用Ajax发送数据到后台servlet ， 对验证码进行验证
        $.get("/check/img.do",
            {code: inputCode},
            function (data) {
                //验证输入正确
                if (data == "true") {
                    checkCodeIsTrue = true
                    $("#codeLabelId").html("")
                } else {
                    checkCodeIsTrue = false
                    $("#codeLabelId").html("<p style='color:red; font-size: small'>验证码输入错误<p>")
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
     style="width: 100%; background: url('${pageContext.request.contextPath}/image/regist_bg.jpg');">
    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-8"
             style="background: #fff; padding: 40px 80px; margin: 30px; border: 7px solid #ccc;">
             会员注册USER REGISTER
            <!-- onsubmit : 表单提交时间 ， 可以控制表单的提交 -->
            <form class="form-horizontal" onsubmit="return checkForm()" action="/user/registerSure.do" method="post"
                  style="margin-top: 5px;">
                <div class="form-group">
                    <label for="username" class="col-sm-2 control-label">用户名</label>
                    <div class="col-sm-6">
                        <!-- onfocus :获得焦点事件
                        onblur :失去焦点事件 -->
                        <input type="text" class="form-control" id="username" onblur="usernameBlur(this)"
                               onfocus="printMsg(this , '请输入4-16位英文用户名')" name="username"
                               placeholder="请输入用户名"><label></label>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-2 control-label">密码</label>
                    <div class="col-sm-6">
                        <input type="password" class="form-control" id="inputPassword3" name="password"
                               required autocomplete='tel'
                               onblur="passwordBlur(this)" onfocus="printMsg(this , '请输入4-16位密码，第一个字符不能位数字')"
                               placeholder="请输入密码"><label></label>
                    </div>
                </div>

                <div class="form-group">
                    <label for="confirmpwd" class="col-sm-2 control-label">确认密码</label>
                    <div class="col-sm-6">
                        <input type="password" class="form-control" id="confirmpwd"
                               required autocomplete='tel'
                               onblur="rePasswordBlur(this)"  onfocus="printMsg(this , '请再一次输入密码')"
                               placeholder="请输入确认密码"><label></label>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputEmail3" class="col-sm-2 control-label">Email</label>
                    <div class="col-sm-6">
                        <input type="email" class="form-control" id="inputEmail3" name="email"
							   onblur="emailBlur(this)" onfocus="printMsg(this, '请输入正确的邮箱格式')"
                               placeholder="Email"><label></label>
                    </div>
                </div>
                <div class="form-group">
                    <label for="usercaption" class="col-sm-2 control-label">姓名</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="usercaption" name="name"
                               placeholder="请输入姓名">
                    </div>
                </div>
                <div class="form-group opt">
                    <label for="inlineRadio1" class="col-sm-2 control-label">性别</label>
                    <div class="col-sm-6">
                        <label class="radio-inline">
                            <input type="radio" name="sex" id="inlineRadio1" value="1" checked="checked">
                            男
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="sex" id="inlineRadio2" value="0">
                            女
                        </label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">出生日期</label>
                    <div class="col-sm-6">
                        <input type="date" name="birthday" class="form-control">
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label">验证码</label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control" onblur="checkCode(this)">

                    </div>
                    <div class="col-sm-2">
                        <img src="/auth/code.do" onclick="changeImg(this)"/>
                    </div>
                    <label id="codeLabelId" style="margin-left: 40px"></label>

                </div>

                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <input type="submit" width="100" value="注册" name="submit"
                               style="background: url('${pageContext.request.contextPath}/images/register.gif') no-repeat scroll 0 0 rgba(0, 0, 0, 0); height: 35px; width: 100px; color: white;">
                    </div>
                </div>
            </form>
        </div>
        <div class="col-md-2"></div>


    </div>
</div>

<!-- 引入footer.jsp -->
<jsp:include page="/footer.jsp"></jsp:include>

</body>
</html>




