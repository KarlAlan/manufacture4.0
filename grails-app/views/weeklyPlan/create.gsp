<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'weeklyPlan.label', default: 'WeeklyPlan')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
    <ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
        <li role="presentation">
            <g:link class="list" action="index">
                <g:message code="default.list.label" args="[entityName]" />
            </g:link>
        </li>
        <li role="presentation" class="active">
            <g:link class="create" action="create">
                <g:message code="default.new.label" args="[entityName]" />
            </g:link>
        </li>
    </ul>

    <div class="row">
        <div id="create-weeklyPlan" class="col-xs-12" role="main">
            <div class="space-4"></div>
            <g:if test="${flash.message}">
                <div class="alert alert-block alert-success" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${weeklyPlanInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${weeklyPlanInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <g:form class="form-horizontal" role="form" url="[resource:weeklyPlanInstance, action:'save']" >

                <g:render template="form"/>


            <div class="clearfix form-actions">
                <div class="col-md-offset-3 col-md-9">
                    <g:submitButton name="create" class="btn btn-info" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                </div>
            </div>
            </g:form>
        </div>
    </div>

	</body>
</html>
