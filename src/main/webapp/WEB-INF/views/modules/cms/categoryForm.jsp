<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>栏目管理</title>
<meta name="decorator" content="default"/>
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
		<li><a href="${ctx}/cms/category/">栏目列表</a></li>
		<li class="active"><a href="${ctx}/cms/category/form?id=${category.id}&parent.id=${category.parent.id}">栏目<shiro:hasPermission name="cms:category:edit">${not empty category.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cms:category:edit">查看</shiro:lacksPermission></a></li>
	</ul>
    <div class="container-fluid">
    	<form:form id="inputForm" modelAttribute="category" action="${ctx}/cms/category/save" method="post" class="form-horizontal">
    		<form:hidden path="id"/>
    		<sys:message content="${message}"/>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">归属机构:</label>
    			<div class="col-sm-3">
                    <sys:treeselect id="office" name="office.id" value="${category.office.id}" labelName="office.name" labelValue="${category.office.name}"
    					title="机构" url="/sys/office/treeData" cssClass="required"/>
    			</div>
    		</div>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">上级栏目:</label>
    			<div class="col-sm-3">
                    <sys:treeselect id="category" name="parent.id" value="${category.parent.id}" labelName="parent.name" labelValue="${category.parent.name}"
    					title="栏目" url="/cms/category/treeData" extId="${category.id}" cssClass="required"/>
    			</div>
    		</div>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">栏目模型:</label>
    			<div class="col-sm-2">
    				<form:select path="module" cssClass="form-control">
    					<form:option value="" label="公共模型"/>
    					<form:options items="${fns:getDictList('cms_module')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
    				</form:select>
    			</div>
    		</div>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">栏目名称:</label>
    			<div class="col-sm-3">
    				<form:input path="name" htmlEscape="false" maxlength="50" class="required form-control"/>
    			</div>
    		</div>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">缩略图:</label>
    			<div class="col-sm-3">
    				<form:hidden path="image" htmlEscape="false" maxlength="255"/>
    				<sys:ckfinder input="image" type="thumb" uploadPath="/cms/category"/>
    			</div>
    		</div>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">链接:</label>
    			<div class="col-sm-3">
    				<form:input path="href" class="form-control" htmlEscape="false" maxlength="200"/>
    			</div>
				<p class="form-control-static help-inline">栏目超链接地址，优先级“高”</p>
    		</div>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">目标:</label>
    			<div class="col-sm-3">
    				<form:input path="target" class="form-control" htmlEscape="false" maxlength="200"/>
    			</div>
				<p class="form-control-static help-inline">栏目超链接打开的目标窗口，新窗口打开，请填写：“_blank”</p>
    		</div>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">描述:</label>
    			<div class="col-sm-3">
    				<form:textarea path="description" htmlEscape="false" rows="4" maxlength="200" class="form-control"/>
    			</div>
    		</div>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">关键字:</label>
    			<div class="col-sm-3">
    				<form:input path="keywords" class="form-control" htmlEscape="false" maxlength="200"/>
    			</div>
				<p class="form-control-static help-inline">填写描述及关键字，有助于搜索引擎优化</p>
    		</div>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">排序:</label>
    			<div class="col-sm-3">
    				<form:input path="sort" htmlEscape="false" maxlength="11" class="required digits form-control"/>
    			</div>
				<p class="form-control-static help-inline">栏目的排列次序</p>
    		</div>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">在导航中显示:</label>
    			<div class="col-sm-2">
                    <label class="form-control-static">
        				<form:radiobuttons path="inMenu" items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
                    </label>
    			</div>
				<p class="form-control-static help-inline">是否在导航中显示该栏目</p>
    		</div>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">在分类页中显示列表:</label>
    			<div class="col-sm-2">
                    <label class="form-control-static">
        				<form:radiobuttons path="inList" items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
                    </label>
    			</div>
				<p class="form-control-static help-inline">是否在分类页中显示该栏目的文章列表</p>
    		</div>
    		<div class="form-group">
    			<label class="col-sm-2 control-label" title="默认展现方式：有子栏目显示栏目列表，无子栏目显示内容列表。">展现方式:</label>
    			<div class="col-sm-5">
                    <label class="form-control-static">
        				<form:radiobuttons path="showModes" items="${fns:getDictList('cms_show_modes')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
                    </label>
                    <%--
    				<form:select path="showModes" class="input-medium">
    					<form:option value="" label="默认"/>
    					<form:options items="${fns:getDictList('cms_show_modes')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
    				</form:select><span class="help-inline"></span> --%>
    			</div>
    		</div>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">是否允许评论:</label>
    			<div class="col-sm-3">
                    <label class="form-control-static">
        				<form:radiobuttons path="allowComment" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                    </label>
    			</div>
    		</div>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">是否需要审核:</label>
    			<div class="col-sm-3">
                    <label class="form-control-static">
        				<form:radiobuttons path="isAudit" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                    </label>
    			</div>
    		</div>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">自定义列表视图:</label>
    			<div class="col-sm-3">
                    <form:select path="customListView" cssClass="form-control">
                        <form:option value="" label="默认视图"/>
                        <form:options items="${listViewList}" htmlEscape="false"/>
                    </form:select>
    			</div>
                <p class="form-control-static help-inline">自定义列表视图名称必须以"${category_DEFAULT_TEMPLATE}"开始</p>
    		</div>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">自定义内容视图:</label>
    			<div class="col-sm-3">
                    <form:select path="customContentView" cssClass="form-control">
                        <form:option value="" label="默认视图"/>
                        <form:options items="${contentViewList}" htmlEscape="false"/>
                    </form:select>
    			</div>
                <p class="form-control-static help-inline">自定义内容视图名称必须以"${article_DEFAULT_TEMPLATE}"开始</p>
    		</div>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">自定义视图参数:</label>
    			<div class="col-sm-3">
                    <form:input path="viewConfig" class="form-control" htmlEscape="true"/>
    			</div>
                <p class="form-control-static help-inline">视图参数例如: {count:2, title_show:"yes"}</p>
    		</div>
    		<div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
        			<shiro:hasPermission name="cms:category:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保存"/></shiro:hasPermission>
        			<input id="btnCancel" class="btn btn-default" type="button" value="返回" onclick="history.go(-1)"/>
                </div>
    		</div>
    	</form:form>
    </div>
</body>
</html>