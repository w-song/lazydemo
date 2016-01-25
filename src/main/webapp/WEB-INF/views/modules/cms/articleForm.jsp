<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>文章管理</title>
<meta name="decorator" content="default" />
<!-- webUploader -->
<link href="${ctxStatic}/webUploader/webuploader.css" rel="stylesheet">
<script src="${ctxStatic}/webUploader/webuploader.html5only.js"></script>
<script>
    $(function() {
        if($("#link").val()){
            $('#linkBody').show();
            $('#url').attr("checked", true);
        }
        $("#title").focus();
        $("#inputForm").validate({
            submitHandler: function(form){
                if ($("#categoryId").val()==""){
                    $("#categoryName").focus();
                    showTip('请选择归属栏目','warning');
                }else if (CKEDITOR.instances.content.getData()=="" && $("#link").val().trim()==""){
                    showTip('请填写正文','warning');
                }else{
                    loading('正在提交，请稍等...');
                    form.submit();
                }
            },
            errorContainer: "#messageBox",
            errorPlacement: function(error, element) {
                $("#messageBox").text("输入有误，请先更正。");
                if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-group")){
                    error.appendTo(element.parent().parent());
                } else {
                    error.appendTo(element.parent());
                }
            }
        });
    });
</script>
</head>
<body>
	<ul class="nav nav-tabs mb-2">
		<li><a href="${ctx}/cms/article/?category.id=${article.category.id}">文章列表</a></li>
		<li class="active"><a href="<c:url value='${fns:getAdminPath()}/cms/article/form?id=${article.id}&category.id=${article.category.id}'><c:param name='category.name' value='${article.category.name}'/></c:url>">文章<shiro:hasPermission name="cms:article:edit">${not empty article.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cms:article:edit">查看</shiro:lacksPermission></a></li>
	</ul>
    <div class="container-fluid">
    	<form:form id="inputForm" modelAttribute="article" action="${ctx}/cms/article/save" method="post" class="form-horizontal">
    		<form:hidden path="id"/>
    		<sys:message content="${message}"/>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">归属栏目:</label>
    			<div class="col-sm-3">
                    <sys:treeselect id="category" name="category.id" value="${article.category.id}" labelName="category.name" labelValue="${article.category.name}"
    					title="栏目" url="/cms/category/treeData" module="article" selectScopeModule="true" notAllowSelectRoot="false" notAllowSelectParent="true" cssClass="required"/>
                    <span>
                        <input id="url" type="checkbox" onclick="if(this.checked){$('#linkBody').show()}else{$('#linkBody').hide()}$('#link').val()"><label for="url">外部链接</label>
                    </span>
    			</div>
    		</div>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">标题:</label>
    			<div class="col-sm-6">
    				<form:input path="title" htmlEscape="false" maxlength="200" class="form-control measure-input required"/>
    				
    			</div>
    		</div>
            <div class="form-group">
                <label class="col-sm-2 control-label">颜色:</label>
                <div class="col-sm-2">
                    <form:select path="color" class="form-control">
                        <form:option value="" label="默认"/>
                        <form:options items="${fns:getDictList('color')}" itemLabel="label" itemValue="value" htmlEscape="false" />
                    </form:select>
                </div>
            </div>
            
            <div id="linkBody" class="form-group hide-element">
                <label class="col-sm-2 control-label">外部链接:</label>
                <div class="col-sm-3">
                    <form:input path="link" class="form-control" htmlEscape="false" maxlength="200"/>
                </div>
                <p class="form-control-static help-inline">绝对或相对地址。</p>
            </div>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">关键字:</label>
    			<div class="col-sm-3">
    				<form:input path="keywords" class="form-control" htmlEscape="false" maxlength="200"/>
    			</div>
				<p class="form-control-static help-inline">多个关键字，用空格分隔。</p>
    		</div>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">权重:</label>
    			<div class="col-sm-2">
    				<form:input path="weight" htmlEscape="false" maxlength="200" class="form-control required digits"/>
    				<span>
    					<input id="weightTop" type="checkbox" onclick="$('#weight').val(this.checked?'999':'0')"><label for="weightTop">置顶</label>
    				</span>
    			</div>
    		</div>
            <div class="form-group">
                <label class="col-sm-2 control-label">过期时间：</label>
                <div class="col-sm-3">
                    <input id="weightDate" name="weightDate" type="text" readonly="readonly" maxlength="20" class="form-control datepicker"
    					value="<fmt:formatDate value="${article.weightDate}" pattern="yyyy-MM-dd"/>"/>
                </div>
				<p class="form-control-static help-inline">数值越大排序越靠前，过期时间可为空，过期后取消置顶。</p>
            </div>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">摘要:</label>
    			<div class="col-sm-3">
    				<form:textarea path="description" htmlEscape="false" rows="4" maxlength="200" class="form-control"/>
    			</div>
    		</div>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">缩略图:</label>
    			<div class="col-sm-3">
                    <sys:ftpFileUpload name="image" fileTypes="gif,jpg,jpeg,bmp,png"
                        value="${article.image}"
                        ftpFile="${article.imageFtpFile}"
                        multiple="false"></sys:ftpFileUpload>
    			</div>
    		</div>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">正文:</label>
    			<div class="col-sm-8">
    				<form:textarea id="content" htmlEscape="true" path="articleData.content" rows="4" maxlength="200" class="form-control"/>
    				<sys:ckeditor replace="content" uploadPath="/cms/article" />
    			</div>
    		</div>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">来源:</label>
    			<div class="col-sm-3">
    				<form:input path="articleData.copyfrom" class="form-control" htmlEscape="false" maxlength="200"/>
    			</div>
    		</div>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">相关文章:</label>
    			<div class="col-sm-3">
    				<form:hidden id="articleDataRelation" path="articleData.relation" htmlEscape="false" maxlength="200"/>
                    <label class="form-control-static">
        				<button id="relationButton" class="btn btn-default" type="button">添加相关</button>
                    </label>
    				<ol id="articleSelectList"></ol>
    				<script>
    					var articleSelect = [];
    					function articleSelectAddOrDel(id,title){
    						var isExtents = false, index = 0;
    						for (var i=0; i<articleSelect.length; i++){
    							if (articleSelect[i][0]==id){
    								isExtents = true;
    								index = i;
    							}
    						}
    						if(isExtents){
    							articleSelect.splice(index,1);
    						}else{
    							articleSelect.push([id,title]);
    						}
    						articleSelectRefresh();
    					}
    					function articleSelectRefresh(){
    						$("#articleDataRelation").val("");
    						$("#articleSelectList").children().remove();
    						for (var i=0; i<articleSelect.length; i++){
    							$("#articleSelectList").append("<li>"+articleSelect[i][1]+"&nbsp;&nbsp;<a href=\"javascript:\" onclick=\"articleSelectAddOrDel('"+articleSelect[i][0]+"','"+articleSelect[i][1]+"');\">×</a></li>");
    							$("#articleDataRelation").val($("#articleDataRelation").val()+articleSelect[i][0]+",");
    						}
    					}
    					$.getJSON("${ctx}/cms/article/findByIds",{ids:$("#articleDataRelation").val()},function(data){
    						for (var i=0; i<data.length; i++){
    							articleSelect.push([data[i][1],data[i][2]]);
    						}
    						articleSelectRefresh();
    					});
    					$("#relationButton").click(function(){
    						top.dialog({
    							title : '添加相关',
    							url : '${ctx}/cms/article/selectList?pageSize=8',
    							width : $(top.document).width()-220,
    							height : $(top.document).height()-180,
    							button : [{
    								value : '确定',
    								callback: function () {
    								}
    							}]
    						}).show();
    					});
    				</script>
    			</div>
    		</div>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">是否允许评论:</label>
    			<div class="col-sm-3">
                    <label class="form-control-static">
    				    <form:radiobuttons path="articleData.allowComment" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
    			    </label>
                </div>
    		</div>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">推荐位:</label>
    			<div class="col-sm-3">
                    <label class="form-control-static">
    				    <form:checkboxes path="posidList" items="${fns:getDictList('cms_posid')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
    			     </label>
                </div>
    		</div>
    		<div class="form-group">
    			<label class="col-sm-2 control-label">发布时间:</label>
    			<div class="col-sm-3">
    				<input id="createDate" name="createDate" type="text" readonly="readonly" maxlength="20" class="form-control datepicker"
    					value="<fmt:formatDate value="${article.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
    			</div>
    		</div>
    		<shiro:hasPermission name="cms:article:audit">
    			<div class="form-group">
    				<label class="col-sm-2 control-label">发布状态:</label>
    				<div class="col-sm-3">
                        <label class="form-control-static">
        					<form:radiobuttons path="delFlag" items="${fns:getDictList('cms_del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
        				</label>
                    </div>
    			</div>
    		</shiro:hasPermission>
    		<shiro:hasPermission name="cms:category:edit">
                <div class="form-group">
                    <label class="col-sm-2 control-label">自定义内容视图:</label>
                    <div class="col-sm-3">
                          <form:select path="customContentView" class="form-control">
                              <form:option value="" label="默认视图"/>
                              <form:options items="${contentViewList}" htmlEscape="false"/>
                          </form:select>
                    </div>
                  <p class="form-control-static help-inline">自定义内容视图名称必须以"${article_DEFAULT_TEMPLATE}"开始</p>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">自定义视图参数:</label>
                    <div class="col-sm-3">
                          <form:input path="viewConfig" class="form-control" htmlEscape="true"/>
                    </div>
                  <p class="form-control-static help-inline">视图参数例如: {count:2, title_show:"yes"}</p>
                </div>
    		</shiro:hasPermission>
    		<c:if test="${not empty article.id}">
    			<div class="form-group">
    				<label class="col-sm-2 control-label">查看评论:</label>
    				<div class="col-sm-3">
    					<input id="btnComment" class="btn btn-default" type="button" value="查看评论" onclick="viewComment('${ctx}/cms/comment/?module=article&contentId=${article.id}&status=0')"/>
    					<script>
    						function viewComment(href) {
    						    top.dialog({
    						        title : '查看评论',
    						        url : href,
                            		width : $(top.document).width() - 220,
                                    height : $(top.document).height() - 180,
                                    button : [ {
                                        value : '关闭'
                                    } ]
                                }).show();
                                return false;
                            }
                        </script>
    				</div>
    			</div>
    		</c:if>
    		<div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
        			<shiro:hasPermission name="cms:article:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保存"/></shiro:hasPermission>
        			<input id="btnCancel" class="btn btn-default" type="button" value="返回" onclick="history.go(-1)"/>
                </div>
    		</div>
    	</form:form>
    </div>
</body>
</html>