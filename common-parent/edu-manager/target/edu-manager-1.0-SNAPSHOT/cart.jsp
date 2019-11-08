<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>商城购物车</title>
    <style>
    html{background-color:#E3E3E3; font-size:14px; color:#000; font-family:'微软雅黑'}
    a,a:hover{ text-decoration:none;}
    pre{font-family:'微软雅黑'}
    .box{padding:20px; background-color:#fff; margin:50px 100px; border-radius:5px;}
    .box a{padding-right:15px;}
    #about_hide{display:none}
    .layer_text{background-color:#fff; padding:20px;}
    .layer_text p{margin-bottom: 10px; text-indent: 2em; line-height: 23px;}
    .button{display:inline-block; *display:inline; *zoom:1; line-height:30px; padding:0 20px; background-color:#56B4DC; color:#fff; font-size:14px; border-radius:3px; cursor:pointer; font-weight:normal;}
    .photos-demo img{width:200px;}
</style>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css"/>
    <script src="http://cdn.bootcss.com/jquery/1.12.3/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
    <!-- 引入自定义css文件 style.css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css"/>
    <script src="${pageContext.request.contextPath}/js/layer.js"></script>
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

    <script>
        function del_btn(url) {
            layer.confirm('确定删除？', {
                skin: 'layui-layer-molv',
                btn: ['删除', '取消'] //按钮
            }, function () {
                layer.msg('删除成功', {icon: 1,time:2000});   //点击删除按钮，页面跳转
                self.location.href =  url
            }, function () {
                layer.msg('取消', {time:2000});   // 点击取消按钮，弹出框消失，页面不跳转
            });
        }
        function delete_All(url) {
            layer.confirm('确定清空吗？', {
                skin: 'layui-layer-molv',
                btn: ['确定', '取消'] //按钮
            }, function () {
                layer.msg('操作成功', {icon: 1,time:2000});   //点击删除按钮，页面跳转
                self.location.href =  url
            }, function () {
                layer.msg('取消', {time:2000});   // 点击取消按钮，弹出框消失，页面不跳转
            });
        }
    </script>

    <script type="text/javascript">

        function subNum(pid, num) {
            location.href = "/shop/updateCart.do?pid=" + pid + "&num=" + num;
        }

    $(function() {
        $("#allCheck").click(function(){
            /* 点击事件产生之后的操作
            1 ，获得最上面复选框的状态（当前元素）
            2,获得下面所有的复选框 ， 并把下面所有的复选框的状态设置与上面复选框状态一致
            */
            var allCheckStatus = $(this).prop("checked")
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
            layer.confirm('确定删除？', {
                skin: 'layui-layer-molv',
                btn: ['删除', '取消'] //按钮
            }, function () {
                layer.msg('删除成功', {icon: 1,time:2000});   //点击删除按钮，页面跳转
                var oIds = 'oid=' ;
                $.each( $(".aloneCheck:checked") , function(){

                    var oid = $(this).val() ;

                    oIds += oid+","
                });
                oIds = oIds.substring(0 , oIds.length-1)
                self.location.href =  "/shop/deleteCart.do?"+ oIds
            }, function () {
                layer.msg('取消', {time:2000});   // 点击取消按钮，弹出框消失，页面不跳转
            });

           /* if(!confirm("确认删除吗?")){
                return
            }*/

        })
    })
    </script>
</head>

<body>
<!-- 引入header.jsp -->
<jsp:include page="/header.jsp"></jsp:include>

<div class="container">
    <div class="row">

        <div style="margin:0 auto; margin-top:10px;width:950px;">
            <strong style="font-size:16px;margin:5px 0;">订单详情</strong>
            <table class="table table-bordered">
                <tbody>

                <tr class="warning">
                    <th><input type="checkbox" id="allCheck"/></th>
                    <th>图片</th>
                    <th>商品</th>
                    <th>价格</th>
                    <th>数量</th>
                    <th>小计</th>
                    <th>操作</th>
                </tr>


                <c:forEach items="${cartList}" var="cartList">
                    <tr class="active">
                        <td width="60">
                            <input type="checkbox" class="aloneCheck" value="${cartList.oid }" />
                        </td>
                            <%--图片--%>
                        <td width="60">
                            <input type="hidden" name="id" value="22">
                            <a href="/info/product.do?pid=${cartList.pid }">
                                <img src="${pageContext.request.contextPath}/${cartList.pimage }" width="70"
                                     height="60">
                            </a>
                        </td>
                            <%--名字--%>
                        <td width="30%">
                            <a href="/info/product.do?pid=${cartList.pid }">${cartList.pname }</a>
                        </td>
                            <%--价格--%>
                        <td width="20%">
                            ￥${cartList.shop_price }
                        </td>
                        <td width="10%">
                            <input type="button" value="-" onclick="subNum('${cartList.pid }', -1)"/>
                            <span>${cartList.num }</span>
                            <input type="button" value="+" onclick="subNum('${cartList.pid }', 1)"/>
                        </td>
                        <td width="15%">
                            <span class="subtotal">￥${cartList.subtotal }</span>
                        </td>
                        <td>
                            <a href="javascript:del_btn('/shop/deleteCart.do?oid=${cartList.oid}');"title="删除">删除 </a>
                            <%--<a href="/shop/deleteCart.do?oid=${cartList.oid}" class="delete">删除</a>--%>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div style="margin-right:130px;">
        <div style="text-align:right;">
            <em style="color:#ff6600;">
                登录后确认是否享有优惠&nbsp;&nbsp;
            </em> 赠送积分: <em style="color:#ff6600;">${count}</em>&nbsp; 商品金额: <strong
                style="color:#ff6600;">￥${count}元</strong>
        </div>
        <div style="text-align:right;margin-top:10px;margin-bottom:10px;">
            <button type="button" id="del" name="del" value="删除" class="button_add" >删除</button>
            <a href="javascript:delete_All('/shop/deleteALLCart.do');"title="删除">清空购物车 </a>
            <a href="order_info.jsp">
                <input type="submit" width="100" value="提交订单" name="submit" border="0"
                       style="background: url('${pageContext.request.contextPath}/images/register.gif') no-repeat scroll 0 0 rgba(0, 0, 0, 0);
                               height:35px;width:100px;color:white;">
            </a>
        </div>
    </div>

</div>

<!-- 引入footer.jsp -->
<jsp:include page="/footer.jsp"></jsp:include>

</body>

</html>