
<%@ page import="com.rcstc.business.Bill" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'bill.label', default: 'Bill')}" />
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
		<div id="show-bill" class="col-xs-12" role="main">
            <div class="space-4"></div>
			<g:if test="${flash.message}">
			<div class="alert alert-block alert-success" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list bill">
			
				<g:if test="${billInstance?.contract}">
				<li class="fieldcontain">
					<span id="contract-label" class="col-sm-3 control-label no-padding-right"><g:message code="bill.contract.label" default="Contract" /></span>
					
						<span class="property-value" aria-labelledby="contract-label"><g:link controller="contract" action="show" id="${billInstance?.contract?.id}">${billInstance?.contract?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${billInstance?.title}">
				<li class="fieldcontain">
					<span id="title-label" class="col-sm-3 control-label no-padding-right"><g:message code="bill.title.label" default="Title" /></span>
					
						<span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${billInstance}" field="title"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${billInstance?.amount}">
				<li class="fieldcontain">
					<span id="amount-label" class="col-sm-3 control-label no-padding-right"><g:message code="bill.amount.label" default="Amount" /></span>
					
						<span class="property-value" aria-labelledby="amount-label"><g:fieldValue bean="${billInstance}" field="amount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${billInstance?.expireDate}">
				<li class="fieldcontain">
					<span id="expireDate-label" class="col-sm-3 control-label no-padding-right"><g:message code="bill.expireDate.label" default="Expire Date" /></span>
					
						<span class="property-value" aria-labelledby="expireDate-label"><g:formatDate date="${billInstance?.expireDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${billInstance?.remark}">
				<li class="fieldcontain">
					<span id="remark-label" class="col-sm-3 control-label no-padding-right"><g:message code="bill.remark.label" default="Remark" /></span>
					
						<span class="property-value" aria-labelledby="remark-label"><g:fieldValue bean="${billInstance}" field="remark"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${billInstance?.fpPerson}">
				<li class="fieldcontain">
					<span id="fpPerson-label" class="col-sm-3 control-label no-padding-right"><g:message code="bill.fpPerson.label" default="Fp Person" /></span>
					
						<span class="property-value" aria-labelledby="fpPerson-label"><g:fieldValue bean="${billInstance}" field="fpPerson"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${billInstance?.spPerson}">
				<li class="fieldcontain">
					<span id="spPerson-label" class="col-sm-3 control-label no-padding-right"><g:message code="bill.spPerson.label" default="Sp Person" /></span>
					
						<span class="property-value" aria-labelledby="spPerson-label"><g:fieldValue bean="${billInstance}" field="spPerson"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${billInstance?.creater}">
				<li class="fieldcontain">
					<span id="creater-label" class="col-sm-3 control-label no-padding-right"><g:message code="bill.creater.label" default="Creater" /></span>
					
						<span class="property-value" aria-labelledby="creater-label"><g:link controller="person" action="show" id="${billInstance?.creater?.id}">${billInstance?.creater?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${billInstance?.createDate}">
				<li class="fieldcontain">
					<span id="createDate-label" class="col-sm-3 control-label no-padding-right"><g:message code="bill.createDate.label" default="Create Date" /></span>
					
						<span class="property-value" aria-labelledby="createDate-label"><g:formatDate date="${billInstance?.createDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${billInstance?.invoices}">
				<li class="fieldcontain">
					<span id="invoices-label" class="col-sm-3 control-label no-padding-right"><g:message code="bill.invoices.label" default="Invoices" /></span>
					
						<g:each in="${billInstance.invoices}" var="i">
						<span class="property-value" aria-labelledby="invoices-label"><g:link controller="invoice" action="show" id="${i.id}">${i?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${billInstance?.funds}">
				<li class="fieldcontain">
					<span id="funds-label" class="col-sm-3 control-label no-padding-right"><g:message code="bill.funds.label" default="Funds" /></span>
					
						<g:each in="${billInstance.funds}" var="f">
						<span class="property-value" aria-labelledby="funds-label"><g:link controller="fund" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${billInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="col-sm-3 control-label no-padding-right"><g:message code="bill.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${billInstance}" field="status"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${billInstance?.verification}">
				<li class="fieldcontain">
					<span id="verification-label" class="col-sm-3 control-label no-padding-right"><g:message code="bill.verification.label" default="Verification" /></span>
					
						<span class="property-value" aria-labelledby="verification-label"><g:formatBoolean boolean="${billInstance?.verification}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:billInstance, action:'delete']" method="DELETE" class="form-horizontal" role="form">
                <div class="clearfix form-actions">
                    <div class="col-md-offset-3 col-md-9">
                        <g:link class="btn btn-info" action="edit" resource="${billInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                        <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                    </div>
                </div>
			</g:form>
		</div>
    </div>
	</body>
</html>
