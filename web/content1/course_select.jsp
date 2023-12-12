<%@ page import="com.car.service.CourseSelectService" %>
<%@ page import="com.car.entity.CourseSelect" %>
<%@ page import="com.car.service.StudentService" %>
<%@ page import="com.car.entity.Student" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%><!DOCTYPE html>
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

    <script src="lib/jquery-1.8.1.min.js" type="text/javascript"></script>

    <!-- Demo page code -->

    <style type="text/css">

        .table th, .table td {
            line-height: 30px;
        }

        .brand .first {
            color: #ccc;
            font-style: italic;
        }

        .brand .second {
            color: #fff;
            font-weight: bold;
        }

        .table-danger>th {
            background-color: #f5c6cb;
        }

        button.bg-success:hover,
        button.bg-success:focus {
            background-color: #09aeee !important;
        }
    </style>

</head>

<%
    CourseSelectService csService=new CourseSelectService();
    StudentService stuService=new StudentService();
    String userId=(String) session.getAttribute("userId");
    String path= request.getContextPath();
%>

<body class="">
<c:if test="${ role == \"学生\" }">
    <div class="">
        <div class="header">
            <h1 class="page-title">学生选课</h1>
        </div>

        <ul class="breadcrumb">
            <li><a href="welcome.jsp">Home</a> <span class="divider">/</span></li>
            <li class="active">Course</li>
            <span class="divider">/</span>
            <li class="active">Select</li>
        </ul>

        <div class="container-fluid">
            <div class="row-fluid">

                <div class="btn-toolbar">
                    <button class="btn btn-primary"><i class=""></i>Here</button>
                    <button class="btn">Import</button>
                    <button class="btn">Export</button>
                    <div class="btn-group">
                    </div>
                </div>
                <div class="well">
                    <b style="font-size: 18px">课程名称：</b>

                    <!-- 下拉列表 -->
                    <select name="courseName" id="courseSel">
                        <option value="0">请选择</option>
                        <%
                            for (CourseSelect cs : csService.queryDisCourse(userId)) {
                        %>
                        <option value=<%=cs.getCourseNo()%>><%=cs.getCourseName()%></option>
                        <%
                            }
                        %>
                    </select>

                        <%--                    选课按钮--%>
                    <button class="bg-success">选课</button>

                    <table class="table table-hover table-dark">
                        <thead>
                        <tr class="table-danger">
                            <th scope="col">#</th>
                            <th scope="col">课程编号</th>
                            <th scope="col">课程名称</th>
                            <th scope="col">操作</th>
                        </tr>
                        </thead>
                        <tbody>

                        <%
                            int j=1;

                            for (CourseSelect cs : csService.queryCourses(userId)) {
                        %>
                        <tr >
                            <td><%=j%></td>
                            <td class="no"><%=cs.getCourseNo()%></td>
                            <td><%=cs.getCourseName()%></td>
                                <%--                                <td>99</td>--%>
                            <td>

                                <%
                                      if(cs.getScore().equals("0")){
                                %>
                                         <a href="#myModal" role="button" data-toggle="modal"><i class="icon-remove"></i></a>
                                <%
                                      }
                                %>


                            </td>
                        </tr>
                        <%
                                j++;
                            }
                        %>

                        </tbody>
                    </table>
                </div>






            </div>
        </div>
    </div>
</c:if>

<c:if test="${ role == \"教师\"}">

    <div class="">
        <div class="header">
            <h1 class="page-title">学生选课</h1>
        </div>

        <ul class="breadcrumb">
            <li><a href="welcome.jsp">Home</a> <span class="divider">/</span></li>
            <li class="active">Course</li>
            <span class="divider">/</span>
            <li class="active">Select</li>
        </ul>

        <div class="container-fluid">
            <div class="row-fluid">

                <div class="btn-toolbar">
                    <button class="btn btn-primary"><i class=""></i>Here</button>
                    <button class="btn">Import</button>
                    <button class="btn">Export</button>
                    <div class="btn-group">
                    </div>
                </div>
                <div class="well">
                    <b style="font-size: 18px">课程名称：</b>

                    <!-- 下拉列表 -->
                    <select name="courseName" id="courseSel2">
                        <option value="0"><%=csService.queryCoursesByTeach(userId).get(0).getCourseName()%></option>
                    </select>

                    <table class="table table-hover table-dark">
                        <thead>
                        <tr class="table-danger">
                            <th scope="col">#</th>
                            <th scope="col">学号</th>
                            <th scope="col">姓名</th>
                            <th scope="col">性别</th>
                        </tr>
                        </thead>
                        <tbody>

                        <%
                            int j=1;

                            for (Student stu : stuService.queryStusByTeach(userId)) {
                        %>
                        <tr >
                            <td><%=j%></td>
                            <td><%=stu.getStu_no()%></td>
                            <td><%=stu.getName()%></td>
                            <td><%=stu.getSex()%></td>

                        </tr>
                        <%
                                j++;
                            }
                        %>

                        </tbody>
                    </table>
                </div>


            </div>
        </div>
    </div>

</c:if>

<c:if test="${ role == \"管理员\"}">

    <%
        userId="3";
    %>
    <div class="">
        <div class="header">
            <h1 class="page-title">学生选课</h1>
        </div>

        <ul class="breadcrumb">
            <li><a href="welcome.jsp">Home</a> <span class="divider">/</span></li>
            <li class="active">Course</li>
            <span class="divider">/</span>
            <li class="active">Select</li>
        </ul>

        <div class="container-fluid">
            <div class="row-fluid">

                <div class="btn-toolbar">
                    <button class="btn btn-primary"><i class=""></i>Here</button>
                    <button class="btn">Import</button>
                    <button class="btn">Export</button>
                    <div class="btn-group">
                    </div>
                </div>
                <div class="well">
                    <b style="font-size: 18px">课程名称：</b>

                    <!-- 下拉列表 -->
                    <select name="courseName" id="courseSel4">
                        <option value="0"><%=csService.queryCoursesByTeach(userId).get(0).getCourseName()%></option>
                    </select>

                    <table class="table table-hover table-dark">
                        <thead>
                        <tr class="table-danger">
                            <th scope="col">#</th>
                            <th scope="col">学号</th>
                            <th scope="col">姓名</th>
                            <th scope="col">性别</th>
                        </tr>
                        </thead>
                        <tbody>

                        <%
                            int j=1;

                            for (Student stu : stuService.queryStusByTeach(userId)) {
                        %>
                        <tr >
                            <td><%=j%></td>
                            <td><%=stu.getStu_no()%></td>
                            <td><%=stu.getName()%></td>
                            <td><%=stu.getSex()%></td>

                        </tr>
                        <%
                                j++;
                            }
                        %>

                        </tbody>
                    </table>
                </div>


            </div>
        </div>
    </div>

</c:if>

<%--删除模态框--%>
<div class="modal small hide fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="myModalLabel">Delete Confirmation</h3>
    </div>
    <div class="modal-body">
        <p class="error-text"><i class="icon-warning-sign modal-icon"></i>Are you sure you want to
            delete the course?</p>
    </div>
    <div class="modal-footer">
        <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
        <button id="delCon" class="btn btn-danger" data-dismiss="modal" value="">Delete</button>
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
         选课
         **/
        add();
    });

    /**
     选课
     **/
    function add() {

        //当点击选课时
        $(".bg-success").click(function (){

            var selCourse=$("#courseSel option:selected").val();

            //如果未选择课程，就提示
            if (selCourse==0){

                $("#courseSel").focus();

                //如果选择了就进行选课
            }else{
                // alert(selCourse);
                //异步请求
                $.ajax({
                    // 地址
                    url: "<%=path%>/course",
                    data:{"op":"add","courseNo":selCourse},
                    type:"post",
                    dataType:"json",
                    success: function(msg){
                        //刷新页面
                        location.reload();
                    }
                });
            }




        });
    }

    /**
     删除
     **/
    function del() {

        //当删除按钮被点击时
        $(".icon-remove").click(function (){

            //获取到要删除的课程编号
            $("#delCon").val($(this).parent().parent().prev().prev().text());

        });

        //当确认删除按钮被点击时
        $("#delCon").click(function (){

            //定义变量接收课程编号
            var courseNo= $("#delCon").val();

            //异步请求删除课程
            $.ajax({
                // 地址
                url: "<%=path%>/course",
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

</script>

</body>



</html>
