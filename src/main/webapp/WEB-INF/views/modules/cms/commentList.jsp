<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>评论管理</title>
<meta name="decorator" content="default" />
<script>
	function view(href) {
	    top.dialog({
	        title : '查看文档',
	        url : href,
	        width : $(top.document).width() - 220,
	        height : $(top.document).height() - 180,
	        button : [ {
	            value : '关闭',
	            callback : function() {
	            }
	        } ]
	    }).show();
		return false;
	}
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
        <li class="active"><a href="${ctx}/cms/comment/">评论列表</a></li>
    </ul>
    <div class="container-fluid">
        <form:form id="searchForm" modelAttribute="comment" action="${ctx}/cms/comment/" method="post" class="breadcrumb form-inline form-search">
            <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
            <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
            <div class="row">
                <div class="form-group">
                    <label>文档标题：</label>
                    <form:input path="title" htmlEscape="false" maxlength="50" class="form-control" />
                </div>
                <div class="form-group">
                    <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" />
                </div>
                <div class="form-group">
                    <label>状态：</label>
                    <form:radiobuttons onclick="$('#searchForm').submit();" path="delFlag" items="${fns:getDictList('cms_del_flag')}" itemLabel="label"
                        itemValue="value" htmlEscape="false" />
                </div>
            </div>
        </form:form>
        <sys:message content="${message}" />
        <table id="contentTable" class="table table-bordered">
            <thead>
                <tr>
                    <th>评论内容</th>
                    <th>文档标题</th>
                    <th>评论人</th>
                    <th>评论IP</th>
                    <th>评论时间</th>
                    <th nowrap="nowrap">操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${page.list}" var="comment">
                    <tr>
                        <td><a href="javascript:" onclick="$('#c_${comment.id}').toggle()">${fns:abbr(fns:replaceHtml(comment.content),40)}</a></td>
                        <td><a
                            href="${pageContext.request.contextPath}${fns:getFrontPath()}/view-${comment.category.id}-${comment.contentId}${fns:getUrlSuffix()}"
                            title="${comment.title}" onclick="return view(this.href);">${fns:abbr(comment.title,40)}</a></td>
                        <td>${comment.name}</td>
                        <td>${comment.ip}</td>
                        <td><fmt:formatDate value="${comment.createDate}" type="both" /></td>
                        <td>
                            <shiro:hasPermission name="cms:comment:edit">
                                <c:if test="${comment.delFlag ne '2'}">
                                    <a href="${ctx}/cms/comment/delete?id=${comment.id}${comment.delFlag ne 0?'&isRe=true':''}"
                                        onclick="return confirmx('确认要${comment.delFlag ne 0?'恢复审核':'删除'}该审核吗？', this.href)">${comment.delFlag ne 0?'恢复审核':'删除'}</a>
                                </c:if>
                                <c:if test="${comment.delFlag eq '2'}">
                                    <a href="${ctx}/cms/comment/save?id=${comment.id}">审核通过</a>
                                </c:if>
                            </shiro:hasPermission>
                        </td>
                    </tr>
                    <tr id="c_${comment.id}" style="background: #fdfdfd; display: none;">
                        <td colspan="6">${fns:replaceHtml(comment.content)}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <nav>${page}</nav>
    </div>
</body>
</html>
