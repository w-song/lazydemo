<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<%@ attribute name="category" type="com.thinkgem.jeesite.modules.cms.entity.Category" required="true" description="栏目对象"%>
<%@ attribute name="pageSize" type="java.lang.Integer" required="false" description="页面大小"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="页面样式"%>
<div class="panel panel-theme-1 ${cssClass}">
    <div class="panel-heading">
        <span class="category-title"><i class="fa fa-life-ring icon"></i> 阅读推荐</span>
    </div>
    <div class="panel-body">
        <div class="list-theme-3">
            <c:forEach items="${fnc:getArticleList(category.site.id, category.id, not empty pageSize ? pageSize : 5, '')}" var="article" varStatus="status">
                <div class="list-head">
                    <i class="fa fa-caret-right icon-list"></i>
                    <a class="list-title" href="${article.url}" style="color: ${article.color}" title="${article.title}">${fns:abbr(article.title, 36)}</a>
                    <div class="media list-mess">
                        <c:if test="${article.image ne ''}">
                            <div class="media-left">
                                <a href="${article.url}">
                                    <img class="media-object list-image" 
                                        src="" 
                                        alt="${article.title}" 
                                        title="${article.title}"
                                        data-original="<sys:ftpFilePath ftpFile='${article.imageFtpFile}'></sys:ftpFilePath>">
                                </a>
                            </div>
                        </c:if>
                        <div class="media-body">
                            <p class="list-description">${fns:abbr(article.description, 72)}</p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>