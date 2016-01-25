<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<%@ attribute name="category" type="com.thinkgem.jeesite.modules.cms.entity.Category" required="true" description="栏目对象"%>
<ol class="breadcrumb breadcrumb-theme-1">
    <li>
        <a href="${ctx}/index-${site.id}${urlSuffix}">
            <span class="glyphicon glyphicon-home"></span> 首页
        </a>
    </li>
    <c:forEach items="${fnc:getCategoryListByIds(category.parentIds)}" var="tpl">
        <c:if test="${tpl.id ne '1'}">
            <li>
                <a href="${ctx}/list-${tpl.id}${urlSuffix}"> ${category.name} </a>
            </li>
        </c:if>
    </c:forEach>
    <li class="active">
        <a href="${category.url}">${category.name}</a>
    </li>
</ol>