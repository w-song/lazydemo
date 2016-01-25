<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta name="decorator" content="blank" />
<%@include file="/WEB-INF/views/include/treeview.jsp"%>
</head>
<body>
    <div id="menuTreeselect" class="ztree"></div>
    <script> 
        var menuTreeselectSetting = {
			view : {
				selectedMulti : false,
				dblClickExpand : false,
				nameIsHTML : true,
				showIcon : false,
				showTitle : false
			},
			data : {
				simpleData : {
					enable : true
				}
			},
			callback : {
				onClick : function(event, treeId, treeNode) {
					menuTreeselect.expandNode(treeNode);
					if (!treeNode.isParent) {
						cookie('menuId', treeNode.id, {
							path : '/'
						});
					}
				}
			}
		};
		var menuTreeselectNodes = [
				//<c:forEach items="${fns:getMenuList()}" var="menu">
				//<c:if test="${menu.isShow eq '1'}">
				{
					id : "${menu.id}",
					pId : "${not empty menu.parent.id ? menu.parent.id : 0}",
					name : "<i class=\"glyphicon glyphicon-${not empty menu.icon ? menu.icon : 'file'}\"></i>&nbsp;${not empty menu.parent.id ? menu.name : ''}",
					url : "${not empty menu.href && fn:indexOf(menu.href, '://') eq -1 ? ctx : ''}${not empty menu.href ? menu.href : 'javascript:'}",
					target : "${not empty menu.target ? menu.target:'_top'}"
				},
				//</c:if>
				//</c:forEach>
				{
					id : new Date().getTime(),
					pId : "0",
					name : "<i class=\"glyphicon glyphicon-home\"></i>&nbsp;进入主页",
					url : "${ctx}",
					target : "_top"
				},
				{
					id : new Date().getTime(),
					pId : "0",
					name : "<i class=\"glyphicon glyphicon-share\"></i>&nbsp;退出登录",
					url : "${ctx}/logout",
					target : "_top"
				} ];
		var menuTreeselect = $.fn.zTree.init($("#menuTreeselect"), menuTreeselectSetting, menuTreeselectNodes);
		//<c:if test="${empty parentId}">
		var menuTreeselectNodes = menuTreeselect.getNodesByParam("level", 1);
		for (var i = 0; i < menuTreeselectNodes.length; i++) {
			menuTreeselect.expandNode(menuTreeselectNodes[i], true, false, false);
		}
		//</c:if>
		var menuTreeselectNode = menuTreeselect.getNodeByParam("id", "${parentId != '' ? parentId : cookie.menuId.value}");
		menuTreeselect.selectNode(menuTreeselectNode, true);
		menuTreeselect.expandNode(menuTreeselectNode, true, false, false);
	</script>
</body>
</html>