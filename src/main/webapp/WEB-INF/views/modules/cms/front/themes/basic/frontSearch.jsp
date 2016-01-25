<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>全站搜索</title>
<meta name="decorator" content="cms_default_${site.theme}" />
<meta name="description" content="${site.description}" />
<meta name="keywords" content="${site.keywords}" />
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <form:form class="search search-2" id="searchForm" method="post" action="${ctx}/search">
                    <input type="hidden" id="pageNo" name="pageNo" value="${page.pageNo}" />
                    <input type="hidden" id="pageSize" name="pageSize" value="${page.pageSize}" />
                    <input type="hidden" id="t" name="t" value="${not empty t ? t : 'article'}" />
                    <input type="hidden" id="cid" name="cid" value="${cid}" />
                    <input type="hidden" id="a" name="a" value="${not empty t ? t : '0'}" />
                    <div class="input-group input-group-lg ">
                        <input name="q" type="text" class="form-control" value="${q}" placeholder="请输入关键词">
                        <span class="input-group-btn">
                            <button class="btn btn-success" type="submit"><i class="fa fa-search"></i></button>
                        </span>
                    </div>
                </form:form>
                <div class="search-theme-1">
                    <div class="search-result">搜索结果：</div>
                    <hr />
                    <ul class="search-ul">
                        <c:if test="${empty t || t eq 'article'}">
                            <c:forEach items="${page.list}" var="article">
                                <li class="search-li">
                                    <a class="search-li-title" href="${ctx}/view-${article.category.id}-${article.id}${urlSuffix}" target="_blank">${article.title}</a>
                                    <p>
                                        <span>发布者：${article.createBy.name}</span>
                                        <span>点击数：${article.hits}</span>
                                        <span>发布时间：<fmt:formatDate value="${article.createDate}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
                                        <span>更新时间：<fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
                                    </p>
                                    <p class="search-li-description">${article.description}</p>
                                </li>
                            </c:forEach>
                        </c:if>
                        <c:if test="${fn:length(page.list) eq 0}">
                            <dt>
                                <c:if test="${empty q}">请键入要查找的关键字。</c:if>
                                <c:if test="${not empty q}">抱歉，没有找到与“${q}”相关内容。</c:if>
                                <span>建议：</span>
                            </dt>
                            <dd>
                                <ul>
                                    <li>检查输入是否正确；</li>
                                    <li>简化输入词；</li>
                                    <li>尝试其他相关词，如同义、近义词等。</li>
                                </ul>
                            </dd>
                        </c:if>
                    </ul>
                </div>
                <nav>${page}</nav>
                <script>
                    function page(n, s) {
                        $("#pageNo").val(n);
                        $("#pageSize").val(s);
                        $("#searchForm").submit();
                        return false;
                    }
                </script>
            </div>
        </div>
    </div>
</body>
</html>