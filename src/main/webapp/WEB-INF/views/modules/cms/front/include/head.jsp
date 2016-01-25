<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="renderer" content="webkit">
<meta http-equiv="Expires" content="0">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Cache-Control" content="no-store">
<!-- jQuery -->
<script src="${ctxStatic}/jquery/jquery-1.11.2.min.js"></script>
<script src="${ctxStatic}/jquery/jquery-migrate-1.2.1.min.js"></script>
<!-- animate -->
<link href="${ctxStatic}/animate/animate.css" rel="stylesheet" />
<!-- font-awesome -->
<link href="${ctxStatic}/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
<c:if test="${site.theme eq 'basic'}">
    <!-- Bootstrap -->
    <link href="${ctxStatic}/bootstrap/3.3.4/css_default/bootstrap.css" rel="stylesheet" />
    <script src="${ctxStatic}/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <!-- lazyLoad -->
    <script src="${ctxStatic}/jquery-plugin/jquery.lazyload.min.js"></script>
    <script>var ctx = '${ctx}', ctxStaticTheme = '${ctxStaticTheme}';</script>
    <!-- basic -->
    <link href="${ctxStaticTheme}/base.css" rel="stylesheet" />
    <link href="${ctxStaticTheme}/theme-basic.css" rel="stylesheet" />
    <script src="${ctxStaticTheme}/theme-basic.js"></script>
</c:if>