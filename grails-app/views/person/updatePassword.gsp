<%@ page import="com.rcstc.manufacture.Person" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>
</head>
<body>


<div id="edit-person" class="content scaffold-edit" role="main">
<!--
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			-->
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${personInstance}">
        <ul class="errors" role="alert">
            <g:eachError bean="${personInstance}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form url="[resource:personInstance, action:'passwordUpdated']" method="PUT" >
        <g:hiddenField name="version" value="${personInstance?.version}" />
        <fieldset class="form">
            <div class="fieldcontain ${hasErrors(bean: personInstance, field: 'password', 'error')} required">
                <label for="pw">
                    <g:message code="person.password.label" default="Password" />
                    <span class="required-indicator">*</span>
                </label>
                <g:textField name="pw" required="" value=""/>

            </div>
        </fieldset>
        <fieldset class="buttons">
            <g:actionSubmit class="btn btn-info btn-sm" action="passwordUpdated" value="${message(code: 'default.button.update.label', default: 'Update')}" />
        </fieldset>
    </g:form>
</div>
</body>
</html>
