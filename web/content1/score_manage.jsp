<%@ page import="com.car.service.CourseSelectService" %>
<%@ page import="com.car.entity.CourseSelect" %>
<%@ page import="com.car.entity.ScoreManage" %>
<%@ page import="com.car.service.ScoreService" %><%--
  Created by IntelliJ IDEA.
  User: 皮皮
  Date: 2021/1/14
  Time: 9:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%><!DOCTYPE html>
<html lang="en">

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
        .table-danger>th {
            background-color: #ffeeba;
        }

        .table th, .table td {
            line-height: 30px;
        }
    </style>

</head>

<%
    CourseSelectService csService=new CourseSelectService();
    String userId=(String) session.getAttribute("userId");
    String path= request.getContextPath();
%>

<body class="">
<c:if test="${ role == \"学生\" }">
    <div class="">

        <div class="header">

            <h1 class="page-title">成绩管理</h1>
        </div>

        <ul class="breadcrumb">
            <li><a href="welcome.jsp">Home</a> <span class="divider">/</span></li>
            <li class="active">Score</li>
            <span class="divider">/</span>
            <li class="active">Manage</li>
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
                    <b style="font-size: 18px">学生：</b>

                    <!-- 下拉列表 -->
                    <select name="studentName" id="studentSel">
                        <option value="1">邹仁波</option>
                    </select>

                    <b style="font-size: 18px">课程：</b>

                    <!-- 下拉列表 -->
                    <select name="courseName" id="courseSel">
                        <option value="0">所有课程</option>
                        <%
                            for (CourseSelect cs : csService.queryCourses(userId)) {

                        %>
                        <option value=<%=cs.getCourseNo()%>><%=cs.getCourseName()%></option>
                        <%

                            }
                        %>
                    </select>

                    <table class="table table-hover table-dark">
                        <thead>
                        <tr class="table-danger">
                            <th scope="col">#</th>
                            <th scope="col">学号</th>
                            <th scope="col">姓名</th>
                            <th scope="col">课程编号</th>
                            <th scope="col">课程名称</th>
                            <th scope="col">成绩</th>
                        </tr>
                        </thead>
                        <tbody>

                        <%
                            int j=1;

                            for (CourseSelect cs : csService.queryCourses(userId)) {
                        %>
                        <tr >
                            <td><%=j%></td>
                            <td>${userNo}</td>
                            <td>${name}</td>
                            <td class="no"><%=cs.getCourseNo()%></td>
                            <td><%=cs.getCourseName()%></td>
                            <td><%=cs.getScore()%></td>

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

<c:if test="${ role == \"教师\" }">

    <%
        ScoreService scoreService =new ScoreService();
        String courseName= csService.queryCoursesByTeach(userId).get(0).getCourseName();
        String courseNo=csService.queryCoursesByTeach(userId).get(0).getCourseNo();
    %>
    <div class="">

        <div class="header">

            <h1 class="page-title">成绩管理</h1>
        </div>

        <ul class="breadcrumb">
            <li><a href="welcome.jsp">Home</a> <span class="divider">/</span></li>
            <li class="active">Score</li>
            <span class="divider">/</span>
            <li class="active">Manage</li>
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
                    <b style="font-size: 18px">学生：</b>

                    <!-- 下拉列表 -->
                    <select name="studentName" id="studentSel2">
                        <option value="0">所有学生</option>
                        <%
                            for (ScoreManage score : scoreService.queryStuInfos(userId)) {
                        %>
                        <option value=<%=score.getStuNo()%>><%=score.getName()%></option>
                        <%
                            }
                        %>
                    </select>

                    <b style="font-size: 18px">课程：</b>

                    <!-- 下拉列表 -->
                    <select name="courseName" id="courseSel2">
                        <option value="0"><%=courseName%></option>
                    </select>

                    <table class="table table-hover table-dark">
                        <thead>
                        <tr class="table-danger">
                            <th scope="col">#</th>
                            <th scope="col">学号</th>
                            <th scope="col">姓名</th>
                            <th scope="col">课程编号</th>
                            <th scope="col">课程名称</th>
                            <th scope="col">成绩</th>
                            <th scope="col">操作</th>
                        </tr>
                        </thead>
                        <tbody>

                        <%
                            int j=1;

                            for (ScoreManage score : scoreService.queryStuInfos(userId)) {
                        %>
                        <tr >
                            <td id="seq" class="0"><%=j%></td>
                            <td class="no"><%=score.getStuNo()%></td>
                            <td><%=score.getName()%></td>
                            <td ><%=courseNo%></td>
                            <td><%=courseName%></td>
                            <td hidden><input id="hidInp" value="<%=score.getScore()%>" hidden></td>
                            <td class="score"><%=score.getScore()%>

                            </td>
                               <td>
                                <a href="javascript:;"><i class="icon-pencil"></i></a>

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
<c:if test="${ role == \"管理员\" }">

    <%
        userId="3";
        ScoreService scoreService =new ScoreService();
        String courseName= csService.queryCoursesByTeach(userId).get(0).getCourseName();
        String courseNo=csService.queryCoursesByTeach(userId).get(0).getCourseNo();
    %>
    <div class="">

        <div class="header">

            <h1 class="page-title">成绩管理</h1>
        </div>

        <ul class="breadcrumb">
            <li><a href="welcome.jsp">Home</a> <span class="divider">/</span></li>
            <li class="active">Score</li>
            <span class="divider">/</span>
            <li class="active">Manage</li>
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
                    <b style="font-size: 18px">学生：</b>

                    <!-- 下拉列表 -->
                    <select name="studentName" id="studentSel3">
                        <option value="0">所有学生</option>
                        <%
                            for (ScoreManage score : scoreService.queryStuInfos(userId)) {
                        %>
                        <option value=<%=score.getStuNo()%>><%=score.getName()%></option>
                        <%
                            }
                        %>
                    </select>

                    <b style="font-size: 18px">课程：</b>

                    <!-- 下拉列表 -->
                    <select name="courseName" id="courseSel3">
                        <option value="0"><%=courseName%></option>
                    </select>

                    <table class="table table-hover table-dark">
                        <thead>
                        <tr class="table-danger">
                            <th scope="col">#</th>
                            <th scope="col">学号</th>
                            <th scope="col">姓名</th>
                            <th scope="col">课程编号</th>
                            <th scope="col">课程名称</th>
                            <th scope="col">成绩</th>
                            <th scope="col">操作</th>
                        </tr>
                        </thead>
                        <tbody>

                        <%
                            int j=1;

                            for (ScoreManage score : scoreService.queryStuInfos(userId)) {
                        %>
                        <tr >
                            <td id="seq" class="0"><%=j%></td>
                            <td class="no"><%=score.getStuNo()%></td>
                            <td><%=score.getName()%></td>
                            <td ><%=courseNo%></td>
                            <td><%=courseName%></td>
                            <td hidden><input id="hidInp" value="<%=score.getScore()%>" hidden></td>
                            <td class="score"><%=score.getScore()%>

                            </td>
                            <td>
                                <a href="javascript:;"><i class="icon-pencil"></i></a>

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
<script type="text/javascript">

    /**
     * 初始化
     */
    $(function (){

        /**
         *修改及录入成绩
         */
        typeInScore();

        /**
         删除
         **/
        del();

    });

    /**
     删除
     **/
    function del() {

        /*
        当删除按钮被点击时
        */
        $(".icon-remove").click(function (){

            $("#delCon").val($(this).parent().parent().prev().prev().prev().prev().prev().prev().prev().text());

        });

        /*
        当确认删除被点击时
         */
        $("#delCon").click(function (){

            var stuNo=$("tr:eq("+$(this).val()+")").find(".no").text();

            //成绩归零
            $("tr:eq("+$(this).val()+")").find(".score").text("0");

            //异步请求
            $.ajax({
                // 地址
                url: "<%=path%>/score",
                data:{"op":"upd","stuNo":stuNo,"score":"0"},
                type:"post",
                dataType:"json",
                success: function(msg){
                    // alert(msg);
                }
            });

            //重新加载当前界面()可以不用
            // location.reload();
        });
    }

    /**
     *修改及录入成绩
     */
    function typeInScore(){

        //当修改按钮被点击时
        $(".icon-pencil").click(function (){

            //记录序号(方便增删改查)
            $("#seq").attr("class",$(this).parent().parent().prev().prev().prev().prev().prev().prev().prev().text());

            //改变页面布局(成绩变为输入框)
            $(this).parent().parent().prev().html("<input type=\"text\" id=\"scoreIn\">\n" +
                "                              <span id=\"scoreSpan\" style=\"color: red\"></span>");

            $(this).parent().parent().html(" <button disabled id=\"conBtn\">确认</button>\n" +
                "                          <button id='cancelBtn'>取消</button>");

            //定位到输入框
            $("#scoreIn").focus();

            /**
             * 成绩录入合法检测
             */
            checkScore();

            //当取消按钮被点击时,恢复原样
            $("#cancelBtn").click(function (){

                //恢复原样
                recover(this,$(this).parent().prev().prev().children("input").val());

            });

            //当确认按钮被点击时,保存成绩到数据库
            $("#conBtn").click(function () {

                //成绩
                var score=$("#scoreIn").val();

                //更新隐藏框成绩
                recover(this,score);

                //保存
                save(score);

            });

        });

    }
    /**
     * 恢复原样
     */
    function recover(here,score) {

        //设置隐藏框成绩
        $(here).parent().prev().prev().children("input").val(score);

        //恢复成绩
        $(here).parent().prev().html($(here).parent().prev().prev().children("input").val());
        $(here).parent().html("<a href=\"javascript:;\"><i class=\"icon-pencil\"></i></a>\n");

        //重新绑定
        typeInScore();
        del();
    }


    /**
     * 保存成绩到数据库
     */
    function save(score) {

        //学号
        var stuNo=$("tr:eq("+$("#seq").attr("class")+")").find(".no").text();

        //异步请求
        $.ajax({
            // 地址
            url: "<%=path%>/score",
            data:{"op":"upd","stuNo":stuNo,"score":score},
            type:"post",
            dataType:"json",
            success: function(msg){
                // alert(msg);
            }
        });

        //重新加载当前界面()可以不用
        // location.reload();
    }

    /**
     * 成绩录入合法检测
     */
    function checkScore() {

        //当输入框失去焦点时
        $("#scoreIn").keyup(function (){

            //正整数正则
            var pattern = /[1-9]\d*/;

            //成绩
            var score =$(this).val();

            //如果成绩不合法（不是0~100之间的正整数），就提示,并定位到输入框
            if (pattern.test(score)&&score<=100&&score>=0) {

                $("#scoreSpan").html("");

                //合法之后，方可确认
                $("#conBtn").attr("disabled", false);

            }else {

                $("#scoreSpan").html("请输入0~100的正整数");

                $("#conBtn").attr("disabled", true);

                $(this).focus();

            }

        });
    }

</script>

<%--
    删除的模态框
--%>
<div class="modal small hide fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="myModalLabel">Confirmation</h3>
    </div>
    <div class="modal-body">
        <p class="error-text"><i class="icon-warning-sign modal-icon"></i>确定要将成绩归零吗？</p>
    </div>
    <div class="modal-footer">
        <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
        <button id="delCon" class="btn btn-danger" data-dismiss="modal">Confirm</button>
    </div>
</div>

<script src="lib/bootstrap/js/bootstrap.js"></script>
<script type="text/javascript">
    $("[rel=tooltip]").tooltip();
    $(function () {
        $('.demo-cancel-click').click(function () { return false; });
    });
</script>

</body>

</html>
