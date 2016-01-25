<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>个人信息</title>
<meta name="decorator" content="default" />
<script>
	$(function() {
		$("#inputForm").validate({
			submitHandler: function(form){
				loading('正在提交，请稍等...');
				form.submit();
			},
			errorContainer: "#messageBox",
			errorPlacement: function(error, element) {
				$("#messageBox").text("输入有误，请先更正。");
				if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-group")){
					error.appendTo(element.parent().parent());
				} else {
					error.appendTo(element.parent());
				}
			}
		});
	});
</script>
</head>
<body>
    <ul class="nav nav-tabs mb-2">
        <li class="active"><a href="${ctx}/sys/user/info">个人信息</a></li>
        <li><a href="${ctx}/sys/user/modifyPwd">修改密码</a></li>
    </ul>
    <div class="container-fluid">
        <form:form class="form-horizontal" id="inputForm" modelAttribute="user" action="${ctx}/sys/user/info" method="post">
            <sys:message content="${message}" />
            <div class="form-group">
                <label class="col-sm-2 control-label">头像:</label>
                <div class="col-sm-3">
                    <form:hidden id="nameImage" path="photo" htmlEscape="false" maxlength="255" />
                    <sys:ckfinder input="nameImage" type="images" uploadPath="/photo" selectMultiple="false" maxWidth="100" maxHeight="100" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">归属公司:</label>
                <div class="col-sm-3">
                    <p class="form-control-static">${user.company.name}</p>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">归属部门:</label>
                <div class="col-sm-3">
                    <p class="form-control-static">${user.office.name}</p>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">姓名:</label>
                <div class="col-sm-3">
                    <form:input cssClass="form-control required" path="name" htmlEscape="false" maxlength="50"  readonly="true" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">邮箱:</label>
                <div class="col-sm-3">
                    <form:input cssClass="form-control email" path="email" htmlEscape="false" maxlength="50" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">电话:</label>
                <div class="col-sm-3">
                    <form:input cssClass="form-control" path="phone" htmlEscape="false" maxlength="50" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">手机:</label>
                <div class="col-sm-3">
                    <form:input cssClass="form-control" path="mobile" htmlEscape="false" maxlength="50" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">备注:</label>
                <div class="col-sm-3">
                    <form:textarea cssClass="form-control" path="remarks" htmlEscape="false" rows="3" maxlength="200" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">用户类型:</label>
                <div class="col-sm-3">
                    <p class="form-control-static">${fns:getDictLabel(user.userType, 'sys_user_type', '无')}</p>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">用户角色:</label>
                <div class="col-sm-3">
                    <p class="form-control-static">${user.roleNames}</p>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">上次登录:</label>
                <div class="col-sm-3">
                    <p class="form-control-static">IP: ${user.oldLoginIp}</p>
                    <p class="form-control-static">时间：<fmt:formatDate value="${user.oldLoginDate}" type="both" dateStyle="full" />
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