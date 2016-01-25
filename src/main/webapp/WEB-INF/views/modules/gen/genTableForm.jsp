<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>业务表管理</title>
<meta name="decorator" content="default" />
<script>
    $(function() {
        $("#comments").focus();
        $("#inputForm").validate({
            submitHandler: function(form){
                loading('正在提交，请稍等...');
                $("input[type=checkbox]").each(function(){
                    $(this).after("<input type=\"hidden\" name=\""+$(this).attr("name")+"\" value=\""
                            +($(this).attr("checked")?"1":"0")+"\"/>");
                    $(this).attr("name", "_"+$(this).attr("name"));
                });
                form.submit();
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
        <li><a href="${ctx}/gen/genTable/">业务表列表</a></li>
        <li class="active">
            <a href="${ctx}/gen/genTable/form?id=${genTable.id}&name=${genTable.name}">
                业务表<shiro:hasPermission name="gen:genTable:edit">${not empty genTable.id?'修改':'添加'}</shiro:hasPermission>
                <shiro:lacksPermission name="gen:genTable:edit">查看</shiro:lacksPermission>
            </a>
        </li>
    </ul>
    <div class="container-fluid">
        <c:choose>
            <c:when test="${empty genTable.name}">
                <form:form id="inputForm" modelAttribute="genTable" action="${ctx}/gen/genTable/form" method="post" class="form-search form-inline">
                    <form:hidden path="id" />
                    <sys:message content="${message}" />
                    <div class="form-group">
                        <label class="control-label">表名:</label>
                        <form:select path="name" class="form-control">
                            <form:options items="${tableList}" itemLabel="nameAndComments" itemValue="name" htmlEscape="false" />
                        </form:select>
                    </div>
                    <div class="form-group">
                        <input id="btnSubmit" class="btn btn-primary" type="submit" value="下一步" />
                        <input id="btnCancel" class="btn btn-default" type="button" value="返回" onclick="history.go(-1)" />
                    </div>
                </form:form>
            </c:when>
            <c:otherwise>
                <form:form id="inputForm" modelAttribute="genTable" action="${ctx}/gen/genTable/save" method="post" class="form-horizontal">
                    <form:hidden path="id" />
                    <sys:message content="${message}" />
                    <fieldset>
                        <legend>基本信息</legend>
                        <div class="form-group">
                            <label class="col-sm-1 control-label">表名:</label>
                            <div class="col-sm-3">
                                <form:input path="name" htmlEscape="false" maxlength="200" cssClass="form-control required" readonly="true" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 control-label">说明:</label>
                            <div class="col-sm-3">
                                <form:input path="comments" htmlEscape="false" maxlength="200" cssClass="form-control required" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 control-label">类名:</label>
                            <div class="col-sm-3">
                                <form:input path="className" htmlEscape="false" maxlength="200" cssClass="form-control required" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 control-label">父表表名:</label>
                            <div class="col-sm-3">
                                <form:select path="parentTable" cssClass="form-control">
                                    <form:option value="">无</form:option>
                                    <form:options items="${tableList}" itemLabel="nameAndComments" itemValue="name" htmlEscape="false" />
                                </form:select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 control-label">当前表外键：</label>
                            <div class="col-sm-3">
                                <form:select path="parentTableFk" cssClass="form-control">
                                    <form:option value="">无</form:option>
                                    <form:options items="${genTable.columnList}" itemLabel="nameAndComments" itemValue="name" htmlEscape="false" />
                                </form:select>
                                <p class="form-control-static help-inline">如果有父表，请指定父表表名和外键</p>
                            </div>
                        </div>
                        <div class="form-group hide-element">
                            <label class="col-sm-1 control-label">备注:</label>
                            <div class="col-sm-3">
                                <form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="200" class="form-control" />
                            </div>
                        </div>
                    </fieldset>
                    <legend>字段列表</legend>
                    <table id="contentTable" class="table table-striped table-bordered">
                        <thead>
                            <tr>
                                <th nowrap title="数据库字段名">列名</th>
                                <th nowrap title="默认读取数据库字段备注">说明</th>
                                <th nowrap title="数据库中设置的字段类型及长度">物理类型</th>
                                <th nowrap title="实体对象的属性字段类型">Java类型</th>
                                <th nowrap title="实体对象的属性字段（对象名.属性名|属性名2|属性名3，例如：用户user.id|name|loginName，属性名2和属性名3为Join时关联查询的字段）">Java属性名称 <i class="glyphicon glyphicon-question-sign"></i></th>
                                <th nowrap title="是否是数据库主键">主键</th>
                                <th nowrap title="字段是否可为空值，不可为空字段自动进行空值验证">可空</th>
                                <th nowrap title="选中后该字段被加入到insert语句里">插入</th>
                                <th nowrap title="选中后该字段被加入到update语句里">编辑</th>
                                <th nowrap title="选中后该字段被加入到查询列表里">列表</th>
                                <th nowrap title="选中后该字段被加入到查询条件里">查询</th>
                                <th nowrap title="该字段为查询字段时的查询匹配放松">查询匹配方式</th>
                                <th nowrap title="字段在表单中显示的类型">显示表单类型</th>
                                <th nowrap title="显示表单类型设置为“下拉框、复选框、点选框”时，需设置字典的类型">字典类型</th>
                                <th nowrap>排序</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${genTable.columnList}" var="column" varStatus="vs">
                                <tr ${column.delFlag eq '1'?' class="danger" title="已删除的列，保存之后消失！"':''}>
                                    <td nowrap>
                                        <input type="hidden" name="columnList[${vs.index}].id" value="${column.id}" />
                                        <input type="hidden" name="columnList[${vs.index}].delFlag" value="${column.delFlag}" />
                                        <input type="hidden" name="columnList[${vs.index}].genTable.id" value="${column.genTable.id}" />
                                        <input type="hidden" name="columnList[${vs.index}].name" value="${column.name}" />${column.name}
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[${vs.index}].comments" value="${column.comments}" maxlength="200" class="form-control required"/>
                                    </td>
                                    <td nowrap>
                                        <input type="hidden" name="columnList[${vs.index}].jdbcType" value="${column.jdbcType}" />${column.jdbcType}
                                    </td>
                                    <td>
                                        <select name="columnList[${vs.index}].javaType" class="required form-control">
                                            <c:forEach items="${config.javaTypeList}" var="dict">
                                                <option value="${dict.value}" ${dict.value==column.javaType?'selected':''} title="${dict.description}">${dict.label}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[${vs.index}].javaField" value="${column.javaField}" maxlength="200" class="required form-control" />
                                    </td>
                                    <td>
                                        <input type="checkbox" name="columnList[${vs.index}].isPk" value="1" ${column.isPk eq '1' ? 'checked' : ''} />
                                    </td>
                                    <td>
                                        <input type="checkbox" name="columnList[${vs.index}].isNull" value="1" ${column.isNull eq '1' ? 'checked' : ''} />
                                    </td>
                                    <td>
                                        <input type="checkbox" name="columnList[${vs.index}].isInsert" value="1" ${column.isInsert eq '1' ? 'checked' : ''} />
                                    </td>
                                    <td>
                                        <input type="checkbox" name="columnList[${vs.index}].isEdit" value="1" ${column.isEdit eq '1' ? 'checked' : ''} />
                                    </td>
                                    <td>
                                        <input type="checkbox" name="columnList[${vs.index}].isList" value="1" ${column.isList eq '1' ? 'checked' : ''} />
                                    </td>
                                    <td>
                                        <input type="checkbox" name="columnList[${vs.index}].isQuery" value="1" ${column.isQuery eq '1' ? 'checked' : ''} />
                                    </td>
                                    <td>
                                        <select name="columnList[${vs.index}].queryType" class="required form-control">
                                            <c:forEach items="${config.queryTypeList}" var="dict">
                                                <option value="${fns:escapeHtml(dict.value)}" ${fns:escapeHtml(dict.value)==column.queryType?'selected':''}
                                                    title="${dict.description}">${fns:escapeHtml(dict.label)}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                    <td>
                                        <select name="columnList[${vs.index}].showType" class="required form-control">
                                            <c:forEach items="${config.showTypeList}" var="dict">
                                                <option value="${dict.value}" ${dict.value==column.showType?'selected':''} title="${dict.description}">${dict.label}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[${vs.index}].dictType" value="${column.dictType}" maxlength="200" class="form-control" />
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[${vs.index}].sort" value="${column.sort}" maxlength="200" class="required form-control digits" />
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div class="clearfix">
                        <shiro:hasPermission name="gen:genTable:edit">
                            <input id="btnSubmit" class="btn btn-primary" type="submit" value="保存" />
                        </shiro:hasPermission>
                        <input id="btnCancel" class="btn btn-default" type="button" value="返回" onclick="history.go(-1)" />
                    </div>
                </form:form>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
