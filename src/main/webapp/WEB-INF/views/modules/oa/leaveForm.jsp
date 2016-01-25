<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>请假管理</title>
<meta name="decorator" content="default" />
<script>
    $(function() {
        $("#name").focus();
        $("#inputForm").validate({
            submitHandler : function(form) {
                loading('正在提交，请稍等...');
                form.submit();
            },
            errorContainer : "#messageBox",
            errorPlacement : function(error, element) {
                $("#messageBox").text("输入有误，请先更正。");
                if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-group")) {
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
        <li><a href="${ctx}/oa/leave/">待办任务</a></li>
        <li><a href="${ctx}/oa/leave/list">所有任务</a></li>
        <shiro:hasPermission name="oa:leave:edit">
            <li class="active"><a href="${ctx}/oa/leave/form">请假申请</a></li>
        </shiro:hasPermission>
    </ul>
    <div class="container-fluid">
        <form:form id="inputForm" modelAttribute="leave" action="${ctx}/oa/leave/save" method="post" class="form-horizontal">
            <form:hidden path="id" />
            <sys:message content="${message}" />
            <div class="form-group">
                <label class="col-sm-2 control-label">请假类型：</label>
                <div class="col-sm-2">
                    <form:select path="leaveType" class="form-control">
                        <form:options items="${fns:getDictList('oa_leave_type')}" itemLabel="label" itemValue="value"
                            htmlEscape="false" />
                    </form:select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">开始时间：</label>
                <div class="col-sm-3">
                    <input id="startTime" name="startTime" type="text" readonly="readonly" maxlength="20" class="form-control datepicker required" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">结束时间：</label>
                <div class="col-sm-3">
                    <input id="endTime" name="endTime" type="text" readonly="readonly" maxlength="20" class="form-control datepicker required"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">请假原因：</label>
                <div class="col-sm-3">
                    <form:textarea path="reason" class="form-control required" rows="5" maxlength="20" />
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <shiro:hasPermission name="oa:leave:edit">
                        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保存" />
                    </shiro:hasPermission>
                    <input id="btnCancel" class="btn btn-default" type="button" value="返回" onclick="history.go(-1)" />
                </div>
            </div>
        </form:form>
    </div>
</body>
</html>
