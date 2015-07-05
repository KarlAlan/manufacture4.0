<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
    <ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
        <li role="presentation">
            <g:link class="list" action="index">
                <g:message code="project.list" args="[entityName]" />
            </g:link>
        </li>
        <li role="presentation" class="active">
            <g:link class="create" action="create">
                <g:message code="project.create" args="[entityName]" />
            </g:link>
        </li>
        <li role="presentation">
            <g:link class="create" action="people4Project">
                项目通讯录
            </g:link>
        </li>
    </ul>

		<div id="create-project" class="content scaffold-create" role="main">
            <!--
			<h1><g:message code="default.create.label" args="[entityName]" /></h1>
			-->
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${projectInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${projectInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
            <div class="row">
                <div class="col-md-8" style="padding: 10px">
                    <g:form url="[resource:projectInstance, action:'save']" role="form" class="form-horizontal">
                        <g:render template="form"/>
                        <div class="col-sm-offset-2 col-sm-10">
                            <g:submitButton name="create" class="btn btn-success" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                        </div>
                    </g:form>
                </div>
                <div class="col-md-4" style="padding: 10px"></div>
            </div>
		</div>
	</body>
</html>
