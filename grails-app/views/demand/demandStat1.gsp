
<%@page import="java.text.SimpleDateFormat"%>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="layout" content="main">
    <g:set var="entityName"
           value="${message(code: 'demand.label', default: 'Demand')}" />
    <title><g:message code="demand.list" args="[entityName]" /></title>
</head>
<body>

<form id="search_list" action="demandStat1" method="post" 	>
<div class="row" style="margin: 20px 0">
    <div class="col-lg-6">
        <div class="input-prepend input-group">
            <span class="add-on input-group-addon">
                <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
            </span>
            <input type="text" style="width: 200px" name="sumbit_start_end_date" id="sumbit_start_end_date" class="form-control" value="${params.sumbit_start_end_date}" />
        </div><!-- /input-group -->
    </div><!-- /.col-lg-6 -->
    <div class="col-lg-6">
        <button style="float: right" type="submit" class="btn btn-info btn-sm">查询</button>
    </div><!-- /.col-lg-6 -->
</div><!-- /.row -->
</form>

<div id="list-task" class="content scaffold-list" role="main">
    <g:if test="${flash.message}">
        <div class="message" role="status">
            ${flash.message}
        </div>
    </g:if>
    <table class="table table-striped table-bordered">
        <thead>
        <tr>
            <th width="200px">项目名称</th>
            <th>BA分析</th>
            <th>系统设计</th>
            <th>开发</th>
            <th>SIT</th>
            <th>UAT</th>
            <th>关闭</th>
            <th>作废</th>
            <th>完成率</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${tg}" status="i" var="ds">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td>${ds[1]}</td>
                <td><g:link action="index" params='[pid:"${ds[0]}",task_status:"10",update_date:"${params.update_date }" ]'><span ${ds[2]==''?'':'class="task_num"' }>${ds[2]}</span></g:link></td>
                <td><g:link action="index" params='[pid:"${ds[0]}",task_status:"20",update_date:"${params.update_date }" ]'><span ${ds[3]==''?'':'class="task_num"' }>${ds[3]}</span></g:link></td>
                <td><g:link action="index" params='[pid:"${ds[0]}",task_status:"30",update_date:"${params.update_date }" ]'><span ${ds[4]==''?'':'class="task_num"' }>${ds[4]}</span></g:link></td>
                <td><g:link action="index" params='[pid:"${ds[0]}",task_status:"31",update_date:"${params.update_date }" ]'><span ${ds[5]==''?'':'class="task_num"' }>${ds[5]}</span></g:link></td>
                <td><g:link action="index" params='[pid:"${ds[0]}",task_status:"32",update_date:"${params.update_date }" ]'><span ${ds[6]==''?'':'class="task_num"' }>${ds[6]}</span></g:link></td>
                <td><g:link action="index" params='[pid:"${ds[0]}",task_status:"40",update_date:"${params.update_date }" ]'><span ${ds[7]==''?'':'class="task_num"' }>${ds[7]}</span></g:link></td>
                <td><g:link action="index" params='[pid:"${ds[0]}",task_status:"99",update_date:"${params.update_date }" ]'><span ${ds[8]==''?'':'class="task_num"' }>${ds[8]}</span></g:link></td>
                <td style="font: 14px bold; color: darkblue">


                    <%
                        int tg7 = 0
                        if(ds[7]!=""){
                            tg7 = ds[7] as int
                        }
                        int tg = 0
                        for (int f = 2;f<8;f++){
                            if(ds[f]!=""){
                                tg = tg + (ds[f] as int)
                            }

                        }

                    %>
                    <g:if test="${tg!=0}">
                        ${(tg7/tg)*100 as int}%
                    </g:if>



                </td>
            </tr>
        </g:each>

        <tr style="font: 16px bold; background: lightcyan;color: darkblue;text-align: right">
            <td>合计</td>
            <td>${total[0]}</td>
            <td>${total[1]}</td>
            <td>${total[2]}</td>
            <td>${total[3]}</td>
            <td>${total[4]}</td>
            <td>${total[5]}</td>
            <td>${total[6]}</td>
            <td>
                <g:if test="${total[0]+total[1]+total[2]+total[3]+total[4]+total[5]!=0}">
                    ${(total[5]/(total[0]+total[1]+total[2]+total[3]+total[4]+total[5]))*100 as int}%
                </g:if>
            </td>
        </tr>
        </tbody>
    </table>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        $('#sumbit_start_end_date').daterangepicker(null, function(start, end, label) {
            console.log(start.toISOString(), end.toISOString(), label);
        });
    });
</script>

</body>


</html>
