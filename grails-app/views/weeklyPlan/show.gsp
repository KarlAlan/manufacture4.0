
<%@ page import="com.rcstc.manufacture.WeeklyPlan" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'weeklyPlan.label', default: 'WeeklyPlan')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
    <ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
        <li role="presentation">
            <g:link class="list" action="index">
                <g:message code="default.list.label" args="[entityName]" />
            </g:link>
        </li>
        <li role="presentation">
            <g:link class="create" action="create">
                <g:message code="default.new.label" args="[entityName]" />
            </g:link>
        </li>
        <li role="presentation" class="active">
            <a href="#">
                <g:message code="default.show.label" args="[entityName]" />
            </a>
        </li>
    </ul>
    <div class="row">
		<div id="show-weeklyPlan" class="col-xs-12" role="main">
            <div class="space-4"></div>
			<g:if test="${flash.message}">
			<div class="alert alert-block alert-success" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list weeklyPlan">
			
				<g:if test="${weeklyPlanInstance?.person}">
				<li class="fieldcontain">
					<span id="person-label" class="col-sm-3 control-label no-padding-right"><g:message code="weeklyPlan.person.label" default="Person" /></span>
					
						<span class="property-value" aria-labelledby="person-label"><g:link controller="person" action="show" id="${weeklyPlanInstance?.person?.id}">${weeklyPlanInstance?.person?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${weeklyPlanInstance?.planTasksAmount}">
				<li class="fieldcontain">
					<span id="planTasksAmount-label" class="col-sm-3 control-label no-padding-right"><g:message code="weeklyPlan.planTasksAmount.label" default="Plan Tasks Amount" /></span>
					
						<span class="property-value" aria-labelledby="planTasksAmount-label"><g:fieldValue bean="${weeklyPlanInstance}" field="planTasksAmount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${weeklyPlanInstance?.planWorkload}">
				<li class="fieldcontain">
					<span id="planWorkload-label" class="col-sm-3 control-label no-padding-right"><g:message code="weeklyPlan.planWorkload.label" default="Plan Workload" /></span>
					
						<span class="property-value" aria-labelledby="planWorkload-label"><g:fieldValue bean="${weeklyPlanInstance}" field="planWorkload"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${weeklyPlanInstance?.actualTasksAmount}">
				<li class="fieldcontain">
					<span id="actualTasksAmount-label" class="col-sm-3 control-label no-padding-right"><g:message code="weeklyPlan.actualTasksAmount.label" default="Actual Tasks Amount" /></span>
					
						<span class="property-value" aria-labelledby="actualTasksAmount-label"><g:fieldValue bean="${weeklyPlanInstance}" field="actualTasksAmount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${weeklyPlanInstance?.actualWorkload}">
				<li class="fieldcontain">
					<span id="actualWorkload-label" class="col-sm-3 control-label no-padding-right"><g:message code="weeklyPlan.actualWorkload.label" default="Actual Workload" /></span>
					
						<span class="property-value" aria-labelledby="actualWorkload-label"><g:fieldValue bean="${weeklyPlanInstance}" field="actualWorkload"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${weeklyPlanInstance?.tasks}">
				<li class="fieldcontain">
					<span id="tasks-label" class="col-sm-3 control-label no-padding-right"><g:message code="weeklyPlan.tasks.label" default="Tasks" /></span>
					
						<g:each in="${weeklyPlanInstance.tasks}" var="t">
						<span class="property-value" aria-labelledby="tasks-label"><g:link controller="task" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${weeklyPlanInstance?.week}">
				<li class="fieldcontain">
					<span id="week-label" class="col-sm-3 control-label no-padding-right"><g:message code="weeklyPlan.week.label" default="Week" /></span>
					
						<span class="property-value" aria-labelledby="week-label"><g:fieldValue bean="${weeklyPlanInstance}" field="week"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${weeklyPlanInstance?.year}">
				<li class="fieldcontain">
					<span id="year-label" class="col-sm-3 control-label no-padding-right"><g:message code="weeklyPlan.year.label" default="Year" /></span>
					
						<span class="property-value" aria-labelledby="year-label"><g:fieldValue bean="${weeklyPlanInstance}" field="year"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:weeklyPlanInstance, action:'delete']" method="DELETE" class="form-horizontal" role="form">
                <div class="clearfix form-actions">
                    <div class="col-md-offset-3 col-md-9">
                        <g:link class="btn btn-info" action="edit" resource="${weeklyPlanInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                        <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                    </div>
                </div>
			</g:form>
		</div>
    </div>
	</body>
</html>
