<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>用户管理</title>
<meta name="decorator" content="default" />
<script>
    $(function() {
        $("#no").focus();
        $("#inputForm").validate({
            rules: {
                loginName: {remote: "${ctx}/sys/user/checkLoginName?oldLoginName=" + encodeURIComponent('${user.loginName}')}
            },
            messages: {
                loginName: {remote: "用户登录名已存在"},
                confirmNewPassword: {equalTo: "输入与上面相同的密码"}
            },
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
        <li><a href="${ctx}/sys/user/list">用户列表</a></li>
        <li class="active">
            <a href="${ctx}/sys/user/form?id=${user.id}">
                用户<shiro:hasPermission name="sys:user:edit">${not empty user.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:user:edit">查看</shiro:lacksPermission>
            </a>
        </li>
    </ul>
    <div class="container-fluid">
        <form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/save" method="post" class="form-horizontal">
            <form:hidden path="id" />
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
                    <sys:treeselect id="company" name="company.id" value="${user.company.id}" labelName="company.name" labelValue="${user.company.name}" title="公司"
                        url="/sys/office/treeData?type=1" cssClass="required" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">归属部门:</label>
                <div class="col-sm-3">
                    <sys:treeselect id="office" name="office.id" value="${user.office.id}" labelName="office.name" labelValue="${user.office.name}" title="部门"
                        url="/sys/office/treeData?type=2" cssClass="required" notAllowSelectParent="true" />
                </div>
            </div>
            <div class="form-group has-feedback has-required">
                <label class="col-sm-2 control-label">工号:</label>
                <div class="col-sm-3">
                    <form:input cssClass="form-control required" path="no" htmlEscape="false" maxlength="50"  />
                    <span class="glyphicon glyphicon-asterisk form-control-feedback" aria-hidden="true"></span>
                </div>
            </div>
            <div class="form-group has-feedback has-required">
                <label class="col-sm-2 control-label">姓名:</label>
                <div class="col-sm-3">
                    <form:input cssClass="form-control required" path="name" htmlEscape="false" maxlength="50" />
                    <span class="glyphicon glyphicon-asterisk form-control-feedback" aria-hidden="true"></span>
                </div>
            </div>
            <div class="form-group has-feedback has-required">
                <label class="col-sm-2 control-label">登录名:</label>
                <div class="col-sm-3">
                    <input id="oldLoginName" name="oldLoginName" type="hidden" value="${user.loginName}">
                    <form:input cssClass="form-control required userName" path="loginName" htmlEscape="false" maxlength="50" />
                    <span class="glyphicon glyphicon-asterisk form-control-feedback" aria-hidden="true"></span>
                </div>
            </div>
            <div class="form-group has-feedback has-required">
                <label class="col-sm-2 control-label">密码:</label>
                <div class="col-sm-3">
                    <input class="form-control" id="newPassword" name="newPassword" type="password" maxlength="50" class="${empty user.id?'required':''}" />
                    <c:if test="${empty user.id}">
                        <span class="glyphicon glyphicon-asterisk form-control-feedback" aria-hidden="true"></span>
                    </c:if>
                    <c:if test="${not empty user.id}">
                        <span class="help-inline">若不修改密码，请留空。</span>
                    </c:if>
                </div>
            </div>
            <div class="form-group has-feedback has-required">
                <label class="col-sm-2 control-label">确认密码:</label>
                <div class="col-sm-3">
                    <input class="form-control" name="confirmNewPassword" type="password" maxlength="50" equalTo="#newPassword" />
                    <c:if test="${empty user.id}">
                        <span class="glyphicon glyphicon-asterisk form-control-feedback" aria-hidden="true"></span>
                    </c:if>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">邮箱:</label>
                <div class="col-sm-3">
                    <form:input cssClass="form-control email" path="email" htmlEscape="false" maxlength="100" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">电话:</label>
                <div class="col-sm-3">
                    <form:input cssClass="form-control" path="phone" htmlEscape="false" maxlength="100" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">手机:</label>
                <div class="col-sm-3">
                    <form:input cssClass="form-control" path="mobile" htmlEscape="false" maxlength="100" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">是否允许登录:</label>
                <div class="col-sm-2">
                    <form:select path="loginFlag" class="form-control">
                        <form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" />
                    </form:select>
                </div>
                <p class="form-control-static help-inline">“是”代表此账号允许登录，“否”则表示此账号不允许登录</p>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">用户类型:</label>
                <div class="col-sm-2">
                    <form:select path="userType" class="form-control">
                        <form:option value="" label="请选择" />
                        <form:options items="${fns:getDictList('sys_user_type')}" itemLabel="label" itemValue="value" htmlEscape="false" />
                    </form:select>
                </div>
            </div>
            <div class="form-group has-required">
                <label class="col-sm-2 control-label">用户角色:</label>
                <div class="col-sm-8">
                    <label class="form-control-static">
                        <form:checkboxes path="roleIdList" items="${allRoles}" itemLabel="name" itemValue="id" htmlEscape="false" class="required" />
                        <span class="glyphicon glyphicon-asterisk form-control-feedback" aria-hidden="true"></span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">备注:</label>
                <div class="col-sm-3">
                    <form:textarea cssClass="form-control" path="remarks" htmlEscape="false" rows="3" maxlength="200" />
                </div>
            </div>
            <c:if test="${not empty user.id}">
                <div class="form-group">
                    <label class="col-sm-2 control-label">创建时间:</label>
                    <div class="col-sm-5">
                        <p class="form-control-static"><fmt:formatDate value="${user.createDate}" type="both" dateStyle="full" /></p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">最后登陆:</label>
                    <div class="col-sm-3">
                        <p class="form-control-static">IP: ${user.loginIp}时间：<fmt:formatDate value="${user.loginDate}" type="both" dateStyle="full" /></p>
                    </div>
                </div>
            </c:if>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <shiro:hasPermission name="sys:user:edit">
                        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保存" />
                    </shiro:hasPermission>
                    <input id="btnCancel" class="btn btn-default" type="button" value="返回" onclick="history.go(-1)" />
                </div>
            </div>
        </form:form>
    </div>
</body>
</html>