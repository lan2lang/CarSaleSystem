<%@ page import="com.car.dao.impl.OrderDao" %>
<%@ page import="com.car.entity.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="com.car.dao.impl.ClientDao" %>
<%@ page import="com.car.entity.Client" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page%>

<!DOCTYPE html>
<html lang="en">

<%--获取请求地址--%>
<%
  String path = request.getContextPath();
  String userinfo = session.getAttribute("userinfo").toString();
  String userId = "";
  ClientDao clientDao = new ClientDao();
  List<Client> clients = null;
  // 是否是管理员
  if (userinfo.contains("admin")) {
    clients = clientDao.selectAll(Client.class);
  } else {
    // 获取员工id
    userId = userinfo.substring(userinfo.indexOf(",") - 1, userinfo.indexOf(","));
    clients = clientDao.selectClientsByStaff(Integer.parseInt(userId));
  }


  clientDao.close();
%>

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <title>客户查询</title>
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
      grid-template-columns: 250px 250px 250px 250px;
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
    <div>系统用户名</div>
    <div>姓名</div>
    <div>性别</div>
    <div>电话</div>
  </div>

  <%
    for (Client client : clients) {


  %>
  <div class="main-context">
    <div><%=client.getClientNo()%></div>
    <div><%=client.getClientName()%></div>
    <div><%=client.getSex()%></div>
    <div><%=client.getPhone()%></div>
  </div>

  <%
    }
  %>
</div>


<script src="<%=path%>/Content/js/jquery-1.8.3.js" type="text/javascript"></script>
<script type="text/javascript">

</script>
</body>
</html>
