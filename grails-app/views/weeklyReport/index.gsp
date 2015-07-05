
<%@ page import="com.rcstc.manufacture.WeeklyReport" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'weeklyReport.label', default: 'WeeklyReport')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
    <ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
        <li role="presentation" class="active">
            <g:link class="list" action="index">
                <g:message code="default.list.label" args="[entityName]" />
            </g:link>
        </li>
    </ul>

		<div id="list-weeklyReport">

			<g:if test="${flash.message}">
				<div class="alert alert-block alert-success" role="status">${flash.message}</div>
			</g:if>
            <div title="查询条件" style="margin: 10px">
                <g:form action="index" method="post" class="form-inline" role="form">
                    <div class="form-group">
                        <label for="pid">项目：</label>
                        <g:select name="pid" from="${pl}"  optionKey="id" value="${params.pid}" noSelection="['-1':'-所有-']" class="form-control"/>
                    </div>
                    <button type="submit" class="btn btn-info btn-sm pull-right">查询</button>
                </g:form>
            </div>

			<table class="table table-bordered">
			<thead>
					<tr>
                        <th></th>
						<th><g:message code="weeklyReport.project.label" default="Project" /></th>
						<g:sortableColumn property="startDate" title="${message(code: 'weeklyReport.startEndDate.label', default: 'Start Date')}" />

                        <th>${message(code: 'weeklyReport.situation.label', default: 'situation')}</th>
					    <th>${message(code: 'weeklyReport.description.label', default: 'description')}</th>
                        <th>${message(code: 'weeklyReport.question.label', default: 'question')}</th>
                        <th>${message(code: 'weeklyReport.resource.label', default: 'resource')}</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${weeklyReportInstanceList}" status="i" var="weeklyReportInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        <td>
                            <g:if test="${!weeklyReportInstance.status|| weeklyReportInstance.status=='draft'}">
                                <i class="glyphicon glyphicon-pencil text-warning" ></i>
                            </g:if>
                            <g:else>
                                <i class="glyphicon glyphicon-ok text-success" ></i>
                            </g:else>
                        </td>
						<td><g:link action="show" id="${weeklyReportInstance.id}">${fieldValue(bean: weeklyReportInstance, field: "project")}</g:link></td>
					
						<td><g:formatDate date="${weeklyReportInstance.startDate}" format="yy/MM/dd"/>-<g:formatDate date="${weeklyReportInstance.stopDate}" format="MM/dd"/></td>

						<td>
                            <g:if test="${weeklyReportInstance?.situation=='normal'}">
                                <span class="label label-info" >按计划进行</span>
                            </g:if>
                            <g:elseif test="${weeklyReportInstance?.situation=='delay'}">
                                <span class="label label-warning" >比计划落后</span>
                            </g:elseif>
                            <g:else>
                                <span class="label label-success" >按计划提前</span>
                            </g:else>
                        </td>
					
						<td>${fieldValue(bean: weeklyReportInstance, field: "description")}</td>
                        <td>${fieldValue(bean: weeklyReportInstance, field: "question")}</td>
                        <td>${fieldValue(bean: weeklyReportInstance, field: "resource")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${weeklyReportInstanceCount ?: 0}" />
                <span style="padding-left: 20px;position: relative;bottom: 30px">总共<span style="color: darkblue">${weeklyReportInstanceCount ?: 0}</span>条</span>
			</div>
		</div>
	</body>
</html>
