
<%@ page import="com.rcstc.manufacture.PersonProject" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'personProject.label', default: 'PersonProject')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-personProject" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-personProject" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list personProject">
			
				<g:if test="${personProjectInstance?.person}">
				<li class="fieldcontain">
					<span id="person-label" class="property-label"><g:message code="personProject.person.label" default="Person" /></span>
					
						<span class="property-value" aria-labelledby="person-label"><g:link controller="person" action="show" id="${personProjectInstance?.person?.id}">${personProjectInstance?.person?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${personProjectInstance?.project}">
				<li class="fieldcontain">
					<span id="project-label" class="property-label"><g:message code="personProject.project.label" default="Project" /></span>
					
						<span class="property-value" aria-labelledby="project-label"><g:link controller="project" action="show" id="${personProjectInstance?.project?.id}">${personProjectInstance?.project?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${personProjectInstance?.projectRole}">
				<li class="fieldcontain">
					<span id="projectRole-label" class="property-label"><g:message code="personProject.projectRole.label" default="Project Role" /></span>
					
						<span class="property-value" aria-labelledby="projectRole-label"><g:fieldValue bean="${personProjectInstance}" field="projectRole"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:personProjectInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${personProjectInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
