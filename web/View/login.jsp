<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" import="java.util.ArrayList,java.util.List"%>

<!DOCTYPE html>
<html lang="en">

<%--获取请求地址--%>
<% String path = request.getContextPath(); %>

<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="">

	<title>教务管理系统登录界面</title>

	<link rel="icon" href="<%=path%>/content1/images/my.ico">
	<link rel="stylesheet" type="text/css" href="../Registration3_files/reset.css">
	<link rel="stylesheet" type="text/css" href="../Registration3_files/t-sign.css">
	<link rel="stylesheet" type="text/css" href="../Registration3_files/t-futura.css">

	<script async="" src="file://www.google-analytics.com/analytics.js"></script>
	<script async="" src="../Registration3_files/analytics.js.下载"></script>
	<script type="text/javascript" src="../Registration3_files/jquery-1.10.2.min.js.下载"></script>
	<script type="text/javascript" src="../Registration3_files/t-sign-up.min.js.下载"></script>
	<script type="text/javascript" src="../Registration3_files/t-counters.js.下载"></script>
	<script type="text/javascript" src="../Registration3_files/jquery.saveutm.js.下载"></script>

	<script src="<%=path%>/content1/lib/jquery-1.7.2.min.js" type="text/javascript"></script>
	<script src="<%=path%>/Content/dist/js/popper.min.js" type="text/javascript"></script>
	<script src="<%=path%>/content1/lib/bootstrap/js/bootstrap.js"></script>

	<style>
		.theme .ts-form{
			background-image: linear-gradient(rgb(49, 99, 112),rgb(20,24,23));
		}

		#btnLogin{
			position: relative;
			padding: 10px 67px 11px;
			margin: 50px 0 0 0;
			border: 0;
			background: #ffe8c7;
			border-radius: 100px;
			font-size: 18px;
			color: #000;
		}
	</style>

	<script type="text/javascript">

		$(function() {

			<%
				// 验证Session
				if(session.getAttribute("state") == "false")
				{
//					System.out.println("登录失败");
				}
			%>

			//初始化登陆按钮点击事件
			$("#btnLogin").click(function() {

				// 验证用户名的合法性（是否为空，为空就提示，不为空就提交表单到服务器）
				if ($("#userName").val()==""){

					//提示用户输入用户名
					$("#lable1").show();
					$("#lable1").html("<span style=\"color: rgb(229,192,79)\">请输入用户名</span>");

					//定位到输入框
					$("#userName").focus();

				}else {

					//恢复原样
					$("#lable1").html("UserName");

					// 提交表单
					$("#form1").submit();
				}

			});

			/*
			防止lable拉垮
			 */
			function lablePre(){

				$(this).next().hide();

				if ($(this).val()==""){
					$(this).next().show();
				}
			}

			$("#userName,#passWord").change(lablePre);

		});
	</script>
</head>

<body class="theme" style="background-image: url(../Registration3_files/bg.jpg); background-attachment: fixed;">

<div class="ts-page">
	<div class="ts-page-wrapper">
		<div class="ts-form">
			<div class="ts-form-logo" style="padding-bottom:0px;">
			</div>
			<div class="ts-errormsg" style="margin-top:30px;">
				<div class="ts-errormsg__wrapper" id="errormsg"></div>
			</div>
			<form id="form1" name="form" action="<%=path%>/login" method="post">
				<div class="ts-inputs">
					<div style="position: absolute; left: -5000px;"><input type="text" name="tildachek9230"
																		   tabindex="-1" value="" id="tildachek9230"></div>
					<div class="ts-inputs__item"><label>
						<input type="text" required="" name="userName" id="userName"
															   class="ts-input ts-input_autofill-transparent" autocomplete="off">
						<div id="lable1" class="ts-placeholder">UserName</div>
					</label></div>
					<div class="ts-inputs__item ts-password-input-item"><label><input type="password" required=""
																					  name="passWord" id="passWord" class="ts-input" autocomplete="off">
						<div  class="ts-placeholder">PassWord</div>
					</label></div>

					<div class="text-center item" style="padding-top:0px;">
						<br><br><br><br>
						<a id="btnLogin" class="btn btn-primary pull-right">Log in</a>
					</div>
				</div>
			</form>
			<br>
			<div class="ts-terms-link" style="opacity:0.7; margin-top:10px;">
				Dedicated to providing you with the best service You'll be satisfied</div>
			<div class="ts-help-link" style="opacity:0.5; color:#fff;"><a href="../content1/egg.html">
				Don't have an account yet, please click </a></div>
		</div>
	</div>
</div>

</body>
</html>
