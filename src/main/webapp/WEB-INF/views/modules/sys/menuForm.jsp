\<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>菜单管理</title>
<meta name="decorator" content="default" />
<script>
    $(function() {
        $("#name").focus();
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
        <li><a href="${ctx}/sys/menu/">菜单列表</a></li>
        <li class="active">
            <a href="${ctx}/sys/menu/form?id=${menu.id}&parent.id=${menu.parent.id}">
                菜单<shiro:hasPermission name="sys:menu:edit">${not empty menu.id?'修改':'添加'}</shiro:hasPermission>
                <shiro:lacksPermission name="sys:menu:edit">查看</shiro:lacksPermission>
            </a>
        </li>
    </ul>
    <div class="container-fluid">
        <form:form id="inputForm" modelAttribute="menu" action="${ctx}/sys/menu/save" method="post" class="form-horizontal">
            <form:hidden path="id" />
            <sys:message content="${message}" />
            <div class="form-group">
                <label class="col-sm-2 control-label">上级菜单:</label>
                <div class="col-sm-3">
                    <sys:treeselect id="menu" name="parent.id" value="${menu.parent.id}" labelName="parent.name" labelValue="${menu.parent.name}" title="菜单"
                        url="/sys/menu/treeData" extId="${menu.id}" cssClass="required" />
                </div>
            </div>
            <div class="form-group has-feedback has-required">
                <label class="col-sm-2 control-label">名称:</label>
                <div class="col-sm-3">
                    <form:input path="name" htmlEscape="false" maxlength="50" cssClass="required form-control" />
                    <span class="glyphicon glyphicon-asterisk form-control-feedback" aria-hidden="true"></span>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">链接:</label>
                <div class="col-sm-6">
                    <form:input path="href" htmlEscape="false" maxlength="2000" cssClass="form-control" />
                </div>
                <p class="form-control-static help-inline">点击菜单跳转的页面</p>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">目标:</label>
                <div class="col-sm-3">
                    <form:input path="target" htmlEscape="false" maxlength="10" cssClass="form-control" />
                </div>
                <p class="form-control-static help-inline">链接地址打开的目标窗口，默认：mainFrame</p>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">图标:</label>
                <div class="col-sm-3">
                    <sys:iconselect id="icon" name="icon" value="${menu.icon}" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">排序:</label>
                <div class="col-sm-3">
                    <form:input path="sort" htmlEscape="false" maxlength="50" cssClass="required digits form-control" />
                </div>
                <p class="form-control-static help-inline">排列顺序，升序</p>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">可见:</label>
                <div class="col-sm-2">
                    <label class="form-control-static">
                        <form:radiobuttons path="isShow" items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value" htmlEscape="false" cssClass="required" />
                    </label>
                </div>
                <p class="form-control-static help-inline">该菜单或操作是否显示到系统菜单中</p>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">权限标识:</label>
                <div class="col-sm-3">
                    <form:input path="permission" htmlEscape="false" maxlength="100" cssClass="form-control" />
                </div>
                <p class="form-control-static help-inline">控制器中定义的权限标识，如：@RequiresPermissions("权限标识")</p>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">备注:</label>
                <div class="col-sm-6">
                    <form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" cssClass="form-control" />
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <shiro:hasPermission name="sys:menu:edit">
                        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保存" />&nbsp;</shiro:hasPermission>
                    <input id="btnCancel" class="btn btn-default" type="button" value="返回" onclick="history.go(-1)" />
                </div>
            </div>
        </form:form>
    </div>
</body>
</html>