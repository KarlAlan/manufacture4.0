
<%@ page import="com.rcstc.manufacture.WeeklyPlan" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'weeklyPlan.label', default: 'WeeklyPlan')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
    <ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
        <li role="presentation" >
            <g:link class="list" action="index">
                <g:message code="task.list" args="[entityName]" />
            </g:link>
        </li>
        <li role="presentation" class="active">
            <g:link controller="weeklyPlan" class="create" action="index">
                每周计划
            </g:link>
        </li>
        <li role="presentation">
            <g:link class="create" controller="weeklyPlan" action="schedue">
                周计划安排
            </g:link>
        </li>
    </ul>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <button id="prev_week" class="btn btn-xs btn-info pull-left"><i class="ace-icon bigger-120 icon-chevron-left"></i></button>
    <button id="next_week" class="btn btn-xs btn-info pull-right"><i class="ace-icon bigger-120 icon-chevron-right"></i></button>
    <h4 id="title_week" month="0" style="text-align: center">${new Date().format("yyyy年M月")}</h4>

		<div id="list-weeklyPlan" class="content scaffold-list" role="main">

			<g:if test="${flash.message}">
				<div class="alert alert-block alert-success" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
			<thead>
					<tr>
					    <th></th>
						<th><g:message code="weeklyPlan.person.label" default="Person" /></th>
					
						<g:sortableColumn property="planTasksAmount" title="${message(code: 'weeklyPlan.planTasksAmount.label', default: 'Plan Tasks Amount')}" />
					
						<g:sortableColumn property="planWorkload" title="${message(code: 'weeklyPlan.planWorkload.label', default: 'Plan Workload')}" />
					
						<g:sortableColumn property="actualTasksAmount" title="${message(code: 'weeklyPlan.actualTasksAmount.label', default: 'Actual Tasks Amount')}" />
					
						<g:sortableColumn property="actualWorkload" title="${message(code: 'weeklyPlan.actualWorkload.label', default: 'Actual Workload')}" />

					</tr>
				</thead>
				<tbody>
				<g:each in="${weeklyPlanInstanceList}" status="i" var="weeklyPlanInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					    <td></td>
						<td><g:link action="show" id="${weeklyPlanInstance.id}">${fieldValue(bean: weeklyPlanInstance, field: "person")}</g:link></td>
					
						<td>${fieldValue(bean: weeklyPlanInstance, field: "planTasksAmount")}</td>
					
						<td>${fieldValue(bean: weeklyPlanInstance, field: "planWorkload")}</td>
					
						<td>${fieldValue(bean: weeklyPlanInstance, field: "actualTasksAmount")}</td>
					
						<td>${fieldValue(bean: weeklyPlanInstance, field: "actualWorkload")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${weeklyPlanInstanceCount ?: 0}" />
                <span style="padding-left: 20px;position: relative;bottom: 30px">总共<span style="color: darkblue">${weeklyPlanInstanceCount ?: 0}</span>条</span>
			</div>
		</div>
	</body>
</html>
