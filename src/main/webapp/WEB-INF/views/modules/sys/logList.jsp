<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>日志管理</title>
<meta name="decorator" content="default" />
<script>
    function page(n,s){
        $("#pageNo").val(n);
        $("#pageSize").val(s);
        $("#searchForm").submit();
        return false;
    }
</script>
</head>
<body>
    <div class="container-fluid">
        <form:form id="searchForm" action="${ctx}/sys/log/" method="post" class="breadcrumb form-inline form-search">
            <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
            <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
            <div class="row">
                <div class="form-group">
                    <label>操作菜单：</label>
                    <input id="title" name="title" type="text" maxlength="50" class="form-control" value="${log.title}" />
                </div>
                <div class="form-group">
                    <label>用户ID：</label>
                    <input id="createBy.id" name="createBy.id" type="text" maxlength="50" class="form-control" value="${log.createBy.id}" />
                </div>
                <div class="form-group">
                    <label>URI：</label>
                    <input id="requestUri" name="requestUri" type="text" maxlength="50" class="form-control" value="${log.requestUri}" />
                </div>
            </div>
            <div class="row">
                <div class="form-group">
                    <label>日期范围：</label>
                </div>
                <div class="form-group">
                    <div class="input-daterange input-group datepicker">
                        <input type="text" class="form-control" name="beginDate"
                            value="<fmt:formatDate value="${log.beginDate}" pattern="yyyy-MM-dd"/>" readonly="readonly" maxlength="20" />
                        <span class="input-group-addon">至</span>
                        <input type="text" class="form-control" name="endDate"
                            value="<fmt:formatDate value="${log.endDate}" pattern="yyyy-MM-dd"/>" readonly="readonly" maxlength="20" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="checkbox">
                        <label>
                            <input id="exception" name="exception" type="checkbox" ${log.exception eq '1'?' checked':''} value="1" />只查询异常信息
                        </label>
                    </div>
                	<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" />
                </div>
            </div>
        </form:form>
        <sys:message content="${message}" />
        <table id="contentTable" class="table table-striped table-bordered">
            <thead>
                <tr>
                    <th>操作菜单</th>
                    <th>操作用户</th>
                    <th>所在公司</th>
                    <th>所在部门</th>
                    <th>URI</th>
                    <th>提交方式</th>
                    <th>操作者IP</th>
                    <th>操作时间</th>
            </thead>
            <tbody>
                <%
                    request.setAttribute("strEnter", "\n");
                    request.setAttribute("strTab", "\t");
                %>
                <c:forEach items="${page.list}" var="log">
                    <tr>
                        <td>${log.title}</td>
                        <td>${log.createBy.name}</td>
                        <td>${log.createBy.company.name}</td>
                        <td>${log.createBy.office.name}</td>
                        <td><strong>${log.requestUri}</strong></td>
                        <td>${log.method}</td>
                        <td>${log.remoteAddr}</td>
                        <td><fmt:formatDate value="${log.createDate}" type="both" /></td>
                    </tr>
                    <c:if test="${not empty log.exception}">
                        <tr>
                            <td colspan="8" style="word-wrap: break-word; word-break: break-all;">异常信息: <br />
                                ${fn:replace(fn:replace(fns:escapeHtml(log.exception), strEnter, '<br/>'), strTab, '&nbsp; &nbsp; ')}
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
            </tbody>
        </table>
        <nav>${page}</nav>
    </div>
</body>
</html>