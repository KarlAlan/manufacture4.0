
<%@ page import="com.rcstc.business.ContractStatus; com.rcstc.business.Contract" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'contract.label', default: 'Contract')}" />
    <title>应付查询</title>
</head>
<body>

<div title="查询条件" style="margin: 10px">
    <g:form action="payable" method="post" class="form-inline" role="form">
        <div class="form-group">
            <label>合同编号：</label>
            <input value="${params.contract_serial}" id="contract_serial" name="contract_serial" type="text" class="form-control" placeholder="合同编号" style="width: 100px">
        </div>
        <div class="form-group">
            <label>合同名称：</label>
            <input value="${params.contract_name}" id="contract_name" name="contract_name" type="text" class="form-control" placeholder="合同名称">
        </div>
        <div class="form-group">
            <label>乙方：</label>
            <input value="${params.second_party}" id="second_party" name="second_party" type="text" class="form-control party" placeholder="乙方">
        </div>

        <div class="form-group">
            <button type="submit" class="btn btn-info btn-sm">查询</button>
            <button id="reset_button" type="reset" class="btn btn-warning btn-sm">重置</button>
        </div>

    </g:form>
</div>

<div id="list-contract" class="content scaffold-list" role="main" style="overflow-x: scroll">

    <g:if test="${flash.message}">
        <div class="alert alert-block alert-success" role="status">${flash.message}</div>
    </g:if>
    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <th></th>
            <th></th>
            <g:sortableColumn property="serial" title="${message(code: 'contract.serial.label', default: 'Serial')}" />

            <g:sortableColumn property="name" title="${message(code: 'contract.name.label', default: 'Name')}" />

            <g:sortableColumn property="secondParty" title="${message(code: 'contract.secondParty.label', default: 'Second Party')}" />

            <g:sortableColumn property="contractAmount" title="${message(code: 'contract.contractAmount.label', default: 'Contract Amount')}" />
            <th>应付总额</th>
            <th>已付总额</th>
            <th>到期应付未付</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${contractInstanceList}" status="i" var="contractInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                <td>${i+1}</td>
                <td>
                    <g:if test="${contractInstance?.status==ContractStatus.DRAFT}">
                        <i class="ace-icon fa fa-circle-o blue"></i>
                    </g:if>
                    <g:elseif test="${contractInstance?.status==ContractStatus.ACTIVE}">
                        <i class="ace-icon fa fa-adjust orange"></i>
                    </g:elseif>
                    <g:elseif test="${contractInstance?.status==ContractStatus.ACCOMPLISHED}">
                        <i class="ace-icon fa fa-circle green"></i>
                    </g:elseif>
                    <g:else>
                        <i class="ace-icon fa fa-ban red"></i>
                    </g:else>
                </td>
                <td><g:link action="show" id="${contractInstance.id}">${fieldValue(bean: contractInstance, field: "serial")}</g:link></td>

                <td>${fieldValue(bean: contractInstance, field: "name")}</td>

                <td>${fieldValue(bean: contractInstance, field: "secondParty")}</td>

                <td style="text-align: right">
                    <b class="green"><g:formatNumber number="${contractInstance?.contractAmount}" format="￥###,##0.00" /></b>
                </td>
                <td style="text-align: right">
                    <b class="blue"><g:formatNumber number="${contractInstance?.unPay()}" format="￥###,##0.00" /></b>
                </td>
                <td style="text-align: right">
                    <b><g:formatNumber number="${contractInstance?.payed()}" format="￥###,##0.00" /></b>
                </td>
                <td style="text-align: right">
                    <b class="red"><g:formatNumber number="${contractInstance?.shouldPay()}" format="￥###,##0.00" /></b>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
    <div class="pagination">
        <g:paginate total="${contractInstanceCount ?: 0}" />
        <span style="padding-left: 20px;position: relative;bottom: 30px">总共<span style="color: darkblue">${contractInstanceCount ?: 0}</span>条</span>
    </div>
</div>

<script type="text/javascript">
    var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
    basepath= basepath.substring(0,basepath.indexOf('/')) ;

    $(function(){

        $('.party').typeahead({
            source: function(query,process) {
                return $.post('/'+basepath+'/project/ajaxCompanyName', { query: query },function(data){
                    return process(data);
                });
            }
        });
    })
</script>
</body>
</html>
