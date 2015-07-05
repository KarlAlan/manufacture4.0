
<%@ page import="com.rcstc.business.Invoice" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'invoice.label', default: 'Invoice')}" />
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

		<div id="list-invoice" class="content scaffold-list" role="main">

			<g:if test="${flash.message}">
				<div class="alert alert-block alert-success" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
			<thead>
					<tr>
					
						<g:sortableColumn property="invoiceNo" title="${message(code: 'invoice.invoiceNo.label', default: 'Invoice No')}" />
					
						<g:sortableColumn property="invoiceTitle" title="${message(code: 'invoice.invoiceTitle.label', default: 'Invoice Title')}" />
					
						<g:sortableColumn property="invoiceAmount" title="${message(code: 'invoice.invoiceAmount.label', default: 'Invoice Amount')}" />
					
						<g:sortableColumn property="invoiceDate" title="${message(code: 'invoice.invoiceDate.label', default: 'Invoice Date')}" />
					
						<g:sortableColumn property="drawer" title="${message(code: 'invoice.drawer.label', default: 'Drawer')}" />
					
						<g:sortableColumn property="receiver" title="${message(code: 'invoice.receiver.label', default: 'Receiver')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${invoiceInstanceList}" status="i" var="invoiceInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${invoiceInstance.id}">${fieldValue(bean: invoiceInstance, field: "invoiceNo")}</g:link></td>
					
						<td>${fieldValue(bean: invoiceInstance, field: "invoiceTitle")}</td>
					
						<td>${fieldValue(bean: invoiceInstance, field: "invoiceAmount")}</td>
					
						<td><g:formatDate date="${invoiceInstance.invoiceDate}" /></td>
					
						<td>${fieldValue(bean: invoiceInstance, field: "drawer")}</td>
					
						<td>${fieldValue(bean: invoiceInstance, field: "receiver")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${invoiceInstanceCount ?: 0}" />
                <span style="padding-left: 20px;position: relative;bottom: 30px">总共<span style="color: darkblue">${invoiceInstanceCount ?: 0}</span>条</span>
			</div>
		</div>
	</body>
</html>
