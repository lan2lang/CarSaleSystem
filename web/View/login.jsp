<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.util.ArrayList,java.util.List" %>
<%@ page import="com.car.dao.impl.StaffDao" %>
<%@ page import="com.car.entity.Staff" %>

<!DOCTYPE html>
<html lang="en">

<%--获取请求地址--%>
<%
    StaffDao staffDao = new StaffDao();
    List<Staff> staff = null;
    try {
        staff = staffDao.selectAllStaff();

    } catch (Exception e) {
        throw new RuntimeException(e);
    } finally {
        staffDao.close();
    }
    String path = request.getContextPath();
%>

<head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <title>登录界面</title>
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

        ul {
            list-style: none;
        }

        input, select {
            outline: none;
        }

        .middle {
            width: 500px;
            height: 400px;
            margin: 10% auto;
        }

        .login {
            width: inherit;
            height: inherit;
            box-shadow: 0 6px 13px 0 rgba(0, 0, 0, .1);
            background-color: white;
            border-radius: 15px;
            display: flex;
            justify-content: center;
        }

        #role {
            width: 400px;
            height: 40px;
            background-color: #f1f1f1;
            border-radius: 10px;
            display: flex;
            justify-content: space-around;
            align-items: center;
            margin: 55px 0 35px 0;
            padding: 2px 0;
        }

        #role li {
            width: 190px;
            height: 36px;
            text-align: center;
            line-height: 36px;

        }

        #role .active {
            background-color: white;
            border-radius: 10px;
            color: #00a6a7;
        }

        #role li:hover {
            cursor: pointer;
            color: #00a6a7;
        }

        .form {
            width: 400px;
        }

        .form select {
            width: 146px;
            height: 40px;
            border: 1px solid #8a8989;
            border-radius: 5px;
            font-size: 16px;
            padding-left: 5px;
        }

        .form input {
            width: 300px;
            height: 36px;
            margin: 0 0 20px 40px;
            border: 1px solid #8a8989;
            border-radius: 5px;
            font-size: 16px;
            padding-left: 5px;
        }

        .form input[type="button"] {
            background-color: #00a6a7;
            color: #fff;
            border-color: #00a6a7;
            margin-left: 45px;

        }

        #name {
            width: 150px;
        }


        .form input[type="button"]:hover {
            cursor: pointer;
        }

        .form input:hover {
            border-color: #00a6a7;
        }

        .form input:focus {
            border-color: #00a6a7;
        }

        #registerBtn {
            margin-top: 30px;
            color: #00a6a7;
        }

        #backLogin {
            color: #00a6a7;
            margin-bottom: 5px;
        }

        #registerBtn:hover, #backLogin:hover {
            cursor: pointer;
        }

        #clientPage {
            display: block;
        }

        #employeePage {
            display: none;
            margin-top: 20px;
        }

        #staffId {
            width: 310px;
            margin: 0 0 20px 40px;
        }


    </style>
</head>

<body>

<div class="middle">
    <div class="login">

        <%--    登录窗口    --%>
        <div id="clientPage">
            <ul id="role">
                <li id="client" class="active">用 户</li>
                <li id="employee">员 工</li>
            </ul>
            <form class="form" action="#" method="post" enctype="application/json">
                <input id="username" type="text" value="" placeholder="用户名">
                <input id="password" type="password" value="" placeholder="密码">
                <input id="loginBtn" type="button" value="登 录">
            </form>
            <div id="registerBtn">注册</div>
        </div>
        <%--    注册窗口    --%>
        <div id="employeePage">
            <form class="form" action="#">
                <input id="clientNo" type="text" value="" placeholder="用户名">
                <input id="pwd" type="password" value="" placeholder="密码">
                <input id="name" type="text" value="" placeholder="称谓">
                <select id="sex">
                    <option value="男">男</option>
                    <option value="女">女</option>
                </select>
                <input id="phone" type="tel" value="" placeholder="电话">

                <%-- 查询员工列表 --%>
                <select id="staffId">
                    <%
                        for (Staff staff1 : staff) {
                    %>
                    <option value="<%=staff1.getStaffId()%>"><%=staff1.getStaffName()%>
                    </option>
                    <%
                        }
                    %>
                </select>
                <input id="register" type="button" value="注册">
            </form>
            <div id="backLogin">登录</div>
        </div>

    </div>

</div>
<script src="<%=path%>/Content/js/jquery-1.8.3.js" type="text/javascript"></script>
<script type="text/javascript">

    let role = 0;

    // 进行注册的时候隐藏登录界面,显示注册界面
    $("#registerBtn").click(function () {
        $("#clientPage").hide();
        $("#employeePage").show();
    })

    // 进行登录的时候隐藏注册界面,显示登录界面
    $("#backLogin").click(function () {
        $("#clientPage").show();
        $("#employeePage").hide();
    })

    // 用户和员工登录切换
    $("#client").click(function () {
        $("#client").attr('class', 'active')
        $("#employee").attr('class', '')
        role = 0;
    })

    // 用户和员工登录切换
    $("#employee").click(function () {
        $("#employee").attr('class', 'active')
        $("#client").attr('class', '')
        role = 1;
    })

    // 进行登录
    $("#loginBtn").click(function () {

        // 登录的相关信息
        let loginDataInfo = {
            username: $("#username").val(),
            password: $("#password").val(),
            role: role
        };

        // 登录请求
        $.ajax({
            url: "<%=path%>/login",
            data: JSON.stringify(loginDataInfo),
            dataType: 'json',
            type: 'post',
            contentType: 'application/json',
            success: function (data) {
                if (data.code === 0) {
                    alert(data.msg)
                } else {
                    if (loginDataInfo.role === 0) {
                        window.location.replace("<%=path%>/View/clientCarList.jsp")
                    }
                    if (loginDataInfo.role === 1){
                        window.location.replace("<%=path%>/View/backStage.jsp")
                    }

                }
            },
            error: function () {
                alert("请求失败")
            }
        })
    })

    // 进行注册
    $("#register").click(function () {
        // 注册相关信息
        let registerInfo = {
            clientNo: $("#clientNo").val(),
            password: $("#pwd").val(),
            clientName: $("#name").val(),
            sex: $("#sex").val(),
            phone: $("#phone").val(),
            staffId: $("#staffId").val()
        }

        // 注册请求
        $.ajax({
            url: "<%=path%>/register",
            data: JSON.stringify(registerInfo),
            dataType: 'json',
            type: 'post',
            contentType: 'application/json',
            success: function (data) {
                if (data.code === 0) {
                    alert(data.msg)
                }
                console.log(data)
            },
            error: function () {
                alert("注册失败")
            }
        })

        $("#clientPage").show();
        $("#employeePage").hide();
    })
</script>
</body>
</html>
