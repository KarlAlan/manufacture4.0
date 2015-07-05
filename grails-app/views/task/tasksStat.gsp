<%@ page import="com.rcstc.manufacture.Priority; com.rcstc.manufacture.Task; com.rcstc.manufacture.TaskType; com.rcstc.manufacture.TaskStatus" %>

<!DOCTYPE html>

<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'task.label', default: 'task')}" />
    <title>任务完成情况统计</title>
    <style  type="text/css">

    </style>
</head>
<body>


<!--<h1><g:message code="default.list.label" args="[entityName]" /></h1> -->
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>
<div title="查询条件" style="margin: 10px">
    <g:form action="tasksStat" method="post" class="form-inline" role="form">

        <div class="form-group">
            <div class="controls">
                <div class="input-prepend input-group">
                    <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i><span style="margin-left: 3px">完成日期</span></span>
                    <input type="text" readonly="readonly" style="width: 200px" name="start_end_date" id="start_end_date" class="form-control" value="${params.start_end_date}"/>
                </div>
            </div>
        </div>

        <div class="form-group">
            <button type="submit" class="btn btn-info btn-sm">查询</button>
        </div>

    </g:form>
</div>

<div class="row">
    <div class="col-md-8">
        <div class="panel panel-info" style="margin: 10px">
            <!-- Default panel contents -->
            <div class="panel-heading">
                项目任务完成情况一览表
            </div>

            <!-- Table -->
            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>项目名称</th>
                    <th>任务数</th>
                    <th>任务量</th>
                    <th>评价</th>
                    <th>好评率</th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${projectTask}" status="i" var="pt">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                        <td><g:link controller="task" action="taskDetailStat" params='[start_end_date:"${params.start_end_date}",pid:"${pt[6]}"]'>${pt[0]}</g:link></td>
                        <td style="text-align: right"><span class="label label-primary">${pt[1]}</span></td>
                        <td style="text-align: right"><span class="label label-purple">${pt[2]}</span></td>
                        <td style="text-align: right"><span class="label label-success">${pt[3]}</span><span class="label label-warning">${pt[4]}</span><span class="label label-danger">${pt[5]}</span></td>
                        <td>
                            <div class="progress" style="margin-bottom: 0px">
                                <%
                                    int fr = 0
                                    if(pt[3]+pt[4]+pt[5]!=0)
                                        fr = pt[3]/(pt[3]+pt[4]+pt[5])*100
                                %>
                                <g:if test="${fr<40}">
                                    <div class="progress-bar progress-bar-danger progress-bar-striped active" role="progressbar" aria-valuenow="${fr}" aria-valuemin="0" aria-valuemax="100" style="width: ${fr}%;">
                                        ${fr}%
                                    </div>
                                </g:if>
                                <g:elseif test="${fr<80}">
                                    <div class="progress-bar progress-bar-warning progress-bar-striped active" role="progressbar" aria-valuenow="${fr}" aria-valuemin="0" aria-valuemax="100" style="width: ${fr}%;">
                                        ${fr}%
                                    </div>
                                </g:elseif>
                                <g:else>
                                    <div class="progress-bar progress-bar-success progress-bar-striped active" role="progressbar" aria-valuenow="${fr}" aria-valuemin="0" aria-valuemax="100" style="width: ${fr}%;">
                                        ${fr}%
                                    </div>
                                </g:else>

                            </div>
                        </td>
                    </tr>
                </g:each>

                </tbody>
            </table>
        </div>

        <div class="panel panel-info" style="margin: 10px">
            <!-- Default panel contents -->
            <div class="panel-heading">
                人员任务完成情况一览表
            </div>

            <!-- Table -->
            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>姓名</th>
                    <th>任务数</th>
                    <th>任务量</th>
                    <th>评价</th>
                    <th>好评率</th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${userTask}" status="i" var="ut">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                        <td>${ut[0]}</td>
                        <td style="text-align: right"><span class="label label-primary">${ut[1]}</span></td>
                        <td style="text-align: right"><span class="label label-purple">${ut[2]}</span></td>
                        <td style="text-align: right"><span class="label label-success">${ut[3]}</span><span class="label label-warning">${ut[4]}</span><span class="label label-danger">${ut[5]}</span></td>
                        <td>
                            <div class="progress" style="margin-bottom: 0px">
                                <%
                                    int fr1 = 0
                                    if(ut[3]+ut[4]+ut[5]!=0)
                                        fr1 = ut[3]/(ut[3]+ut[4]+ut[5])*100
                                %>
                                <g:if test="${fr1<40}">
                                    <div class="progress-bar progress-bar-danger progress-bar-striped active" role="progressbar" aria-valuenow="${fr}" aria-valuemin="0" aria-valuemax="100" style="width: ${fr1}%;">
                                        ${fr1}%
                                    </div>
                                </g:if>
                                <g:elseif test="${fr1<80}">
                                    <div class="progress-bar progress-bar-warning progress-bar-striped active" role="progressbar" aria-valuenow="${fr}" aria-valuemin="0" aria-valuemax="100" style="width: ${fr1}%;">
                                        ${fr1}%
                                    </div>
                                </g:elseif>
                                <g:else>
                                    <div class="progress-bar progress-bar-success progress-bar-striped active" role="progressbar" aria-valuenow="${fr}" aria-valuemin="0" aria-valuemax="100" style="width: ${fr1}%;">
                                        ${fr1}%
                                    </div>
                                </g:else>

                            </div>
                        </td>
                    </tr>
                </g:each>

                </tbody>
            </table>
        </div>
    </div>
    <div class="col-md-4">
    </div>
</div>

<script type="text/javascript">
    $(function(){
        var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
        basepath= basepath.substring(0,basepath.indexOf('/')) ;

        $('#start_end_date').daterangepicker(null, function(start, end, label) {
            console.log(start.toISOString(), end.toISOString(), label);
        });
    })
</script>
</body>
</html>
