<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>内容管理</title>
<meta name="decorator" content="default" />
<style>
#content {
  margin: 0px;
}
</style>
</head>
<body>
    <div id="content" class="row">
        <div id="left">
            <iframe id="cmsMenuFrame" name="cmsMenuFrame" src="${ctx}/cms/tree" style="overflow: visible;" scrolling="yes" frameborder="no" width="100%"></iframe>
        </div>
        <div id="openClose" class="close"></div>
        <div id="right">
            <iframe id="cmsMainFrame" name="cmsMainFrame" src="${ctx}/cms/none" style="overflow: visible;" scrolling="yes" frameborder="no" width="100%"></iframe>
        </div>
    </div>
<script> 
    var leftWidth = "160"; // 左侧窗口大小
    function wSize(){
        var strs=getWindowSize().toString().split(",");
        $("#cmsMenuFrame, #cmsMainFrame, #openClose").height(strs[0]-5);
        $("#right").width($("body").width()-$("#left").width()-$("#openClose").width()-20);
    }
    // 鼠标移动到边界自动弹出左侧菜单
    $("#openClose").mouseover(function(){
        if($(this).hasClass("open")){
            $(this).click();
        }
    });
</script>
<script src="${ctxStatic}/common/wsize.min.js"></script>
</body>
</html>