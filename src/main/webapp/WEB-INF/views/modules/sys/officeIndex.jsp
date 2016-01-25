<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>机构管理</title>
<meta name="decorator" content="default" />
<%@include file="/WEB-INF/views/include/treeview.jsp"%>
<style>
#content {
  margin: 0px;
}

.ztree {
  overflow: auto;
  margin: 0;
  _margin-top: 10px;
  padding: 10px 0 0 10px;
}
</style>
</head>
<body>
    <sys:message content="${message}" />
    <div id="content" class="row">
        <div id="left" class="panel panel-default">
            <div class="panel-heading">
                <a class="accordion-toggle" href="javascript:void(0);">组织机构<i class="glyphicon glyphicon-refresh pull-right" onclick="refreshTree();"></i></a>
            </div>
            <div id="ztree" class="ztree"></div>
        </div>
        <div id="openClose" class="close"></div>
        <div id="right">
            <iframe id="officeContent" src="${ctx}/sys/office/list?id=&parentIds=" width="100%" height="91%" frameborder="0"></iframe>
        </div>
    </div>
<script>
    var setting = {data:{simpleData:{enable:true,idKey:"id",pIdKey:"pId",rootPId:'0'}},
        callback:{onClick:function(event, treeId, treeNode){
                var id = treeNode.pId == '0' ? '' :treeNode.pId;
                $('#officeContent').attr("src","${ctx}/sys/office/list?id="+id+"&parentIds="+treeNode.pIds);
            }
        }
    };
    
    function refreshTree(){
        $.getJSON("${ctx}/sys/office/treeData",function(data){
            $.fn.zTree.init($("#ztree"), setting, data).expandAll(true);
        });
    }
    refreshTree();
     
    var leftWidth = 180; // 左侧窗口大小
    var htmlObj = $("html"), mainObj = $("#main");
    var frameObj = $("#left, #openClose, #right, #right iframe");
    function wSize(){
        var strs = getWindowSize().toString().split(",");
        htmlObj.css({"overflow-x":"hidden", "overflow-y":"hidden"});
        mainObj.css("width","auto");
        frameObj.height(strs[0] - 5);
        var leftWidth = ($("#left").width() < 0 ? 0 : $("#left").width());
        $("#right").width($("#content").width()- leftWidth - $("#openClose").width() -5);
        $(".ztree").width(leftWidth - 10).height(frameObj.height() - 46);
    }
</script>
<script src="${ctxStatic}/common/wsize.min.js"></script>
</body>
</html>