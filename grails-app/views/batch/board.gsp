<%--
  Created by IntelliJ IDEA.
  User: karl
  Date: 14-8-15
  Time: 下午6:47
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="com.rcstc.manufacture.TaskStatus" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'batch.label', default: 'Batch')}" />
    <script src="${createLink(uri:'/js/Chart.min.js')}"></script>
    <title>生成看板</title>
    <style type="text/css">

    </style>
</head>
<body>



<div class="row">
    <div class="col-md-8">
        <div class="panel panel-info" style="margin: 10px">
            <!-- Default panel contents -->
            <div class="panel-heading">
                需求处理情况一览表
            </div>

            <!-- Table -->
            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>项目名称</th>
                    <th>BA分析</th>
                    <th>系统设计</th>
                    <th>方案确认</th>
                    <th>开发</th>
                    <th>SIT</th>
                    <th>UAT</th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${tg}" status="i" var="ds">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                        <td>${ds[1]}</td>
                        <td style="text-align: right"><g:link controller="demand" action="index" params='[pid:"${ds[0]}",demand_status:"10" ]'><span class="label label-danger">${ds[2]!=0?ds[2]:''}</span><span class="label label-info">${(ds[2]+ds[3])!=0?(ds[2]+ds[3]):''}</span></g:link><span class="badge badge-inverse">${ds[14]!=0?ds[14]:''}</span></td>
                        <td style="text-align: right"><g:link controller="demand" action="index" params='[pid:"${ds[0]}",demand_status:"20" ]'><span class="label label-danger">${ds[6]!=0?ds[6]:''}</span><span class="label label-info">${(ds[6]+ds[7])!=0?(ds[6]+ds[7]):''}</span></g:link><span class="badge badge-inverse">${ds[16]!=0?ds[16]:''}</span></td>
                        <td style="text-align: right;background-color: lightcyan"><g:link controller="demand" action="index" params='[pid:"${ds[0]}",demand_status:"12" ]'><span class="label label-danger">${ds[4]!=0?ds[4]:''}</span><span class="label label-info">${(ds[4]+ds[5])!=0?(ds[4]+ds[5]):''}</span></g:link><span class="badge badge-inverse">${ds[15]!=0?ds[15]:''}</span></td>
                        <td style="text-align: right"><g:link controller="demand" action="index" params='[pid:"${ds[0]}",demand_status:"30" ]'><span class="label label-danger">${ds[8]!=0?ds[8]:''}</span><span class="label label-info">${(ds[8]+ds[9])!=0?(ds[8]+ds[9]):''}</span></g:link><span class="badge badge-inverse">${ds[17]!=0?ds[17]:''}</span></td>
                        <td style="text-align: right"><g:link controller="demand" action="index" params='[pid:"${ds[0]}",demand_status:"31" ]'><span class="label label-danger">${ds[10]!=0?ds[10]:''}</span><span class="label label-info">${(ds[10]+ds[11])!=0?(ds[10]+ds[11]):''}</span></g:link><span class="badge badge-inverse">${ds[18]!=0?ds[18]:''}</span></td>
                        <td style="text-align: right;background-color: lightcyan"><g:link controller="demand" action="index" params='[pid:"${ds[0]}",demand_status:"32" ]'><span class="label label-danger">${ds[12]!=0?ds[12]:''}</span><span class="label label-info">${(ds[12]+ds[13])!=0?(ds[12]+ds[13]):''}</span></g:link><span class="badge badge-inverse">${ds[19]!=0?ds[19]:''}</span></td>

                    </tr>
                </g:each>



                </tbody>
            </table>
            <div style="margin: 10px">
                <span class="label label-info">0</span>待处理需求数量
                <span class="label label-danger">0</span>待处理紧急需求数量
                <span class="badge badge-inverse">0</span>已超过10个工作日以上还处于待处理需求数量
            </div>
        </div>

        <div class="panel panel-info" style="margin: 10px">
            <!-- Default panel contents -->
            <div class="panel-heading">
                项目进行中任务一览表
            </div>

            <!-- Table -->
            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>项目名称</th>
                    <th>任务类型</th>
                    <th>任务数(个)</th>
                    <th>任务量(小时)</th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${projectTask}" status="i" var="pt">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                        <td class="type_name">${pt[1]}</td>
                        <td>${pt[4]?.name}</td>
                        <td style="text-align: right"><g:link controller="task" action="index" params='[pid:"${pt[0]}",task_type:"${pt[4].id}",exculde_status:99]' ><span class="label label-primary">${pt[2]}</span></g:link></td>
                        <td style="text-align: right"><span class="label label-purple">${pt[3]}</span></td>

                    </tr>
                </g:each>

                </tbody>
            </table>
        </div>

        <!--
        <div class="panel panel-warning" style="margin: 10px">

            <div class="panel-heading">
                需求完成情况
            </div>

            <div class="panel-body">
                <canvas id="myChart"></canvas>
            </div>

        </div>
    -->
    </div>
    <div class="col-md-4">
        <div class="panel panel-success" style="margin: 10px">
            <!-- Default panel contents -->
            <div class="panel-heading">
                本周开发人员任务
            </div>

            <!-- Table -->
            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>人员</th>
                    <th>任务数</th>
                    <th>任务量</th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${pts}" status="i" var="pt">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        <td><g:link controller="task" action="myWeeklyTasks" params='[pid:"${pt.person.id}"]'>${pt.person.name}</g:link> </td>
                        <td style="text-align: right"><span class="label label-info">${pt.planTasksAmount}</span><span class="label label-success">${pt.actualTasksAmount}</span></td>
                        <td style="text-align: right"><span class="label label-info">${pt.planWorkload}</span><span class="label label-success">${pt.actualWorkload}</span></td>
                    </tr>
                </g:each>
                </tbody>
            </table>
            <div class="pagination" style="display: block;margin:0 10px">
                <g:paginate total="${ptsTotal}" params="${params }" />
                <span style="padding-left: 20px;position: relative;bottom: 30px">总共<span style="color: darkblue">${ptsTotal ?: 0}</span>条</span>
            </div>
        </div>

        <div class="panel panel-success" style="margin: 10px">
            <!-- Default panel contents -->
            <div class="panel-heading">
                生产动态
            </div>

            <!-- Table -->
            <table class="table table-striped table-bordered" style="font-size: 0.8em">
                <thead>
                <tr>
                    <th>人员</th>
                    <th>时间</th>
                    <th>内容</th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${records}" status="i" var="record">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        <td>${record.person}</td>
                        <td><prettytime:display date="${record.operateDate}"/></td>
                        <td>${record.description}</td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>

    </div>
</div>




<script type="text/javascript">
    var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
    basepath= basepath.substring(0,basepath.indexOf('/')) ;

    var randomScalingFactor = function(){ return Math.round(Math.random()*100)};

    var barChartData = {
        labels : ["January","February","March","April","May","June","July"],
        datasets : [
            {
                fillColor : "rgba(220,220,220,0.5)",
                strokeColor : "rgba(220,220,220,0.8)",
                highlightFill: "rgba(220,220,220,0.75)",
                highlightStroke: "rgba(220,220,220,1)",
                data : [randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor()]
            },
            {
                fillColor : "rgba(151,187,205,0.5)",
                strokeColor : "rgba(151,187,205,0.8)",
                highlightFill : "rgba(151,187,205,0.75)",
                highlightStroke : "rgba(151,187,205,1)",
                data : [randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor()]
            }
        ]

    }


    $(function(){
        /*
        var ctx = document.getElementById("myChart").getContext("2d");
        window.myBar = new Chart(ctx).Bar(barChartData, {
            responsive : true
        });
        */

        var td_name;
        $('.type_name').each(function(){
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