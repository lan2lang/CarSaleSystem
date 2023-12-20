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

        .main-title, .main-context {
            width: 1000px;
            display: grid;
            grid-template-columns: 160px 160px 160px 160px 160px 200px;
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
            <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#modify"
                    onclick="modifyCar('<%=car.getCarId()%>')">
                修改
            </button>
        </div>
    </div>
    <%
            }
        }
    %>

    <button type="button" class="button-color-red addBtn" data-bs-toggle="modal" data-bs-target="#add">
        新增
    </button>


    <!-- 修改的 弹窗 (bootstrap导入)-->
    <div class="modal fade" id="modify" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
         aria-labelledby="modifyLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="modifyLabel">修改车辆</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="input-group input-group-lg mb-3">
                        <span class="input-group-text" id="input-brand">品牌</span>
                        <input id="modify-brand" type="text" class="form-control" aria-label="Sizing example input"
                               aria-describedby="inputGroup-sizing-lg" value="">
                    </div>
                    <div class="input-group input-group-lg mb-3">
                        <span class="input-group-text" id="input-model">型号</span>
                        <input id="modify-model" type="text" class="form-control" aria-label="Sizing example input"
                               aria-describedby="inputGroup-sizing-lg" value="">
                    </div>
                    <div class="input-group input-group-lg mb-3">
                        <span class="input-group-text" id="input-price">价格</span>
                        <input id="modify-price" type="text" class="form-control" aria-label="Sizing example input"
                               aria-describedby="inputGroup-sizing-lg" value="">
                    </div>
                    <div class="input-group input-group-lg">
                        <span class="input-group-text" id="input-count">库存数量</span>
                        <input id="modify-count" type="text" class="form-control" aria-label="Sizing example input"
                               aria-describedby="inputGroup-sizing-lg" value="">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">关闭</button>
                    <button id="modify-submit" type="button" class="btn btn-primary">确认</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 新增的 弹窗 (bootstrap导入)-->
    <div class="modal fade" id="add" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
         aria-labelledby="addLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="addLabel">新增员工</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form method="post" action="<%=path%>/upload" enctype="multipart/form-data" id="form">
                        <div class="mb-3">
                            <input class="form-control" onchange="submitImg()" type="file" id="formFile">
                        </div>
                    </form>
                    <div class="input-group input-group-lg mb-3">
                        <span class="input-group-text" id="add-input-brand">品牌</span>
                        <input id="add-brand" type="text" class="form-control" aria-label="Sizing example input"
                               aria-describedby="inputGroup-sizing-lg" value="">
                    </div>
                    <div class="input-group input-group-lg mb-3">
                        <span class="input-group-text" id="add-input-model">型号</span>
                        <input id="add-model" type="text" class="form-control" aria-label="Sizing example input"
                               aria-describedby="inputGroup-sizing-lg" value="">
                    </div>
                    <div class="input-group input-group-lg mb-3">
                        <span class="input-group-text" id="add-input-price">价格</span>
                        <input id="add-price" type="text" class="form-control" aria-label="Sizing example input"
                               aria-describedby="inputGroup-sizing-lg" value="">
                    </div>
                    <div class="input-group input-group-lg mb-3">
                        <span class="input-group-text" id="add-input-count">库存数量</span>
                        <input id="add-count" type="text" class="form-control" aria-label="Sizing example input"
                               aria-describedby="inputGroup-sizing-lg" value="">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="addCar()">确认</button>
                </div>
            </div>
        </div>
    </div>

</div>
<iframe name="hidden_iframe" id="hidden_iframe" style="display: none"></iframe>

<script src="<%=path%>/Content/js/jquery-1.8.3.js" type="text/javascript"></script>
<script type="text/javascript">
    let modifyInfo = {
        carId: "",
        brand: "",
        model: "",
        count: "",
        price: "",
        pic: ""
    }
    let picUrl = "";
    function modifyCar(id){
        $.ajax({
            url: "<%=path%>/detail?id=" + id,
            dataType: 'json',
            type: 'post',
            contentType: 'application/json',
            success: function (data) {
                if (data.code === 0) {
                    alert(data.msg)
                } else {
                    $("#modify-brand").val(data.data.brand)
                    $("#modify-model").val(data.data.model)
                    $("#modify-price").val(data.data.price)
                    $("#modify-count").val(data.data.count)
                    modifyInfo.carId = id;
                    modifyInfo.pic = data.data.pic;
                }
            },
            error: function () {
                alert("修改失败")
            }
        })
    }

    $("#modify-submit").click(function (){

        modifyInfo.brand = $("#modify-brand").val()
        modifyInfo.model = $("#modify-model").val()
        modifyInfo.price = $("#modify-price").val()
        modifyInfo.count = $("#modify-count").val()
        console.log(modifyInfo)
        $.ajax({
            url: "<%=path%>/car",
            data: JSON.stringify(modifyInfo),
            dataType: 'json',
            type: 'put',
            contentType: 'application/json',
            success: function (data) {
                if (data.code === 0) {
                    alert(data.msg)
                } else {
                    window.location.reload()
                }
            },
            error: function () {
                alert("修改失败")
            }
        })

    })

    function submitImg(){
        let formData = new FormData();
        formData.append("file", $("#formFile")[0].files[0]);
        $.ajax({
            url: "<%=path%>/upload",
            type: "post",
            data: formData,
            processData: false, // 告诉jQuery不要去处理发送的数据
            contentType: false, // 告诉jQuery不要去设置Content-Type请求头
            dataType: 'text',
            success: function(data) {
                let params = JSON.parse(data)
                picUrl = params.data
                console.log(picUrl)
            },
            error: function(data) {

            }
        });
    }

    function addCar(){
        let carInfo = {
            brand: $("#add-brand").val(),
            model: $("#add-model").val(),
            count: $("#add-count").val(),
            price: $("#add-price").val(),
            pic: picUrl.toString()
        }
        console.log(carInfo)

        $.ajax({
            url: "<%=path%>/car",
            data: JSON.stringify(carInfo),
            dataType: 'json',
            type: 'post',
            contentType: 'application/json',
            success: function (data) {
                if (data.code === 0) {
                    alert(data.msg)
                } else {
                    window.location.reload()
                }
            },
            error: function () {
                alert("新增失败")
            }
        })
    }
</script>
</body>
</html>
