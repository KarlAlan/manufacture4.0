
<%@ page import="org.joda.time.DateTime; com.rcstc.manufacture.TaskStatus; com.rcstc.business.ContractStatus; com.rcstc.business.Contract" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'contract.label', default: 'Contract')}" />
    <title>任务退回统计</title>
</head>
<body>

<div title="查询条件" style="margin: 10px">
    <g:form action="statBackwardTask" method="post" class="form-inline" role="form">
        <div class="form-group">
            <label>任务人：</label>
            <input value="${params.task_person_name}" id="task_person_name" name="task_person_name" type="text" class="form-control person" placeholder="任务人" autocomplete="off" style="width: 100px">
        </div>
        <div class="form-group">
            <div class="controls">
                <div class="input-prepend input-group">
                    <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i><span style="margin-left: 3px">完成日期</span></span>
                    <input type="text" readonly="readonly" style="width: 200px" name="start_end_date" id="start_end_date" class="form-control" value="${params.start_end_date}"/>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label>次数：</label>
            <input value="${params.back_times?:3}" id="back_times" name="back_times" type="number" class="form-control person" placeholder="次数" autocomplete="off" style="width: 50px">
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
            <th>任务序号</th>
            <th>任务人</th>
            <th>次数</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${tasks}" status="i" var="task">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                <td><g:link controller="task" action="show" id="${task[0]}">${task[1]}</g:link></td>
                <td>${task[2]}</td>
                <td>${task[3]}</td>
            </tr>
        </g:each>
        </tbody>
    </table>

</div>

<script type="text/javascript">
    var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
    basepath= basepath.substring(0,basepath.indexOf('/')) ;

    $(function(){

        $('.person').typeahead({
            source: function(query,process) {
                return $.post('/'+basepath+'/person/ajaxPersonName', { query: query },function(data){
                    return process(data);
                });
            }
        });

        $('#start_end_date').daterangepicker(null, function(start, end, label) {
            console.log(start.toISOString(), end.toISOString(), label);
        });
    })
</script>
</body>
</html>
