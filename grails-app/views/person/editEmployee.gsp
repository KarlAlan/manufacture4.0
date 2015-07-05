<%@ page import="com.rcstc.manufacture.Person" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}" />
    <title><g:message code="person.edit" args="[entityName]" /></title>
</head>
<body>


<div id="edit-person" class="content scaffold-edit" role="main">
<!--
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			-->
    <g:if test="${flash.message}">
        <div class="alert alert-success no-margin">
            <button type="button" class="close" data-dismiss="alert">
                <i class="ace-icon fa fa-times"></i>
            </button>

            <i class="ace-icon fa fa-umbrella bigger-120 blue"></i>
            ${flash.message}
        </div>
    </g:if>
    <g:hasErrors bean="${personInstance}">
        <ul class="errors" role="alert">
            <g:eachError bean="${personInstance}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>


    <div class="row">
        <div class="col-md-8" style="padding: 10px">
            <g:form url="[resource:personInstance, action:'update']" method="PUT" role="form" class="form-horizontal">
                <g:hiddenField name="version" value="${personInstance?.version}"/>
                <g:render template="form"/>
                <div class="col-sm-offset-2 col-sm-10">
                    <g:actionSubmit name="update" action="update" class="btn btn-success" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                </div>
            </g:form>
        </div>
        <div class="col-md-4">
        </div>
    </div>
</div>
</body>
</html>
