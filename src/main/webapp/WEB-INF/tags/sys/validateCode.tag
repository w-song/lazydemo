<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="验证码输入框名称"%>
<%@ attribute name="inputCssClass" type="java.lang.String" required="false" description="验证框样式"%>
<%@ attribute name="imageCssClass" type="java.lang.String" required="false" description="验证码图片样式"%>
<input type="text" id="${name}" name="${name}" maxlength="5" required class="form-control ${inputCssClass}" />
<img class="${name} ${imageCssClass}" src="${pageContext.request.contextPath}/servlet/validateCodeServlet"
    onclick="$('.${name}').attr('src', '${pageContext.request.contextPath}/servlet/validateCodeServlet?' + new Date().getTime());" />
