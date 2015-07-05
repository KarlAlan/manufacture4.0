<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'task.label', default: 'Task')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>


		<div id="create-task" class="content scaffold-create" role="main">
            <!--
			<h1><g:message code="default.create.label" args="[entityName]" /></h1>
			-->
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${taskInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${taskInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:taskInstance, action:'saveCommonTask']" role="form" class="form-horizontal">
                <g:render template="form"/>
                <div class="col-sm-offset-2 col-sm-10">
                    <g:submitButton name="create" class="btn btn-success" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                </div>
			</g:form>
		</div>
	</body>
</html>
