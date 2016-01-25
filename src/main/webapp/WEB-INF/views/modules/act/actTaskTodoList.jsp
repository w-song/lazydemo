<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>待办任务</title>
<meta name="decorator" content="default"/>
<script>
	/**
	 * 签收任务
	 */
	function claim(taskId) {
		$.get('${ctx}/act/task/claim' ,{taskId: taskId}, function(data) {
			if (data == 'true'){
	        	showTip('签收完成');
	            location = '${ctx}/act/task/todo/';
			}else{
	        	showTip('签收失败');
			}
	    });
	}
	// 提示输入对话框
    function promptx(title, lable, href, closed) {
        top.dialog({
            title : '提示',
            content : "<div class='form-search'>" + lable + "：<input type='text' id='txt' name='txt'/></div>",
            button : [ {
                value : '确定',
                callback : function() {
                    var txt = $("#txt").val();
                    if (txt == '') {
                        showTip("请输入" + lable + "。", 'error');
                        return false;
                    }
                    if (typeof href == 'function') {
                        href();
                    } else {
                        location = href + encodeURIComponent(txt);
                    }
                }
            }, {
                value : '关闭'
            } ]
        }).show();
        return false;
    }
</script>
</head>
<body>
	<ul class="nav nav-tabs mb-2">
		<li class="active"><a href="${ctx}/act/task/todo/">待办任务</a></li>
		<li><a href="${ctx}/act/task/historic/">已办任务</a></li>
		<li><a href="${ctx}/act/task/process/">新建任务</a></li>
	</ul>
    <div class="container-fluid">
    	<form:form id="searchForm" modelAttribute="act" action="${ctx}/act/task/todo/" method="get" class="breadcrumb form-inline form-search">
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
    				<th>创建时间</th>
    				<th>操作</th>
    			</tr>
    		</thead>
    		<tbody>
    			<c:forEach items="${list}" var="act">
    				<c:set var="task" value="${act.task}" />
    				<c:set var="vars" value="${act.vars}" />
    				<c:set var="procDef" value="${act.procDef}" />
    				<c:set var="status" value="${act.status}" />
    				<tr>
    					<td>
    						<c:if test="${empty task.assignee}">
    							<a href="javascript:claim('${task.id}');" title="签收任务">${fns:abbr(not empty act.vars.map.title ? act.vars.map.title : task.id, 60)}</a>
    						</c:if>
    						<c:if test="${not empty task.assignee}">
    							<a href="${ctx}/act/task/form?taskId=${task.id}&taskName=${fns:urlEncode(task.name)}&taskDefKey=${task.taskDefinitionKey}&procInsId=${task.processInstanceId}&procDefId=${task.processDefinitionId}&status=${status}">${fns:abbr(not empty vars.map.title ? vars.map.title : task.id, 60)}</a>
    						</c:if>
    					</td>
    					<td>
    						<a target="_blank" href="${pageContext.request.contextPath}/act/rest/diagram-viewer?processDefinitionId=${task.processDefinitionId}&processInstanceId=${task.processInstanceId}">${task.name}</a>
    					</td>
    					<td>${procDef.name}</td>
    					<td><b title='流程版本号'>V: ${procDef.version}</b></td>
    					<td><fmt:formatDate value="${task.createTime}" type="both"/></td>
    					<td>
    						<c:if test="${empty task.assignee}">
    							<a href="javascript:claim('${task.id}');">签收任务</a>
    						</c:if>
    						<c:if test="${not empty task.assignee}">
    							<a href="${ctx}/act/task/form?taskId=${task.id}&taskName=${fns:urlEncode(task.name)}&taskDefKey=${task.taskDefinitionKey}&procInsId=${task.processInstanceId}&procDefId=${task.processDefinitionId}&status=${status}">任务办理</a>
    						</c:if>
    						<shiro:hasPermission name="act:process:edit">
    							<c:if test="${empty task.executionId}">
    								<a href="${ctx}/act/task/deleteTask?taskId=${task.id}&reason=" onclick="return promptx('删除任务','删除原因',this.href);">删除任务</a>
    							</c:if>
    						</shiro:hasPermission>
    						<a target="_blank" href="${pageContext.request.contextPath}/act/rest/diagram-viewer?processDefinitionId=${task.processDefinitionId}&processInstanceId=${task.processInstanceId}">跟踪1</a>
    						<a target="_blank" href="${ctx}/act/task/trace/photo/${task.processDefinitionId}/${task.executionId}">跟踪2</a>
    					</td>
    				</tr>
    			</c:forEach>
    		</tbody>
    	</table>
    </div>
</body>
</html>
