<%@ page import="com.rcstc.manufacture.Priority; com.rcstc.manufacture.Task; com.rcstc.manufacture.TaskType; com.rcstc.manufacture.TaskStatus" %>

<!DOCTYPE html>

<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'task.label', default: 'task')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <asset:javascript src="bootstrap-multiselect.js"/>
    <asset:stylesheet src="bootstrap-multiselect.css"/>
    <style  type="text/css">
    th, td {
        white-space: nowrap;
    }
    .form-group {
        margin: 5px;
    }
    .zero-hour {
        color: orangered;
    }
    </style>
</head>
<body>


<!--<h1><g:message code="default.list.label" args="[entityName]" /></h1> -->
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>

<div title="查询条件" style="margin: 10px">
    <g:form action="indexTroubleTask" method="post" class="form-inline" role="form">
        <div class="form-group">
            <label>项目名称：</label>
            <g:select name="pid" from="${pl}"  optionKey="id" value="${params.pid}" class="form-control"/>
        </div>

        <div class="form-group">
            <button type="submit" class="btn btn-info btn-sm">查询</button>
            <g:actionSubmit value="新建故障处理记录" action="createTroubleTask" class="btn btn-primary btn-sm">新建故障处理记录</g:actionSubmit>
        </div>

    </g:form>
</div>

<div id="list-task" class="content scaffold-list" role="main" style="overflow-x: scroll">

    <table class="table table-bordered">
        <thead>
        <tr>
            <th></th>
            <th>状态</th>
            <th><g:message code="task.project.label" default="Project" /></th>
            <th>${message(code: 'task.serial.label', default: 'Serial')}</th>

            <th>故障表现</th>
            <th>严重程度</th>
            <th>原因与解决方法</th>
            <th>备注</th>


            <th>工作量(小时)</th>

            <th>完成人</th>
            <th>完成日期</th>
            <th>验收人</th>
            <th>验收日期</th>
            <th>评价</th>

        </tr>
        </thead>
        <tbody>
        <g:each in="${taskInstanceList}" status="i" var="taskInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                <td>
                    ${(params.offset ? params.int('offset') : 0)+i+1}
                </td>

                <td><span class="label label-primary" >${taskInstance?.status?.name}</span></td>
                <td>${fieldValue(bean: taskInstance, field: "project")}</td>

                <!--
                <td><g:link action="show" id="${taskInstance.id}">${fieldValue(bean: taskInstance, field: "serial")}</g:link></td>
                -->
                <td>${fieldValue(bean: taskInstance, field: "serial")}</td>


                <td>${fieldValue(bean: taskInstance, field: "proposal")}</td>
                <td>
                    <g:if test="${taskInstance.priority==Priority.EMERGENCY}">
                        <i class="icon-warning-sign" style="color: red"></i>
                    </g:if>
                    <g:elseif test="${taskInstance.priority==Priority.NORMAL}">
                        <i class="icon-info-sign" style="color: green"></i>
                    </g:elseif>
                    <g:else>
                        <i class="icon-exclamation-sign" style="color: darkgreen"></i>
                    </g:else>
                </td>
                <td>${fieldValue(bean: taskInstance, field: "scenario")}</td>
                <td>${fieldValue(bean: taskInstance, field: "remark")}</td>

                <td style="text-align: right" class="${taskInstance.planHour==0?'zero-hour':''}">
                    ${fieldValue(bean: taskInstance, field: "planHour")}
                </td>

                <td>${taskInstance.finisher?.name}</td>
                <td>${taskInstance.finishDate?.format("yyyy-MM-dd")}</td>
                <td>${taskInstance.approver?.name}</td>
                <td>${taskInstance.approveDate?.format("yyyy-MM-dd")}</td>
                <td>
                    <g:if test="${taskInstance.evaluate=='good'}">
                        <span class="label label-success arrowed">好评</span>
                    </g:if>
                    <g:if test="${taskInstance.evaluate=='normal'}">
                        <span class="label label-warning">中评</span>
                    </g:if>
                    <g:if test="${taskInstance.evaluate=='bad'}">
                        <span class="label label-danger arrowed-in">差评</span>
                    </g:if>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>
<div class="pagination" style="display: block;margin:0 10px">
    <g:paginate total="${taskInstanceTotal}"/>
    <span style="padding-left: 20px;position: relative;bottom: 30px">总共<span style="color: darkblue">${taskInstanceTotal ?: 0}</span>条</span>
</div>


<script type="text/javascript">


    $(function(){
        var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
        basepath= basepath.substring(0,basepath.indexOf('/')) ;


    })
</script>
</body>
</html>
