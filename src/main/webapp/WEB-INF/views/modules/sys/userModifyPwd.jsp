<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>修改密码</title>
<meta name="decorator" content="default" />
<script>
    $(function() {
        $(".oldPassword").focus();
        $("#inputForm").validate({
            rules: {
            },
            messages: {
                confirmNewPassword: {equalTo: "输入与上面相同的密码"}
            },
            submitHandler: function(form){
                loading('正在提交，请稍等...');
                form.submit();
            },
            errorContainer: "#messageBox",
            errorPlacement: function(error, element) {
                $("#messageBox").text("输入有误，请先更正。");
                error.appendTo(element.parent());
            }
        });
    });
</script>
</head>
<body>
    <ul class="nav nav-tabs mb-2">
        <li><a href="${ctx}/sys/user/info">个人信息</a></li>
        <li class="active"><a href="${ctx}/sys/user/modifyPwd">修改密码</a></li>
    </ul>
    <div class="container-fluid">
        <form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/modifyPwd" method="post" class="form-horizontal">
            <form:hidden path="id" />
            <sys:message content="${message}" />
            <div class="form-group has-feedback has-required">
                <label class="col-sm-2 control-label">旧密码:</label>
                <div class="col-sm-3">
                    <input class="form-control required" name="oldPassword" type="password" maxlength="50"/>
                    <span class="glyphicon glyphicon-asterisk form-control-feedback" aria-hidden="true"></span>
                </div>
            </div>
            <div class="form-group has-feedback has-required">
                <label class="col-sm-2 control-label">新密码:</label>
                <div class="col-sm-3">
                    <input class="form-control required" id="newPassword" name="newPassword" type="password" maxlength="50"/>
                    <span class="glyphicon glyphicon-asterisk form-control-feedback" aria-hidden="true"></span>
                </div>
            </div>
            <div class="form-group has-feedback has-required">
                <label class="col-sm-2 control-label">确认新密码:</label>
                <div class="col-sm-3">
                    <input class="form-control required" name="confirmNewPassword" type="password" maxlength="50" equalTo="#newPassword" />
                    <span class="glyphicon glyphicon-asterisk form-control-feedback" aria-hidden="true"></span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <input id="btnSubmit" class="btn btn-primary" type="submit" value="保存" />
                </div>
            </div>
        </form:form>
    </div>
</body>
</html>