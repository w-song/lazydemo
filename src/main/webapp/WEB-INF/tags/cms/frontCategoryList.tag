<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<%@ attribute name="categoryList" type="java.util.List" required="true" description="栏目列表"%>
<div class="panel panel-theme-1">
    <div class="panel-heading">
        <span class="category-title"><i class="fa fa-list-ul icon"></i> 栏目列表</span>
    </div>
    <div class="panel-body">
        <div class="list-theme-5">
            <div class="row">
                <div class="col-md-12">
                    <ul class="list-ul">
                        <c:forEach items="${categoryList}" var="tpl" varStatus="status">
                            <c:choose>
                                <c:when test="${not empty tpl.href}">
                                    <c:choose>
                                        <c:when test="${fn:indexOf(tpl.href, '://') eq -1 && fn:indexOf(tpl.href, 'mailto:') eq -1}">
                                            <c:set var="url" value="${ctx}${tpl.href}" />
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="url" value="${tpl.href}" />
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="url" value="${ctx}/list-${tpl.id}${urlSuffix}" />
                                </c:otherwise>
                            </c:choose>
                            <li class="${requestScope.category.id eq tpl.id ? 'active' : ''}">
                                <i class="fa fa-circle-o icon"></i>
                                <a class="list-item" href="${url}" target="${tpl.target}" title="${tpl.name}">${tpl.name}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>