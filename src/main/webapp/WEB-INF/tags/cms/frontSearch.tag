<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="搜索框样式"%>
<form action="${ctx}/search" method="POST">
    <div class="input-group search ${cssClass}">
        <input name="q" type="text" class="form-control" placeholder="请输入关键词">
        <span class="input-group-btn">
            <button class="btn btn-success" type="submit">
                <i class="fa fa-search"></i>
            </button>
        </span>
    </div>
</form>