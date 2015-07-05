<%@ page import="com.rcstc.business.SetOfAccount" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'setOfAccount.label', default: 'SetOfAccount')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>

    <ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
        <li role="presentation">
            <g:link class="list" action="index">
                <g:message code="setOfAccount.list" args="[entityName]" />
            </g:link>
        </li>
        <li role="presentation">
            <g:link class="create" action="create">
                <g:message code="setOfAccount.create" args="[entityName]" />
            </g:link>
        </li>
        <li role="presentation" class="active">
            <a href="#">编辑</a>
        </li>
    </ul>
		<div id="edit-setOfAccount" class="content scaffold-edit" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${setOfAccountInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${setOfAccountInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
            <div class="row">
                <div class="col-md-8" style="padding: 10px">
                    <g:form url="[resource:setOfAccountInstance, action:'update']" method="PUT" role="form" class="form-horizontal">
                        <g:hiddenField name="version" value="${setOfAccountInstance?.version}" />
                        <g:render template="form"/>
                        <div class="col-sm-offset-2 col-sm-10">
                            <g:submitButton name="save" action="update" class="btn btn-success" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                        </div>
                    </g:form>
                </div>
                <div class="col-md-4">
                </div>
            </div>
		</div>
	</body>
</html>
