<%@ page import="com.car.service.TeacherService" %>
<%@ page import="com.car.entity.Teacher" %>
<%@ page import="com.car.entity.PageList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
        #line-chart {
            height:300px;
            width:800px;
            margin: 0px auto;
            margin-top: 1em;
        }
        .table th, .table td {
            line-height: 30px;
        }
        .table-danger, .table-danger>td, .table-danger>th {
            background-color: #f5c6cb;
        }
    </style>


</head>

<body class="">
<%
    TeacherService teaService=new TeacherService();
    String path= request.getContextPath();
%>
<div class="">

    <div class="header">

        <h1 class="page-title">Teacher</h1>
    </div>

    <ul class="breadcrumb">
        <li><a href="welcome.jsp">Home</a> <span class="divider">/</span></li>
        <li class="active">Users</li>
    </ul>

    <div class="container-fluid">
        <div class="row-fluid">

            <div class="btn-toolbar">
                <button class="btn btn-primary"><i class="icon-plus"></i> New User</button>
                <button class="btn">Import</button>
                <button class="btn">Export</button>
                <div class="btn-group">
                </div>
            </div>
            <div class="well">
                <table class="table">

                    <thead>
                    <tr class="table-danger">
                        <th>#</th>
                        <th>教师编号</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <%--            <th>所教课程</th>--%>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>

                    <%
                        int j=1;
                        String pageIndex= request.getParameter("pageIndex");

                        if(pageIndex==null||pageIndex.equals("Begin")){
                            pageIndex="1";
                        }else if(pageIndex.equals("End")){
                            pageIndex=String.valueOf(teaService.getTeasByPage(1,5).getPageCount());
                        }
                        PageList<Teacher> pageList=teaService.getTeasByPage(Integer.parseInt(pageIndex),5);

                        for (Teacher teacher : pageList.getData()) {
                    %>
                    <tr >
                        <td><%=j%></td>
                        <td><%=teacher.getTeach_no()%></td>
                        <td><%=teacher.getName()%></td>
                        <td><%=teacher.getSex()%></td>
                        <td>
                            <a href="403.html"><i class="icon-pencil"></i></a>
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
            <div class="pagination">
                <ul>
                    <li><a href="javascript:;">Begin</a></li>

                    <%
                        for (int z=1;pageList.getPageCount()>=z;z++) {
                            String temp="a"+z;
                    %>
                    <li ><a href="javascript:;" class=<%=temp%>><%=z%></a></li>
                    <%
                        }
                    %>
                    <li><a href="javascript:;">End</a></li>
                </ul>
            </div>

            <div class="modal small hide fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h3 id="myModalLabel">Delete Confirmation</h3>
                </div>
                <div class="modal-body">
                    <p class="error-text"><i class="icon-warning-sign modal-icon"></i>Are you sure you want to delete the user?</p>
                </div>
                <div class="modal-footer">
                    <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
                    <button class="btn btn-danger" data-dismiss="modal">Delete</button>
                </div>
            </div>



            <!-- <footer>
                <hr>

               Purchase a site license to remove this link from the footer: http://www.portnine.com/bootstrap-themes -->
            <!--                        <p class="pull-right">A <a href="http://www.portnine.com/bootstrap-themes" target="_blank">Free Bootstrap Theme</a> by <a href="http://www.portnine.com" target="_blank">Portnine</a></p>-->

            <!--                        <p>&copy; 2012 <a href="http://www.portnine.com" target="_blank">Portnine</a></p>-->
            <!--                    </footer> &ndash;&gt;-->

        </div>
    </div>
</div>



<script src="lib/bootstrap/js/bootstrap.js"></script>
<script type="text/javascript">
    $("[rel=tooltip]").tooltip();
    $(function() {
        $('.demo-cancel-click').click(function(){return false;});

        /**
         * 当前页面突出
         **/
        var str=".pagination .a"+<%=pageIndex%>;
        $(str).css("backgroundColor","#f5c6cb");

        /**
         * 分页
         **/
        setPage();

    });

    /**
    * 分页
    **/
    function setPage() {

        /*
        当a标签被点击时
         */
        $(".pagination a").click(function (){

            //获取a标签的值
            var pageIndex=$(this).text();


            $("#pageInp").val(pageIndex);

            //

            // 提交表单
            $("#pageForm").submit();

            //异步请求(需要建servlet)
            <%--$.ajax({--%>
            <%--    // 地址--%>
            <%--    url: "<%=path%>/content1/student.jsp",--%>
            <%--    data:{"pageIndex":pageIndex},--%>
            <%--    type:"post",--%>
            <%--    dataType:"json",--%>
            <%--    success: function(msg){--%>
            <%--        alert(3);--%>
            <%--        //刷新页面--%>
            <%--        // location.reload();--%>
            <%--    }--%>
            <%--});--%>

            <%--                <%--%>
            <%--                session.setAttribute("index",pageIndex);--%>
            <%--                %>--%>
        });
    }
</script>

<form  method="post" action="teacher.jsp" id ="pageForm">
    <input id = "pageInp" type = "hidden" name="pageIndex">
</form>

</body>
</html>


