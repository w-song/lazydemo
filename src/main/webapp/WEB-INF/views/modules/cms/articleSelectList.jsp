<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>选择文章</title>
<meta name="decorator" content="default"/>
<script>
	$(function() {
		$("input[name=id]").each(function(){
			var articleSelect = null;
			if (top.mainFrame.cmsMainFrame){
				articleSelect = top.mainFrame.cmsMainFrame.articleSelect;
			}else{
				articleSelect = top.mainFrame.articleSelect;
			}
			for (var i=0; i<articleSelect.length; i++){
				if (articleSelect[i][0]==$(this).val()){
					this.checked = true;
				}
			}
			$(this).click(function(){
				var id = $(this).val(), title = $(this).attr("title");
				if (top.mainFrame.cmsMainFrame){
					top.mainFrame.cmsMainFrame.articleSelectAddOrDel(id, title);
				}else{
					top.mainFrame.articleSelectAddOrDel(id, title);
				}
			});
		});
	});
	function view(href){
		top.dialog({
			title : '查看文章',
			url : href,
			width : $(top.document).width()-220,
			height : $(top.document).height()-180,
			button : [{
				value : '确定',
				callback: function () {
				}
			}]
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
    <div class="container-fluid">
        <form:form id="searchForm" modelAttribute="article" action="${ctx}/cms/article/selectList" method="post" class="breadcrumb form-inline form-search">
            <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
            <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
            <div class="row">
                <div class="form-group">
                    <label>栏目：</label>
                    <sys:treeselect id="category" name="category.id" value="${article.category.id}" labelName="category.name" labelValue="${article.category.name}"
                        title="栏目" url="/cms/category/treeData" module="article" cssClass="form-control" />
                </div>
                <div class="form-group">
                    <label>标题：</label>
                    <form:input path="title" htmlEscape="false" maxlength="50" class="form-control" />
                </div>
                <div class="form-group">
                    <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" />
                </div>
            </div>
    	</form:form>
        <table id="contentTable" class="table table-striped table-bordered">
            <thead>
                <tr>
                    <th>选择</th>
                    <th>栏目</th>
                    <th>标题</th>
                    <th>权重</th>
                    <th>点击数</th>
                    <th>发布者</th>
                    <th>更新时间</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${page.list}" var="article">
                    <tr>
                        <td style="text-align: center;"><input type="checkbox" name="id" value="${article.id}" title="${fns:abbr(article.title,40)}" /></td>
                        <td><a href="javascript:"
                            onclick="$('#categoryId').val('${article.category.id}');$('#categoryName').val('${article.category.name}');$('#searchForm').submit();return false;">${article.category.name}</a></td>
                        <td><a href="${ctx}/cms/article/form?id=${article.id}" title="${article.title}" onclick="return view(this.href);">${fns:abbr(article.title,40)}</a></td>
                        <td>${article.weight}</td>
                        <td>${article.hits}</td>
                        <td>${article.createBy.name}</td>
                        <td><fmt:formatDate value="${article.updateDate}" type="both" /></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <nav>${page}</nav>
    </div>
</body>
</html>