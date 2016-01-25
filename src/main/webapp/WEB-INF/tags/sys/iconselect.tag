<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="编号"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="输入框名称"%>
<%@ attribute name="value" type="java.lang.String" required="true" description="输入框值"%>
<i id="${id}Icon" class="glyphicon glyphicon-${not empty value ? value : ' hide-element'}"></i>
<label id="${id}IconLabel">${not empty value ? value : '无'}</label>
<input id="${id}" name="${name}" type="hidden" value="${value}"/>
<a id="${id}Button" href="javascript:void(0);" class="btn btn-default">选择</a>
<script>
	$("#${id}Button").click(function() {
		top.dialog({
			id : "iconSelect",
			title : "选择图标",
			url : "${ctx}/tag/iconselect?value=" + $("#${id}").val(),
			width : 600,
			height : $(top.document).height() - 240,
			button : [{
				id : 'ok',
				value : '选择',
            	callback : function () {
            		var icon = top.$("div[role=dialog]").find("iframe")[0].contentWindow.$("#icon").val();
            		getIcon(icon);
            	},
            	autofocus : true
			},{
				value : '清除',
            	callback : function () {
            		getIcon(null);
            	}
			},{
				value : '关闭'
			}]
		}).show();
	});
	
	function getIcon(icon) {
		if (icon == null) {
			$("#${id}Icon").attr("class", "hide-element");
            $("#${id}IconLabel").text("无");
            $("#${id}").val("");
		} else {
    		$("#${id}Icon").attr("class", "glyphicon glyphicon-" + icon);
            $("#${id}IconLabel").text(icon);
            $("#${id}").val(icon);
		}
	}
</script>