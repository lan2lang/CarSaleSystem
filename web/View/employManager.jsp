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
  <link rel="stylesheet" href="<%=path%>/Content/dist/css/bootstrap.css">
  <script src="<%=path%>/Content/dist/js/bootstrap.js"></script>
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
        <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#modify" onclick="text('<%=staff1.getStaffId()%>')">
          修改员工
        </button>
      </div>
    </div>

  <%
    }
  %>

  <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#add">
    新增员工
  </button>


  <!-- 修改的弹窗 (bootstrap导入)-->
  <div class="modal fade" id="modify" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modifyLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h1 class="modal-title fs-5" id="modifyLabel">修改员工</h1>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="input-group input-group-lg mb-3" >
            <span class="input-group-text" id="input-name">姓名</span>
            <input id="modify-name" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg">
          </div>
          <div class="input-group input-group-lg mb-3">
            <span class="input-group-text" id="input-password">密码</span>
            <input id="modify-password" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg">
          </div>
          <div class="input-group input-group-lg mb-3">
            <span class="input-group-text" id="input-sex">性别</span>
            <input id="modify-sex" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg">
          </div>
          <div class="input-group input-group-lg">
            <span class="input-group-text" id="input-电话">电话</span>
            <input id="modify-phone" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg">
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">关闭</button>
          <button id="modify-submit" type="button" class="btn btn-primary">确认</button>
        </div>
      </div>
    </div>
  </div>

  <!-- 新增的弹窗 (bootstrap导入)-->
  <div class="modal fade" id="add" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="addLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h1 class="modal-title fs-5" id="addLabel">修改员工</h1>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="input-group input-group-lg mb-3" >
            <span class="input-group-text" id="add-input-username">用户名</span>
            <input id="add-username" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg">
          </div>
          <div class="input-group input-group-lg mb-3" >
            <span class="input-group-text" id="add-input-name">姓名</span>
            <input id="add-name" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg">
          </div>
          <div class="input-group input-group-lg mb-3">
            <span class="input-group-text" id="add-input-password">密码</span>
            <input id="add-password" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg">
          </div>
          <div class="input-group input-group-lg mb-3">
            <span class="input-group-text" id="add-input-sex">性别</span>
            <input id="add-sex" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg">
          </div>
          <div class="input-group input-group-lg">
            <span class="input-group-text" id="add-input-电话">电话</span>
            <input id="add-phone" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg">
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">关闭</button>
          <button id="add-submit" type="button" class="btn btn-primary">确认</button>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="<%=path%>/Content/js/jquery-1.8.3.js" type="text/javascript"></script>
<script type="text/javascript">

</script>
</body>
</html>
