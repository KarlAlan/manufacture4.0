
<%@ page import="com.rcstc.manufacture.TaskStatus; com.rcstc.manufacture.Batch" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'batch.label', default: 'Batch')}" />
    <title>周计划看板</title>
    <style type="text/css">

    th, td {
        white-space: nowrap;
    }

    </style>
</head>
<body>
<ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
    <li role="presentation">
        <g:link controller="task" class="list" action="index">
            <g:message code="task.list" args="[entityName]" />
        </g:link>
    </li>
    <!--
    <li role="presentation">
        <g:link controller="task" class="create" action="create">
        <g:message code="task.create" args="[entityName]" />
    </g:link>
    </li>
    -->
    <li role="presentation"  class="active">
        <g:link controller="batch" class="create" action="index">
            生产批次管理
        </g:link>
    </li>
    <li role="presentation">
        <g:link class="create" controller="batch" action="scheduling">
            <g:message code="batch.scheduling" />
        </g:link>
    </li>
</ul>


<div id="list-batch" class="content scaffold-list" role="main">
    <div title="查询条件" style="margin: 10px">
        <g:form action="index" method="post" class="form-inline" role="form">
            <div class="form-group">
                <label for="pid">项目：</label>
                <g:select name="pid" from="${pl}"  optionKey="id" value="${params.pid}" noSelection="['-1':'-所有-']" class="form-control"/>
            </div>
            <div class="form-group">
                <label>批次号：</label>
                <input value="${params.batch_serial}" id="batch_serial" name="batch_serial" type="text" class="form-control" placeholder="批次号">
            </div>
            <div class="form-group">
                <label>开发人：</label>
                <input value="${params.batch_developer}" id="batch_developer" name="batch_developer" type="text" class="form-control" placeholder="开发员" autocomplete="off">
            </div>
            <div class="form-group">
                <label>包括完成：</label>

                <g:checkBox name="batch_isDone" class="form-control" value="checked" checked="${params.batch_isDone?'true':''}"></g:checkBox>
            </div>
            <button type="submit" class="btn btn-info btn-sm pull-right">查询</button>
        </g:form>
    </div>

    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <div  style="overflow-x: scroll">
        <table class="table table-bordered">
            <thead>
            <tr>
                <th></th>
                <th>姓名</th>
                <th>计划任务数</th>
                <th>计划任务量</th>
                <th>完成任务数</th>
                <th>完成任务量</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${batchInstanceList}" status="i" var="batchInstance">
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
    <div class="pagination" style="display: block;margin:0 10px">
        <g:paginate total="0" />
    </div>
</div>

<script type="text/javascript">
    $(function(){
        var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
        basepath= basepath.substring(0,basepath.indexOf('/')) ;

    })
</script>
</body>
</html>
