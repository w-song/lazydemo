<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>区域管理</title>
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
        <li><a href="${ctx}/sys/area/">区域列表</a></li>
        <li class="active">
            <a href="form?id=${area.id}&parent.id=${area.parent.id}">
                区域<shiro:hasPermission name="sys:area:edit">${not empty area.id?'修改':'添加'}</shiro:hasPermission>
                <shiro:lacksPermission name="sys:area:edit">查看</shiro:lacksPermission>
            </a>
        </li>
    </ul>
    <div class="container-fluid">
        <form:form id="inputForm" modelAttribute="area" action="${ctx}/sys/area/save" method="post" class="form-horizontal">
            <form:hidden path="id" />
            <sys:message content="${message}" />
            <div class="form-group">
                <label class="col-sm-2 control-label">上级区域:</label>
                <div class="col-sm-3">
                    <sys:treeselect id="area" name="parent.id" value="${area.parent.id}" labelName="parent.name" labelValue="${area.parent.name}" title="区域"
                        url="/sys/area/treeData" extId="${area.id}" allowClear="true" />
                </div>
            </div>
            <div class="form-group has-feedback has-required">
                <label class="col-sm-2 control-label">区域名称:</label>
                <div class="col-sm-3">
                    <form:input path="name" htmlEscape="false" maxlength="50" cssClass="form-control required" />
                    <span class="glyphicon glyphicon-asterisk form-control-feedback" aria-hidden="true"></span>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">区域编码:</label>
                <div class="col-sm-3">
                    <form:input cssClass="form-control" path="code" htmlEscape="false" maxlength="50" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">区域类型:</label>
                <div class="col-sm-3">
                    <form:select cssClass="form-control" path="type">
                        <form:options items="${fns:getDictList('sys_area_type')}" itemLabel="label" itemValue="value" htmlEscape="false" />
                    </form:select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">备注:</label>
                <div class="col-sm-3">
                    <form:textarea cssClass="form-control" path="remarks" htmlEscape="false" rows="3" maxlength="200" />
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <shiro:hasPermission name="sys:area:edit">
                        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保存" />
                    </shiro:hasPermission>
                    <input id="btnCancel" class="btn btn-default" type="button" value="返回" onclick="history.go(-1)" />
                </div>
            </div>
        </form:form>
    </div>
</body>
</html>