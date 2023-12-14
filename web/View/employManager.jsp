<%@ page import="com.car.dao.impl.StaffDao" %>
<%@ page import="com.car.entity.Staff" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page%>

<!DOCTYPE html>
<html lang="en">

<%--获取请求地址--%>
<%
  String path = request.getContextPath();
  StaffDao staffDao = new StaffDao();
  List<Staff> staff = null;
  try {
    staff = staffDao.selectAllStaff();
  } catch (Exception e) {
    throw new RuntimeException(e);
  } finally {
    staffDao.close();
  }

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
      grid-template-columns: 160px 160px 160px 160px 160px 200px;
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

    .button-color-yellow{
      background-color: #ffc107;
      border: 1px solid #ffc107;
    }

  </style>
</head>

<body>

<div class="main">
  <div class="main-title">
    <div>用户名</div>
    <div>姓名</div>
    <div>密码</div>
    <div>性别</div>
    <div>电话</div>
    <div>操作</div>
  </div>

  <%
    for (Staff staff1 : staff) {
  %>

    <div class="main-context">
      <div><%=staff1.getStaffNo()%></div>
      <div><%=staff1.getStaffName()%></div>
      <div><%=staff1.getPassword()%></div>
      <div><%=staff1.getSex()%></div>
      <div><%=staff1.getPhone()%></div>
      <div>
        <button class="button-color-yellow" onclick="text('<%=staff1.getStaffId()%>')">
          修改员工
        </button>
      </div>
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
