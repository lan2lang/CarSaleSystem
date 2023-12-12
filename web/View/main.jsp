<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	// 验证Session
     if(session.getAttribute("role") == null)
    {

		System.out.println("尚未登录");

		//重定向到登录界面
    	response.sendRedirect("login.jsp");

    }

//	System.out.println(session.getAttribute("userId"));
%>

<%--获取请求地址--%>
<% String path = request.getContextPath(); %>

<html lang="en">
<head>

	<meta content = "text/html; charset=UTF-8">
	<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="主界面">
	<meta name="author" content="邹仁波">

	<title>教务管理系统主界面</title>

<%--	标签图标	--%>
	<link rel="icon" href="<%=path%>/content1/images/Darling.ico">

<%--	css文件--%>
	<link rel="stylesheet" type="text/css" href="<%=path%>/content1/lib/bootstrap/css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/content1/stylesheets/theme.css">
	<link rel="stylesheet" href="<%=path%>/content1/lib/font-awesome/css/font-awesome.css">

<%--	js文件--%>
	<script src="<%=path%>/content1/lib/jquery-1.7.2.min.js" type="text/javascript"></script>
	<script src="<%=path%>/Content/dist/js/popper.min.js" type="text/javascript"></script>
	<script src="<%=path%>/content1/lib/bootstrap/js/bootstrap.js"></script>

	<script type="text/javascript">
		$("[rel=tooltip]").tooltip();
		$(function() {
			$('.demo-cancel-click').click(function() {
				return false;
			});
			// 初始化菜单点击事件
			$(".collapse li").each(function(index) {
				var curUrl = $(this).find("a").attr("data-href");
				$(this).click(function() {
					$("#contextFrame").attr("src", curUrl);
				});
				$(this).css("cursor", "pointer");
			});
		});
	</script>

	<style type="text/css">
		#line-chart {
			height: 300px;
			width: 800px;
			margin: 0px auto;
			margin-top: 1em;
		}

		.brand {
			font-family: georgia, serif;
		}

		.brand .first {
			color: #ccc;
			font-style: italic;
		}

		.brand .second {
			color: #fff;
			font-weight: bold;
		}

		#top1{
			background-image: linear-gradient(rgb(238, 139, 139), rgb(148, 53, 53));
		}

	</style>


</head>

<body class="">

<div class="navbar">
	<div class="navbar-inner" id="top1">
		<ul class="nav pull-right">
			<li><a href="#"
				   class="hidden-phone visible-tablet visible-desktop" role="button">${name}</a>
			</li>
			<li id="fat-menu" class="dropdown">
				<a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">
					<i class="icon-user"></i>

<%--					右上角的名字--%>
					${role}
					<i class="icon-caret-down"></i>
			</a>
				<ul class="dropdown-menu">

					<!-- 隐藏设置 -->
					<li><a tabindex="-1" class="visible-phone" href="#">Settings</a></li>
                    <li class="divider visible-phone"></li>

<%--					退出时回到登录界面--%>
					<li><a tabindex="-1" href="<%=path%>/View/login.jsp">退出</a></li>
				</ul>
			</li>
		</ul>
		<a class="brand" href="<%=path%>/content1/egg.html"><span class="first">Lang</span>
			<span class="second">教务管理系统</span></a>
	</div>
</div>

<!-- 左菜单栏 -->
<div class="sidebar-nav">

	<c:if test="${ role == \"管理员\" }" var = "isSystem">
		<a href="#user-menu" class="nav-header"
		   data-toggle="collapse"><i class="icon-dashboard"></i>用户管理 <i
				class="icon-chevron-up"></i></a>

		<ul id="user-menu" class="nav nav-list in collapse">
			<li><a data-href="<%=path%>/content1/student.jsp">学生管理</a></li>
			<li><a data-href="<%=path%>/content1/teacher.jsp">教师管理</a></li>
			<li><a data-href="<%=path%>/content1/edu_manage.jsp">教务人员管理</a></li>
			<li><a data-href="<%=path%>/content1/admin.jsp">管理人员管理</a></li>
		</ul>

		<a href="#others" class="nav-header" data-toggle="collapse"><i
				class="icon-dashboard"></i>教务管理 <i class="icon-chevron-up"></i></a>

		<ul id="others" class="nav nav-list in collapse">
			<li><a data-href="<%=path%>/content1/course_manage.jsp">课程管理</a></li>
			<li><a data-href="<%=path%>/content1/course_select.jsp">学生选课</a></li>
			<li><a data-href="<%=path%>/content1/score_manage.jsp">成绩管理</a></li>
			<li><a data-href="<%=path%>/content1/500.html">统计分析</a></li>
		</ul>

	</c:if>

	<c:if test="${ role == \"学生\" }">
		<a href="#others" class="nav-header " data-toggle="collapse"><i
				class="icon-dashboard"></i>功能列表 <i class="icon-chevron-up"></i></a>
		<ul id="others" class="nav nav-list in collapse">
			<li><a data-href="<%=path%>/content1/course_select.jsp">学生选课</a></li>
			<li><a data-href="<%=path%>/content1/score_manage.jsp">成绩管理</a></li>
		</ul>
	</c:if>

	<c:if test="${ role == \"教师\" }">
		<a href="#others" class="nav-header" data-toggle="collapse"><i
				class="icon-dashboard"></i>功能列表 <i class="icon-chevron-up"></i></a>
		<ul id="others" class="nav nav-list in collapse">
			<li><a data-href="<%=path%>/content1/course_select.jsp">学生选课</a></li>
			<li><a data-href="<%=path%>/content1/score_manage.jsp">成绩管理</a></li>
			<li><a data-href="<%=path%>/content1/500.html">统计分析</a></li>
		</ul>
	</c:if>

	<c:if test="${ role == \"教务人员\" }">
		<a href="#others" class="nav-header" data-toggle="collapse"><i
				class="icon-dashboard"></i>功能列表 <i class="icon-chevron-up"></i></a>
		<ul id="others" class="nav nav-list in collapse">
			<li><a data-href="<%=path%>/content1/student.jsp">查看学生信息</a></li>
			<li><a data-href="<%=path%>/content1/teacher.jsp">查看教师信息</a></li>
			<li><a data-href="<%=path%>/content1/course_manage.jsp">管理课程信息</a></li>
		</ul>
	</c:if>
</div>

<div class="content">
	<div style="position: absolute; left: 0px; top: 0px; bottom: 0px; right: 0px; padding: 0px">

		<iframe id="contextFrame" name="contextFrame" src="<%=path%>/content1/welcome.jsp"
				width="100%" height="100%">
		</iframe>

	</div>
</div>

</body>
</html>


