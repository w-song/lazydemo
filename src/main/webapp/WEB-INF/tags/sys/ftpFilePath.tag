<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="ftpFile" type="com.thinkgem.jeesite.modules.ftpfile.entity.FtpFile" required="true" description="ftpFile类"%>
<%@ attribute name="thumbnail" type="java.lang.Boolean" required="false" description="是否是缩略图"%>
<c:if test="${thumbnail}">
    <c:set value="-thumbnail" var="thumbnail"></c:set>
</c:if>
<c:choose>
    <c:when test="${not empty ftpFile}">
        ${ftpPath}${ftpFile.remotePath}${ftpFile.fileName}${thumbnail}${ftpFile.fileType}
    </c:when>
    <c:otherwise>
        ${noImage}
    </c:otherwise>
</c:choose>