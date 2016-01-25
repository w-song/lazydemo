<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<!DOCTYPE html>
<html lang="zh-cmn-Hans">
<head>
<title><sitemesh:title /> - ${site.title}</title>
<%@include file="/WEB-INF/views/modules/cms/front/include/head.jsp"%>
<sitemesh:head />
</head>
<body>
    <div class="container hidden-xs">
        <div class="row">
            <div class="col-sm-5 logo-theme-1">
                <c:choose>
                    <c:when test="${not empty site.logo}">
                        <a class="site-name" href="${ctx}/index-${site.id}${urlSuffix}">
                            <img class="logo" src="<sys:ftpFilePath ftpFile='${site.logoFtpFile}'></sys:ftpFilePath>" alt="${site.title}" title="${site.name}">
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a class="site-name" href="${ctx}/index-${site.id}${urlSuffix}">${site.name}</a>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="col-sm-7">
            <!-- <div class="header-login-1"> 
                    <div class="login-item">
                        <a href="${ctx}/login"><i class="fa fa-user icon"></i> 登录</a>
                        <a href="${ctx}/register"><i class="fa fa-pencil icon"></i> 注册</a>
                    </div>
                </div> -->
            </div>
        </div>
    </div>
    <nav class="navbar navbar-theme-1" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#navbar" aria-expanded="false">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand visible-xs" href="${ctx}/index-${site.id}${urlSuffix}">${site.name}</a>
            </div>
            <div id="navbar" class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li class="<c:if test="${empty requestScope.category.id}">active</c:if>" role="presentation">
                        <a href="${ctx}/index-${site.id}${urlSuffix}"> <span class="glyphicon glyphicon-home"></span> 首页</a>
                    </li>
                    <c:forEach items="${fnc:getMainNavList('1')}" var="nav">
                        <li class="<c:if test="${requestScope.category.id eq nav.id}">active</c:if>" role="presentation">
                            <a href="${nav.url}">${nav.name}</a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </nav>
    <sitemesh:body />
    <div class="footer-theme-1">
        <div class="footer">
            <div class="container">
                <div class="row">
                    <div class="col-md-4">
                        <div class="headline">
                            <span class="heading-title"><i class="fa fa-info-circle"></i> 关于我们</span>
                        </div>
                        <p>JeeSite前端响应式模板 Powered by MingYi</p>
                    </div>
                    <div class="col-md-4">
                        <div class="headline">
                            <span class="heading-title"><i class="fa fa-phone"></i> 联系我们</span>
                        </div>
                        <p>电话：</p>
                        <address>
                            邮箱：<br/>
                            地址：<br/>
                            邮编：
                        </address>
                    </div>
                    <div class="col-md-4">
                        <div class="headline">
                            <span class="heading-title"><i class="fa fa-graduation-cap"></i> 帮助中心</span>
                        </div>
                        <p class="footer-link">
                            <a href="http://www.liumingyi.cn/" target="_blank">MingYi's 博客</a>
                        </p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="copyright">${site.copyright}</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>