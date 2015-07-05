
<%@ page import="com.rcstc.business.Commission" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'commission.label', default: 'Commission')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>

    <ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
        <li role="presentation">
            <g:link class="list" action="index">
                提成与奖金
            </g:link>
        </li>
        <li role="presentation"  class="active">
            <a href="#">显示</a>
        </li>
    </ul>
		<div id="show-commission" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list commission">
			
				<g:if test="${commissionInstance?.company}">
				<li class="fieldcontain">
					<span id="company-label" class="property-label"><g:message code="commission.company.label" default="Company" /></span>
					
						<span class="property-value" aria-labelledby="company-label"><g:fieldValue bean="${commissionInstance}" field="company"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${commissionInstance?.project}">
				<li class="fieldcontain">
					<span id="project-label" class="property-label"><g:message code="commission.project.label" default="Project" /></span>
					
						<span class="property-value" aria-labelledby="project-label"><g:fieldValue bean="${commissionInstance}" field="project"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${commissionInstance?.contractAmount}">
				<li class="fieldcontain">
					<span id="contractAmount-label" class="property-label"><g:message code="commission.contractAmount.label" default="Contract Amount" /></span>
					
						<span class="property-value" aria-labelledby="contractAmount-label"><g:fieldValue bean="${commissionInstance}" field="contractAmount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${commissionInstance?.procurementCosts}">
				<li class="fieldcontain">
					<span id="procurementCosts-label" class="property-label"><g:message code="commission.procurementCosts.label" default="Procurement Costs" /></span>
					
						<span class="property-value" aria-labelledby="procurementCosts-label"><g:fieldValue bean="${commissionInstance}" field="procurementCosts"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${commissionInstance?.rebate}">
				<li class="fieldcontain">
					<span id="rebate-label" class="property-label"><g:message code="commission.rebate.label" default="Rebate" /></span>
					
						<span class="property-value" aria-labelledby="rebate-label"><g:fieldValue bean="${commissionInstance}" field="rebate"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${commissionInstance?.tax}">
				<li class="fieldcontain">
					<span id="tax-label" class="property-label"><g:message code="commission.tax.label" default="Tax" /></span>
					
						<span class="property-value" aria-labelledby="tax-label"><g:fieldValue bean="${commissionInstance}" field="tax"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${commissionInstance?.saleman}">
				<li class="fieldcontain">
					<span id="saleman-label" class="property-label"><g:message code="commission.saleman.label" default="Saleman" /></span>
					
						<span class="property-value" aria-labelledby="saleman-label"><g:fieldValue bean="${commissionInstance}" field="saleman"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${commissionInstance?.saleRate}">
				<li class="fieldcontain">
					<span id="saleRate-label" class="property-label"><g:message code="commission.saleRate.label" default="Sale Rate" /></span>
					
						<span class="property-value" aria-labelledby="saleRate-label"><g:fieldValue bean="${commissionInstance}" field="saleRate"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${commissionInstance?.saleCommission}">
				<li class="fieldcontain">
					<span id="saleCommission-label" class="property-label"><g:message code="commission.saleCommission.label" default="Sale Commission" /></span>
					
						<span class="property-value" aria-labelledby="saleCommission-label"><g:fieldValue bean="${commissionInstance}" field="saleCommission"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${commissionInstance?.schemer}">
				<li class="fieldcontain">
					<span id="schemer-label" class="property-label"><g:message code="commission.schemer.label" default="Schemer" /></span>
					
						<span class="property-value" aria-labelledby="schemer-label"><g:fieldValue bean="${commissionInstance}" field="schemer"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${commissionInstance?.schemeRate}">
				<li class="fieldcontain">
					<span id="schemeRate-label" class="property-label"><g:message code="commission.schemeRate.label" default="Scheme Rate" /></span>
					
						<span class="property-value" aria-labelledby="schemeRate-label"><g:fieldValue bean="${commissionInstance}" field="schemeRate"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${commissionInstance?.schemeBonus}">
				<li class="fieldcontain">
					<span id="schemeBonus-label" class="property-label"><g:message code="commission.schemeBonus.label" default="Scheme Bonus" /></span>
					
						<span class="property-value" aria-labelledby="schemeBonus-label"><g:fieldValue bean="${commissionInstance}" field="schemeBonus"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${commissionInstance?.manager}">
				<li class="fieldcontain">
					<span id="manager-label" class="property-label"><g:message code="commission.manager.label" default="Manager" /></span>
					
						<span class="property-value" aria-labelledby="manager-label"><g:fieldValue bean="${commissionInstance}" field="manager"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${commissionInstance?.produceRate}">
				<li class="fieldcontain">
					<span id="produceRate-label" class="property-label"><g:message code="commission.produceRate.label" default="Produce Rate" /></span>
					
						<span class="property-value" aria-labelledby="produceRate-label"><g:fieldValue bean="${commissionInstance}" field="produceRate"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${commissionInstance?.planDate}">
				<li class="fieldcontain">
					<span id="planDate-label" class="property-label"><g:message code="commission.planDate.label" default="Plan Date" /></span>
					
						<span class="property-value" aria-labelledby="planDate-label"><g:formatDate date="${commissionInstance?.planDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${commissionInstance?.budget}">
				<li class="fieldcontain">
					<span id="budget-label" class="property-label"><g:message code="commission.budget.label" default="Budget" /></span>
					
						<span class="property-value" aria-labelledby="budget-label"><g:fieldValue bean="${commissionInstance}" field="budget"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${commissionInstance?.actualDate}">
				<li class="fieldcontain">
					<span id="actualDate-label" class="property-label"><g:message code="commission.actualDate.label" default="Actual Date" /></span>
					
						<span class="property-value" aria-labelledby="actualDate-label"><g:formatDate date="${commissionInstance?.actualDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${commissionInstance?.actualCost}">
				<li class="fieldcontain">
					<span id="actualCost-label" class="property-label"><g:message code="commission.actualCost.label" default="Actual Cost" /></span>
					
						<span class="property-value" aria-labelledby="actualCost-label"><g:fieldValue bean="${commissionInstance}" field="actualCost"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${commissionInstance?.teamSize}">
				<li class="fieldcontain">
					<span id="teamSize-label" class="property-label"><g:message code="commission.teamSize.label" default="Team Size" /></span>
					
						<span class="property-value" aria-labelledby="teamSize-label"><g:fieldValue bean="${commissionInstance}" field="teamSize"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${commissionInstance?.teamBonus}">
				<li class="fieldcontain">
					<span id="teamBonus-label" class="property-label"><g:message code="commission.teamBonus.label" default="Team Bonus" /></span>
					
						<span class="property-value" aria-labelledby="teamBonus-label"><g:fieldValue bean="${commissionInstance}" field="teamBonus"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${commissionInstance?.managerBonus}">
				<li class="fieldcontain">
					<span id="managerBonus-label" class="property-label"><g:message code="commission.managerBonus.label" default="Manager Bonus" /></span>
					
						<span class="property-value" aria-labelledby="managerBonus-label"><g:fieldValue bean="${commissionInstance}" field="managerBonus"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${commissionInstance?.grossProfit}">
				<li class="fieldcontain">
					<span id="grossProfit-label" class="property-label"><g:message code="commission.grossProfit.label" default="Gross Profit" /></span>
					
						<span class="property-value" aria-labelledby="grossProfit-label"><g:fieldValue bean="${commissionInstance}" field="grossProfit"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${commissionInstance?.grossProfitRate}">
				<li class="fieldcontain">
					<span id="grossProfitRate-label" class="property-label"><g:message code="commission.grossProfitRate.label" default="Gross Profit Rate" /></span>
					
						<span class="property-value" aria-labelledby="grossProfitRate-label"><g:fieldValue bean="${commissionInstance}" field="grossProfitRate"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:commissionInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${commissionInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
