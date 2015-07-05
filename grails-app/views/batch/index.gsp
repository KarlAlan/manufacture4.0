
<%@ page import="com.rcstc.manufacture.TaskStatus; com.rcstc.manufacture.Batch" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'batch.label', default: 'Batch')}" />
    <title>生产看板</title>
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
            <g:sortableColumn property="serial" title="${message(code: 'batch.serial.label', default: 'Serial')}" />

            <th><g:message code="batch.project.label" default="Project" /></th>

            <th>工作内容</th>

            <g:sortableColumn property="startDate" title="${message(code: 'batch.startDate.label', default: 'Start Date')}" />

            <g:sortableColumn property="planFinishDate" title="${message(code: 'batch.planFinishDate.label', default: 'Plan Finish Date')}" />
            <th>开发员</th>
            <th>测试员</th>
            <th>计划时间</th>

        </tr>
        </thead>
        <tbody>
        <g:each in="${batchInstanceList}" status="i" var="batchInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                <td>

                    <g:if test="${batchInstance[8]}">
                        <i class="glyphicon glyphicon-ok text-success"></i>
                    </g:if>
                    <g:else>
                        <i class="glyphicon glyphicon-time text-warning"></i>
                    </g:else>
                </td>
                <td><g:link action="show" id="${batchInstance[0]}">${batchInstance[1]}</g:link></td>

                <td>${batchInstance[2]}</td>

                <td class="task_desc" data-container="body" data-toggle="popover" title="${batchInstance[4]}" data-content="${batchInstance[5]}">
                        <div style="width:400px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;">(<g:link controller="task" action="show" id="${batchInstance[3]}">${batchInstance[4]}</g:link>)
                        ${batchInstance[5]}</div>
                </td>

                <td><prettytime:display date="${batchInstance[6]}" /></td>

                <td><prettytime:display date="${batchInstance[7]}" /></td>
                <td>${batchInstance[12]}</td>
                <td>${batchInstance[13]}</td>
                <td>${batchInstance[10]+batchInstance[11]}</td>

            </tr>
        </g:each>
        </tbody>
    </table>
        </div>
    <div class="pagination" style="display: block;margin:0 10px">
        <g:paginate total="${batchInstanceCount}" />
    </div>
</div>

<script type="text/javascript">
    $(function(){
        var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
        basepath= basepath.substring(0,basepath.indexOf('/')) ;

        $('#batch_developer').typeahead({
            source: function(query,process) {
                return $.post('/'+basepath+'/person/ajaxPersonName', { query: query },function(data){
                    return process(data);
                });
            }
        });

        $( document ).on( "mouseover", ".task_desc", function() {
            $(this).popover('show');
        })
        $( document ).on( "mouseout", ".task_desc", function() {
            $(this).popover('hide');
        })
    })
</script>
</body>
</html>
