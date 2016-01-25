<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>部署流程 - 流程管理</title>
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
        <li><a href="${ctx}/act/process/">流程管理</a></li>
        <li class="active"><a href="${ctx}/act/process/deploy/">部署流程</a></li>
        <li><a href="${ctx}/act/process/running/">运行中的流程</a></li>
    </ul>
    <div class="container-fluid">
        <sys:message content="${message}" />
        <form id="inputForm" action="${ctx}/act/process/deploy" method="post" enctype="multipart/form-data"
            class="form-horizontal">
            <div class="form-group">
                <label class="col-sm-2 control-label">流程分类：</label>
                <div class="col-sm-2">
                    <select id="category" name="category" class="required form-control">
                        <c:forEach items="${fns:getDictList('act_category')}" var="dict">
                            <option value="${dict.value}">${dict.label}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">流程文件：</label>
                <div class="col-sm-3">
                    <input type="file" id="file" name="file" class="required form-control-upload" />
                </div>
                <p class="form-control-static help-inline">支持文件格式：zip、bar、bpmn、bpmn20.xml</p>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <input id="btnSubmit" class="btn btn-primary" type="submit" value="提交" />
                    <input id="btnCancel" class="btn btn-default" type="button" value="返回" onclick="history.go(-1)" />
                </div>
            </div>
        </form>
    </div>
</body>
</html>
