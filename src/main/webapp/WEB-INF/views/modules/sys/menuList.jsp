<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>菜单管理</title>
<meta name="decorator" content="default" />
<%@include file="/WEB-INF/views/include/treetable.jsp"%>
<script>
    $(function() {
        $("#treeTable").treeTable({expandLevel : 3}).show();
    });
    function updateSort() {
        loading('正在提交，请稍等...');
        $("#listForm").attr("action", "${ctx}/sys/menu/updateSort");
        $("#listForm").submit();
    }
</script>
<style>
.sort-input {
  margin: 0px auto;
  padding: 0px;
  width: 50px;
  height: 20px;
  text-align: center;
}
</style>
</head>
<body>
    <ul class="nav nav-tabs mb-2">
        <li class="active"><a href="${ctx}/sys/menu/">菜单列表</a></li>
        <shiro:hasPermission name="sys:menu:edit">
            <li><a href="${ctx}/sys/menu/form">菜单添加</a></li>
        </shiro:hasPermission>
    </ul>
    <div class="container-fluid">
        <sys:message content="${message}" />
        <form id="listForm" method="post">
            <table id="treeTable" class="table table-striped table-bordered hide-element">
                <thead>
                    <tr>
                        <th>名称</th>
                        <th>链接</th>
                        <th class="text-center">排序</th>
                        <th>可见</th>
                        <th>权限标识</th>
                        <shiro:hasPermission name="sys:menu:edit">
                            <th>操作</th>
                        </shiro:hasPermission>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${list}" var="menu">
                        <tr id="${menu.id}" pId="${menu.parent.id ne '1'?menu.parent.id:'0'}">
                            <td nowrap><i class="glyphicon glyphicon-${not empty menu.icon?menu.icon:' hide-element'}"></i><a href="${ctx}/sys/menu/form?id=${menu.id}">${menu.name}</a></td>
                            <td title="${menu.href}">${fns:abbr(menu.href,30)}</td>
                            <td class="text-center">
                                <shiro:hasPermission name="sys:menu:edit">
                                    <input type="hidden" name="ids" value="${menu.id}" />
                                    <input class="form-control input-sm sort-input" name="sorts" type="text" value="${menu.sort}">
                                </shiro:hasPermission>
                                <shiro:lacksPermission name="sys:menu:edit">${menu.sort}</shiro:lacksPermission>
                            </td>
                            <td>${menu.isShow eq '1'?'显示':'隐藏'}</td>
                            <td title="${menu.permission}">${fns:abbr(menu.permission,30)}</td>
                            <shiro:hasPermission name="sys:menu:edit">
                                <td nowrap>
                                    <a href="${ctx}/sys/menu/form?id=${menu.id}">修改</a>
                                    <a href="${ctx}/sys/menu/delete?id=${menu.id}" onclick="return confirmx('要删除该菜单及所有子菜单项吗？', this.href)">删除</a>
                                    <a href="${ctx}/sys/menu/form?parent.id=${menu.id}">添加下级菜单</a>
                                </td>
                            </shiro:hasPermission>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <shiro:hasPermission name="sys:menu:edit">
                <div class="form-group pagination-left">
                    <input id="btnSubmit" class="btn btn-primary" type="button" value="保存排序" onclick="updateSort();" />
                </div>
            </shiro:hasPermission>
        </form>
    </div>
</body>
</html>