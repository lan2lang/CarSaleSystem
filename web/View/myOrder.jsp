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
  //  如果没有session，跳转到登录界面(未实现)
  if (session.getAttribute("userinfo") == null) {

      System.out.println("尚未登录");

      //重定向到登录界面
//    response.sendRedirect(path+"/View/login.jsp");

  }
  String userinfo = session.getAttribute("userinfo").toString();
  String userName = "";
  String userId = "";

  // 是否是管理员 (管理员, 客户, 员工权限不同)
  if (userinfo.contains("admin")){
      userName = "admin";
      userId = "";
  } else {
      // 获取当前登录的用户是客户还是员工
      userName = userinfo.substring(userinfo.indexOf("(") + 1, userinfo.indexOf(",")-4);
      // 获取用户id
      userId = userinfo.substring(userinfo.indexOf(",") - 1, userinfo.indexOf(","));

  }
  OrderDao orderDao = new OrderDao();
  List<Order> client = orderDao.selectOrdersByType(userName,userId);
  orderDao.close();
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

  <%
    for (Order order : client) {
  %>

    <div class="main-context">
      <div><%=order.getDesc()%></div>
      <div><%=order.getOrderTime()%></div>
      <div>
        <button class="button-color-dark">
          <%=order.getStatus()%>
        </button>
      </div>
      <div>
<%--    只有客户有支付权限    --%>
        <%
            if ("待付款".equals(order.getStatus()) && "client".equals(userName)){
        %>
          <button class="button-color-yellow" onclick="payOrder(<%=order.getOrderId()%>)">
            立即支付
          </button>
        <%
          }
        %>

        <%
          if (!"已取消".equals(order.getStatus()) && !"已完成".equals(order.getStatus())){
        %>
        <button class="button-color-red" onclick="cancel(<%=order.getOrderId()%>)">
          取消订单
        </button>

        <%
          }
        %>
      </div>
    </div>

  <%
    }
  %>
</div>

<%
  if ("client".equals(userName)){
%>
  <button id="backHome" class="btn">
    返回首页
  </button>
<%
  }
%>

<script src="<%=path%>/Content/js/jquery-1.8.3.js" type="text/javascript"></script>
<script type="text/javascript">

  // 取消订单
  function cancel(id){
    $.ajax({
      url:"<%=path%>/buyCar?orderId=" + id,
      dataType: 'json',
      type: 'delete',
      contentType: 'application/json',
      success:function (data){
        if (data.code === 0){
          alert(data.msg)
        } else {
          window.location.reload()
        }
      },
      error: function () {
        alert("删除失败")
      }
    })
  }

  // 订单支付
  function payOrder(id){
      $.ajax({
          url:"<%=path%>/buyCar?orderId=" + id,
          dataType: 'json',
          type: 'put',
          contentType: 'application/json',
          success:function (data){
              if (data.code === 0){
                  alert(data.msg)
              } else {
                  window.location.reload()
              }
          },
          error: function () {
              alert("删除失败")
          }
      })
  }

  // 返回首页
  $("#backHome").click(function (){
    window.location.href = '<%=path%>/View/clientCarList.jsp'
  })

</script>
</body>
</html>
