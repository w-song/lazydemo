<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>${article.title}- ${category.name}</title>
<meta name="decorator" content="cms_default_${site.theme}" />
<meta name="description" content="${article.description} ${category.description}" />
<meta name="keywords" content="${article.keywords} ${category.keywords}" />
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
                <cms:frontCurrentPosition category="${category}" />
            </div>
            <div class="col-md-8 col-xs-12">
                <div class="article-content-1">
                    <div class="article-content-body">
                        <div class="article-content-title">${article.title}</div>
                        <div class="article-content-mess">
                            <span  class="hidden-xs">发布者：${article.user.name}</span>
                            <span>点击数：${article.hits}</span>
                            <span>发布时间：<fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd" /></span>
                        </div>
                        <c:if test="${not empty article.description}">
                            <div class="article-content-description">摘要：${article.description}</div>
                        </c:if>
                        <div class="article-content-detail">${article.articleData.content}</div>
                    </div>
                    <div class="panel panel-theme-2">
                        <div class="panel-heading">
                            <span class="category-title"><i class="fa fa-globe icon"></i> 相关内容</span>
                        </div>
                        <div class="panel-body">
                            <div class="list-theme-6">
                                <div class="row">
                                    <c:forEach items="${relationList}" var="relation">
                                        <div class="col-sm-6 col-xs-12">
                                            <div class="list-head">
                                                <a class="list-title" href="${ctx}/view-${relation[0]}-${relation[1]}${urlSuffix}"
                                                    style="color: ${article.color}" title="${relation[2]}">${fns:abbr(relation[2], 30)}</a>
                                                <p class="list-description">${fns:abbr(article.description, 64)}</p>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="comment comment-theme-1 hide-element" id="comment"><i class="fa fa-refresh fa-spin"></i> 正在加载评论……</div>
            </div>
            <div class="col-md-4 col-xs-12">
                <div class="pinned">
                    <cms:frontArticleHitsTop category="${category}" />
                    <cms:frontArticleRecommend category="${category}" />
                </div>
            </div>
        </div>
    </div>
    <script src="${ctxStatic}/jquery-plugin/jquery.pin.min.js"></script>
    <script>
        $(function() {
            if ("${category.allowComment}" == "1" && "${article.articleData.allowComment}" == "1") {
                $("#comment").show();
                page(1,10);
            }
        });
        function page(n, s) {
            $.post("${ctx}/commentList", {
                theme : '${site.theme}',
                'category.id' : '${category.id}',
                contentId : '${article.id}',
                title : '${article.title}',
                pageNo : n,
                pageSize : s,
                date : new Date().getTime()
            }, function(data) {
                $("#comment").html(data);
            });
        }
        $(".pinned").pin({
            containerSelector : ".container",
            minWidth: 991
        });
    </script>
</body>
</html>