
<%@ page import="com.rcstc.business.ContractStatus; com.rcstc.business.Contract" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'contract.label', default: 'Contract')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
        <style>
            th.contract {
                background-color: lightgrey;
                font-weight: bold;
                font-size: 1.1em;
            }
        </style>
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
		<div id="show-contract" class="col-xs-12" role="main">
            <div class="space-4"></div>
			<g:if test="${flash.message}">
			<div class="alert alert-block alert-success" role="status">${flash.message}</div>
			</g:if>
        <h1 style="text-align: center">${contractInstance.name?:'合同名称'}</h1>
        <g:form url="[resource:contractInstance, action:'delete']" method="DELETE" class="form-horizontal" role="form">
            <div class="clearfix form-actions" style="padding: 5px;margin: 0">
                <div class="col-md-offset-9 col-md-3">
                    <g:if test="${contractInstance.status==ContractStatus.DRAFT}">
                        <g:link class="btn btn-pink btn-xs" action="active" resource="${contractInstance}"><g:message code="default.button.active.label" default="Active" /></g:link>
                        <g:link class="btn btn-info btn-xs" action="edit" resource="${contractInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                        <g:actionSubmit class="btn btn-danger btn-xs" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                    </g:if>
                    <g:if test="${contractInstance.status==ContractStatus.DRAFT||contractInstance.status==ContractStatus.ACTIVE}">
                        <g:link class="btn btn-purple btn-xs" controller="bill" action="create" params="['contract.id': contractInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'bill.label', default: 'Bill')])}</g:link>
                    </g:if>
                    <g:if test="${contractInstance.status==ContractStatus.ACTIVE}">
                        <g:link class="btn btn-success btn-xs" action="accomplish" resource="${contractInstance}"><g:message code="default.button.accomplish.label" default="Accomplish" /></g:link>
                        <g:link class="btn btn-inverse btn-xs" action="cancel" resource="${contractInstance}"><g:message code="default.button.cancel.label" default="Cancel" /></g:link>
                    </g:if>

                </div>
            </div>
        </g:form>
        <table class="table table-bordered">
            <tr>
                <th class="contract"><g:message code="contract.serial.label" default="Serial" /></th>
                <td>${contractInstance.serial}</td>
                <th class="contract"><g:message code="contract.status.label" default="Status" /></th>
                <td>${contractInstance.status.name}</td>
            </tr>
            <tr>
                <th class="contract"><g:message code="contract.firstParty.label" default="First Party" /></th>
                <td>${contractInstance.firstParty}</td>
                <th class="contract"><g:message code="contract.secondParty.label" default="Second Party" /></th>
                <td>${contractInstance.secondParty}</td>
            </tr>
            <tr>
                <th class="contract"><g:message code="contract.fpPersons.label" default="Fp Persons" /></th>
                <td>
                    <g:each in="${contractInstance.fpPersons}" var="f">
                        <span class="property-value" aria-labelledby="fpPersons-label"><g:link controller="person" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></span>
                    </g:each>
                </td>
                <th class="contract"><g:message code="contract.spPersons.label" default="Sp Persons" /></th>
                <td>
                    <g:each in="${contractInstance.spPersons}" var="s">
                        <span class="property-value" aria-labelledby="spPersons-label"><g:link controller="person" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></span>
                    </g:each>
                </td>
            </tr>
            <tr>
                <th class="contract"><g:message code="contract.project.label" default="Project" /></th>
                <td>
                    <g:each in="${contractInstance.projects}" var="p">
                        <span class="property-value" aria-labelledby="spPersons-label"><g:link controller="project" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></span>
                    </g:each>
                </td>
                <th class="contract"><g:message code="contract.batch.label" default="Batch" /></th>
                <td>${contractInstance.batch}</td>
            </tr>
            <tr>
                <th class="contract"><g:message code="contract.signDate.label" default="Sign Date" /></th>
                <td><g:formatDate date="${contractInstance?.signDate}" format="yyyy-MM-dd"/></td>
                <th class="contract"><g:message code="contract.contractAmount.label" default="Contract Amount" /></th>
                <td class="green"><g:formatNumber number="${contractInstance.contractAmount}" format="￥###,##0.00" /></td>
            </tr>
            <tr>
                <th class="contract"><g:message code="contract.remark.label" default="Remark" /></th>
                <td colspan="3">${contractInstance?.remark}</td>
            </tr>
        </table>

        <g:each in="${contractInstance.bills}" var="bill" status="i">
        <div class="widget-box transparent">
            <div class="widget-header widget-header-flat">
                <h4 class="widget-title lighter">
                    <i class="ace-icon fa fa-star orange"></i>
                    对账单：${bill?.title}

                </h4>

                <div class="widget-toolbar">
                    <a href="#" data-action="collapse">
                        <i class="ace-icon fa fa-chevron-up"></i>
                    </a>
                </div>
            </div>

            <div class="widget-body">
                <div class="widget-main no-padding">
                    <table class="table table-bordered table-striped">
                        <thead class="thin-border-bottom">
                        <tr>
                            <th></th>

                            <th>
                                <i class="ace-icon fa fa-caret-right blue"></i><g:message code="bill.expireDate.label" default="Expire Date" />
                            </th>

                            <th>
                                <i class="ace-icon fa fa-caret-right blue"></i><g:message code="bill.amount.label" default="Amount" />
                            </th>
                            <th>
                                <i class="ace-icon fa fa-caret-right blue"></i><g:message code="bill.fpPerson.label" default="Fp Person" />
                            </th>
                            <th>
                                <i class="ace-icon fa fa-caret-right blue"></i><g:message code="bill.spPerson.label" default="Sp Person" />
                            </th>
                            <th>
                                <i class="ace-icon fa fa-caret-right blue"></i><g:message code="bill.verification.label" default="Verification" />
                            </th>
                            <th>
                                <i class="ace-icon fa fa-caret-right blue"></i><g:message code="bill.remark.label" default="Remark" />
                            </th>
                        </tr>
                        </thead>

                        <tbody>

                            <tr>
                                <td>
                                    <g:if test="${bill?.status==ContractStatus.DRAFT}">
                                        <i class="ace-icon fa fa-circle-o blue"></i>
                                    </g:if>
                                    <g:elseif test="${bill?.status==ContractStatus.ACTIVE}">
                                        <i class="ace-icon fa fa-adjust orange"></i>
                                    </g:elseif>
                                    <g:elseif test="${bill?.status==ContractStatus.ACCOMPLISHED}">
                                        <i class="ace-icon fa fa-circle green"></i>
                                    </g:elseif>
                                    <g:else>
                                        <i class="ace-icon fa fa-ban red"></i>
                                    </g:else>
                                </td>
                                <td>${bill?.expireDate?.format("yy-MM-dd")}</td>
                                <td style="text-align: right">
                                    <b class="green"><g:formatNumber number="${bill?.amount}" format="￥###,##0.00" /></b>
                                </td>
                                <td>${bill?.fpPerson}</td>
                                <td>${bill?.spPerson}</td>
                                <td><input class="bill_expire" bid="${bill?.id}" type="checkbox" ${bill?.verification?'checked':''}/></td>
                                <td width="40%">${bill?.remark}</td>

                            </tr>
                            <tr>
                                <td colspan="7" style="padding: 3px">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="panel panel-info" style="margin: 0">
                                                <!-- Default panel contents -->
                                                <div class="panel-heading">
                                                    发票记录
                                                    <g:link class="btn btn-warning btn-xs pull-right" controller="invoice" action="create" params="['bill.id': bill?.id]">开发票</g:link>
                                                </div>

                                                <!-- Table -->
                                                <table class="table table-striped table-bordered">
                                                    <thead>
                                                    <tr>
                                                        <th><g:message code="invoice.invoiceNo.label" default="Invoice No" /></th>
                                                        <th><g:message code="invoice.invoiceTitle.label" default="Invoice Title" /></th>
                                                        <th><g:message code="invoice.invoiceDate.label" default="Invoice Date" /></th>
                                                        <th><g:message code="invoice.invoiceAmount.label" default="Invoice Amount" /></th>
                                                        <th><g:message code="invoice.drawer.label" default="Drawer" /></th>
                                                        <th><g:message code="invoice.receiver.label" default="Receiver" /></th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <g:each in="${bill?.invoices}" status="j" var="invoice">
                                                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                                            <td>${invoice?.invoiceNo}</td>
                                                            <td>${invoice?.invoiceTitle}</td>
                                                            <td>${invoice?.invoiceDate?.format("yy-MM-dd")}</td>
                                                            <td style="text-align: right">
                                                                <b class="green"><g:formatNumber number="${invoice?.invoiceAmount}" format="￥###,##0.00" /></b>
                                                            </td>
                                                            <td>${invoice?.drawer}</td>
                                                            <td>${invoice?.receiver}</td>

                                                        </tr>
                                                    </g:each>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="panel panel-success" style="margin: 0">
                                                <!-- Default panel contents -->
                                                <div class="panel-heading">
                                                    款项往来记录
                                                    <g:link class="btn btn-warning btn-xs pull-right" controller="fund" action="create" params="['bill.id': bill?.id]">收款记录</g:link>
                                                </div>

                                                <!-- Table -->
                                                <table class="table table-striped table-bordered">
                                                    <thead>
                                                    <tr>
                                                        <th><g:message code="fund.bank.label" default="Bank" /></th>
                                                        <th><g:message code="fund.refNo.label" default="Ref No" /></th>
                                                        <th><g:message code="fund.checkNumber.label" default="Check Number" /></th>
                                                        <th><g:message code="fund.payer.label" default="Payer" /></th>
                                                        <th><g:message code="fund.occurrenceDate.label" default="Occurrence Date" /></th>
                                                        <th><g:message code="fund.credit.label" default="Credit" /></th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <g:each in="${bill?.funds}" status="k" var="fund">
                                                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                                            <td>${fund?.bank}</td>
                                                            <td>${fund?.refNo}</td>
                                                            <td>${fund?.checkNumber}</td>
                                                            <td>${fund?.payer}</td>
                                                            <td>${fund?.occurrenceDate?.format("yy-MM-dd")}</td>
                                                            <td style="text-align: right">
                                                                <b class="green"><g:formatNumber number="${fund?.credit}" format="￥###,##0.00" /></b>
                                                            </td>
                                                        </tr>
                                                    </g:each>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="7">
                                    <span style="font-weight: bolder">发票合计：</span>
                                    <span style="color: green;margin-right: 10px"><g:formatNumber number="${bill.sumAmountByInvoices()}" format="￥###,##0.00" /></span>
                                    <span style="font-weight: bolder">收款合计：：</span>
                                    <span style="color: green;margin-right: 10px"><g:formatNumber number="${bill.sumCreditAmountByFund()}" format="￥###,##0.00" /></span>
                                    <span style="font-weight: bolder">未收款合计：</span>
                                    <span style="color: darkred;margin-right: 10px"><g:formatNumber number="${bill.amount-bill.sumCreditAmountByFund()}" format="￥###,##0.00" /></span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div><!-- /.widget-main -->
            </div><!-- /.widget-body -->
        </div><!-- /.widget-box -->
        </g:each>
        <div style="font-size: 1.5em">
            <span style="font-weight: bolder;color: darkblue">应收合计：</span>
            <span style="color: green;margin-right: 10px"><g:formatNumber number="${contractInstance.unPay()}" format="￥###,##0.00" /></span>
            <span style="font-weight: bolder;color: darkblue">已收合计：：</span>
            <span style="color: green;margin-right: 10px"><g:formatNumber number="${contractInstance.payed()}" format="￥###,##0.00" /></span>
            <span style="font-weight: bolder;color: darkblue">到期应收未收合计：</span>
            <span style="color: darkred;margin-right: 10px"><g:formatNumber number="${contractInstance.shouldPay()}" format="￥###,##0.00" /></span>
        </div>
		</div>
    </div>

    <script type="text/javascript">
        var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
        basepath= basepath.substring(0,basepath.indexOf('/')) ;

        $(function(){

            $(".bill_expire").click(function(){
                var ra = $(this);
                $.ajax({
                    url : '/'+basepath+'/bill/ajaxSetExpire',
                    type : 'POST',
                    dataType : 'json',
                    data : {
                        bid : ra.attr("bid"),
                    },
                    timeout : 10000,
                    error : function(e){
                        alert("操作失败")
                    },
                    success : function(json) {
                        //alert("操作成功")
                        //window.location.reload();
                    }
                });
            })


        })
    </script>
	</body>
</html>
