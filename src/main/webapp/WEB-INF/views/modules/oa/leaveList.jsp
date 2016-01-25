<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>请假一览</title>
<meta name="decorator" content="default" />
<script>
    function page(n, s) {
        $("#pageNo").val(n);
        $("#pageSize").val(s);
        $("#searchForm").submit();
        return false;
    }
</script>
</head>
<body>
    <ul class="nav nav-tabs mb-2">
        <li><a href="${ctx}/oa/leave/">待办任务</a></li>
        <li class="active"><a href="${ctx}/oa/leave/list">所有任务</a></li>
        <shiro:hasPermission name="oa:leave:edit">
            <li><a href="${ctx}/oa/leave/form">请假申请</a></li>
        </shiro:hasPermission>
    </ul>
    <div class="container-fluid">
        <form:form id="searchForm" modelAttribute="leave" action="${ctx}/oa/leave/list" method="post"
            class="breadcrumb form-inline form-search">
            <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
            <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
            <div class="row">
                <div class="form-group">
                    <label>日期范围：</label>
                </div>
                <div class="form-group">
                    <div class="input-daterange input-group datepicker">
                        <input type="text" class="form-control" name="createDateStart"
                            value="<fmt:formatDate value="${leave.createDateStart}" pattern="yyyy-MM-dd"/>" readonly="readonly" maxlength="20" />
                        <span class="input-group-addon">至</span>
                        <input type="text" class="form-control" name="createDateEnd"
                            value="<fmt:formatDate value="${leave.createDateEnd}" pattern="yyyy-MM-dd"/>" readonly="readonly" maxlength="20" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="form-group">
                    <label>请假编号：</label>
                    <form:input path="ids" htmlEscape="false" maxlength="50" class="form-control" placeholder="多个用逗号或空格隔开" />
                </div>
                <div class="form-group">
                    <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" />
                </div>
            </div>
        </form:form>
        <sys:message content="${message}" />
        <table id="contentTable" class="table table-striped table-bordered">
            <thead>
                <tr>
                    <th>请假编号</th>
                    <th>创建人</th>
                    <th>创建时间</th>
                    <th>请假原因</th>
                    <th>当前节点</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${page.list}" var="leave">
                    <c:set var="task" value="${leave.task }" />
                    <c:set var="pi" value="${leave.processInstance }" />
                    <c:set var="hpi" value="${leave.historicProcessInstance }" />
                    <tr>
                        <td>${leave.id}</td>
                        <td>${leave.createBy.name}</td>
                        <td><fmt:formatDate value="${leave.createDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                        <td>${leave.reason}</td>
                        <c:if test="${not empty task}">
                            <td>${task.name}</td>
                            <td>
                                <a href="${ctx}/act/task/trace/photo/${task.processDefinitionId}/${task.executionId}" target="_blank">跟踪</a></td>
                        </c:if>
                        <c:if test="${empty task}">
                            <td>已结束</td>
                            <td>&nbsp;</td>
                        </c:if>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <nav>${page}</nav>
    </div>
</body>
</html>
