
<%@ page import="com.rcstc.manufacture.InformationSystem" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'informationSystem.label', default: 'InformationSystem')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>

    <ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
        <li role="presentation" class="active">
            <g:link class="list" action="index">
                <g:message code="informationSystem.list" args="[entityName]" />
            </g:link>
        </li>
        <li role="presentation">
            <g:link class="create" action="create">
                <g:message code="informationSystem.create" args="[entityName]" />
            </g:link>
        </li>
    </ul>

		<a href="#list-informationSystem" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

		<div id="list-informationSystem" class="content scaffold-list" role="main">
            <!--
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			-->
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
			<thead>
					<tr>
					
						<g:sortableColumn property="org" title="${message(code: 'informationSystem.org.label', default: 'Org')}" />
					
						<g:sortableColumn property="name" title="${message(code: 'informationSystem.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'informationSystem.description.label', default: 'Description')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${informationSystemInstanceList}" status="i" var="informationSystemInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${informationSystemInstance.id}">${fieldValue(bean: informationSystemInstance, field: "org")}</g:link></td>
					
						<td>${fieldValue(bean: informationSystemInstance, field: "name")}</td>
					
						<td>${fieldValue(bean: informationSystemInstance, field: "description")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination" style="display: block;margin:0 10px">
				<g:paginate total="${informationSystemInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
