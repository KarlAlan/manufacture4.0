
<%@ page import="com.rcstc.manufacture.Priority; com.rcstc.manufacture.TaskStatus; com.rcstc.manufacture.Task" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'task.label', default: 'Task')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
    <ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
        <li role="presentation">
            <g:link class="list" action="index">
                <g:message code="default.list.label" args="[entityName]" />
            </g:link>
        </li>
        <li role="presentation" class="active">
            <a href="#">
                <g:message code="default.show.label" args="[entityName]" />
            </a>
        </li>
    </ul>
    <g:if test="${flash.message}">
        <div class="alert alert-block alert-success" role="status">${flash.message}</div>
    </g:if>
    <div class="row">
        <h3 class="row header smaller lighter blue">
            <span class="col-sm-7">
                <i class="ace-icon fa fa-spinner fa-spin orange bigger-125"></i>
                任务:(${taskInstance.serial})
            </span><!-- /.col -->

            <span class="col-sm-5">
                <label class="pull-right inline">
                    <g:if test="${taskInstance.status == TaskStatus.ACCOMPLISHED}">
                        <span class="label label-success" >${taskInstance.status?.name}</span>
                    </g:if>
                    <g:elseif test="${taskInstance.status == TaskStatus.DRAFT||taskInstance.status == TaskStatus.ARRANGE}">
                        <span class="label label-default" >${taskInstance.status?.name}</span>
                    </g:elseif>
                    <g:elseif test="${taskInstance.status == TaskStatus.SIT}">
                        <span class="label label-warning" >${taskInstance.status?.name}</span>
                    </g:elseif>
                    <g:elseif test="${taskInstance.status == TaskStatus.DEVELOP}">
                        <span class="label label-info" >${taskInstance.status?.name}</span>
                    </g:elseif>
                    <g:else>
                        <span class="label label-primary" >${taskInstance.status?.name}</span>
                    </g:else>
                </label>
            </span><!-- /.col -->
        </h3>

        <div class="row" style="line-height: 2em">
            <span class="col-sm-2 text-right"><strong>项目名称:</strong></span>
            <span class="col-sm-4">${taskInstance.project?.name}</span>

            <span class="col-sm-2 text-right"><strong>需求:</strong></span>
            <span class="col-sm-4"><g:link controller="demand" action="show" id="${taskInstance?.demand?.id}">${taskInstance?.demand?.encodeAsHTML()}</g:link></span>

            <span class="col-sm-2 text-right"><strong>任务类型:</strong></span>
            <span class="col-sm-4">
                <span class="label label-info">${taskInstance.type?.name}</span>
            </span>
            <span class="col-sm-2 text-right"><strong>优先程度:</strong></span>
            <span class="col-sm-4">
                <g:if test="${taskInstance.priority==Priority.EMERGENCY}">
                    <span class="label label-warning">${taskInstance.priority?.name}</span>
                </g:if>
                <g:else>
                    <span class="label label-default">${taskInstance.priority?.name}</span>
                </g:else>
            </span>

            <span class="col-sm-2 text-right"><strong>任务花费时间:</strong></span>
            <span class="col-sm-10">
                <span class="label label-info">${taskInstance.planHour}</span>
            </span>

            <g:if test="${taskInstance.finisher&&taskInstance.finishDate}">
                <span class="col-sm-2 text-right"><strong>完成人:</strong></span>
                <span class="col-sm-4">${taskInstance.finisher?.name}</span>

                <span class="col-sm-2 text-right"><strong>完成日期:</strong></span>
                <span class="col-sm-4">${taskInstance.finishDate?.format("yy-MM-dd")}</span>
            </g:if>

            <g:if test="${taskInstance.description}">
                <span class="col-sm-2 text-right"><strong>需求说明:</strong></span>
                <span class="col-sm-10 blob_content">${raw(taskInstance.description)}</span>
            </g:if>

            <g:if test="${taskInstance.proposal}">
                <span class="col-sm-2 text-right"><strong>设计方案:</strong></span>
                <span class="col-sm-10 blob_content">${raw(taskInstance.proposal)}</span>
            </g:if>

            <g:if test="${taskInstance.scenario}">
                <span class="col-sm-2 text-right"><strong>测试方案和报告:</strong></span>
                <span class="col-sm-10 blob_content">${raw(taskInstance.scenario)}</span>
            </g:if>
        </div>


		<div id="show-task" class="col-xs-12" role="main">

			<g:form url="[resource:taskInstance, action:'delete']" method="DELETE" class="form-horizontal" role="form">
                <div class="clearfix form-actions">
                    <div class="col-md-offset-3 col-md-9">
                        <g:link class="btn btn-info" action="edit" resource="${taskInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                        <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                    </div>
                </div>
			</g:form>
		</div>
    </div>
	</body>
</html>
