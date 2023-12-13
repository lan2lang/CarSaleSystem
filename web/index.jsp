<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>$Title$</title>
    <script src="lib/jquery-1.7.2.min.js" type="text/javascript"></script>
</head>
<body>
<%
    //重定向到登录界面
//    response.sendRedirect("View/main.jsp");
    String path = request.getContextPath();
%>
<%=path%>
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
                                                                          name="passWord" id="passWord" class="ts-input"
                                                                          autocomplete="off">
            <div class="ts-placeholder">PassWord</div>
        </label></div>

        <input type="text" name="role" value="0">
        <button id="btnLogin" class="btn btn-primary pull-right">Log in</button>

    </div>
</form>
<script type="text/javascript">
    var dataInfo = {
        user:"user",// 用户名
        pwd:"pwd",// 密码，实际开发应用加密算法加密SHA1/SHA2/MD5)，这里采用明文传输
    }
    $.ajax({
        url: "<%=path%>/register",// 传参方式一：URL传参方式
        type: 'POST',
        dataType: 'json',
        data: JSON.stringify(dataInfo),// 传参方式二：请求体body传参，序列化后的JSON字符串
        contentType: 'application/json',
        success: function (data) {
            console.log(data);
        },
        error: function () {
            console.log("error")
        }
    });

    //初始化登陆按钮点击事件
    $("#btnLogin").click(function () {

        // 验证用户名的合法性（是否为空，为空就提示，不为空就提交表单到服务器）
        if ($("#userName").val() == "") {

            //提示用户输入用户名
            $("#lable1").show();
            $("#lable1").html("<span style=\"color: rgb(229,192,79)\">请输入用户名</span>");

            //定位到输入框
            $("#userName").focus();

        } else {

            //恢复原样
            $("#lable1").html("UserName");

            // 提交表单
            $("#form1").submit();
        }

    });
</script>
</body>
</html>
