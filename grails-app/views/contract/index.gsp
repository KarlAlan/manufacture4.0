
<%@ page import="com.rcstc.business.ContractStatus; com.rcstc.business.Contract" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'contract.label', default: 'Contract')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
        <asset:javascript src="bootstrap-multiselect.js"/>
        <asset:stylesheet src="bootstrap-multiselect.css"/>
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

    <div title="查询条件" style="margin: 10px">
        <g:form action="index" method="post" class="form-inline" role="form">
            <div class="form-group">
                <label>合同编号：</label>
                <input value="${params.contract_serial}" id="contract_serial" name="contract_serial" type="text" class="form-control" placeholder="合同编号" style="width: 100px">
            </div>
            <div class="form-group">
                <label>合同名称：</label>
                <input value="${params.contract_name}" id="contract_name" name="contract_name" type="text" class="form-control" placeholder="合同名称">
            </div>
            <div class="form-group">
                <label>甲方：</label>
                <input value="${params.frist_party}" id="frist_party" name="frist_party" type="text" class="form-control party" placeholder="甲方">
            </div>
            <div class="form-group">
                <label>乙方：</label>
                <input value="${params.second_party}" id="second_party" name="second_party" type="text" class="form-control party" placeholder="乙方">
            </div>
            <div class="form-group">
                <label>状态：</label>
                <g:select name="contract_status" from="${ContractStatus?.values().name}" keys="${ContractStatus.values()*.name()}"  optionKey="id" value="${params.contract_status}"
                          id="contract_status"  class="multiselect" multiple=""/>
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
					
						<g:sortableColumn property="firstParty" title="${message(code: 'contract.firstParty.label', default: 'First Party')}" />
					
						<g:sortableColumn property="secondParty" title="${message(code: 'contract.secondParty.label', default: 'Second Party')}" />

                        <g:sortableColumn property="projects" title="${message(code: 'contract.project.label', default: 'Project')}" />

                        <g:sortableColumn property="batch" title="${message(code: 'contract.batch.label', default: 'Batch')}" />
					
						<g:sortableColumn property="signDate" title="${message(code: 'contract.signDate.label', default: 'Sign Date')}" />
					
						<g:sortableColumn property="contractAmount" title="${message(code: 'contract.contractAmount.label', default: 'Contract Amount')}" />
					
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
					
						<td>${fieldValue(bean: contractInstance, field: "firstParty")}</td>
					
						<td>${fieldValue(bean: contractInstance, field: "secondParty")}</td>

                        <td>
                            <g:each in="${contractInstance.projects}" var="p">
                                <span class="property-value" aria-labelledby="spPersons-label"><g:link controller="project" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></span>
                            </g:each>
                        </td>

                        <td>${fieldValue(bean: contractInstance, field: "batch")}</td>
					
						<td><g:formatDate date="${contractInstance.signDate}" format="yy-MM-dd"/></td>
					
						<td>
                            <b class="green"><g:formatNumber number="${contractInstance?.contractAmount}" format="￥###,##0.00" /></b>
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

            // multiselect控件
            $('.multiselect').multiselect({
                //enableFiltering: true,
                buttonClass: 'btn btn-white btn-primary',
                templates: {
                    button: '<button type="button" class="multiselect dropdown-toggle" data-toggle="dropdown"></button>',
                    ul: '<ul class="multiselect-container dropdown-menu"></ul>',
                    filter: '<li class="multiselect-item filter"><div class="input-group"><span class="input-group-addon"><i class="fa fa-search"></i></span><input class="form-control multiselect-search" type="text"></div></li>',
                    filterClearBtn: '<span class="input-group-btn"><button class="btn btn-default btn-white btn-grey multiselect-clear-filter" type="button"><i class="fa fa-times-circle red2"></i></button></span>',
                    li: '<li><a href="javascript:void(0);"><label></label></a></li>',
                    divider: '<li class="multiselect-item divider"></li>',
                    liGroup: '<li class="multiselect-item group"><label class="multiselect-group"></label></li>'
                }
            });



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
