<%@ page import="com.rcstc.manufacture.Priority; com.rcstc.manufacture.Task; com.rcstc.manufacture.TaskType; com.rcstc.manufacture.TaskStatus" %>

<!DOCTYPE html>

<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'task.label', default: 'task')}" />
    <title>周工作量统计</title>
    <style  type="text/css">

    </style>
</head>
<body>


<!--<h1><g:message code="default.list.label" args="[entityName]" /></h1> -->
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>

<div class="row">
    <div class="col-md-8">

        <div class="panel panel-info" style="margin: 10px">
            <!-- Default panel contents -->
            <div class="panel-heading">
                过去8周完成量统计
            </div>

            <!-- Table -->
            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>姓名</th>
                    <th>-8</th>
                    <th>-7</th>
                    <th>-6</th>
                    <th>-5</th>
                    <th>-4</th>
                    <th>-3</th>
                    <th>-2</th>
                    <th>-1</th>
                    <th>本周</th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${weekHour}" status="i" var="pt">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        <td>${pt[0]}</td>
                        <g:each in="${1..9}" status="w" var="j">
                            <td style="text-align: right">
                                <g:if test="${pt[j]>=40}">
                                    <span class="label label-success">${pt[j]}</span>
                                </g:if>
                                <g:elseif test="${pt[j]<40&&pt[j]>=20}">
                                    <span class="label label-info">${pt[j]}</span>
                                </g:elseif>
                                <g:elseif test="${pt[j]<20&&pt[j]>=10}">
                                    <span class="label label-warning">${pt[j]}</span>
                                </g:elseif>
                                <g:else>
                                    <span class="badge badge-inverse">${pt[j]}</span>
                                </g:else>
                            </td>
                        </g:each>
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
