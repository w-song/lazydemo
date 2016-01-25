<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>字典管理</title>
<meta name="decorator" content="default" />
<script>
    function page(n,s){
        $("#pageNo").val(n);
        $("#pageSize").val(s);
        $("#searchForm").submit();
        return false;
    }
</script>
</head>
<body>
    <ul class="nav nav-tabs mb-2">
        <li class="active"><a href="${ctx}/sys/dict/">字典列表</a></li>
        <shiro:hasPermission name="sys:dict:edit">
            <li><a href="${ctx}/sys/dict/form?sort=10">字典添加</a></li>
        </shiro:hasPermission>
    </ul>
    <div class="container-fluid">
        <form:form id="searchForm" modelAttribute="dict" action="${ctx}/sys/dict/" method="post" class="breadcrumb form-inline form-search">
            <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
            <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
            <div class="row">
                <div class="form-group">
                    <label>类型：</label>
                    <form:select cssClass="form-control" id="type" path="type">
                        <form:option value="" label="" />
                        <form:options items="${typeList}" htmlEscape="false" />
                    </form:select>
                </div>
                <div class="form-group">
                    <label>描述：</label>
                    <form:input cssClass="form-control" path="description" htmlEscape="false" maxlength="50"/>
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
                    <th>键值</th>
                    <th>标签</th>
                    <th>类型</th>
                    <th>描述</th>
                    <th>排序</th>
                    <shiro:hasPermission name="sys:dict:edit">
                        <th>操作</th>
                    </shiro:hasPermission>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${page.list}" var="dict">
                    <tr>
                        <td>${dict.value}</td>
                        <td><a href="${ctx}/sys/dict/form?id=${dict.id}">${dict.label}</a></td>
                        <td><a href="javascript:void(0);" onclick="$('#type').val('${dict.type}');$('#searchForm').submit();return false;">${dict.type}</a></td>
                        <td>${dict.description}</td>
                        <td>${dict.sort}</td>
                        <shiro:hasPermission name="sys:dict:edit">
                            <td>
                                <a href="${ctx}/sys/dict/form?id=${dict.id}">修改</a>
                                <a href="${ctx}/sys/dict/delete?id=${dict.id}&type=${dict.type}" onclick="return confirmx('确认要删除该字典吗？', this.href)">删除</a>
                                <a href="<c:url value='${fns:getAdminPath()}/sys/dict/form?type=${dict.type}&sort=${dict.sort+10}'><c:param name='description' value='${dict.description}'/></c:url>">添加键值</a>
                            </td>
                        </shiro:hasPermission>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <nav>${page}</nav>
    </div>
</body>
</html>