
<%@ page import="com.rcstc.business.SetOfAccount" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'setOfAccount.label', default: 'SetOfAccount')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>

    <ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
        <li role="presentation" >
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
            <a href="#">显示</a>
        </li>
    </ul>
		<div id="show-setOfAccount" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list setOfAccount">
			
				<g:if test="${setOfAccountInstance?.company}">
				<li class="fieldcontain">
					<span id="company-label" class="property-label"><g:message code="setOfAccount.company.label" default="Company" /></span>
					
						<span class="property-value" aria-labelledby="company-label"><g:fieldValue bean="${setOfAccountInstance}" field="company"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${setOfAccountInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="setOfAccount.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${setOfAccountInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${setOfAccountInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="setOfAccount.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${setOfAccountInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:setOfAccountInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${setOfAccountInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
