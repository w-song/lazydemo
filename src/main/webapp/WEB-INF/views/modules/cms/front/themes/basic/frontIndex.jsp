<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>首页</title>
<meta name="decorator" content="cms_default_${site.theme}" />
<meta name="description" content="${site.description}" />
<meta name="keywords" content="${site.keywords}" />
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-md-8 col-sm-12">
                <div class="carousel-theme-1">
                    <cms:frontCarousel categoryId="30" pageSize="5"></cms:frontCarousel>
                </div>
            </div>
            <div class="col-md-4 col-sm-12">
                <div class="panel panel-theme-1">
                    <div class="panel-heading">
                        <a class="category-title" href="${ctx}/"><i class="fa fa-volume-up icon"></i> 栏目标题</a>
                        <a class="category-more" href="${ctx}/">更多 <i class="fa fa-angle-double-right"></i></a>
                    </div>
                    <div class="panel-body">
                        <div class="list-theme-1">
                            <ul class="list-ul">
                                <c:forEach items="${fnc:getArticleList(site.id, 40, 10, '')}" var="article" varStatus="status">
                                    <li>
                                        <span class="badge <c:if test="${status.index < 3}">badge-hot</c:if>">${status.count}</span>
                                        <a class="list-title" href="${article.url}" style="color: ${article.color}" title="${article.title}">${fns:abbr(article.title, 28)}</a>
                                        <span class="pull-right link-date"> <fmt:formatDate value="${article.updateDate}" pattern="MM-dd" /></span>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8 col-sm-12">
                <div class="panel panel-theme-1">
                    <div class="panel-heading">
                        <a href="${ctx}/" class="category-title"><i class="fa fa-bell icon"></i> 栏目标题</a>
                        <a class="category-more" href="${ctx}/">更多 <i class="fa fa-angle-double-right"></i></a>
                    </div>
                    <div class="panel-body">
                        <div class="list-theme-13">
                            <div class="list-top">
                                <div class="row">
                                    <c:forEach items="${fnc:getArticleList(site.id, 30, 2, 'orderBy : \"weight desc\"')}" var="article" varStatus="status">
                                        <c:if test="${status.index eq 0}">
                                            <div class="col-sm-4 hidden-xs">
                                                <a href="${article.url}" title="${article.title}">
                                                    <img class="lazy img-responsive list-image" 
                                                        src="" 
                                                        alt="${article.title}" 
                                                        title="${article.title}" 
                                                        data-original="<sys:ftpFilePath ftpFile='${article.imageFtpFile}' thumbnail='true'></sys:ftpFilePath>">
                                                </a>
                                            </div>
                                        </c:if>
                                        <div class="col-sm-8">
                                            <a class="list-title" href="${article.url}" style="color: ${article.color}" title="${article.title}">${fns:abbr(article.title, 42)}</a>
                                            <p class="list-description" title="${article.description}">${fns:abbr(article.description, 88)}</p>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="list-item">
                                <div class="row">
                                    <c:forEach items="${fnc:getArticleList(site.id, 30, 6, 'orderBy : \"updateDate desc\"')}" var="article">
                                        <div class="col-sm-6">
                                            <div>
                                                <i class="fa fa-caret-right icon-list"></i>
                                                <a class="list-title" href="${article.url}" style="color: ${article.color}" title="${article.title}">${fns:abbr(article.title, 28)}</a>
                                                <span class="pull-right link-date"> <fmt:formatDate value="${article.updateDate}" pattern="MM-dd" /></span>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-sm-12">
                <div class="panel panel-theme-1">
                    <div class="panel-heading">
                        <a class="category-title" href="${ctx}/"><i class="fa fa-key icon"></i> 栏目标题</a>
                        <a class="category-more" href="${ctx}/">更多 <i class="fa fa-angle-double-right"></i></a>
                    </div>
                    <div class="panel-body">
                        <div class="list-theme-3">
<%--                             <c:forEach items="${fnc:getModuleList(1, '')}" var="item">
                                <div class="list-head">
                                    <i class="fa fa-caret-right icon-list"></i>
                                    <a class="list-title" href="${ctx}/" title="${item.name}" target="_blank">${fns:abbr(item.name, 36)}</a>
                                    <div class="list-mess clearfix">
                                        <div class="list-left">
                                            <a href="${ctx}/" target="_blank">
                                                <img class="lazy img-responsive list-image" 
                                                    src="" 
                                                    alt="${item.name}" 
                                                    title="${item.name}" 
                                                    data-original="<sys:ftpFilePath ftpFile='${item.imageFtpFile}' thumbnail='true'></sys:ftpFilePath>">
                                            </a>
                                        </div>
                                        <div class="list-right">
                                            <div class="label label-success" title="${item.tag}">${fns:abbr(item.tag, 28)}</div>
                                            <p class="list-description" title="${item.tagItem}">${fns:abbr(item.tagItem, 48)}</p>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach> --%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8 col-sm-12">
                <div class="panel panel-theme-1">
                    <div class="panel-heading">
                        <a href="${ctx}/" class="category-title"><i class="fa fa-book icon"></i> 栏目标题</a>
                        <a class="category-more" href="${ctx}/">更多 <i class="fa fa-angle-double-right"></i></a>
                    </div>
                    <div class="panel-body">
                        <div class="list-theme-9">
                            <div class="row">
                                <div class="col-sm-3 hidden-xs">
<%--                                     <c:forEach items="${fnc:getModuleList(1, '', '')}" var="item">
                                        <a class="list-cover-1" href="${ctx}/}">
                                            <img class="lazy img-responsive" 
                                                src="" 
                                                alt="${item.name}" 
                                                data-original="<sys:ftpFilePath ftpFile='${item.imageFtpFile}' thumbnail='true'></sys:ftpFilePath>">
                                            <span class="list-cover-text">${fns:abbr(item.name, 28)}</span>
                                        </a>
                                    </c:forEach> --%>
                                </div>
                                <div class="col-sm-9 col-xs-12">
                                    <div class="row">
                                        <ul class="list-ul">
<%--                                             <c:forEach items="${fnc:getModuleList(12, '', '')}" var="item">
                                                <li class="col-sm-6">
                                                    <i class="fa fa-caret-right icon-list"></i>
                                                    <a class="list-title" href="${ctx}/" title="${item.name}">${fns:abbr(item.name, 28)}</a>
                                                </li>
                                            </c:forEach> --%>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-4">
                                    <div class="cate-line-1 clearfix">
                                        <div class="line-title">
                                            <span>百科</span>
                                        </div>
                                        <hr class="line">
                                    </div>
<%--                                     <c:forEach items="${fnc:getModuleList(1, '', '')}" var="item">
                                        <a class="list-cover-2" href="${ctx}/">
                                            <img class="lazy img-responsive" 
                                                src="" 
                                                alt="${item.name}" 
                                                data-original="<sys:ftpFilePath ftpFile='${item.imageFtpFile}' thumbnail='true'></sys:ftpFilePath>">
                                            <span class="list-cover-text" title="${item.name}">${fns:abbr(item.name, 28)}</span>
                                        </a>
                                    </c:forEach> --%>
                                </div>
                                <div class="col-sm-4">
                                    <div class="cate-line-1 clearfix">
                                        <div class="line-title">
                                            <span>图片</span>
                                        </div>
                                        <hr class="line">
                                    </div>
                                    <%--<c:forEach items="${fnc:getModuleList(1, '', '')}" var="item">
                                        <a class="list-cover-2" href="${ctx}/">
                                            <img class="lazy img-responsive" 
                                                src="" 
                                                alt="${item.name}" 
                                                data-original="<sys:ftpFilePath ftpFile='${item.imageFtpFile}' thumbnail='true'></sys:ftpFilePath>">
                                            <span class="list-cover-text" title="${item.name}">${fns:abbr(item.name, 28)}</span>
                                        </a>
                                    </c:forEach> --%>
                                </div>
                                <div class="col-sm-4">
                                    <div class="cate-line-1 clearfix">
                                        <div class="line-title">
                                            <span>漫画</span>
                                        </div>
                                        <hr class="line">
                                    </div>
                                    <%--<c:forEach items="${fnc:getModuleList(1, '', '')}" var="item">
                                        <a class="list-cover-2" href="${ctx}/">
                                            <img class="lazy img-responsive" 
                                                src="" 
                                                alt="${item.name}" 
                                                data-original="<sys:ftpFilePath ftpFile='${item.imageFtpFile}' thumbnail='true'></sys:ftpFilePath>">
                                            <span class="list-cover-text" title="${item.name}">${fns:abbr(item.name, 28)}</span>
                                        </a>
                                    </c:forEach> --%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-sm-12">
                <div class="panel panel-theme-1">
                    <div class="panel-heading">
                        <a href="${ctx}/" class="category-title"><i class="fa fa-street-view icon"></i>栏目标题</a>
                        <a class="category-more" href="${ctx}/">更多 <i class="fa fa-angle-double-right"></i></a>
                    </div>
                    <div class="panel-body">
                        <div class="list-theme-3">
                            <%--<c:forEach items="${fnc:getModuleList(3, '')}" var="item">
                                <div class="list-head">
                                    <i class="fa fa-caret-right icon-list"></i>
                                    <a class="list-title" href="${ctx}/" title="${item.name}">${fns:abbr(item.name, 36)}</a>
                                    <div class="list-mess clearfix">
                                        <div class="list-left">
                                            <a href="${ctx}/view-topic-300-${item.id}${urlSuffix}">
                                                <img class="lazy img-responsive list-image" 
                                                    src="" 
                                                    alt="${item.name}" 
                                                    title="${item.name}" 
                                                    data-original="<sys:ftpFilePath ftpFile='${item.imageFtpFile}' thumbnail='true'></sys:ftpFilePath>">
                                            </a>
                                        </div>
                                        <div class="list-right">
                                            <span class="label label-success" title="${item.description}">${fns:abbr(item.description, 32)}</span>
                                            <p class="list-description" title="${item.description}">${fns:abbr(fns:unescapeHtml(item.description), 42)}</p>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach> --%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-8 col-sm-12">
                <div class="panel panel-theme-1">
                    <div class="panel-heading">
                        <a class="category-title" href="${ctx}/"><i class="fa fa-user icon"></i> 栏目标题</a>
                        <a class="category-more" href="${ctx}/">更多 <i class="fa fa-angle-double-right"></i></a>
                    </div>
                    <div class="panel-body">
                        <div class="list-theme-4">
                            <div class="row">
                                <c:set var="noPhoto" value="${ctxStatic}/images/nophoto.png"></c:set>
                                <%--<c:forEach items="${fnc:getModuleList(4, '')}" var="item" varStatus="status">
                                    <div class="col-md-3 col-sm-4 col-xs-6">
                                        <div class="list-image-1">
                                            <a href="${ctx}/">
                                                <img class="lazy img-responsive center-block list-photo"
                                                    src=""
                                                    alt="${item.name}"
                                                    data-original="<sys:ftpFilePath ftpFile='${item.ftpFile}' thumbnail="true"></sys:ftpFilePath>">
                                            </a>
                                            <div class="caption">
                                                <a class="text-center list-title" href="${ctx}/" title="${item.name}">${fns:abbr(item.name, 28)}</a>
                                                <p class="text-center list-description" title="${item.type.name}">${fns:abbr(item.type.name, 28)}</p>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach> --%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-sm-12">
                <div class="panel panel-theme-1">
                    <div class="panel-heading">
                        <a class="category-title" href="${ctx}/"><i class="fa fa-flag icon"></i> 栏目标题</a>
                        <a class="category-more" href="${ctx}/">更多 <i class="fa fa-angle-double-right"></i></a>
                    </div>
                    <div class="panel-body">
                        <div class="list-theme-1">
                            <ul class="list-ul">
                                <%--<c:forEach items="${fnc:getModuleList(5, '')}" var="item">
                                    <li>
                                        <i class="fa fa-caret-right icon-list"></i>
                                        <a class="list-title" href="${ctx}/" title="${item.name}">${fns:abbr(item.name, 32)}</a>
                                        <label class="label label-success list-label hidden-md">${fns:abbr(item.name, 18)}</label>
                                    </li>
                                </c:forEach> --%>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
    </div>
</body>
</html>