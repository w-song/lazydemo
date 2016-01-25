<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>通知管理</title>
<meta name="decorator" content="default" />
<script>
    $(function() {
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
        <li><a href="${ctx}/oa/oaNotify/">通知列表</a></li>
        <li class="active">
            <a href="${ctx}/oa/oaNotify/form?id=${oaNotify.id}">
            通知<shiro:hasPermission name="oa:oaNotify:edit">${oaNotify.status eq '1' ? '查看' : not empty oaNotify.id ? '修改' : '添加'}</shiro:hasPermission>
            <shiro:lacksPermission name="oa:oaNotify:edit">查看</shiro:lacksPermission></a>
        </li>
    </ul>
    <div class="container-fluid">
        <form:form id="inputForm" modelAttribute="oaNotify" action="${ctx}/oa/oaNotify/save" method="post" class="form-horizontal">
            <form:hidden path="id" />
            <sys:message content="${message}" />
            <div class="form-group has-required not-input">
                <label class="col-sm-2 control-label">类型：</label>
                <div class="col-sm-3">
                    <form:select path="type" class="form-control required">
                        <form:option value="" label="" />
                        <form:options items="${fns:getDictList('oa_notify_type')}" itemLabel="label" itemValue="value"
                            htmlEscape="false" />
                    </form:select>
                    <span class="glyphicon glyphicon-asterisk form-control-feedback" aria-hidden="true"></span>
                </div>
            </div>
            <div class="form-group has-feedback has-required">
                <label class="col-sm-2 control-label">标题：</label>
                <div class="col-sm-3">
                    <form:input path="title" htmlEscape="false" maxlength="200" class="form-control required" />
                    <span class="glyphicon glyphicon-asterisk form-control-feedback" aria-hidden="true"></span>
                </div>
            </div>
            <div class="form-group has-required not-input">
                <label class="col-sm-2 control-label">内容：</label>
                <div class="col-sm-3">
                    <form:textarea path="content" htmlEscape="false" rows="6" maxlength="2000" class="form-control required" />
                    <span class="glyphicon glyphicon-asterisk form-control-feedback" aria-hidden="true"></span>
                </div>
            </div>
            <c:if test="${oaNotify.status ne '1'}">
                <div class="form-group">
                    <label class="col-sm-2 control-label">附件：</label>
                    <div class="col-sm-3">
                        <form:hidden id="files" path="files" htmlEscape="false" maxlength="255" />
                        <sys:ckfinder input="files" type="files" uploadPath="/oa/notify" selectMultiple="true" />
                    </div>
                </div>
                <div class="form-group has-required">
                    <label class="col-sm-2 control-label">状态：</label>
                    <div class="col-sm-2">
                        <p class="form-control-static">
                            <form:radiobuttons path="status" items="${fns:getDictList('oa_notify_status')}" itemLabel="label"
                                itemValue="value" htmlEscape="false" class="required" />
                        </p>
                        <span class="glyphicon glyphicon-asterisk form-control-feedback" aria-hidden="true"></span>
                    </div>
                    <p class="form-control-static help-inline">发布后不能进行操作。</p>
                </div>
                <div class="form-group has-required not-input">
                    <label class="col-sm-2 control-label">接受人：</label>
                    <div class="col-sm-3">
                        <sys:treeselect id="oaNotifyRecord" name="oaNotifyRecordIds" value="${oaNotify.oaNotifyRecordIds}"
                            labelName="oaNotifyRecordNames" labelValue="${oaNotify.oaNotifyRecordNames}" title="用户"
                            url="/sys/office/treeData?type=3" cssClass="form-control required" notAllowSelectParent="true"
                            checked="true" />
                        <span class="glyphicon glyphicon-asterisk form-control-feedback" aria-hidden="true"></span>
                    </div>
                </div>
            </c:if>
            <c:if test="${oaNotify.status eq '1'}">
                <div class="form-group">
                    <label class="col-sm-2 control-label">附件：</label>
                    <div class="col-sm-3">
                        <form:hidden id="files" path="files" htmlEscape="false" maxlength="255" />
                        <sys:ckfinder input="files" type="files" uploadPath="/oa/notify" selectMultiple="true"
                            readonly="true" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">接受人：</label>
                    <div class="col-sm-3">
                        <table id="contentTable" class="table table-striped table-bordered">
                            <thead>
                                <tr>
                                    <th>接受人</th>
                                    <th>接受部门</th>
                                    <th>阅读状态</th>
                                    <th>阅读时间</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${oaNotify.oaNotifyRecordList}" var="oaNotifyRecord">
                                    <tr>
                                        <td>${oaNotifyRecord.user.name}</td>
                                        <td>${oaNotifyRecord.user.office.name}</td>
                                        <td>${fns:getDictLabel(oaNotifyRecord.readFlag, 'oa_notify_read', '')}</td>
                                        <td><fmt:formatDate value="${oaNotifyRecord.readDate}"
                                                pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        已查阅：${oaNotify.readNum} &nbsp; 未查阅：${oaNotify.unReadNum} &nbsp; 总共：${oaNotify.readNum + oaNotify.unReadNum}
                    </div>
                </div>
            </c:if>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <c:if test="${oaNotify.status ne '1'}">
                        <shiro:hasPermission name="oa:oaNotify:edit">
                            <input id="btnSubmit" class="btn btn-primary" type="submit" value="保存" />
                        </shiro:hasPermission>
                    </c:if>
                    <input id="btnCancel" class="btn btn-default" type="button" value="返回" onclick="history.go(-1)" />
                </div>
            </div>
        </form:form>
    </div>
</body>
</html>