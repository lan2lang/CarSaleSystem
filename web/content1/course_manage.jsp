<%@ page import="com.car.entity.CourseManage" %>
<%@ page import="com.car.service.CourseManageService" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%><!DOCTYPE html>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Bootstrap Admin</title>
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <link rel="stylesheet" type="text/css" href="lib/bootstrap/css/bootstrap.css">

    <link rel="stylesheet" type="text/css" href="stylesheets/theme.css">
    <link rel="stylesheet" href="lib/font-awesome/css/font-awesome.css">

    <script src="lib/jquery-1.7.2.min.js" type="text/javascript"></script>

    <!-- Demo page code -->

    <style type="text/css">

        .table-danger>th {
            background-color: #f5c6cb;
        }

        .table th, .table td {
            line-height: 30px;
        }
    </style>

</head>

<%
    CourseManageService cmService=new CourseManageService();
    String path= request.getContextPath();
%>

<body class="">

    <div class="">

        <div class="header">

            <h1 class="page-title">课程管理</h1>
        </div>

        <ul class="breadcrumb">
            <li><a href="welcome.jsp">Home</a> <span class="divider">/</span></li>
            <li class="active">Course</li>
            <span class="divider">/</span>
            <li class="active">Manage</li>
        </ul>

        <div class="container-fluid">
            <div class="row-fluid">

                <div class="btn-toolbar">
                    <button data-toggle="modal" data-target="#staticBackdrop1" class="btn btn-primary"><i class=""></i>Add</button>
                    <button class="btn">Import</button>
                    <button class="btn">Export</button>
                    <div class="btn-group">
                    </div>
                </div>
<%--                <br><br><br><br>--%>
                <div class="well">
                    <table class="table table-hover table-striped">
                        <thead>
                            <tr class="table-danger">
                                <th scope="col">#</th>
                                <th scope="col">课程编号</th>
                                <th scope="col">课程名称</th>
                                <th scope="col">任课老师</th>
                                <th scope="col">状态</th>
                                <th scope="col">操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                int j=1;

                                for (CourseManage cm : cmService.selInfo()) {
                            %>
                            <tr >
                                <td><%=j%></td>
                                <td class="no"><%=cm.getCourseNo()%></td>
                                <td><%=cm.getCourseName()%></td>
                                <td>

                                    <%
                                        if(cm.getTeacher()==null){
                                    %>
                                    暂无
                                    <%
                                        }else{
                                    %>

                                    <%=cm.getTeacher()%>

                                    <%
                                        }
                                    %>

                                </td>
                                <td><%=cm.getState()%></td>
                                <td>
                                    <a href="javascript:;"><i class="icon-pencil"></i></a>
                                    <a href="#myModal" role="button" data-toggle="modal"><i class="icon-remove"></i></a>
                                </td>
                            </tr>
                            <%
                                    j++;
                                }
                            %>
                        </tbody>
                    </table>
                </div>

<%--                删除的模态框--%>
                <div class="modal small hide fade" id="myModal" tabindex="-1" role="dialog"
                    aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h3 id="myModalLabel">Delete Confirmation</h3>
                    </div>
                    <div class="modal-body">
                        <p class="error-text"><i class="icon-warning-sign modal-icon"></i>你确定要删除这门课程吗？</p>
                    </div>
                    <div class="modal-footer">
                        <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
                        <button  id="delCon" class="btn btn-danger" data-dismiss="modal">Delete</button>
                    </div>
                </div>


            </div>
        </div>
    </div>

    <div class="modal fade" id="staticBackdrop1" data-backdrop="static" data-keyboard="false"
         tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

                <%--         头部--%>
                <div class="modal-header">
                    <h5 class="modal-title" id="staticBackdropLabel">请填写课程信息</h5>
                </div>

                <form action="<%=path%>/checkCode" method="post" id="addForm">

                    <%--             身体--%>
                    <div class="modal-body">

                        <div class="input-group mb-3 ">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="addon1">课程编号</span>
                            </div>
                            <input id="txtName" name="courseNo" type="text" class="form-control"
                                   placeholder="CourseNo" aria-label="Username"
                                   aria-describedby="basic-addon1">
                        </div>

                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="addon2">课程名称</span>
                            </div>
                            <input id="txtAge" name="courseName" type="text" class="form-control" placeholder="CourseName"
                                   aria-label="Username" aria-describedby="basic-addon1">
                        </div>


                    </div>
                    <%--             底部--%>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary"
                                data-dismiss="modal">取消
                        </button>
                        <input id="addCon" type="button" class="btn btn-primary" value="提交">
                    </div>
                </form>
            </div>
        </div>
    </div>


    <script src="lib/bootstrap/js/bootstrap.js"></script>

    <script type="text/javascript">

        $("[rel=tooltip]").tooltip();

        $(function () {

            $('.demo-cancel-click').click(function () { return false; });

            /**
             删除
             **/
            del();

            /**
             新增
             **/
            // add();

            /**
             修改
             **/
            alter();

        });

        /**
         删除
         **/
        function del() {

            //当删除按钮被点击时
            $(".icon-remove").click(function (){

                //获取到要删除的课程编号
                $("#delCon").val($(this).parent().parent().prev().prev().prev().prev().text());

            });

            //当确认删除按钮被点击时
            $("#delCon").click(function (){

                //定义变量接收课程编号
                var courseNo= $("#delCon").val();
                // alert(courseNo);

                //异步请求删除课程
                $.ajax({
                    // 地址
                    url: "<%=path%>/course2",
                    data:{"op":"del","courseNo":courseNo},
                    type:"post",
                    dataType:"json",
                    success: function(msg){
                    }
                });

                //重新加载当前界面
                location.reload();
            });
        }

        /**
         修改
         **/
        function alter() {

            //当修改按钮被点击时
            $(".icon-pencil").click(function (){

                //定义变量接收课程开放状态
                var state=$(this).parent().parent().prev().text();
                // alert(state);

                //如果为开启，则改为关闭
                if (state=="开启"){

                    $(this).parent().parent().prev().text("关闭");

                }else{

                    $(this).parent().parent().prev().text("开启");

                }

            });

            //重新加载当前界面
            // location.reload();
        }
    </script>

</body>

</html>
