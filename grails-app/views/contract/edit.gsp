<%@ page import="com.rcstc.business.Contract" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'contract.label', default: 'Contract')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
        <asset:javascript src="bootstrap-multiselect.js"/>
        <asset:stylesheet src="bootstrap-multiselect.css"/>
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
                <g:message code="default.edit.label" args="[entityName]" />
            </a>
        </li>
    </ul>

    <div class="row">
		<div id="edit-contract" class="col-xs-12" role="main">
            <div class="space-4"></div>
			<g:if test="${flash.message}">
			<div class="alert alert-block alert-success" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${contractInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${contractInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form class="form-horizontal" role="form" url="[resource:contractInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${contractInstance?.version}" />

					<g:render template="form"/>


            <div class="clearfix form-actions">
                <div class="col-md-offset-3 col-md-9">
                    <g:actionSubmit class="btn btn-info" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                </div>
            </div>
			</g:form>
		</div>
    </div>

	</body>
</html>
