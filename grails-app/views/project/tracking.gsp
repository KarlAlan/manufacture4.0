
<%@ page import="com.rcstc.manufacture.Project" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <style>
        .demand_block {
            border: solid 1px;
            border-radius: 2px;
            margin: 3px;
        }
        .demand_name {
            background-color: darkblue;
            color: white;
            padding-left: 5px;
            padding-right: 5px;
        }
        .demand_amount {
            min-width: 20px;
            padding-left: 5px;
            padding-right: 5px;
        }
    </style>
</head>
<body>

<div id="list-project" class="content scaffold-list" role="main">
<!--
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			-->
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table class="table table-bordered">
        <thead>
        <tr>
            <g:sortableColumn property="name" title="${message(code: 'project.name.label', default: 'Name')}" />
            <th>涉及系统</th>
            <th>业务单位</th>
            <th>IT负责人</th>
            <th>运营部负责人</th>
            <th>业务单位负责人</th>
            <th>外包供应商</th>
            <th>预算</th>
            <th>立项</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${pws}" status="i" var="pw">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" style="background-color: lightgoldenrodyellow">
                <td><g:link action="edit" id="${pw["project"].id}">${fieldValue(bean: pw["project"], field: "name")}</g:link></td>
                <td>${pw["project"].informationSystem?.name}</td>
                <td>${fieldValue(bean: pw["project"], field: "usingDepartment")}</td>
                <td>
                    <g:each in="${pw["itp"]}" status="j" var="itpe">
                        ${itpe?.person?.name}
                        ,
                    </g:each>
                </td>
                <td>
                    <g:each in="${pw["yup"]}" status="j" var="yupe">
                        ${yupe?.person?.name}
                        ,
                    </g:each>
                </td>
                <td>
                    <g:each in="${pw["yep"]}" status="j" var="yepe">
                        ${yepe?.person?.name}
                        ,
                    </g:each>
                </td>
                <td>${fieldValue(bean: pw["project"], field: "secondParty")}</td>
                <td><g:formatNumber number="${pw["project"].budget}" format="￥###,##0.00"></g:formatNumber></td>
                <td>${pw["project"].approvalDate?.format('yy-MM-dd')}</td>
            </tr>
            <tr>

                <td colspan="9">
                    <table class="table">
                        <tr>
                            <td>汇报周期</td>
                            <td>
                                ${pw["weekly"]?.startDate?.format("yy/MM/dd")}-${pw["weekly"]?.stopDate?.format("MM/dd")}
                                <g:if test="${pw["weekly"]?.situation=='normal'}">
                                    <span class="label label-info pull-right arrowed" >按计划进行</span>
                                </g:if>
                                <g:elseif test="${pw["weekly"]?.situation=='delay'}">
                                    <span class="label label-warning pull-right arrowed" >比计划落后</span>
                                </g:elseif>
                                <g:else>
                                    <span class="label label-success pull-right arrowed" >按计划提前</span>
                                </g:else>
                            </td>
                        </tr>

                        <tr>
                            <td>需求情况</td>
                            <td>
                                <span class="demand_block"><span class="demand_name">需求关闭</span><span class="demand_amount">${pw["weekly"]?.demandClosed}</span></span>
                                <span class="demand_block"><span class="demand_name">UAT</span><span class="demand_amount">${pw["weekly"]?.demandUAT}</span></span>
                                <span class="demand_block"><span class="demand_name">SIT</span><span class="demand_amount">${pw["weekly"]?.demandSIT}</span></span>
                                <span class="demand_block"><span class="demand_name" style="background-color: darkgreen">累计完成</span><span class="demand_amount">${pw["weekly"]?.demandTotal}</span></span>
                                <span class="demand_block"><span class="demand_name" style="background-color: darkgreen">完成率</span><span class="demand_amount">${pw["weekly"]?.demandFinishRate}%</span></span>
                                <span class="demand_block"><span class="demand_name" style="background-color: indianred">新增需求</span><span class="demand_amount">${pw["weekly"]?.demandNew}</span></span>
                                <g:link controller="demand" action="projectDemandStat" class="pull-right" params="[pid : pw['project'].id]">详细...</g:link>
                            </td>
                        </tr>
                        <g:if test="${pw["weekly"]?.description}">
                            <tr>
                                <td>进度说明</td>
                                <td><pre>${pw["weekly"]?.description}</pre></td>
                            </tr>
                        </g:if>
                        <g:if test="${pw["weekly"]?.question}">
                            <tr>
                                <td>问题</td>
                                <td><pre>${pw["weekly"]?.question}</pre></td>
                            </tr>
                        </g:if>
                        <g:if test="${pw["weekly"]?.resource}">
                            <tr>
                                <td>资源</td>
                                <td><pre>${pw["weekly"]?.resource}</pre></td>
                            </tr>
                        </g:if>
                        <g:if test="${pw["weekly"]?.remark}">
                            <tr>
                                <td>备注</td>
                                <td><pre>${pw["weekly"]?.remark}</pre></td>
                            </tr>
                        </g:if>
                    </table>
                    <g:link controller="weeklyReport" action="index" class="pull-right" params="[pid : pw['project'].id]">更多...</g:link>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
    <div class="pagination" style="display: block;margin:0 10px">
        <g:paginate total="${projectInstanceCount ?: 0}" />
    </div>
</div>
</body>
</html>
