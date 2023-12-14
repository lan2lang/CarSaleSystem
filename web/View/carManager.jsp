<%@ page import="com.car.dao.impl.OrderDao" %>
<%@ page import="com.car.entity.Order" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page%>

<!DOCTYPE html>
<html lang="en">

<%--获取请求地址--%>
<%
    String path = request.getContextPath();
%>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <title>车辆管理</title>
    <link rel="icon" href="<%=path%>/content1/images/my.ico">
    <style>
        * {
            margin: 0;
        }

        body {
            background-image: url("<%=path%>/Content/img/bk-2.jpg");
            background-repeat: no-repeat;
            background-size: 100% 100%;
            background-attachment: fixed;
        }

        .btn {
            width: 100px;
            height: 40px;
            position: fixed;
            top: 0;
            left: 0;
            margin: 15px 0 0 15px;
            background-color: #ffc107;
            border: 1px solid #ffc107;
            border-radius: 5px;
            box-shadow: 0 6px 13px 0 rgba(0, 0, 0, .1);
            color: #fff;
        }

        .btn:hover,.button-color-red:hover,.button-color-yellow:hover{
            cursor: pointer;
        }

        .main {
            width: 1000px;
            height: 100%;
            margin: 10px auto;
            background-color: white;
            padding: 5px 10px;
        }

        .main-title,.main-context{
            width: 1000px;
            display: grid;
            grid-template-columns: 300px 250px 200px 250px;
            grid-template-rows: 40px;
            justify-items: center;
            align-items: center;
            border-bottom: #eeeeee solid 1px;
        }

        .main-context{
            grid-template-rows: 60px !important;
        }

        .main-context div button{
            width: 100px;
            height: 40px;
            border-radius: 5px;
            color: #fff;
        }

        .button-color-red{
            background-color: #dc3545;
            border: 1px solid #dc3545;
        }

        .button-color-dark{
            background-color: #6c757d;
            border: 1px solid #6c757d;
        }

        .button-color-green{
            background-color: #198754;
            border: 1px solid #198754;
        }

        .button-color-yellow{
            background-color: #ffc107;
            border: 1px solid #ffc107;
        }



    </style>
</head>

<body>

<div class="main">
    <div class="main-title">
        <div>订单详情</div>
        <div>订单时间</div>
        <div>订单状态</div>
        <div>操作</div>
    </div>

    <div class="main-context">
        <div>dsakjdladjklaj</div>
        <div>dsakjkdajkdla</div>
        <div>
            skjdkaldjkakj
        </div>
        <div>
            <button class="button-color-yellow">
                立即支付
            </button>
            <button class="button-color-red">
                取消订单
            </button>
        </div>
    </div>
</div>


<script src="<%=path%>/Content/js/jquery-1.8.3.js" type="text/javascript"></script>
<script type="text/javascript">

</script>
</body>
</html>
