
<%@ page import="com.rcstc.manufacture.Batch" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'batch.label', default: 'Batch')}" />
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
            <g:link class="create" action="scheduling">
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
		<div id="show-batch" class="col-xs-12" role="main">
            <div class="space-4"></div>
			<g:if test="${flash.message}">
			<div class="alert alert-block alert-success" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list batch">
			
				<g:if test="${batchInstance?.serial}">
				<li class="fieldcontain">
					<span id="serial-label" class="col-sm-3 control-label no-padding-right"><g:message code="batch.serial.label" default="Serial" /></span>
					
						<span class="property-value" aria-labelledby="serial-label"><g:fieldValue bean="${batchInstance}" field="serial"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${batchInstance?.project}">
				<li class="fieldcontain">
					<span id="project-label" class="col-sm-3 control-label no-padding-right"><g:message code="batch.project.label" default="Project" /></span>
					
						<span class="property-value" aria-labelledby="project-label"><g:link controller="project" action="show" id="${batchInstance?.project?.id}">${batchInstance?.project?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${batchInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="col-sm-3 control-label no-padding-right"><g:message code="batch.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${batchInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${batchInstance?.startDate}">
				<li class="fieldcontain">
					<span id="startDate-label" class="col-sm-3 control-label no-padding-right"><g:message code="batch.startDate.label" default="Start Date" /></span>
					
						<span class="property-value" aria-labelledby="startDate-label"><g:formatDate date="${batchInstance?.startDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${batchInstance?.planFinishDate}">
				<li class="fieldcontain">
					<span id="planFinishDate-label" class="col-sm-3 control-label no-padding-right"><g:message code="batch.planFinishDate.label" default="Plan Finish Date" /></span>
					
						<span class="property-value" aria-labelledby="planFinishDate-label"><g:formatDate date="${batchInstance?.planFinishDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${batchInstance?.planHour}">
				<li class="fieldcontain">
					<span id="planHour-label" class="col-sm-3 control-label no-padding-right"><g:message code="batch.planHour.label" default="Plan Hour" /></span>
					
						<span class="property-value" aria-labelledby="planHour-label"><g:fieldValue bean="${batchInstance}" field="planHour"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${batchInstance?.bufferHour}">
				<li class="fieldcontain">
					<span id="bufferHour-label" class="col-sm-3 control-label no-padding-right"><g:message code="batch.bufferHour.label" default="Buffer Hour" /></span>
					
						<span class="property-value" aria-labelledby="bufferHour-label"><g:fieldValue bean="${batchInstance}" field="bufferHour"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${batchInstance?.developer}">
				<li class="fieldcontain">
					<span id="developer-label" class="col-sm-3 control-label no-padding-right"><g:message code="batch.developer.label" default="Developer" /></span>
					
						<span class="property-value" aria-labelledby="developer-label"><g:link controller="person" action="show" id="${batchInstance?.developer?.id}">${batchInstance?.developer?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${batchInstance?.sitPeople}">
				<li class="fieldcontain">
					<span id="sitPeople-label" class="col-sm-3 control-label no-padding-right"><g:message code="batch.sitPeople.label" default="Sit People" /></span>
					
						<span class="property-value" aria-labelledby="sitPeople-label"><g:link controller="person" action="show" id="${batchInstance?.sitPeople?.id}">${batchInstance?.sitPeople?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${batchInstance?.remark}">
				<li class="fieldcontain">
					<span id="remark-label" class="col-sm-3 control-label no-padding-right"><g:message code="batch.remark.label" default="Remark" /></span>
					
						<span class="property-value" aria-labelledby="remark-label"><g:fieldValue bean="${batchInstance}" field="remark"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${batchInstance?.isDone}">
				<li class="fieldcontain">
					<span id="isDone-label" class="col-sm-3 control-label no-padding-right"><g:message code="batch.isDone.label" default="Is Done" /></span>
					
						<span class="property-value" aria-labelledby="isDone-label"><g:formatBoolean boolean="${batchInstance?.isDone}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${batchInstance?.finishDate}">
				<li class="fieldcontain">
					<span id="finishDate-label" class="col-sm-3 control-label no-padding-right"><g:message code="batch.finishDate.label" default="Finish Date" /></span>
					
						<span class="property-value" aria-labelledby="finishDate-label"><g:formatDate date="${batchInstance?.finishDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${batchInstance?.task}">
				<li class="fieldcontain">
					<span id="task-label" class="col-sm-3 control-label no-padding-right"><g:message code="batch.task.label" default="Task" /></span>
					
						<g:each in="${batchInstance.task}" var="t">
						<span class="property-value" aria-labelledby="task-label"><g:link controller="task" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:batchInstance, action:'delete']" method="DELETE" class="form-horizontal" role="form">
                <div class="clearfix form-actions">
                    <div class="col-md-offset-3 col-md-9">
                        <g:link class="btn btn-info" action="scheduling" resource="${batchInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                        <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                    </div>
                </div>
			</g:form>
		</div>
    </div>
	</body>
</html>
