
<%@ page import="com.rcstc.business.Fund" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'fund.label', default: 'Fund')}" />
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
		<div id="show-fund" class="col-xs-12" role="main">
            <div class="space-4"></div>
			<g:if test="${flash.message}">
			<div class="alert alert-block alert-success" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list fund">
			
				<g:if test="${fundInstance?.bank}">
				<li class="fieldcontain">
					<span id="bank-label" class="col-sm-3 control-label no-padding-right"><g:message code="fund.bank.label" default="Bank" /></span>
					
						<span class="property-value" aria-labelledby="bank-label"><g:fieldValue bean="${fundInstance}" field="bank"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${fundInstance?.refNo}">
				<li class="fieldcontain">
					<span id="refNo-label" class="col-sm-3 control-label no-padding-right"><g:message code="fund.refNo.label" default="Ref No" /></span>
					
						<span class="property-value" aria-labelledby="refNo-label"><g:fieldValue bean="${fundInstance}" field="refNo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${fundInstance?.checkNumber}">
				<li class="fieldcontain">
					<span id="checkNumber-label" class="col-sm-3 control-label no-padding-right"><g:message code="fund.checkNumber.label" default="Check Number" /></span>
					
						<span class="property-value" aria-labelledby="checkNumber-label"><g:fieldValue bean="${fundInstance}" field="checkNumber"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${fundInstance?.payer}">
				<li class="fieldcontain">
					<span id="payer-label" class="col-sm-3 control-label no-padding-right"><g:message code="fund.payer.label" default="Payer" /></span>
					
						<span class="property-value" aria-labelledby="payer-label"><g:fieldValue bean="${fundInstance}" field="payer"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${fundInstance?.payee}">
				<li class="fieldcontain">
					<span id="payee-label" class="col-sm-3 control-label no-padding-right"><g:message code="fund.payee.label" default="Payee" /></span>
					
						<span class="property-value" aria-labelledby="payee-label"><g:fieldValue bean="${fundInstance}" field="payee"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${fundInstance?.occurrenceDate}">
				<li class="fieldcontain">
					<span id="occurrenceDate-label" class="col-sm-3 control-label no-padding-right"><g:message code="fund.occurrenceDate.label" default="Occurrence Date" /></span>
					
						<span class="property-value" aria-labelledby="occurrenceDate-label"><g:formatDate date="${fundInstance?.occurrenceDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${fundInstance?.debit}">
				<li class="fieldcontain">
					<span id="debit-label" class="col-sm-3 control-label no-padding-right"><g:message code="fund.debit.label" default="Debit" /></span>
					
						<span class="property-value" aria-labelledby="debit-label"><g:fieldValue bean="${fundInstance}" field="debit"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${fundInstance?.credit}">
				<li class="fieldcontain">
					<span id="credit-label" class="col-sm-3 control-label no-padding-right"><g:message code="fund.credit.label" default="Credit" /></span>
					
						<span class="property-value" aria-labelledby="credit-label"><g:fieldValue bean="${fundInstance}" field="credit"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${fundInstance?.particulars}">
				<li class="fieldcontain">
					<span id="particulars-label" class="col-sm-3 control-label no-padding-right"><g:message code="fund.particulars.label" default="Particulars" /></span>
					
						<span class="property-value" aria-labelledby="particulars-label"><g:fieldValue bean="${fundInstance}" field="particulars"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${fundInstance?.creater}">
				<li class="fieldcontain">
					<span id="creater-label" class="col-sm-3 control-label no-padding-right"><g:message code="fund.creater.label" default="Creater" /></span>
					
						<span class="property-value" aria-labelledby="creater-label"><g:link controller="person" action="show" id="${fundInstance?.creater?.id}">${fundInstance?.creater?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${fundInstance?.createDate}">
				<li class="fieldcontain">
					<span id="createDate-label" class="col-sm-3 control-label no-padding-right"><g:message code="fund.createDate.label" default="Create Date" /></span>
					
						<span class="property-value" aria-labelledby="createDate-label"><g:formatDate date="${fundInstance?.createDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${fundInstance?.bill}">
				<li class="fieldcontain">
					<span id="bill-label" class="col-sm-3 control-label no-padding-right"><g:message code="fund.bill.label" default="Bill" /></span>
					
						<span class="property-value" aria-labelledby="bill-label"><g:link controller="bill" action="show" id="${fundInstance?.bill?.id}">${fundInstance?.bill?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:fundInstance, action:'delete']" method="DELETE" class="form-horizontal" role="form">
                <div class="clearfix form-actions">
                    <div class="col-md-offset-3 col-md-9">
                        <g:link class="btn btn-info" action="edit" resource="${fundInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                        <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                    </div>
                </div>
			</g:form>
		</div>
    </div>
	</body>
</html>
