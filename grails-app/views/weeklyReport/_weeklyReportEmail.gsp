<%@ page contentType="text/html" %>

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
    pre {
        background-color: transparent;
        border: 0px;
    }

    th td {
        border: solid 1px #808080;
    }
    th {
        text-align: left;
        white-space: nowrap;
    }
</style>

<h3 class="row header smaller lighter green">
    <span class="col-sm-7">
        <i class="ace-icon fa fa-bullhorn"></i>
        ${weeklyReportInstance.title}
    </span><!-- /.col -->
</h3>

<div class="row" style="line-height: 2em">
    <span class="col-sm-2 text-right"><strong>项目名称:</strong></span>
    <span class="col-sm-4">${weeklyReportInstance.project?.name}</span>

    <span class="col-sm-2 text-right"><strong>汇报周期:</strong></span>
    <span class="col-sm-4"><g:formatDate date="${weeklyReportInstance?.startDate}" format="yyyy/M/d"/>—<g:formatDate date="${weeklyReportInstance?.stopDate}" format="yyyy/M/d"/></span>

    <span class="col-sm-2 text-right"><strong>编写人:</strong></span>
    <span class="col-sm-4">${weeklyReportInstance?.buildPerson}</span>

    <span class="col-sm-2 text-right"><strong>编写日期:</strong></span>
    <span class="col-sm-4"><g:formatDate date="${weeklyReportInstance?.buildDate}" format="yyyy/M/d"/></span>

    <span class="col-sm-2 text-right"><strong>${message(code: 'weeklyReport.situation.label', default: 'situation')}:</strong></span>
    <span class="col-sm-10">
        <g:if test="${weeklyReportInstance?.situation=='normal'}">
            <span class="label label-info" >按计划进行</span>
        </g:if>
        <g:elseif test="${weeklyReportInstance?.situation=='delay'}">
            <span class="label label-warning" >比计划落后</span>
        </g:elseif>
        <g:else>
            <span class="label label-success" >按计划提前</span>
        </g:else>
    </span>

    <g:if test="${weeklyReportInstance?.handled}">
        <span class="col-sm-2 text-right"><strong>${message(code: 'weeklyReport.handled.label', default: 'handled')}:</strong></span>
        <span class="col-sm-10">${raw(weeklyReportInstance?.handled)}</span>
    </g:if>

    <g:if test="${weeklyReportInstance?.description}">
        <span class="col-sm-2 text-right"><strong>${message(code: 'weeklyReport.description.label', default: 'description')}:</strong></span>
        <span class="col-sm-10">${raw(weeklyReportInstance?.description)}</span>
    </g:if>

    <g:if test="${weeklyReportInstance?.finishedTask}">
        <span class="col-sm-2 text-right"><strong>${message(code: 'weeklyReport.finishedTask.label', default: 'finishedTask')}:</strong></span>
        <span class="col-sm-10">${raw(weeklyReportInstance?.finishedTask)}</span>
    </g:if>

    <g:if test="${weeklyReportInstance?.planingTask}">
        <span class="col-sm-2 text-right"><strong>${message(code: 'weeklyReport.planingTask.label', default: 'planingTask')}:</strong></span>
        <span class="col-sm-10">${raw(weeklyReportInstance?.planingTask)}</span>
    </g:if>

    <g:if test="${weeklyReportInstance?.question}">
        <span class="col-sm-2 text-right"><strong>${message(code: 'weeklyReport.question.label', default: 'question')}:</strong></span>
        <span class="col-sm-10">${raw(weeklyReportInstance?.question)}</span>
    </g:if>

    <g:if test="${weeklyReportInstance?.resource}">
        <span class="col-sm-2 text-right"><strong>${message(code: 'weeklyReport.resource.label', default: 'resource')}:</strong></span>
        <span class="col-sm-10">${raw(weeklyReportInstance?.resource)}</span>
    </g:if>

    <g:if test="${weeklyReportInstance?.remark}">
        <span class="col-sm-2 text-right"><strong>${message(code: 'weeklyReport.remark.label', default: 'remark')}:</strong></span>
        <span class="col-sm-10">${raw(weeklyReportInstance?.remark)}</span>
    </g:if>

</div>

