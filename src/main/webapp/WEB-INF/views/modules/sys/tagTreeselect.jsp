<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>数据选择</title>
<meta name="decorator" content="blank"/>
<%@include file="/WEB-INF/views/include/treeview.jsp" %>
<script>
	var key, lastValue = "", nodeList = [], type = getQueryString("type", "${url}");
	var tree, setting = {view:{selectedMulti:false,dblClickExpand:false},check:{enable:"${checked}",nocheckInherit:true},
			async:{enable:(type==3),url:"${ctx}/sys/user/treeData",autoParam:["id=officeId"]},
			data:{simpleData:{enable:true}},callback:{
				onClick:function(event, treeId, treeNode){
					tree.expandNode(treeNode);
				},onCheck: function(e, treeId, treeNode){
					var nodes = tree.getCheckedNodes(true);
					for (var i=0, l=nodes.length; i<l; i++) {
						tree.expandNode(nodes[i], true, false, false);
					}
					return false;
				},onAsyncSuccess: function(event, treeId, treeNode, msg){
					var nodes = tree.getNodesByParam("pId", treeNode.id, null);
					for (var i=0, l=nodes.length; i<l; i++) {
						try{tree.checkNode(nodes[i], treeNode.checked, true);}catch(e){}
						//tree.selectNode(nodes[i], false);
					}
					selectCheckNode();
				},onDblClick: function(){//<c:if test="${!checked}">
					top.$("div[role=dialog]").find("button[i-id=ok]").trigger("click");//</c:if>
				}
			}
		};
	function expandNodes(nodes) {
		if (!nodes) return;
		for (var i=0, l=nodes.length; i<l; i++) {
			tree.expandNode(nodes[i], true, false, false);
			if (nodes[i].isParent && nodes[i].zAsync) {
				expandNodes(nodes[i].children);
			}
		}
	}
	$(function(){
		$.get("${ctx}${url}${fn:indexOf(url,'?')==-1?'?':'&'}&extId=${extId}&isAll=${isAll}&module=${module}&t="
				+ new Date().getTime(), function(zNodes){
			// 初始化树结构
			tree = $.fn.zTree.init($("#tree"), setting, zNodes);
			
			// 默认展开一级节点
			var nodes = tree.getNodesByParam("level", 0);
			for(var i=0; i<nodes.length; i++) {
				tree.expandNode(nodes[i], true, false, false);
			}
			//异步加载子节点（加载用户）
			var nodesOne = tree.getNodesByParam("isParent", true);
			for(var j=0; j<nodesOne.length; j++) {
				tree.reAsyncChildNodes(nodesOne[j],"!refresh",true);
			}
			selectCheckNode();
		});
		key = $("#key");
		key.bind("focus", focusKey).bind("blur", blurKey).bind("change cut input propertychange", searchNode);
		key.bind('keydown', function (e){if(e.which == 13){searchNode();}});
	});
	
	// 默认选择节点
	function selectCheckNode(){
		var ids = "${selectIds}".split(",");
		for(var i=0; i<ids.length; i++) {
			var node = tree.getNodeByParam("id", (type==3?"u_":"")+ids[i]);
			if("${checked}" == "true"){
				try{tree.checkNode(node, true, true);}catch(e){}
				tree.selectNode(node, false);
			}else{
				tree.selectNode(node, true);
			}
		}
	}
  	function focusKey(e) {
		if (key.hasClass("empty")) {
			key.removeClass("empty");
		}
	}
	function blurKey(e) {
		if (key.get(0).value === "") {
			key.addClass("empty");
		}
		searchNode(e);
	}
	
	//搜索节点
	function searchNode() {
		// 取得输入的关键字的值
		var value = $.trim(key.get(0).value);
		
		// 按名字查询
		var keyType = "name";
		
		if (lastValue === value) {
			return;
		}
		
		// 保存最后一次
		lastValue = value;
		
		var nodes = tree.getNodes();
		if (value == "") {
			showAllNode(nodes);
			return;
		}
		hideAllNode(nodes);
		nodeList = tree.getNodesByParamFuzzy(keyType, value);
		updateNodes(nodeList);
	}
	
	//隐藏所有节点
	function hideAllNode(nodes){			
		nodes = tree.transformToArray(nodes);
		for(var i=nodes.length-1; i>=0; i--) {
			tree.hideNode(nodes[i]);
		}
	}
	
	//显示所有节点
	function showAllNode(nodes){			
		nodes = tree.transformToArray(nodes);
		for(var i=nodes.length-1; i>=0; i--) {
			/* if(!nodes[i].isParent){
				tree.showNode(nodes[i]);
			}else{ */
				if(nodes[i].getParentNode()!=null){
					tree.expandNode(nodes[i],false,false,false,false);
				}else{
					tree.expandNode(nodes[i],true,true,false,false);
				}
				tree.showNode(nodes[i]);
				showAllNode(nodes[i].children);
			/* } */
		}
	}
	
	//更新节点状态
	function updateNodes(nodeList) {
		tree.showNodes(nodeList);
		for(var i=0, l=nodeList.length; i<l; i++) {
			
			//展开当前节点的父节点
			tree.showNode(nodeList[i].getParentNode()); 
			//tree.expandNode(nodeList[i].getParentNode(), true, false, false);
			//显示展开符合条件节点的父节点
			while(nodeList[i].getParentNode()!=null){
				tree.expandNode(nodeList[i].getParentNode(), true, false, false);
				nodeList[i] = nodeList[i].getParentNode();
				tree.showNode(nodeList[i].getParentNode());
			}
			//显示根节点
			tree.showNode(nodeList[i].getParentNode());
			//展开根节点
			tree.expandNode(nodeList[i].getParentNode(), true, false, false);
		}
	}
</script>
</head>
<body>
    <div class="container-fluid">
        <div class="row mb-1">
            <div class="col-lg-6">
                <div id="search" class="input-group">
                    <input id="key" name="key" type="text" class="form-control" maxlength="50" placeholder="请输入关键字">
                    <span class="input-group-btn">
                        <button class="btn btn-default" type="button" onclick="searchNode()">
                            <i class="glyphicon glyphicon-search"></i>
                        </button>
                    </span>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-6">
                <div id="tree" class="ztree"></div>
            </div>
        </div>
    </div>
</body>
</html>