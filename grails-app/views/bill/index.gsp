
<%@ page import="com.rcstc.business.Bill" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'bill.label', default: 'Bill')}" />
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

		<div id="list-bill" class="content scaffold-list" role="main">

			<g:if test="${flash.message}">
				<div class="alert alert-block alert-success" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
			<thead>
					<tr>
					
						<th><g:message code="bill.contract.label" default="Contract" /></th>
					
						<g:sortableColumn property="title" title="${message(code: 'bill.title.label', default: 'Title')}" />
					
						<g:sortableColumn property="amount" title="${message(code: 'bill.amount.label', default: 'Amount')}" />
					
						<g:sortableColumn property="expireDate" title="${message(code: 'bill.expireDate.label', default: 'Expire Date')}" />
					
						<g:sortableColumn property="remark" title="${message(code: 'bill.remark.label', default: 'Remark')}" />
					
						<g:sortableColumn property="fpPerson" title="${message(code: 'bill.fpPerson.label', default: 'Fp Person')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${billInstanceList}" status="i" var="billInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${billInstance.id}">${fieldValue(bean: billInstance, field: "contract")}</g:link></td>
					
						<td>${fieldValue(bean: billInstance, field: "title")}</td>
					
						<td>${fieldValue(bean: billInstance, field: "amount")}</td>
					
						<td><g:formatDate date="${billInstance.expireDate}" /></td>
					
						<td>${fieldValue(bean: billInstance, field: "remark")}</td>
					
						<td>${fieldValue(bean: billInstance, field: "fpPerson")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${billInstanceCount ?: 0}" />
                <span style="padding-left: 20px;position: relative;bottom: 30px">总共<span style="color: darkblue">${billInstanceCount ?: 0}</span>条</span>
			</div>
		</div>
	</body>
</html>
