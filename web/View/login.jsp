<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.util.ArrayList,java.util.List" %>

<!DOCTYPE html>
<html lang="en">

<%--获取请求地址--%>
<% String path = request.getContextPath(); %>

<head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <title>登录界面</title>
    <link rel="icon" href="<%=path%>/content1/images/my.ico">
    <script async="" src="file://www.google-analytics.com/analytics.js"></script>
    <script src="<%=path%>/Content/dist/js/popper.min.js" type="text/javascript"></script>
    <style>
        * {
            margin: 0;
        }

        body {
            background-image: url("<%=path%>/Content/img/bk-1.jpg");
            background-repeat: no-repeat;
            background-size: 100% 100%;
            background-attachment: fixed;
        }

        ul{
            list-style: none;
        }

        input{
            outline: none;
        }

        .middle {
            width: 500px;
            height: 350px;
            margin: 10% auto;
        }

        .login{
            width: inherit;
            height: inherit;
            box-shadow: 0 6px 13px 0 rgba(0,0,0,.1);
            background-color: white;
            border-radius: 15px;
            display: flex;
            justify-content: center;
        }

        #role{
            width: 400px;
            height: 40px;
            background-color: #f1f1f1;
            border-radius: 10px;
            display: flex;
            justify-content: space-around;
            align-items: center;
            margin: 35px 0;
            padding: 2px 0;
        }

        #role li{
            width: 190px;
            height: 36px;
            text-align: center;
            line-height: 36px;

        }

        #role .active{
            background-color: white;
            border-radius: 10px;
            color: #00a6a7;
        }

        #role li:hover{
            cursor: pointer;
            color: #00a6a7;
        }

        .form{
            width: 400px;
            height: 80px;
        }

        .form input{
            width: 300px;
            height: 36px;
            margin: 0 0 20px 40px;
            border: 1px solid #8a8989;
            border-radius: 5px;
            font-size: 16px;
            padding-left: 5px;
        }

        .form input[type="button"]{
            background-color: #00a6a7;
            color: #fff;
            border-color: #00a6a7;
            margin-left: 45px;

        }


        .form input[type="button"]:hover{
            cursor: pointer;
        }

        .form input:hover{
            border-color: #00a6a7;
        }

        .form input:focus{
            border-color: #00a6a7;
        }


    </style>
</head>

<body>

<div class="middle">
    <div class="login">
        <div>
            <ul id="role">
                <li id="client" class="active">用 户</li>
                <li id="employee" >员 工</li>
            </ul>
            <form class="form" action="#" method="post" enctype="application/json">
                <input id="username" type="text" value="" placeholder="用户名">
                <input id="password" type="password" value="" placeholder="密码">
                <input id="loginBtn" type="button" value="登 录">
            </form>
        </div>
    </div>
</div>
<script src="<%=path%>/Content/js/jquery-1.8.3.js" type="text/javascript"></script>
<script type="text/javascript">

    let role = 0;

    $("#client").click(function () {
        $("#client").attr('class','active')
        $("#employee").attr('class','')
        role = 1;
    })

    $("#employee").click(function () {
        $("#employee").attr('class','active')
        $("#client").attr('class','')
        role = 1;
    })

    $("#loginBtn").click(function () {
        let loginDataInfo = {
            username: $("#username").val(),
            password: $("#password").val(),
            role: role
        };
        $.ajax({
            url:"<%=path%>/login",
            data: JSON.stringify(loginDataInfo),
            dataType: 'json',
            type: 'post',
            contentType: 'application/json',
            success:function (data){
                if (data.code == 0){
                    alert(data.msg)
                }
                console.log(data)
            },
            error: function (data) {

            }
        })
    })
</script>
</body>
</html>
