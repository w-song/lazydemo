<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="表单name"%>
<%@ attribute name="value" type="java.lang.String" required="true" description="ftpFile批量编号"%>
<%@ attribute name="ftpFile" type="com.thinkgem.jeesite.modules.ftpfile.entity.FtpFile" required="false" description="ftpFile类"%>
<%@ attribute name="ftpFileList" type="java.util.List" required="false" description="ftpFile集合"%>
<%@ attribute name="multiple" type="java.lang.Boolean" required="false" description="是否多文件上传"%>
<%@ attribute name="fileTypes" type="java.lang.String" required="false" description="支持文件类型（多个以,分隔）"%>
<input type="hidden" id="${name}" name="${name}" value="${value}" />
<div id="webuploader-${name}" class="webuploader">
    <div class="webuploader-description">点击上传或将文件拖到这里</div>
</div>
<!-- 修改页面加载已上传文件 -->
<div class="hide" id="${name}UpdateFile">
    <c:choose>
        <c:when test="${not empty ftpFile}">
            <div class="webuploader-list-item animated bounceIn" id="${ftpFile.id}">
                <c:choose>
                    <c:when test="${ftpFile.icon eq 'file-image-o'}">
                        <img class="webuploader-list-img" src="${ftpPath}${ftpFile.remotePath}${ftpFile.fileName}${ftpFile.fileType}" />
                    </c:when>
                    <c:otherwise>
                        <div class="webuploader-file-icon"><i class="fa fa-${ftpFile.icon}"></i></div>
                    </c:otherwise>
                </c:choose>
                <div class="webuploader-list-info">${ftpFile.fileName}${ftpFile.fileType}</div>
                <button class="btn btn-danger btn-block webuploader-list-remove update-remove" type="button">删除</button>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach items="${ftpFileList}" var="entity">
                <div class="webuploader-list-item animated bounceIn" id="${entity.id}">
                    <c:choose>
                        <c:when test="${entity.icon eq 'file-image-o'}">
                            <img class="webuploader-list-img" src="${ftpPath}${entity.remotePath}${entity.fileName}${entity.fileType}" />
                        </c:when>
                        <c:otherwise>
                            <div class="webuploader-file-icon"><i class="fa fa-${entity.icon}"></i></div>
                        </c:otherwise>
                    </c:choose>
                    <div class="webuploader-list-info">${entity.fileName}${entity.fileType}</div>
                    <button class="btn btn-danger btn-block webuploader-list-remove update-remove" type="button">删除</button>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>
<script>
    jQuery(function() {
        var $ = jQuery,
         // 优化retina, 在retina下这个值是2
        ratio = window.devicePixelRatio || 1,
        // 缩略图大小
        thumbWidth = 100 * ratio,
        thumbHeight = 100 * ratio;
        // 创建Web Uploader实例
        var uploader = WebUploader.create({
            // 文件接收服务端。
            server : '${ctx}/ftpFile/upload',
            // 选择文件的按钮。
            pick : {
                id : '#webuploader-${name}'
            },
            // 指定拖拽容器
            dnd : '#webuploader-${name}',
            // 限制文件个数 默认多文件个数
            fileNumLimit : '${multiple ? 10 : 1}',
            // 接受的文件类型
            accept: {
                title: 'file',
                extensions: '${fileTypes}'
            },
            // 批量编号，传往后台参数 uuid
            formData : {batchId : '${empty value ? fns:uuid() : value}'},
            // 不压缩image, 默认如果是jpeg，文件上传前会压缩后再上传
            resize : false
        });
        // 文件列表
        var $list = $('<div class="webuploader-list clearfix"></div>').appendTo($('#webuploader-${name} .webuploader-pick'));
        // 当有文件添加进来的时候
        uploader.on('fileQueued', function(file) {
            // 隐藏描述文字
            $('#webuploader-${name} .webuploader-description').hide();
            // 显示文件信息
            var $li = $('<div class="webuploader-list-item animated bounceIn" id="' + file.id + '">' +
                            '<img class="webuploader-list-img"/>' +
                            '<div class="webuploader-list-info">' + file.name + '</div>' +
                            '<div class="progress progress-striped active">' +
                                '<div class="progress-bar progress-bar-success"></div>' +
                            '</div>' +
                            '<button class="btn btn-danger btn-block webuploader-list-remove" type="button">删除</button>' +
                        '</div>'),
            $img = $li.find('.webuploader-list-img');
            // 隐藏删除按钮
            $li.find(".webuploader-list-remove").hide();
            // 绑定隐藏或显示文件名
            bindShowOrHideName($li);
            $list.append($li);
            // 创建缩略图
            uploader.makeThumb(file, function(error, src) {
                if (error) {
                    $img.replaceWith('<div class="webuploader-file-icon"><i class="fa fa-file-o"></i></div>');
                    return;
                }
                $img.attr('src', src);
            }, thumbWidth, thumbHeight);
         	// 删除文件
            $("#" + file.id).one("click", ".webuploader-list-remove", function() {
                var $li = $(this).parent();
                var id = $li.data("id");
             	// 删除队列
                uploader.removeFile($li.attr("id"), true);
                removeFile(id, $li);
            });
        });

     	// 文件加进队列之前触发
        uploader.on('beforeFileQueued', function(file) {
            // 进入修改页面之后的文件数量
            var size = $("#webuploader-${name} .webuploader-list").find(".webuploader-list-item").size();
            // 文件上传限制数量
            var limit = parseInt('${multiple ? 10 : 1}');
            if (limit - size > 0) {
                // 还未添加完成，可以继续添加
                return true;
            } else {
                return false;
            }
        });

        // 文件加进队列时触发上传
        uploader.on('fileQueued', function(file) {
            uploader.upload(file);
        });

        // 文件上传过程中创建进度条实时显示。
        uploader.on('uploadProgress', function(file, percentage) {
            var $li = $('#' + file.id),
            $percent = $li.find('.progress .progress-bar');
            $percent.css('width', percentage * 100 + '%');
        });
        // 上传成功 返回后台值
        uploader.on('uploadSuccess', function(file, response) {
            // webUploader只会返回一条
            var ftpFile = response[0];
            // 传值保存批量编号
            $("#${name}").val(ftpFile.batchId);
            // 文件名及ID
            var $file = $('#' + file.id);
            $file.data("id", ftpFile.id);
            $file.find(".webuploader-list-info").text(ftpFile.fileName + ftpFile.fileType);
            // 非图片图标
            $file.find(".webuploader-file-icon").html('<i class="fa fa-' + ftpFile.icon + '"></i>');
            // 显示删除按钮
            $file.find(".webuploader-list-remove").show();
        });

        // 上传出错
        uploader.on('uploadError', function(file) {
            // TODO
        });
        // 上传完成
        uploader.on('uploadComplete', function(file) {
            $('#' + file.id).find('.progress').hide();
        });

        // 修改页面加载默认已上传的文件列表
        if ($("#${name}UpdateFile").children().is(".webuploader-list-item")) {
         	// 隐藏描述文字
            $('#webuploader-${name} .webuploader-description').hide();
            $list.html($("#${name}UpdateFile").html());
            // 绑定隐藏或显示文件名
            var $li = $list.find(".webuploader-list-item");
            bindShowOrHideName($li);
        }
        // 修改页面已上传列表文件删除绑定
        $(".update-remove").one("click", function() {
            var $li = $(this).parent();
            var id = $li.attr("id");
            removeFile(id, $li);
        });

     	// 隐藏和显示文件名公共方法
     	function bindShowOrHideName($li) {
     		// 隐藏和显示文件名效果
            $li.on("mouseenter", function() {
                $(this).children(".webuploader-list-info").stop(true, true).fadeIn(200);
            }).on("mouseleave", function() {
                $(this).children(".webuploader-list-info").stop(true, true).fadeOut(200);
            });
     	}
        // 删除文件公共方法
        function removeFile(id, $li) {
         	// 添加渐出动画
            $li.addClass("bounceOut");
            // 动画完成后移除DOM
            $li.one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
                $li.remove();
            });
            $.ajax({
                url : "${ctx}/ftpFile/delete",
                method : "POST",
                data : {
                    id : id
                },
                dataType : "json",
                success : function() {
                    // 清除隐藏文本框值
                    if (!$li.siblings().is(".webuploader-list-item")) {
                        $("#${name}").val("");
                    }
                }
            });
        }

    });
</script>