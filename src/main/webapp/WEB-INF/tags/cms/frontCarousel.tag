<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<%@ attribute name="categoryId" type="java.lang.String" required="true" description="栏目ID"%>
<%@ attribute name="pageSize" type="java.lang.Integer" required="false" description="页面大小"%>
<c:set value="${fnc:getArticleList(site.id, categoryId, not empty pageSize ? pageSize : 5, 'posid : 1')}" var="articleList"></c:set>
<c:if test="${fn:length(articleList) ne 0}">
    <!-- 焦点图推荐 -->
    <div id="carousel-generic" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
            <c:forEach items="${articleList}" var="article" varStatus="status">
                <li data-target="#carousel-generic" data-slide-to="${status.index}" <c:if test="${status.index eq '0'}">class="active"</c:if> ></li>
            </c:forEach>
        </ol>
        <div class="carousel-inner" role="listbox">
            <c:forEach items="${articleList}" var="article" varStatus="status">
                <a class="item <c:if test="${status.index eq '0'}">active</c:if>" href="${article.url}">
                    <img class="carousel-img" 
                        src="<sys:ftpFilePath ftpFile='${article.imageFtpFile}'></sys:ftpFilePath>" 
                        alt="${article.title}" 
                        title="${article.title}">
                    <span class="carousel-caption">${fns:abbr(article.title, 36)}</span>
                </a>
            </c:forEach>
        </div>
        <a class="left carousel-control" href="#carousel-generic" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> <span class="sr-only">上页</span>
        </a>
        <a class="right carousel-control" href="#carousel-generic" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span> <span class="sr-only">下页</span>
        </a>
    </div>
</c:if>