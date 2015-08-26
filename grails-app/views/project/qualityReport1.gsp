
<%@ page import="org.joda.time.DateTime; com.rcstc.manufacture.TaskStatus; com.rcstc.business.ContractStatus; com.rcstc.business.Contract" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'contract.label', default: 'Contract')}" />
    <title>项目质量统计报表</title>
    <asset:javascript src="bootstrap-multiselect.js"/>
    <asset:stylesheet src="bootstrap-multiselect.css"/>
</head>
<body>

<div title="查询条件" style="margin: 10px">
    <g:form action="qualityReport1" method="post" class="form-inline" role="form">
        <div class="form-group">
            <label>年：</label>
            <input value="${params.demand_year}" id="demand_year" name="demand_year" type="text" class="form-control" placeholder="年" style="width: 100px">
        </div>
        <div class="form-group">
            <label>月：</label>
            <input value="${params.demand_month}" id="demand_month" name="demand_month" type="text" class="form-control" placeholder="月" style="width: 100px">
        </div>
        <!--
        <div class="form-group">
            <label>项目：</label>
            <g:select name="demand_pids" from="${pl}"  optionKey="id" value="${params.demand_pids}"
                      id="demand_pids" class="multiselect" multiple=""/>
        </div>
        -->

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
            <th>月份</th>
            <th>项目名称</th>
            <th>总需求数</th>
            <th>有效需求数</th>
            <th>超期条数</th>
            <th>期望完成率</th>
            <th>及时完成率</th>
            <th>UAT通过率</th>
            <th>BUG占比</th>
            <th>好评率</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${stat}" status="i" var="st">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                <td>${params.demand_month}</td>
                <td>${st[0]}</td>
                <td>${st[1]}</td>
                <td>${st[2]}</td>
                <td>${st[3]}</td>
                <td>
                    <g:formatNumber number="${st[4]/100}" type="percent" maxFractionDigits="2"></g:formatNumber>
                </td>
                <td>
                    <g:formatNumber number="${st[5]/(st[1]==0?1:st[1])}" type="percent" maxFractionDigits="2"></g:formatNumber>
                </td>
                <td>
                    <g:formatNumber number="${st[6]/(st[1]==0?1:st[1])}" type="percent" maxFractionDigits="2"></g:formatNumber>
                </td>
                <td>
                    <g:formatNumber number="${st[7]/(st[1]==0?1:st[1])}" type="percent" maxFractionDigits="2"></g:formatNumber>
                </td>
                <td>
                    <g:formatNumber number="${st[8]/(st[9]==0?1:st[9])}" type="percent" maxFractionDigits="2"></g:formatNumber>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>

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

    })
</script>
</body>
</html>
