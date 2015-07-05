
<%@ page import="com.rcstc.manufacture.TaskStatus; com.rcstc.manufacture.Batch" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'batch.label', default: 'Batch')}" />
    <title>生产看板</title>
</head>
<body>
<ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
    <li role="presentation" >
        <g:link class="list" action="index">
            <g:message code="batch.label" args="[entityName]" />
        </g:link>
    </li>
    <li role="presentation" class="active">
        <g:link class="list" action="batch4People">
            人员任务分配情况表
        </g:link>
    </li>
    <li role="presentation">
        <g:link class="create" action="scheduling">
            <g:message code="batch.scheduling" args="[entityName]" />
        </g:link>
    </li>
</ul>
<a href="#list-batch" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

<form class="form-inline" role="form" style="margin: 10px">
    <div class="form-group">
        <label class="sr-only" for="pid">公司</label>
        <g:select name="pid" from="${pl}"  optionKey="id" value="${params.pid}"  class="form-control"/>
    </div>
    <div class="form-group">
        <div class="input-prepend input-group">
            <span class="add-on input-group-addon">
                <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
            </span>
            <input type="text" style="width: 200px" name="sumbit_start_end_date" id="sumbit_start_end_date" class="form-control" value="${params.sumbit_start_end_date}" />
        </div>
    </div>
    <button type="submit" class="btn btn-info" style="float: right">查询</button>
</form>

<div id="list-batch" class="content scaffold-list" role="main">
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table class="table table-bordered">
        <thead>
        <tr>

            <th>开发员</th>
            <th>批次序号</th>
            <th>开始时间</th>
            <th>计划完成时间</th>
            <th>结束时间</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${result}" status="i" var="instance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td>${instance[0]}</td>
                <td>${instance[1]}</td>
                <td>${instance[2]}</td>
                <td>${instance[3]}</td>
                <td>${instance[4]}</td>

            </tr>
        </g:each>
        </tbody>
    </table>

    <script type="text/javascript">
        $(document).ready(function() {
            $('#sumbit_start_end_date').daterangepicker(null, function(start, end, label) {
                console.log(start.toISOString(), end.toISOString(), label);
            });
        });
    </script>

</div>
</body>
</html>
