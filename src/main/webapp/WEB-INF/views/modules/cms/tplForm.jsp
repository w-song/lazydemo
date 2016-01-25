<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>模板管理</title>
	<meta name="decorator" content="default"/>
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
		<li class="active"><a>模板管理</a></li>
	</ul>
    <div class="container-fluid">
    	<form:form id="inputForm" modelAttribute="template" action="${ctx}/cms/template/save" method="post" class="form-horizontal">
            <form:hidden path="name" />
    		<sys:message content="${message}"/>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">文件名:</label>
    			<div class="col-sm-3">
    				<form:input path="filename" htmlEscape="false" maxlength="50" class="required"/>
    			</div>
    		</div>
    		<div class="form-group">
                <form:textarea id="source" path="source" htmlEscape="true" cssStyle="width:100%;height:460px;"/>
                <%--<sys:ckeditor replace="source" uploadPath="/cms/template" />--%>
    		</div>
    		<div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
        			<shiro:hasPermission name="cms:template:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保存"/></shiro:hasPermission>
        			<input id="btnCancel" class="btn btn-default" type="button" value="返回" onclick="history.go(-1)"/>
                </div>
    		</div>
    	</form:form>
    </div>
</body>
</html>