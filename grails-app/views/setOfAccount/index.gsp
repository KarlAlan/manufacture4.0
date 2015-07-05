
<%@ page import="com.rcstc.business.SetOfAccount" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'setOfAccount.label', default: 'SetOfAccount')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>

    <ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
        <li role="presentation" class="active">
            <g:link class="list" action="index">
                <g:message code="setOfAccount.list" args="[entityName]" />
            </g:link>
        </li>
        <li role="presentation">
            <g:link class="create" action="create">
                <g:message code="setOfAccount.create" args="[entityName]" />
            </g:link>
        </li>
    </ul>
		<div id="list-setOfAccount" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
			<thead>
					<tr>
					
						<g:sortableColumn property="company" title="${message(code: 'setOfAccount.company', default: 'Company')}" />
					
						<g:sortableColumn property="name" title="${message(code: 'setOfAccount.name', default: 'Name')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'setOfAccount.description', default: 'Description')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${setOfAccountInstanceList}" status="i" var="setOfAccountInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${setOfAccountInstance.id}">${fieldValue(bean: setOfAccountInstance, field: "company")}</g:link></td>
					
						<td>${fieldValue(bean: setOfAccountInstance, field: "name")}</td>
					
						<td>${fieldValue(bean: setOfAccountInstance, field: "description")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination" style="display: block;margin:0 10px">
				<g:paginate total="${setOfAccountInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
