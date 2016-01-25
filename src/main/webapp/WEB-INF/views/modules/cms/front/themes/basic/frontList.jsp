<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>${category.name}</title>
<meta name="decorator" content="cms_default_${site.theme}" />
<meta name="description" content="${category.description}" />
<meta name="keywords" content="${category.keywords}" />
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <cms:frontCurrentPosition category="${category}" />
            </div>
            <div class="col-md-8 col-xs-12">
                <c:if test="${category.module eq 'article'}">
                    <div class="category-list-1">
                        <c:forEach items="${page.list}" var="article">
                            <div class="category-list-item">
                                <div class="category-list-top">
                                    <i class="fa fa-caret-right icon-list"></i>
                                    <a class="category-list-title" href="${article.url}" style="color:${article.color}" title="${article.title}">${fns:abbr(article.title, 96)}</a>
                                </div>
                                <div class="category-list-head clearfix">
                                    <img class="lazy img-responsive category-list-img" 
                                        src="" 
                                        data-original="<sys:ftpFilePath ftpFile='${article.imageFtpFile}' thumbnail='true'></sys:ftpFilePath>">
                                    <div class="category-detail">
                                        <p class="category-mess">
                                            <span><i class="fa fa-bolt"></i> 点击数：${article.hits}</span>
                                            <span><i class="fa fa-calendar"></i> 发布时间：<fmt:formatDate value="${article.updateDate}"
                                                    pattern="yyyy-MM-dd" /></span>
                                        </p>
                                        <p class="category-description" title="${article.description}">${fns:abbr(article.description, 128)}</p>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <nav class="pagination-1">${page}</nav>
                    <script>
                        function page(n, s) {
                            location = "${ctx}/list-${category.id}${urlSuffix}?pageNo=" + n + "&pageSize=" + s;
                        }
                    </script>
                </c:if>
            </div>
            <div class="col-md-4 col-xs-12">
                <div class="pinned">
                    <cms:frontArticleHitsTop category="${category}" />
                    <cms:frontArticleHotTop category="${category}"/>
                </div>
            </div>
        </div>
    </div>
    <script src="${ctxStatic}/jquery-plugin/jquery.pin.min.js"></script>
    <script>
        $(".pinned").pin({
            containerSelector : ".container",
            minWidth: 991
        });
    </script>
</body>
</html>