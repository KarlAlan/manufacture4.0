<%@ page import="com.rcstc.manufacture.Priority; com.rcstc.manufacture.Task; com.rcstc.manufacture.TaskType; com.rcstc.manufacture.TaskStatus" %>

<!DOCTYPE html>

<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'task.label', default: 'task')}" />
    <title>月完成统计</title>
    <style  type="text/css">

    </style>
</head>
<body>


<!--<h1><g:message code="default.list.label" args="[entityName]" /></h1> -->
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>
<div title="查询条件" style="margin: 10px">
    <div title="查询条件" style="margin: 10px">
        <g:form action="monthlyPersonStat" method="post" class="form-inline" role="form">
            <div class="form-group">
                <label for="year">年份：</label>
                <g:select name="year" from="${2014..<2021}"  value="${params.year}"  class="form-control"/>
            </div>
            <div class="form-group">
                <label>月份：</label>
                <g:select name="month" from="${1..<13}"  value="${params.month}"  class="form-control"/>
            </div>
            <button type="submit" class="btn btn-info btn-sm pull-right">查询</button>
        </g:form>
    </div>
</div>

<div class="row">
    <div class="col-md-8">
        <div class="panel panel-info" style="margin: 10px">
            <!-- Default panel contents -->
            <div class="panel-heading">
            月完成统计
            </div>

            <!-- Table -->
            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>姓名</th>
                    <th>任务数(个)</th>
                    <th>任务量(小时)</th>
                    <th>评价</th>
                    <th>好评率</th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${userTask}" status="i" var="pt">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                        <td><g:link controller="task" action="yearlyPersonStat" params='[pid:"${pt[6]}",year:"${params.year}",name:"${pt[0]}"]'>${pt[0]}</g:link> </td>
                        <td style="text-align: right"><span class="label label-primary">${pt[1]}</span></td>
                        <td style="text-align: right">
                            <g:if test="${pt[2]>=160}">
                                <span class="label label-success">${pt[2]}</span>
                            </g:if>
                            <g:elseif test="${pt[2]<160&&pt[2]>=120}">
                                <span class="label label-info">${pt[2]}</span>
                            </g:elseif>
                            <g:elseif test="${pt[2]<120&&pt[2]>=80}">
                                <span class="label label-warning">${pt[2]}</span>
                            </g:elseif>
                            <g:else>
                                <span class="badge badge-inverse">${pt[2]}</span>
                            </g:else>
                        </td>
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

    </div>
    <div class="col-md-4">
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
