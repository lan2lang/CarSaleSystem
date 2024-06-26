<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page %>

<!DOCTYPE html>
<html lang="en">


<%--获取请求地址--%>
<%
    String path = request.getContextPath();
    String userinfo = session.getAttribute("userinfo").toString();
    String username = "";
    // 是否是管理员
    if (userinfo.contains("admin")) {
        username = "admin";
    }
%>


<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <title>管理页面</title>
    <style>

        * {
            margin: 0;
            padding: 0;
        }

        .main {
            width: 100vw;
            height: 100vh;
            display: grid;
            grid-template-columns: 15vw 85vw;
            grid-template-rows: 100vh;
        }

        .main .main-nav {
            display: grid;
            grid-template-columns: 100%;
            grid-template-rows: repeat(5, 60px);
            justify-items: center;
            align-items: center;
            background-color: #6a97ac;
            color: #fff;
            padding-top: 20px;
        }

        .main .main-nav div {
            display: grid;
            justify-items: center;
            align-items: center;
            width: 100%;
            height: 100%;

        }

        .main .main-nav div:hover {
            cursor: pointer;
            background-color: #2d728b;
        }

        .main div iframe {
            width: 99%;
            height: 99%;
            overflow: hidden;
        }
    </style>
</head>

<body>

<div class="main">

    <%--    页面切换--%>
    <div class="main-nav">
        <div onclick="changeSrc('<%=path%>/View/clientCarList.jsp')">
            浏览车辆
        </div>
        <div onclick="changeSrc('<%=path%>/View/carManager.jsp')">
            车辆管理
        </div>
        <div onclick="changeSrc('<%=path%>/View/myOrder.jsp')">
            订单管理
        </div>
        <div onclick="changeSrc('<%=path%>/View/clientList.jsp')">
            客户查询
        </div>
        <%
            if ("admin".equals(username)) {

        %>
        <div onclick="changeSrc('<%=path%>/View/employManager.jsp')">
            员工管理
        </div>
        <%
            }
        %>
    </div>

    <%--    展示实际页面(页面里面嵌套一个页面)--%>
    <div>
        <iframe id="iframeSrc" src="<%=path%>/View/clientCarList.jsp"></iframe>
    </div>
</div>

<script src="<%=path%>/Content/js/jquery-1.8.3.js" type="text/javascript"></script>
<script type="text/javascript">
    function changeSrc(src) {
        $("#iframeSrc").attr('src', src)
    }
</script>
</body>
</html>
