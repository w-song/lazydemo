<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<!DOCTYPE html>
<html lang="zh-cmn-Hans" style="overflow-x: auto; overflow-y: auto;">
<head>
<title><sitemesh:title /></title>
<%@include file="/WEB-INF/views/include/head.jsp"%>
<sitemesh:head />
</head>
<body>
    <sitemesh:body />
    <script>
		if (!(self.frameElement && self.frameElement.tagName == "IFRAME")) {
			$("body").prepend("<button id=\"btnMenu\" class=\"btn btn-default single-menu\" type=\"button\">" +
					"<i class=\"glyphicon glyphicon-th-list\"></i>" +
					"</button><div id=\"menuContent\"></div>");

			$("#btnMenu").click(function() {
				dialog({
					title : '选择菜单',
					url : '${ctx}/sys/menu/treeselect;JSESSIONID=<shiro:principal property="sessionid"/>',
					width : 300,
					height : 350,
					button : [{
						value : '关闭',
					}]
				}).show();
			});
		}
	</script>
</body>
</html>