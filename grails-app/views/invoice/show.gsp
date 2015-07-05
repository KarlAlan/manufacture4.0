
<%@ page import="com.rcstc.business.Invoice" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'invoice.label', default: 'Invoice')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
    <ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
        <li role="presentation">
            <g:link class="list" action="index">
                <g:message code="default.list.label" args="[entityName]" />
            </g:link>
        </li>
        <li role="presentation">
            <g:link class="create" action="create">
                <g:message code="default.new.label" args="[entityName]" />
            </g:link>
        </li>
        <li role="presentation" class="active">
            <a href="#">
                <g:message code="default.show.label" args="[entityName]" />
            </a>
        </li>
    </ul>
    <div class="row">
		<div id="show-invoice" class="col-xs-12" role="main">
            <div class="space-4"></div>
			<g:if test="${flash.message}">
			<div class="alert alert-block alert-success" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list invoice">
			
				<g:if test="${invoiceInstance?.invoiceNo}">
				<li class="fieldcontain">
					<span id="invoiceNo-label" class="col-sm-3 control-label no-padding-right"><g:message code="invoice.invoiceNo.label" default="Invoice No" /></span>
					
						<span class="property-value" aria-labelledby="invoiceNo-label"><g:fieldValue bean="${invoiceInstance}" field="invoiceNo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${invoiceInstance?.invoiceTitle}">
				<li class="fieldcontain">
					<span id="invoiceTitle-label" class="col-sm-3 control-label no-padding-right"><g:message code="invoice.invoiceTitle.label" default="Invoice Title" /></span>
					
						<span class="property-value" aria-labelledby="invoiceTitle-label"><g:fieldValue bean="${invoiceInstance}" field="invoiceTitle"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${invoiceInstance?.invoiceAmount}">
				<li class="fieldcontain">
					<span id="invoiceAmount-label" class="col-sm-3 control-label no-padding-right"><g:message code="invoice.invoiceAmount.label" default="Invoice Amount" /></span>
					
						<span class="property-value" aria-labelledby="invoiceAmount-label"><g:fieldValue bean="${invoiceInstance}" field="invoiceAmount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${invoiceInstance?.invoiceDate}">
				<li class="fieldcontain">
					<span id="invoiceDate-label" class="col-sm-3 control-label no-padding-right"><g:message code="invoice.invoiceDate.label" default="Invoice Date" /></span>
					
						<span class="property-value" aria-labelledby="invoiceDate-label"><g:formatDate date="${invoiceInstance?.invoiceDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${invoiceInstance?.drawer}">
				<li class="fieldcontain">
					<span id="drawer-label" class="col-sm-3 control-label no-padding-right"><g:message code="invoice.drawer.label" default="Drawer" /></span>
					
						<span class="property-value" aria-labelledby="drawer-label"><g:fieldValue bean="${invoiceInstance}" field="drawer"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${invoiceInstance?.receiver}">
				<li class="fieldcontain">
					<span id="receiver-label" class="col-sm-3 control-label no-padding-right"><g:message code="invoice.receiver.label" default="Receiver" /></span>
					
						<span class="property-value" aria-labelledby="receiver-label"><g:fieldValue bean="${invoiceInstance}" field="receiver"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${invoiceInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="col-sm-3 control-label no-padding-right"><g:message code="invoice.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${invoiceInstance}" field="status"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${invoiceInstance?.confirmer}">
				<li class="fieldcontain">
					<span id="confirmer-label" class="col-sm-3 control-label no-padding-right"><g:message code="invoice.confirmer.label" default="Confirmer" /></span>
					
						<span class="property-value" aria-labelledby="confirmer-label"><g:link controller="person" action="show" id="${invoiceInstance?.confirmer?.id}">${invoiceInstance?.confirmer?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${invoiceInstance?.confirmDate}">
				<li class="fieldcontain">
					<span id="confirmDate-label" class="col-sm-3 control-label no-padding-right"><g:message code="invoice.confirmDate.label" default="Confirm Date" /></span>
					
						<span class="property-value" aria-labelledby="confirmDate-label"><g:formatDate date="${invoiceInstance?.confirmDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${invoiceInstance?.creater}">
				<li class="fieldcontain">
					<span id="creater-label" class="col-sm-3 control-label no-padding-right"><g:message code="invoice.creater.label" default="Creater" /></span>
					
						<span class="property-value" aria-labelledby="creater-label"><g:link controller="person" action="show" id="${invoiceInstance?.creater?.id}">${invoiceInstance?.creater?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${invoiceInstance?.createDate}">
				<li class="fieldcontain">
					<span id="createDate-label" class="col-sm-3 control-label no-padding-right"><g:message code="invoice.createDate.label" default="Create Date" /></span>
					
						<span class="property-value" aria-labelledby="createDate-label"><g:formatDate date="${invoiceInstance?.createDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${invoiceInstance?.bill}">
				<li class="fieldcontain">
					<span id="bill-label" class="col-sm-3 control-label no-padding-right"><g:message code="invoice.bill.label" default="Bill" /></span>
					
						<span class="property-value" aria-labelledby="bill-label"><g:link controller="bill" action="show" id="${invoiceInstance?.bill?.id}">${invoiceInstance?.bill?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:invoiceInstance, action:'delete']" method="DELETE" class="form-horizontal" role="form">
                <div class="clearfix form-actions">
                    <div class="col-md-offset-3 col-md-9">
                        <g:link class="btn btn-info" action="edit" resource="${invoiceInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                        <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                    </div>
                </div>
			</g:form>
		</div>
    </div>
	</body>
</html>
