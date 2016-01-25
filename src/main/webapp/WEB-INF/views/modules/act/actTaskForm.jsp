<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>任务表单</title>
<meta name="decorator" content="default" />
</head>
<body>
    <ul class="nav nav-tabs mb-2">
        <li><a href="${ctx}/act/task/todo/">待办任务</a></li>
        <li><a href="${ctx}/act/task/historic/">已办任务</a></li>
        <li class="active">
            <a href="${ctx}/act/task/form?taskId=${act.taskId}&taskName=${act.taskName}&taskDefKey=${act.taskDefKey}&procInsId=${act.procInsId}&procDefId${act.procDefId}">${empty act.procInsId?"新建任务":"任务处理"}</a>
        </li>
    </ul>
    <div class="container-fluid">
        <form:form method="post" class="form-horizontal">
            <sys:message content="${message}" />
            <div id="formContent">
                <iframe id="reportFrame" src="${formUrl}" width="100%" height="500" style="border: 0;" noresize="noresize"></iframe>
            </div>
            <act:histoicFlow procInsId="${procInsId}" />
        </form:form>
    </div>
</body>
</html>
