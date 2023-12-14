<%@ page import="com.car.dao.impl.CarDao" %>
<%@ page import="com.car.entity.dto.CarDto" %>
<%@ page import="com.car.entity.Car" %>
<%@ page import="java.util.List" %>
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
    <title>员工管理</title>
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

        .btn:hover, .button-color-red:hover, .button-color-yellow:hover {
            cursor: pointer;
        }

        .main {
            width: 1000px;
            height: 100%;
            margin: 10px auto;
            background-color: white;
            padding: 5px 10px;
        }

        .main-title, .main-context {
            width: 1000px;
            display: grid;
            grid-template-columns: 200px 200px 200px 200px 200px;
            grid-template-rows: 40px;
            justify-items: center;
            align-items: center;
            border-bottom: #eeeeee solid 1px;
        }

        .main-context {
            grid-template-rows: 60px !important;
        }

        .main-context div button {
            width: 100px;
            height: 40px;
            border-radius: 5px;
            color: #fff;
        }

        .button-color-red {
            background-color: #dc3545;
            border: 1px solid #dc3545;
        }

        .button-color-dark {
            background-color: #6c757d;
            border: 1px solid #6c757d;
        }

        .button-color-green {
            background-color: #198754;
            border: 1px solid #198754;
        }

        .button-color-yellow {
            background-color: #ffc107;
            border: 1px solid #ffc107;
        }

        .addBtn {
            width: 100px;
            height: 40px;
            position: fixed;
            top: 0;
            left: 0;
            margin: 15px 0 0 15px;
            /*background-color: #ffc107;*/
            /*border: 1px solid #ffc107;*/
            border-radius: 5px;
            box-shadow: 0 6px 13px 0 rgba(0, 0, 0, .1);
            color: #fff;
        }


    </style>
</head>

<body>
<%
    //获取车辆列表
    CarDao carDao = new CarDao();
    List<Car> cars = null;
    try {
        cars = carDao.selectALLCar(new CarDto("", "", ""));
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        carDao.close();
    }

%>
<div class="main">

    <div class="main-title">
        <div>品牌</div>
        <div>型号</div>
        <div>价格</div>
        <div>库存数量</div>
        <div>操作</div>
    </div>

    <%
        if (cars != null) {
            for (Car car : cars) {
    %>
    <div class="main-context">
        <div><%=car.getBrand()%>
        </div>
        <div><%=car.getModel()%>
        </div>
        <div>
            <%=car.getPrice()%>万
        </div>
        <div>
            <%=car.getCount()%>辆
        </div>

        <div>
            <button class="button-color-yellow">
                修改
            </button>
            <button class="button-color-red addBtn">
                新增
            </button>
        </div>
    </div>
    <%
            }
        }
    %>

</div>


<script src="<%=path%>/Content/js/jquery-1.8.3.js" type="text/javascript"></script>
<script type="text/javascript">

</script>
</body>
</html>
