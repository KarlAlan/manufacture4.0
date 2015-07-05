
<%@ page import="com.rcstc.business.Commission" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'commission.label', default: 'Commission')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
        <style>
            th {
                text-align: center;
            }
            .detial_commission th {
                text-align: center;
            }
            .detial_commission th a{
                font-size: 0.8em;
            }
        </style>
	</head>
	<body>


		<div id="list-commission" class="content scaffold-list" role="main" style="overflow-x: scroll">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-bordered">
			<thead>
            <tr>
                <th colspan="9">基本财务资料</th>
                <sec:ifAnyGranted roles="SALESMAN,BUSINESS">
                    <th colspan="3">销售提成</th>
                    <th colspan="3">方案奖金</th>
                </sec:ifAnyGranted>
                <sec:ifAnyGranted roles="ADMIN,BUSINESS">
                    <th colspan="5">生产奖金</th>
                </sec:ifAnyGranted>
                <sec:ifAnyGranted roles="SUPERVISOR,SUPER_ADMIN">
                    <th colspan="2">公司毛利</th>
                </sec:ifAnyGranted>
            </tr>
					<tr class="detial_commission">
					    <!--
						<g:sortableColumn property="company" title="${message(code: 'commission.company.label', default: 'Company')}" />
					    -->
						<g:sortableColumn property="project" title="${message(code: 'commission.project.label', default: 'Project')}" />
					
						<g:sortableColumn property="contractAmount" title="${message(code: 'commission.contractAmount.label', default: 'Contract Amount')}" />
					
						<g:sortableColumn property="procurementCosts" title="${message(code: 'commission.procurementCosts.label', default: 'Procurement Costs')}" />
					
						<g:sortableColumn property="rebate" title="${message(code: 'commission.rebate.label', default: 'Rebate')}" />
					
						<g:sortableColumn property="tax" title="${message(code: 'commission.tax.label', default: 'Tax')}" />

                        <g:sortableColumn property="planDate" title="${message(code: 'commission.planDate.label', default: 'planDate')}" />

                        <g:sortableColumn property="budget" title="${message(code: 'commission.budget.label', default: 'budget')}" />

                        <g:sortableColumn property="actualDate" title="${message(code: 'commission.actualDate.label', default: 'actualDate')}" />

                        <g:sortableColumn property="actualCost" title="${message(code: 'commission.actualCost.label', default: 'actualCost')}" />
                        <sec:ifAnyGranted roles="SALESMAN,BUSINESS">
                            <g:sortableColumn property="saleman" title="${message(code: 'commission.saleman.label', default: 'saleman')}" />
                            <g:sortableColumn property="saleRate" title="${message(code: 'commission.saleRate.label', default: 'saleRate')}" />
                            <g:sortableColumn property="saleCommission" title="${message(code: 'commission.saleCommission.label', default: 'saleCommission')}" />

                            <g:sortableColumn property="schemer" title="${message(code: 'commission.schemer.label', default: 'schemer')}" />
                            <g:sortableColumn property="schemeRate" title="${message(code: 'commission.schemeRate.label', default: 'schemeRate')}" />
                            <g:sortableColumn property="schemeBonus" title="${message(code: 'commission.schemeBonus.label', default: 'schemeBonus')}" />
                        </sec:ifAnyGranted>
                        <sec:ifAnyGranted roles="ADMIN,BUSINESS">
                            <g:sortableColumn property="manager" title="${message(code: 'commission.manager.label', default: 'manager')}" />
                            <g:sortableColumn property="teamSize" title="${message(code: 'commission.teamSize.label', default: 'teamSize')}" />
                            <g:sortableColumn property="produceRate" title="${message(code: 'commission.produceRate.label', default: 'produceRate')}" />
                            <g:sortableColumn property="teamBonus" title="${message(code: 'commission.teamBonus.label', default: 'teamBonus')}" />
                            <g:sortableColumn property="managerBonus" title="${message(code: 'commission.managerBonus.label', default: 'managerBonus')}" />
                        </sec:ifAnyGranted>
                        <sec:ifAnyGranted roles="SUPERVISOR,SUPER_ADMIN">
                            <g:sortableColumn property="grossProfit" title="${message(code: 'commission.grossProfit.label', default: 'grossProfit')}" />
                            <g:sortableColumn property="grossProfitRate" title="${message(code: 'commission.grossProfitRate.label', default: 'grossProfitRate')}" />
                        </sec:ifAnyGranted>
					</tr>
				</thead>
				<tbody>
				<g:each in="${commissionInstanceList}" status="i" var="commissionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					    <!--
						<td><g:link action="show" id="${commissionInstance.id}">${fieldValue(bean: commissionInstance, field: "company")}</g:link></td>
					    -->
						<td style="white-space: nowrap"><g:link action="edit" id="${commissionInstance.id}">${fieldValue(bean: commissionInstance, field: "project")}</g:link></td>
					
						<td class="text-success" style="text-align: right"><g:formatNumber number="${commissionInstance.contractAmount}" format="￥###,##0.00"></g:formatNumber></td>
                        <td class="text-warning" style="text-align: right"><g:formatNumber number="${commissionInstance.procurementCosts}" format="￥###,##0.00"></g:formatNumber></td>
                        <td class="text-warning" style="text-align: right"><g:formatNumber number="${commissionInstance.rebate}" format="￥###,##0.00"></g:formatNumber></td>
                        <td class="text-warning" style="text-align: right"><g:formatNumber number="${commissionInstance.tax}" type="percent"></g:formatNumber></td>

                        <td>${commissionInstance.planDate?.format("yyyy-MM-dd")}</td>
                        <td style="text-align: right"><g:formatNumber number="${commissionInstance.budget}" format="￥###,##0.00"></g:formatNumber></td>
                        <td>${commissionInstance.actualDate?.format("yyyy-MM-dd")}</td>
                        <td style="text-align: right"><g:formatNumber number="${commissionInstance.actualCost}" format="￥###,##0.00"></g:formatNumber></td>

                        <sec:ifAnyGranted roles="SALESMAN,BUSINESS">
                            <td>${commissionInstance.saleman}</td>
                            <td style="text-align: right"><g:formatNumber number="${commissionInstance.saleRate}" type="percent"></g:formatNumber></td>
                            <td class="text-primary" style="text-align: right"><g:formatNumber number="${commissionInstance.saleCommission}" format="￥###,##0.00"></g:formatNumber></td>

                            <td>${commissionInstance.schemer}</td>
                            <td style="text-align: right"><g:formatNumber number="${commissionInstance.schemeRate}" type="percent"></g:formatNumber></td>
                            <td class="text-primary" style="text-align: right"><g:formatNumber number="${commissionInstance.schemeBonus}" format="￥###,##0.00"></g:formatNumber></td>
                        </sec:ifAnyGranted>
                        <sec:ifAnyGranted roles="ADMIN,BUSINESS">
                            <td>${commissionInstance.manager}</td>
                            <td style="text-align: right"><g:formatNumber number="${commissionInstance.teamSize}" format="#0"></g:formatNumber></td>
                            <td style="text-align: right"><g:formatNumber number="${commissionInstance.produceRate}" type="percent"></g:formatNumber></td>
                            <td class="text-primary" style="text-align: right"><g:formatNumber number="${commissionInstance.teamBonus}" format="￥###,##0.00"></g:formatNumber></td>
                            <td class="text-primary" style="text-align: right"><g:formatNumber number="${commissionInstance.managerBonus}" format="￥###,##0.00"></g:formatNumber></td>
                        </sec:ifAnyGranted>
                        <sec:ifAnyGranted roles="SUPERVISOR,SUPER_ADMIN">
                            <td style="text-align: right"><g:formatNumber number="${commissionInstance.grossProfit}" format="￥###,##0.00"></g:formatNumber></td>
                            <td style="text-align: right"><g:formatNumber number="${commissionInstance.grossProfitRate}" type="percent"></g:formatNumber></td>
                        </sec:ifAnyGranted>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination" style="display: block;margin:0 10px">
				<g:paginate total="${commissionInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
