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
    String carId = request.getParameter("carId");
    String userinfo = session.getAttribute("userinfo").toString();
    String clientId = userinfo.substring(userinfo.indexOf("clientId") + 9, userinfo.indexOf("clientId")+ 10);
    CarDao carDao = new CarDao();
    Car car = carDao.selectById(carId);
    carDao.close();
%>

<head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <title>车辆列表</title>
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

        .main {
            width: 1000px;
            height: 425px;
            margin: 50px auto;
            background-color: white;
            display: grid;
            grid-template-columns: 500px 480px;
            grid-template-rows: 425px;
            column-gap: 20px;
        }

        .main-content{
            display: grid;
            grid-template-columns: 480px;
            grid-template-rows: 100px 50px 50px 100px;
            align-items: center;
        }

        .main-content .main-content-piece{
            display: grid;
            grid-template-columns: 240px 240px;
            font-size: 20px;

        }


        .main div img{
            width: 100%;
            height: 425px;
            object-fit: cover;
        }

        #buyBtn {
            width: 100px;
            height: 40px;
            position: fixed;
            background-color: #dc3545;
            border: 1px solid #dc3545;
            border-radius: 5px;
            box-shadow: 0 6px 13px 0 rgba(0, 0, 0, .1);
            color: #fff;
        }

        .btn:hover, #buyBtn:hover{
            cursor: pointer;
        }


    </style>
</head>

<body>

<div class="main">
    <div class="img-contain"><img src="<%=path+"\\"+car.getPic()%>" alt=""></div>
    <div class="main-content">
        <div style="font-size: 40px;font-weight: bold"><%=car.getBrand()%>-<%=car.getModel()%></div>
        <div class="main-content-piece">
            <div>价格:</div>
            <div style="display:grid;justify-items: end;margin-right: 40px"><%=car.getPrice()%>0000元</div>
        </div>
        <div class="main-content-piece">
            <div>库存:</div>
            <div style="display:grid;justify-items: end;margin-right: 40px"><%=car.getCount()%>辆</div>
        </div>
        <div class="main-content-piece">
            <div></div>
            <div style="display:grid;justify-items: end;margin-right: 40px">
                <button id="buyBtn" >
                    立即订购
                </button>
            </div>
        </div>
    </div>
</div>


<button id="backHome" class="btn">
    返回首页
</button>

<script src="<%=path%>/Content/js/jquery-1.8.3.js" type="text/javascript"></script>
<script type="text/javascript">


    $("#buyBtn").click(function () {
        let buyCar = {
            carId: <%=carId%>,
            clientId: <%=clientId%>
        }
        $.ajax({
            url:"<%=path%>/buyCar",
            data: JSON.stringify(buyCar),
            dataType: 'json',
            type: 'post',
            contentType: 'application/json',
            success:function (data){
                if (data.code === 0){
                    alert(data.msg)
                } else {
                    window.location.href = "<%=path%>/View/myOrder.jsp";
                }

            },
            error: function () {
                alert("购买失败")
            }
        })
    })

    // 返回首页
    $("#backHome").click(function () {
        window.location.href = '<%=path%>/View/clientCarList.jsp'
    })

</script>
</body>
</html>
