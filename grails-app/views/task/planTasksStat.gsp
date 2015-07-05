<%@ page import="com.rcstc.manufacture.Priority; com.rcstc.manufacture.Task; com.rcstc.manufacture.TaskType; com.rcstc.manufacture.TaskStatus" %>

<!DOCTYPE html>

<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'task.label', default: 'task')}" />
    <title>计划执行情况统计</title>
    <style  type="text/css">
       .label {
           min-width: 40px;
       }
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
            计划执行情况统计表
            </div>

            <!-- Table -->
            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th></th>
                    <th>姓名</th>
                    <th>未按计划完成</th>
                    <th>本周计划</th>
                    <th>本周完成</th>
                    <th>未来计划</th>
                    <th>超前完成</th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${weekplan}" status="i" var="ds">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        <td>${i+1}</td>
                        <td>${ds[0]}</td>
                        <td style="text-align: right"><span class="label label-warning">${ds[1]!=0?ds[1]:''}</span><span class="label label-info">${ds[1]!=0?ds[2]:''}</span></td>
                        <td style="text-align: right"><span class="label label-warning">${ds[3]!=0?ds[3]:''}</span><span class="label label-info">${ds[3]!=0?ds[4]:''}</span></td>
                        <td style="text-align: right"><span class="label label-warning">${ds[5]!=0?ds[5]:''}</span><span class="label label-info">${ds[5]!=0?ds[6]:''}</span></td>
                        <td style="text-align: right"><span class="label label-warning">${ds[7]!=0?ds[7]:''}</span><span class="label label-info">${ds[7]!=0?ds[8]:''}</span></td>
                        <td style="text-align: right"><span class="label label-warning">${ds[9]!=0?ds[9]:''}</span><span class="label label-info">${ds[9]!=0?ds[10]:''}</span></td>
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
