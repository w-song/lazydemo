<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>运行中的流程</title>
<meta name="decorator" content="default" />
<script>
    function page(n, s) {
        location = '${ctx}/act/process/running/?pageNo=' + n + '&pageSize=' + s;
    }
    function updateCategory(id, category) {
        $("#categoryBoxId").val(id);
        $("#categoryBoxCategory").val(category);
        dialog({
            title : '设置分类',
            content : $("#categoryBox").html()
        }).show();
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
        <li><a href="${ctx}/act/process/">流程管理</a></li>
        <li><a href="${ctx}/act/process/deploy/">部署流程</a></li>
        <li class="active"><a href="${ctx}/act/process/running/">运行中的流程</a></li>
    </ul>
    <div class="container-fluid">
        <form id="searchForm" action="${ctx}/act/process/running/" method="post" class="breadcrumb form-inline form-search">
            <div class="row">
                <div class="form-group">
                    <label>流程实例ID：</label>
                    <input type="text" id="procInsId" name="procInsId" value="${procInsId}" class="form-control" />
                </div>
                <div class="form-group">
                    <label>流程定义Key：</label>
                    <input type="text" id="procDefKey" name="procDefKey" value="${procDefKey}" class="form-control" />
                </div>
                <div class="form-group">
                    <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" />
                </div>
            </div>
        </form>
        <sys:message content="${message}" />
        <table class="table table-striped table-bordered">
            <thead>
                <tr>
                    <th>执行ID</th>
                    <th>流程实例ID</th>
                    <th>流程定义ID</th>
                    <th>当前环节</th>
                    <th>是否挂起</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${page.list}" var="procIns">
                    <tr>
                        <td>${procIns.id}</td>
                        <td>${procIns.processInstanceId}</td>
                        <td>${procIns.processDefinitionId}</td>
                        <td>${procIns.activityId}</td>
                        <td>${procIns.suspended}</td>
                        <td><shiro:hasPermission name="act:process:edit">
                                <a href="${ctx}/act/process/deleteProcIns?procInsId=${procIns.processInstanceId}&reason=" onclick="return promptx('删除流程','删除原因',this.href);">删除流程</a>
                            </shiro:hasPermission>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <nav>${page}</nav>
    </div>
    <div id="categoryBox" class="hide-element">
        <form id="categoryForm" action="${ctx}/act/process/updateCategory" method="post" enctype="multipart/form-data"
        class="form-search form-inline" onsubmit="loading('正在设置，请稍等...');">
        <input id="categoryBoxId" type="hidden" name="procDefId" value="" />
        <select id="categoryBoxCategory" name="category" class="form-control">
            <c:forEach items="${fns:getDictList('act_category')}" var="dict">
                <option value="${dict.value}">${dict.label}</option>
            </c:forEach>
        </select>　
        <input id="categorySubmit" class="btn btn-primary" type="submit" value="保存"/>　　
    </form>
    </div>
</body>
</html>
