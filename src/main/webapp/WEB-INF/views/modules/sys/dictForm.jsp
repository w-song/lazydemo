<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>字典管理</title>
<meta name="decorator" content="default" />
<script>
    $(function() {
        $("#value").focus();
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
        <li><a href="${ctx}/sys/dict/">字典列表</a></li>
        <li class="active">
            <a href="${ctx}/sys/dict/form?id=${dict.id}">
                字典<shiro:hasPermission name="sys:dict:edit">${not empty dict.id?'修改':'添加'}</shiro:hasPermission>
                <shiro:lacksPermission name="sys:dict:edit">查看</shiro:lacksPermission>
            </a>
        </li>
    </ul>
    <div class="container-fluid">
        <form:form id="inputForm" modelAttribute="dict" action="${ctx}/sys/dict/save" method="post" class="form-horizontal">
            <form:hidden path="id" />
            <sys:message content="${message}" />
            <div class="form-group has-feedback has-required">
                <label class="col-sm-2 control-label">键值:</label>
                <div class="col-sm-3">
                    <form:input path="value" htmlEscape="false" maxlength="50" cssClass="form-control required" />
                    <span class="glyphicon glyphicon-asterisk form-control-feedback" aria-hidden="true"></span>
                </div>
            </div>
            <div class="form-group has-feedback has-required">
                <label class="col-sm-2 control-label">标签:</label>
                <div class="col-sm-3">
                    <form:input path="label" htmlEscape="false" maxlength="50" cssClass="form-control required" />
                    <span class="glyphicon glyphicon-asterisk form-control-feedback" aria-hidden="true"></span>
                </div>
            </div>
            <div class="form-group has-feedback has-required">
                <label class="col-sm-2 control-label">类型:</label>
                <div class="col-sm-3">
                    <form:input path="type" htmlEscape="false" maxlength="50" cssClass="form-control required abc" />
                    <span class="glyphicon glyphicon-asterisk form-control-feedback" aria-hidden="true"></span>
                </div>
            </div>
            <div class="form-group has-feedback has-required">
                <label class="col-sm-2 control-label">描述:</label>
                <div class="col-sm-3">
                    <form:input path="description" htmlEscape="false" maxlength="50" cssClass="form-control required" />
                    <span class="glyphicon glyphicon-asterisk form-control-feedback" aria-hidden="true"></span>
                </div>
            </div>
            <div class="form-group has-feedback has-required">
                <label class="col-sm-2 control-label">排序:</label>
                <div class="col-sm-3">
                    <form:input path="sort" htmlEscape="false" maxlength="11" cssClass="form-control required digits" />
                    <span class="glyphicon glyphicon-asterisk form-control-feedback" aria-hidden="true"></span>
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
                    <shiro:hasPermission name="sys:dict:edit">
                        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保存" />
                    </shiro:hasPermission>
                    <input id="btnCancel" class="btn btn-default" type="button" value="返回" onclick="history.go(-1)" />
                </div>
            </div>
        </form:form>
    </div>
</body>
</html>