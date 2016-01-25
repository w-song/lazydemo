<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>已办任务</title>
	<meta name="decorator" content="default"/>
	<script>
		function page(n,s){
        	location = '${ctx}/act/task/historic/?pageNo='+n+'&pageSize='+s;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs mb-2">
		<li><a href="${ctx}/act/task/todo/">待办任务</a></li>
		<li class="active"><a href="${ctx}/act/task/historic/">已办任务</a></li>
		<li><a href="${ctx}/act/task/process/">新建任务</a></li>
	</ul>
    <div class="container-fluid">
    	<form:form id="searchForm" modelAttribute="act" action="${ctx}/act/task/historic/" method="get" class="breadcrumb form-inline form-search">
    		<div class="row">
                <div class="form-group">
                    <label>日期范围：</label>
                </div>
                <div class="form-group">
                    <div class="input-daterange input-group datepicker">
                        <input type="text" class="form-control" name="beginDate"
                            value="<fmt:formatDate value="${act.beginDate}" pattern="yyyy-MM-dd"/>" readonly="readonly" maxlength="20" />
                        <span class="input-group-addon">至</span>
                        <input type="text" class="form-control" name="endDate"
                            value="<fmt:formatDate value="${act.endDate}" pattern="yyyy-MM-dd"/>" readonly="readonly" maxlength="20" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="form-group">
                    <label>流程类型：</label>
                    <form:select path="procDefKey" class="form-control">
                        <form:option value="" label="全部流程"/>
                        <form:options items="${fns:getDictList('act_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                    </form:select>
                </div>
                <div class="form-group">
                    <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
                </div>
            </div>
    	</form:form>
    	<sys:message content="${message}"/>
    	<table id="contentTable" class="table table-striped table-bordered">
    		<thead>
    			<tr>
    				<th>标题</th>
    				<th>当前环节</th>
    				<th>流程名称</th>
    				<th>流程版本</th>
    				<th>完成时间</th>
    				<th>操作</th>
    			</tr>
    		</thead>
    		<tbody>
    			<c:forEach items="${page.list}" var="act">
    				<c:set var="task" value="${act.histTask}" />
    				<c:set var="vars" value="${act.vars}" />
    				<c:set var="procDef" value="${act.procDef}" />
    				<c:set var="status" value="${act.status}" />
    				<tr>
    					<td>
    						<a href="${ctx}/act/task/form?taskId=${task.id}&taskName=${fns:urlEncode(task.name)}&taskDefKey=${task.taskDefinitionKey}&procInsId=${task.processInstanceId}&procDefId=${task.processDefinitionId}&status=${status}">${fns:abbr(not empty vars.map.title ? vars.map.title : task.id, 60)}</a>
    					</td>
    					<td>
    						<a target="_blank" href="${pageContext.request.contextPath}/act/rest/diagram-viewer?processDefinitionId=${task.processDefinitionId}&processInstanceId=${task.processInstanceId}">${task.name}</a>
    					</td>
    					<td>${procDef.name}</td>
    					<td><b title='流程版本号'>V: ${procDef.version}</b></td>
    					<td><fmt:formatDate value="${task.endTime}" type="both"/></td>
    					<td>
    						<a href="${ctx}/act/task/form?taskId=${task.id}&taskName=${fns:urlEncode(task.name)}&taskDefKey=${task.taskDefinitionKey}&procInsId=${task.processInstanceId}&procDefId=${task.processDefinitionId}&status=${status}">详情</a>
    					</td>
    				</tr>
    			</c:forEach>
    		</tbody>
    	</table>
    	<nav>${page}</nav>
    </div>
</body>
</html>
