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
            <div class="col-md-8 col-sm-7 col-xs-12">
                <cms:frontCurrentPosition category="${category}" />
            </div>
            <div class="col-md-4 col-sm-5 col-xs-12">
                <cms:frontSearch cssClass="search-1"/>
            </div>
        </div>
        <div class="row">
            <c:forEach items="${categoryList}" var="tpl">
                <div class="col-md-6 col-xs-12">
                    <c:if test="${tpl.inList eq '1' && tpl.module ne ''}">
                        <div class="panel panel-theme-1">
                            <div class="panel-heading">
                                <a href="${ctx}/list-${tpl.id}${urlSuffix}" class="category-title">${tpl.name}</a>
                            </div>
                            <div class="panel-body">
                                <div class="list-theme-1">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <ul class="list-ul">
                                                <c:forEach items="${fnc:getArticleList(site.id, tpl.id, 5, '')}" var="article">
                                                    <li>
                                                        <i class="fa fa-chevron-right icon-list"></i>
                                                        <a class="list-title" href="${ctx}/view-${article.category.id}-${article.id}${urlSuffix}"
                                                            style="color:${article.color}">${fns:abbr(article.title,40)}</a>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>