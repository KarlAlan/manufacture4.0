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
    <g:form action="taskDetailStat" method="post" class="form-inline" role="form">
        <div class="form-group">
            <label>项目名称：</label>
            <g:select name="pid" from="${pl}"  optionKey="id" value="${params.pid}" class="form-control"/>
        </div>
        <div class="form-group">
            <div class="controls">
                <div class="input-prepend input-group">
                    <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></span>
                    <div class="input-group-btn">
                        <button type="button" class="btn btn-white btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false" ><span id="pd_name">完成日期</span></button>
                    </div><!-- /btn-group -->

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
                    <th>姓名</th>
                    <th>任务类型</th>
                    <th>任务数(个)</th>
                    <th>任务量(小时)</th>
                    <th>评价</th>
                    <th>好评率</th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${tasks}" status="i" var="pt">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                        <td class="person_name">${pt[0]}</td>
                        <td>${pt[1]?.name}</td>
                        <td style="text-align: right"><span class="label label-primary">${pt[2]}</span></td>
                        <td style="text-align: right"><span class="label label-purple">${pt[3]}</span></td>
                        <td style="text-align: right"><span class="label label-success">${pt[4]}</span><span class="label label-warning">${pt[5]}</span><span class="label label-danger">${pt[6]}</span></td>
                        <td>
                            <div class="progress" style="margin-bottom: 0px">
                                <%
                                    int fr = 0
                                    if(pt[6]+pt[4]+pt[5]!=0)
                                        fr = pt[4]/(pt[6]+pt[4]+pt[5])*100
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

        $('#start_end_date').daterangepicker(null, function(start, end, label) {
            console.log(start.toISOString(), end.toISOString(), label);
        });

        var td_name;
        $('.person_name').each(function(){
            var pn = $(this)
            if (pn.text()==td_name){
                pn.text("");
            } else {
                td_name = pn.text();
            }

        })
    })
</script>
</body>
</html>
