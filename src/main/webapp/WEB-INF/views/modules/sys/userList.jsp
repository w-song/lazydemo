<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>用户管理</title>
<meta name="decorator" content="default" />
<script>
    $(function() {
        $("#btnExport").click(function(){
        	top.dialog({
        		title : '系统提示',
				content : '确定要导出用户数据吗？',
				button : [{
					value : '确定',
	            	callback: function () {
	            		$("#searchForm").attr("action", "${ctx}/sys/user/export");
	                    $("#searchForm").submit();
	            	},
	            	autofocus : true
				},{
					value : '取消'
				}]
        	}).show();
        });
        $("#btnImport").click(function(){
        	dialog({
        		title : '导入数据',
				content : $("#importBox").html(),
				button : [{
					value: '关闭'
				}],
				statusbar : '导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！'
        	}).show();
        });
    });
    function page(n,s){
        if(n) $("#pageNo").val(n);
        if(s) $("#pageSize").val(s);
        $("#searchForm").attr("action","${ctx}/sys/user/list");
        $("#searchForm").submit();
        return false;
    }
</script>
</head>
<body>
    <ul class="nav nav-tabs mb-2">
        <li class="active"><a href="${ctx}/sys/user/list">用户列表</a></li>
        <shiro:hasPermission name="sys:user:edit">
            <li><a href="${ctx}/sys/user/form">用户添加</a></li>
        </shiro:hasPermission>
    </ul>
    <div class="container-fluid">
        <form:form id="searchForm" modelAttribute="user" action="${ctx}/sys/user/list" method="post" class="breadcrumb form-inline form-search">
            <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
            <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
            <sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();" />
            <div class="row">
            	<div class="form-group">
                    <label>归属公司：</label>
                    <sys:treeselect id="company" name="company.id" value="${user.company.id}" labelName="company.name"
                            labelValue="${user.company.name}" title="公司" url="/sys/office/treeData?type=1" allowClear="true" />
                </div>
                <div class="form-group">
                    <label>登录名：</label>
                    <form:input cssClass="form-control" path="loginName" htmlEscape="false" maxlength="50" />
                </div>
            </div>
            <div class="row">
                <div class="form-group">
                    <label>归属部门：</label>
                    <sys:treeselect id="office" name="office.id" value="${user.office.id}" labelName="office.name"
                        labelValue="${user.office.name}" title="部门" url="/sys/office/treeData?type=2" allowClear="true" notAllowSelectParent="true" />
                </div>
                <div class="form-group">
                    <label>姓名：</label>
                    <form:input cssClass="form-control" path="name" htmlEscape="false" maxlength="50" />
                </div>
                <div class="form-group">
                    <div class="btn-group" role="group">
                        <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();" />
                        <input id="btnExport" class="btn btn-primary" type="button" value="导出" />
                        <input id="btnImport" class="btn btn-primary" type="button" value="导入" />
                    </div>
                </div>
            </div>
        </form:form>
        <sys:message content="${message}" />
        <table id="contentTable" class="table table-striped table-bordered">
            <thead>
                <tr>
                    <th>归属公司</th>
                    <th>归属部门</th>
                    <th class="sort-column login_name">登录名</th>
                    <th class="sort-column name">姓名</th>
                    <th>电话</th>
                    <th>手机</th>
                    <shiro:hasPermission name="sys:user:edit">
                        <th>操作</th>
                    </shiro:hasPermission>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${page.list}" var="user">
                    <tr>
                        <td>${user.company.name}</td>
                        <td>${user.office.name}</td>
                        <td><a href="${ctx}/sys/user/form?id=${user.id}">${user.loginName}</a></td>
                        <td>${user.name}</td>
                        <td>${user.phone}</td>
                        <td>${user.mobile}</td>
                        <shiro:hasPermission name="sys:user:edit">
                            <td>
                                <a href="${ctx}/sys/user/form?id=${user.id}">修改</a>
                                <a href="${ctx}/sys/user/delete?id=${user.id}" onclick="return confirmx('确认要删除该用户吗？', this.href)">删除</a>
                            </td>
                        </shiro:hasPermission>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <nav>${page}</nav>
        <div id="importBox" class="hide-element">
            <form id="importForm" action="${ctx}/sys/user/import" class="form-search" onsubmit="loading('正在导入，请稍等...');" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <input id="uploadFile" name="file" type="file"/>
                </div>
                <div class="form-group">
                    <input id="btnImportSubmit" class="btn btn-primary" type="submit" value="导入"/>
                    <a href="${ctx}/sys/user/import/template">下载模板</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>