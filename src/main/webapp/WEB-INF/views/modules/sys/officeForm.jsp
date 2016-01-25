<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>机构管理</title>
<meta name="decorator" content="default" />
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
        <li><a href="${ctx}/sys/office/list?id=${office.parent.id}&parentIds=${office.parentIds}">机构列表</a></li>
        <li class="active">
            <a href="${ctx}/sys/office/form?id=${office.id}&parent.id=${office.parent.id}">
                机构<shiro:hasPermission name="sys:office:edit">${not empty office.id?'修改':'添加'}</shiro:hasPermission>
                <shiro:lacksPermission name="sys:office:edit">查看</shiro:lacksPermission>
            </a>
        </li>
    </ul>
    <div class="container-fluid">
        <form:form id="inputForm" modelAttribute="office" action="${ctx}/sys/office/save" method="post" class="form-horizontal">
            <form:hidden path="id" />
            <sys:message content="${message}" />
            <div class="form-group">
                <label class="col-sm-2 control-label">上级机构:</label>
                <div class="col-sm-3">
                    <sys:treeselect id="office" name="parent.id" value="${office.parent.id}" labelName="parent.name" labelValue="${office.parent.name}" title="机构"
                        url="/sys/office/treeData" extId="${office.id}" cssClass="" allowClear="${office.currentUser.admin}" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">归属区域:</label>
                <div class="col-sm-3">
                    <sys:treeselect id="area" name="area.id" value="${office.area.id}" labelName="area.name" labelValue="${office.area.name}" title="区域"
                        url="/sys/area/treeData" cssClass="required" />
                </div>
            </div>
            <div class="form-group has-feedback has-required">
                <label class="col-sm-2 control-label">机构名称:</label>
                <div class="col-sm-3">
                    <form:input cssClass="form-control required" path="name" htmlEscape="false" maxlength="50" />
                    <span class="glyphicon glyphicon-asterisk form-control-feedback" aria-hidden="true"></span>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">机构编码:</label>
                <div class="col-sm-3">
                    <form:input cssClass="form-control" path="code" htmlEscape="false" maxlength="50" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">机构类型:</label>
                <div class="col-sm-3">
                    <form:select path="type" class="form-control">
                        <form:options items="${fns:getDictList('sys_office_type')}" itemLabel="label" itemValue="value" htmlEscape="false" />
                    </form:select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">机构级别:</label>
                <div class="col-sm-3">
                    <form:select path="grade" class="form-control">
                        <form:options items="${fns:getDictList('sys_office_grade')}" itemLabel="label" itemValue="value" htmlEscape="false" />
                    </form:select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">是否可用:</label>
                <div class="col-sm-2">
                    <form:select path="useable" class="form-control">
                        <form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" />
                    </form:select>
                </div>
                <p class="form-control-static help-inline">“是”代表此账号允许登陆，“否”则表示此账号不允许登陆</p>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">主负责人:</label>
                <div class="col-sm-3">
                    <sys:treeselect id="primaryPerson" name="primaryPerson.id" value="${office.primaryPerson.id}" labelName="office.primaryPerson.name"
                        labelValue="${office.primaryPerson.name}" title="用户" url="/sys/office/treeData?type=3" allowClear="true" notAllowSelectParent="true" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">副负责人:</label>
                <div class="col-sm-3">
                    <sys:treeselect id="deputyPerson" name="deputyPerson.id" value="${office.deputyPerson.id}" labelName="office.deputyPerson.name"
                        labelValue="${office.deputyPerson.name}" title="用户" url="/sys/office/treeData?type=3" allowClear="true" notAllowSelectParent="true" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">联系地址:</label>
                <div class="col-sm-3">
                    <form:input cssClass="form-control" path="address" htmlEscape="false" maxlength="50" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">邮政编码:</label>
                <div class="col-sm-3">
                    <form:input cssClass="form-control" path="zipCode" htmlEscape="false" maxlength="50" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">负责人:</label>
                <div class="col-sm-3">
                    <form:input cssClass="form-control" path="master" htmlEscape="false" maxlength="50" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">电话:</label>
                <div class="col-sm-3">
                    <form:input cssClass="form-control" path="phone" htmlEscape="false" maxlength="50" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">传真:</label>
                <div class="col-sm-3">
                    <form:input cssClass="form-control" path="fax" htmlEscape="false" maxlength="50" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">邮箱:</label>
                <div class="col-sm-3">
                    <form:input cssClass="form-control" path="email" htmlEscape="false" maxlength="50" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">备注:</label>
                <div class="col-sm-3">
                    <form:textarea cssClass="form-control" path="remarks" htmlEscape="false" rows="3" maxlength="200" />
                </div>
            </div>
            <c:if test="${empty office.id}">
                <div class="form-group">
                    <label class="col-sm-2 control-label">快速添加下级部门:</label>
                    <div class="col-sm-3">
                        <label class="form-control-static">
                            <form:checkboxes path="childDeptList" items="${fns:getDictList('sys_office_common')}" itemLabel="label" itemValue="value" htmlEscape="false" />
                        </label>
                    </div>
                </div>
            </c:if>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <shiro:hasPermission name="sys:office:edit">
                        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保存" />
                    </shiro:hasPermission>
                    <input id="btnCancel" class="btn btn-default" type="button" value="返回" onclick="history.go(-1)" />
                </div>
            </div>
        </form:form>
    </div>
</body>
</html>