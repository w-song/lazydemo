<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!-- jQuery validation -->
<link href="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.min.css" rel="stylesheet" />
<script src="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.min.js"></script>
<!-- artDialog -->
<link href="${ctxStatic}/artDialog/6.0.5/css/ui-dialog.css" rel="stylesheet" />
<script src="${ctxStatic}/artDialog/6.0.5/js/dialog-plus.js"></script>
<script>
    $(function() {
        comment(0);
    });
    function commentForm(form) {
        $(form).validate({
            rules : {
                validateCode : {
                    remote : "${pageContext.request.contextPath}/servlet/validateCodeServlet"
                }
            },
            messages : {
                content : {
                    required : "请填写评论内容"
                },
                validateCode : {
                    remote : "验证码不正确",
                    required : "请填写验证码"
                }
            },
            submitHandler : function(form) {
                $.post($(form).attr("action"), $(form).serialize(), function(data) {
                    data = eval("(" + data + ")");
                    dialog({
                        title : '提示',
                        width : 200,
                        content : data.message,
                        button : [ {
                            value : '关闭'
                        } ]
                    }).show();
                    if (data.result == 1) {
                        page(1);
                        comment(0);
                    }
                });
            },
            highlight : function(element) {
                $(element).closest('.form-group').addClass('has-error');
            },
            unhighlight : function(element) {
                $(element).closest('.form-group').removeClass('has-error');
            },
            errorElement : 'label',
            errorClass : 'help-block',
            errorPlacement : function(error, element) {
                if (element.parent('.input-group').length) {
                    error.insertAfter(element.parent());
                } else if (element.is(":checkbox") || element.is(":radio")) {
                    error.appendTo(element.parent().parent());
                } else {
                	var name =$(element).attr("name");
                	if(name == "validateCode"){
                		error.insertAfter(element.parent());
                	}else{
                    	error.insertAfter(element);
                	}
                	
                }
            }
        });
    }
    function comment(id) {
        if ($("#commentForm" + id).html() == "") {
            $(".validateCodeRefresh").click();
            $(".commentForm").hide(function() {
                $(this).html("");
            });
            $("#commentForm" + id).html($("#commentFormTpl").html()).show();
            $("#commentForm" + id + " input[name='replyId']").val(id);
            commentForm("#commentForm" + id + " form");
        } else {
            $("#commentForm" + id).hide(function() {
                $(this).html("");
            });
        }
    }
</script>
<div class="panel panel-theme-1">
    <div class="panel-heading">
        <span class="category-title"><i class="fa fa-comments icon"></i> 评论列表</span>
    </div>
    <div class="panel-body">
        <div class="article-comment-list-1">
            <ul class="media-list">
                <c:set var="noPhoto" value="${ctxStatic}/images/nophoto.png"></c:set>
                <c:forEach items="${page.list}" var="comment" varStatus="status">
                    <li class="media">
                        <div class="media-left">
                            <img class="lazy img-responsive comment-photo" alt="${comment.name}" src="" data-original="${noPhoto}">
                            <span class="comment-name">${comment.name}</span>
                        </div>
                        <div class="media-body">
                            <div class="comment-mess">
                                <span class="comment-index">IP地址：${comment.ip}</span>
                                <span class="comment-date">时间：<fmt:formatDate value="${comment.createDate}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
                            </div>
                            <div class="comment-content">${comment.content}</div>
                            <div><a href="javascript:comment('${comment.id}')">回复</a></div>
                            <div id="commentForm${comment.id}" class="commentForm hide-element"></div>
                        </div>
                    </li>
                </c:forEach>
                <c:if test="${fn:length(page.list) eq 0}">
                    <li>暂时还没有人评论！</li>
                </c:if>
            </ul>
        </div>
    </div>
    <nav class="pagination-1 text-center">${page}</nav>
</div>
<div id="commentForm0"></div>
<div class="hide" id="commentFormTpl">
    <div class="panel panel-theme-1">
        <div class="panel-heading">
            <span class="category-title"><i class="fa fa-comment icon"></i> 我要评论</span>
        </div>
        <div class="panel-body">
            <div class="article-comment-1">
                <form:form class="form-comment" action="${ctx}/comment" method="post">
                    <input type="hidden" name="category.id" value="${comment.category.id}" />
                    <input type="hidden" name="contentId" value="${comment.contentId}" />
                    <input type="hidden" name="title" value="${comment.title}" />
                    <input type="hidden" name="replyId" />
					<div class="comment-text">
						<span class="form-control-static">欢迎，</span>
						<input class="form-control txt required" type="text" name="name" value="匿名" maxlength="11" />
						<span class="form-control-static">已有帐号？点击 <a href="${ctx}/login">登录</a></span>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<textarea class="form-control textarea-comment txt required"
								name="content" rows="4" maxlength="200"></textarea>
							<label class="form-control-static">验证码：</label>
							<sys:validateCode name="validateCode"
								inputCssClass="comment-code" />
							<input class="btn btn-success btn-submit" type="submit"
								value="发表评论" />
						</div>
					</div>
                </form:form>
            </div>
        </div>
    </div>
</div>