<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>分配角色</title>
<meta name="decorator" content="default" />
</head>
<body>
    <ul class="nav nav-tabs mb-2">
        <li><a href="${ctx}/sys/role/">角色列表</a></li>
        <li class="active">
            <a href="${ctx}/sys/role/assign?id=${role.id}">
                <shiro:hasPermission name="sys:role:edit">角色分配</shiro:hasPermission>
                <shiro:lacksPermission name="sys:role:edit">人员列表</shiro:lacksPermission>
            </a>
        </li>
    </ul>
    <div class="container-fluid">
        <div class="well">
            <div class="container-fluid">
                <div class="row col-md-12 mb-1">
                    <span class="col-md-4">角色名称： <b>${role.name}</b></span>
                    <span class="col-md-4">归属机构： ${role.office.name}</span>
                    <span class="col-md-4">英文名称： ${role.enname}</span>
                </div>
                <div class="row col-md-12">
                    <span class="col-md-4">角色类型： ${role.roleType}</span>
                    <c:set var="dictvalue" value="${role.dataScope}" scope="page" />
                    <span class="col-md-4">数据范围： ${fns:getDictLabel(dictvalue, 'sys_data_scope', '')}</span>
                </div>
            </div>
        </div>
        <sys:message content="${message}" />
        <div class="mb-2">
            <form id="assignRoleForm" action="${ctx}/sys/role/assignrole" method="post" class="hide-element">
                <input type="hidden" name="id" value="${role.id}">
                <input id="idsArr" type="hidden" name="idsArr">
            </form>
            <input id="assignButton" class="btn btn-primary" type="submit" value="分配角色" />
            <script>
                $("#assignButton").click(function(){
                	top.dialog({
            			id : "userToRole",
            			title : "分配角色",
            			url : "${ctx}/sys/role/usertorole?id=${role.id}",
            			width : 800,
            			height : $(top.document).height() - 240,
            			button : [{
            				value : '确定分配',
                        	callback : function () {
                        		var pre_ids = top.$("div[role=dialog]").find("iframe")[0].contentWindow.pre_ids;
                                var ids = top.$("div[role=dialog]").find("iframe")[0].contentWindow.ids;
                             	// 删除''的元素
                                if(ids[0] == ''){
                                    ids.shift();
                                    pre_ids.shift();
                                }
                                if(pre_ids.sort().toString() == ids.sort().toString()){
                                    showTip("未给角色【${role.name}】分配新成员！", 'info');
                                    return false;
                                };
                                // 执行保存
                                loading('正在提交，请稍等...');
                                var idsArr = "";
                                for (var i = 0; i<ids.length; i++) {
                                    idsArr = (idsArr + ids[i]) + (((i + 1)== ids.length) ? '' : ',');
                                }
                                $('#idsArr').val(idsArr);
                                $('#assignRoleForm').submit();
                        	},
                        	autofocus : true
            			},{
            				value : '清除',
                        	callback : function () {
                        		top.$("div[role=dialog]").find("iframe")[0].contentWindow.clearAssign();
                        		return false;
                        	}
            			},{
            				value : '关闭'
            			}],
            			statusbar : '通过选择部门，然后为列出的人员分配角色。',
                        onclose : function () {
            				this.remove();
            			}
            		}).show();
                });
            </script>
        </div>
        <table id="contentTable" class="table table-striped table-bordered">
            <thead>
                <tr>
                    <th>归属公司</th>
                    <th>归属部门</th>
                    <th>登录名</th>
                    <th>姓名</th>
                    <th>电话</th>
                    <th>手机</th>
                    <shiro:hasPermission name="sys:user:edit">
                        <th>操作</th>
                    </shiro:hasPermission>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${userList}" var="user">
                    <tr>
                        <td>${user.company.name}</td>
                        <td>${user.office.name}</td>
                        <td><a href="${ctx}/sys/user/form?id=${user.id}">${user.loginName}</a></td>
                        <td>${user.name}</td>
                        <td>${user.phone}</td>
                        <td>${user.mobile}</td>
                        <shiro:hasPermission name="sys:role:edit">
                            <td>
                                <a href="${ctx}/sys/role/outrole?userId=${user.id}&roleId=${role.id}" 
                                    onclick="return confirmx('确认要将用户<b>[${user.name}]</b>从<b>[${role.name}]</b>角色中移除吗？', this.href)">移除</a>
                            </td>
                        </shiro:hasPermission>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
