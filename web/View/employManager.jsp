<%@ page import="com.car.dao.impl.StaffDao" %>
<%@ page import="com.car.entity.Staff" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page %>

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
        if (staff != null) {
            for (Staff staff1 : staff) {
    %>

    <div class="main-context">
        <div><%=staff1.getStaffNo()%>
        </div>
        <div><%=staff1.getStaffName()%>
        </div>
        <div><%=staff1.getPassword()%>
        </div>
        <div><%=staff1.getSex()%>
        </div>
        <div><%=staff1.getPhone()%>
        </div>
        <div>
            <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#modify"
                    onclick="modifyEmploy('<%=staff1.getStaffId()%>')">
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
                    <h1 class="modal-title fs-5" id="modifyLabel">修改员工</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="input-group input-group-lg mb-3">
                        <span class="input-group-text" id="input-name">姓名</span>
                        <input id="modify-name" type="text" class="form-control" aria-label="Sizing example input"
                               aria-describedby="inputGroup-sizing-lg" value="">
                    </div>
                    <div class="input-group input-group-lg mb-3">
                        <span class="input-group-text" id="input-password">密码</span>
                        <input id="modify-password" type="text" class="form-control" aria-label="Sizing example input"
                               aria-describedby="inputGroup-sizing-lg" value="">
                    </div>
                    <div class="input-group input-group-lg mb-3">
                        <span class="input-group-text" id="input-sex">性别</span>
                        <input id="modify-sex" type="text" class="form-control" aria-label="Sizing example input"
                               aria-describedby="inputGroup-sizing-lg" value="">
                    </div>
                    <div class="input-group input-group-lg">
                        <span class="input-group-text" id="input-电话">电话</span>
                        <input id="modify-phone" type="text" class="form-control" aria-label="Sizing example input"
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
                    <div class="input-group input-group-lg mb-3">
                        <span class="input-group-text" id="add-input-username">用户名</span>
                        <input id="addUsername" type="text" class="form-control" aria-label="Sizing example input"
                               aria-describedby="inputGroup-sizing-lg" value="">
                    </div>
                    <div class="input-group input-group-lg mb-3">
                        <span class="input-group-text" id="add-input-name">姓名</span>
                        <input id="addName" type="text" class="form-control" aria-label="Sizing example input"
                               aria-describedby="inputGroup-sizing-lg" value="">
                    </div>
                    <div class="input-group input-group-lg mb-3">
                        <span class="input-group-text" id="add-input-password">密码</span>
                        <input id="addPassword" type="text" class="form-control" aria-label="Sizing example input"
                               aria-describedby="inputGroup-sizing-lg" value="">
                    </div>
                    <div class="input-group input-group-lg mb-3">
                        <span class="input-group-text" id="add-input-sex">性别</span>
                        <input id="addSex" type="text" class="form-control" aria-label="Sizing example input"
                               aria-describedby="inputGroup-sizing-lg" value="">
                    </div>
                    <div class="input-group input-group-lg">
                        <span class="input-group-text" id="add-input-电话">电话</span>
                        <input id="addPhone" type="text" class="form-control" aria-label="Sizing example input"
                               aria-describedby="inputGroup-sizing-lg" value="">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="addEmploy()">确认</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="<%=path%>/Content/js/jquery-1.8.3.js" type="text/javascript"></script>
<script type="text/javascript">

    let modifyInfo = {
        staffNo: "",
        staffName: "",
        password: "",
        sex: "",
        phone: "",
        staffId: ""
    }

    function modifyEmploy(id){
        console.log(id)
        $.ajax({
            url: "<%=path%>/detail?id=" + id,
            dataType: 'json',
            type: 'get',
            contentType: 'application/json',
            success: function (data) {
                if (data.code === 0) {
                    alert(data.msg)
                } else {
                    $("#modify-name").val(data.data.staffName)
                    $("#modify-password").val(data.data.password)
                    $("#modify-sex").val(data.data.sex)
                    $("#modify-phone").val(data.data.phone)
                    modifyInfo.staffNo = data.data.staffNo;
                    modifyInfo.staffId = data.data.staffId;
                }
            },
            error: function () {
                alert("修改失败")
            }
        })
    }

    $("#modify-submit").click(function (){

        modifyInfo.staffName = $("#modify-name").val()
        modifyInfo.password = $("#modify-password").val()
        modifyInfo.sex = $("#modify-sex").val()
        modifyInfo.phone = $("#modify-phone").val()
        console.log(modifyInfo)
        $.ajax({
            url: "<%=path%>/staff",
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


    function addEmploy(){
        let employInfo = {
            staffNo: $("#addUsername").val(),
            staffName: $("#addName").val(),
            password: $("#addPassword").val(),
            sex: $("#addSex").val(),
            phone: $("#addPhone").val()
        }
        console.log(employInfo);
        $.ajax({
            url: "<%=path%>/staff",
            data: JSON.stringify(employInfo),
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
