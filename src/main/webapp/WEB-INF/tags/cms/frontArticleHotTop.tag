<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<%@ attribute name="category" type="com.thinkgem.jeesite.modules.cms.entity.Category" required="true" description="栏目对象"%>
<%@ attribute name="pageSize" type="java.lang.Integer" required="false" description="页面大小"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="页面样式"%>
<div class="panel panel-theme-1 ${cssClass}">
    <div class="panel-heading">
        <span class="category-title"><i class="fa fa-fire icon"></i> 热点内容</span>
    </div>
    <div class="panel-body">
        <div class="list-theme-1">
            <ul class="list-ul">
                <c:forEach items="${fnc:getArticleList(category.site.id, category.id, not empty pageSize ? pageSize : 5, 'orderBy : \"hits desc\"')}" var="article" varStatus="status">
                    <li>
                        <i class="fa fa-caret-right icon-list"></i>
                        <a class="list-title" href="${article.url}" style="color: ${article.color}" title="${article.title}">${fns:abbr(article.title, 38)}</a>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>