
<%@ page import="com.rcstc.business.Fund" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'fund.label', default: 'Fund')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
    <ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
        <li role="presentation" class="active">
            <g:link class="list" action="index">
                <g:message code="default.list.label" args="[entityName]" />
            </g:link>
        </li>
        <li role="presentation">
            <g:link class="create" action="create">
                <g:message code="default.new.label" args="[entityName]" />
            </g:link>
        </li>
    </ul>

		<div id="list-fund" class="content scaffold-list" role="main">

			<g:if test="${flash.message}">
				<div class="alert alert-block alert-success" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
			<thead>
					<tr>
					
						<g:sortableColumn property="bank" title="${message(code: 'fund.bank.label', default: 'Bank')}" />
					
						<g:sortableColumn property="refNo" title="${message(code: 'fund.refNo.label', default: 'Ref No')}" />
					
						<g:sortableColumn property="checkNumber" title="${message(code: 'fund.checkNumber.label', default: 'Check Number')}" />
					
						<g:sortableColumn property="payer" title="${message(code: 'fund.payer.label', default: 'Payer')}" />
					
						<g:sortableColumn property="payee" title="${message(code: 'fund.payee.label', default: 'Payee')}" />
					
						<g:sortableColumn property="occurrenceDate" title="${message(code: 'fund.occurrenceDate.label', default: 'Occurrence Date')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${fundInstanceList}" status="i" var="fundInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${fundInstance.id}">${fieldValue(bean: fundInstance, field: "bank")}</g:link></td>
					
						<td>${fieldValue(bean: fundInstance, field: "refNo")}</td>
					
						<td>${fieldValue(bean: fundInstance, field: "checkNumber")}</td>
					
						<td>${fieldValue(bean: fundInstance, field: "payer")}</td>
					
						<td>${fieldValue(bean: fundInstance, field: "payee")}</td>
					
						<td><g:formatDate date="${fundInstance.occurrenceDate}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${fundInstanceCount ?: 0}" />
                <span style="padding-left: 20px;position: relative;bottom: 30px">总共<span style="color: darkblue">${fundInstanceCount ?: 0}</span>条</span>
			</div>
		</div>
	</body>
</html>
