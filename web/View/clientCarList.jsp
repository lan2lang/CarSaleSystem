<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page %>

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
    <title>车辆列表</title>
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

        a{
            text-decoration: none;
            color:inherit;
        }

        button{
            text-transform: none;
            box-shadow: none;
        }

        .main {
            width: 1000px;
            height: 100%;
            margin: 10px auto;
            display: grid;
            grid-template-columns: 500px 500px;
            grid-template-rows: 470px 470px;

        }

        .main .piece {
            padding: 20px 50px 0 50px;
            display: grid;
            grid-template-columns: 400px;
            grid-auto-rows: 340px 30px 45px;
            font-size: 0;

        }

        .main .piece img {
            width: 400px;
            border-radius: 5px 5px 0 0;
            box-shadow: 0 6px 13px 0 rgba(0, 0, 0, .1);
        }

        .main .piece .piece-left {
            padding-right: 8px;
            display: grid;
            justify-items: end;
            align-items: start;
            background-color: #fff;
            font-size: 20px;
            color: #3a3a3a;
        }

        .main .piece .piece-right {
            display: grid;
            justify-items: end;
            align-items: start;
            color: #ff5000;
            font-size: 30px;
            background-color: #fff;
            border-radius: 0 0 5px 5px;
            padding-right: 8px;
            box-shadow: 0 6px 13px 0 rgba(0, 0, 0, .1);
        }

        .btn {
            width: 100px;
            height: 40px;
            position: fixed;
            top: 0;
            right: 0;
            margin: 15px 15px 0 0;
            background-color: #ffc107;
            border: 1px solid #ffc107;
            border-radius: 5px;
            box-shadow: 0 6px 13px 0 rgba(0, 0, 0, .1);
            color: #fff;
        }

        .btn:hover{
            cursor: pointer;
        }
    </style>
</head>

<body>

<div class="main">
    <div class="piece">
        <a href="<%=path%>/View/carDetail.jsp?carId=1">
            <img src="<%=path%>/upload/bydwangchaoplus.jpg" alt="">
            <div class="piece-left">王朝2023年冠军版</div>
            <div class="piece-right">18万</div>
        </a>
    </div>


</div>
<button id="myOrder" class="btn">
    我的订单
</button>

<script src="<%=path%>/Content/js/jquery-1.8.3.js" type="text/javascript"></script>
<script type="text/javascript">

    // 前往订单页面
    $("#myOrder").click(function () {
        window.location.href = '<%=path%>/View/myOrder.jsp'
    })
    
    $(function () {

    })
</script>
</body>
</html>
