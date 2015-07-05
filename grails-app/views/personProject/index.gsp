
<%@ page import="com.rcstc.manufacture.PersonProject" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'personProject.label', default: 'PersonProject')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-personProject" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-personProject" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="personProject.person.label" default="Person" /></th>
					
						<th><g:message code="personProject.project.label" default="Project" /></th>
					
						<g:sortableColumn property="projectRole" title="${message(code: 'personProject.projectRole.label', default: 'Project Role')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${personProjectInstanceList}" status="i" var="personProjectInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${personProjectInstance.id}">${fieldValue(bean: personProjectInstance, field: "person")}</g:link></td>
					
						<td>${fieldValue(bean: personProjectInstance, field: "project")}</td>
					
						<td>${fieldValue(bean: personProjectInstance, field: "projectRole")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${personProjectInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
