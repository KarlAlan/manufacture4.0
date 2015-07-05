<%--
  Created by IntelliJ IDEA.
  User: karl
  Date: 14-8-15
  Time: 下午6:47
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="com.rcstc.manufacture.TaskType" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'weeklyPlan.label', default: 'Weekly Plan')}" />
    <title>每周任务计划安排</title>
    <script src="${createLink(uri:'/ace/assets/js/jquery-ui.js')}"></script>
    <style type="text/css">
        .task-list {
            background: lightgoldenrodyellow;
            padding: 5px;
            list-style-type: none;
            margin: 0;
        }
        .task-li {
            background: white;
            margin-bottom: 5px;
            padding: 5px;
            border-radius: 3px;
        }
        .task-list li:hover{
            background-color: #dcdcdc;
            cursor: pointer;
        }
        .task-list > .task-li > .task-project {
            display: none;
        }
        .plan-list {
            background: transparent;
            padding: 5px;
            list-style-type: none;
            margin: 0;
        }
        .plan-list li:not(.drag-disabled):hover{
            background-color: #dcdcdc;
            cursor: pointer;
        }
        .person-tasks {
            background: azure;
            margin-bottom: 5px;
            padding: 2px;
        }
        .person-meta {
            padding-right: 8px;
            padding-left: 8px;
        }
        .person-name {
            font: bolder 1.2em;
            width: 40px;
        }
        .person-plan-amount {
            width: 170px;
            text-align: right;
        }
        .person-plan-hours {
            width: 170px;
            text-align: right;
        }
        .task-proposal {
            font-size: 0.8em;
            color: darkgray;
        }
        .task-serial {
            width: 200px;
            display: inline-block;
            color: navy;
        }
        .task-planhour {
            color: #a52a2a;
        }
        .drag-disabled {
            background: wheat;
        }
        .header {
            margin-top: 0px;
        }

        .glyphicon {
            cursor: pointer;
        }
    </style>
</head>
<body>
<ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
    <li role="presentation" >
        <g:link controller="task" class="list" action="index">
            <g:message code="task.list" args="[entityName]" />
        </g:link>
    </li>
    <li role="presentation">
        <g:link controller="weeklyPlan" class="create" action="weeklyPlan4Person">
            每周计划
        </g:link>
    </li>
    <li role="presentation" class="active">
        <g:link class="create" controller="weeklyPlan" action="schedue">
            周计划安排
        </g:link>
    </li>
</ul>

<div id="create-batch" class="content scaffold-create" role="main">
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${batchInstance}">
        <ul class="errors" role="alert">
            <g:eachError bean="${batchInstance}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>

    <div title="查询条件" style="margin: 10px">
        <g:form action="schedue" method="post" class="form-inline" role="form">
            <div class="form-group">
                <label><g:message code="batch.project.label" default="Project" /></label>
                <g:select id="project" name="project.id" from="${pl}" optionKey="id" required="" noSelection="['-1':'-请选择-']" value="${params.project?.id?:-1}" class="many-to-one form-control"/>
            </div>
            <div class="form-group">
                <label>作业类型：</label>
                <g:select name="task_type" from="${TaskType?.values().name}" keys="${TaskType.values()*.id}"  optionKey="id"
                          id="task_type" value="${params.task_type?:50}"/>
            </div>
            <button type="submit" class="btn btn-info btn-sm pull-right">查询</button>
        </g:form>
    </div>

    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->
            <div class="row">
                <div class="col-sm-6">
                    <h3 class="header smaller lighter green">任务列表</h3>
                    <div id="nestable">
                        <ul class="task-list">
                            <g:each in="${tasks}" status="i" var="task">
                                <li class="task-li" tid=${task.id}>
                                    <g:if test="${task.priority== com.rcstc.manufacture.Priority.EMERGENCY}">
                                        <i class="pull-right bigger-130 ace-icon fa fa-exclamation-triangle red"></i>
                                    </g:if>
                                    <div class="task-project">项目名称：${task.project.name}</div>
                                    <div class="task-meta">
                                        <span class='task-serial'>任务序号：${task.serial}</span>
                                        <span class='task-planhour'>任务量：${task.planHour}小时</span>
                                    </div>
                                    <div class="task-proposal">
                                        任务内容：${task.proposal}
                                    </div>
                                </li>
                            </g:each>
                        </ul>
                    </div>
                </div>

                <div class="vspace-16-sm"></div>

                <div class="col-sm-6">
                    <button id="next_week" class="btn btn-xs btn-info pull-right"><i class="ace-icon bigger-120 icon-chevron-right"></i></button>
                    <button id="prev_week" class="btn btn-xs btn-info pull-right" style="margin-right: 3px"><i class="ace-icon bigger-120 icon-chevron-left"></i></button>

                    <h3 id="plan_week" year="${year}" week="${week}" weekOffset="0" class="header smaller lighter blue">${year}年第${week}周(${fd}-${ld})计划安排</h3>
                    <g:each in="${developers}" status="i" var="developer">
                        <div class="person-tasks">
                            <div id="person_${developer.id}" class="person-meta">
                                <span class="person_tasks_list"><i class="glyphicon glyphicon-minus"></i></span>
                                <span class="person-name">${developer.name}</span>
                                <span class="person-plan-hours pull-right"></span>
                                <span class="person-plan-amount pull-right"></span>
                            </div>
                            <ul class="plan-list" pid="${developer.id}">
                            </ul>
                        </div>
                    </g:each>

                </div>
            </div><!-- PAGE CONTENT ENDS -->
        </div><!-- /.col -->
    </div><!-- /.row -->


</div>

<script type="text/javascript">
    var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
    basepath= basepath.substring(0,basepath.indexOf('/')) ;

    var initPlanList = function(){
        $('.plan-list').each(function(){
            var plan_list = $(this);
            plan_list.empty();
            var pid = plan_list.attr("pid")

            $('#person_'+pid+" > .person-plan-amount").text("实际数/计划数：0/0");
            $('#person_'+pid+" > .person-plan-hours").text("实际量/计划量：0/0");

            $.ajax({
                url : '/'+basepath+'/weeklyPlan/ajaxGetPlan4Person',
                type : 'POST',
                dataType : 'json',
                data : {
                    pid : pid,
                    year : $('#plan_week').attr("year"),
                    week : $('#plan_week').attr("week")
                },
                timeout : 10000,
                error : function(e){
                    alert("获取任务安排失败");
                },
                success : function(json) {
                    $.each(json,function(index, data){
                        //alert(data.planTasksAmount)
                        $('#person_'+pid+" > .person-plan-amount").text("实际数/计划数："+data.actualTasksAmount+"/"+data.planTasksAmount);
                        $('#person_'+pid+" > .person-plan-hours").text("实际量/计划量："+data.actualWorkload+"/"+data.planWorkload);
                        $.each(data.tasks,function(i, d){
                            var a1 = $('<i class="pull-right bigger-130 ace-icon fa fa-exclamation-triangle red"></i>');
                            var a2 = $('<i class="pull-right bigger-130 ace-icon glyphicon glyphicon-ok green"></i>');
                            var ps = $("<div class='task-project'/>").text("项目名称："+d.project.name);
                            var ts = $("<span class='task-serial'/>").text("任务序号："+d.serial);
                            var th = $("<span class='task-planhour'/>").text("任务量："+d.planHour+"小时");
                            var ti = $("<div class='task-meta'/>").append(ts).append(th);
                            var pr = $("<div class='task-title'/>").text("任务标题："+d.title);
                            var li = $("<li class='task-li'/>").attr("wpid", data.id).attr("tid", d.id);
                            if(d.priority.name=="EMERGENCY"){
                                li.append(a1);
                            }
                            if(d.status.name=="ACCOMPLISHED"){
                                li.append(a2);
                                li.addClass("drag-disabled");
                            }
                            if(d.project.id!=${params.project?.id}){
                                li.addClass("drag-disabled");
                            }
                            li.append(ps).append(ti).append(pr);

                            plan_list.append(li);
                        })

                    })
                }
            });
        });
    }

    $(function(){
        $('#start_end_date').daterangepicker(null, function(start, end, label) {
            console.log(start.toISOString(), end.toISOString(), label);
        });

        // task plan
        initPlanList();

        $('.task-list').sortable({
            connectWith: ".plan-list"
        });

        $('.plan-list').sortable({
            connectWith: ".task-list",
            cancel:".drag-disabled"
        });

        $( ".plan-list" ).on( "sortreceive", function( event, ui ) {
            var pl = $(this);
            var pid = pl.attr("pid")
            var uit = $(ui.item);
            $.ajax({
                url : '/'+basepath+'/weeklyPlan/ajaxAddTask4Plan',
                type : 'POST',
                dataType : 'json',
                data : {
                    pid : pl.attr("pid"),
                    year : $('#plan_week').attr("year"),
                    week : $('#plan_week').attr("week"),
                    tid : uit.attr("tid")
                },
                timeout : 10000,
                error : function(e){
                    alert("任务安排失败");
                },
                success : function(json) {
                    $('#person_'+pid+" > .person-plan-amount").text("实际数/计划数："+json.actualTasksAmount+"/"+json.planTasksAmount);
                    $('#person_'+pid+" > .person-plan-hours").text("实际量/计划量："+json.actualWorkload+"/"+json.planWorkload);

                    uit.attr("wpid",json.id);
                }
            });

        } );

        $( ".plan-list" ).on( "sortremove", function( event, ui ) {
            var pl = $(this);
            var pid = pl.attr("pid")
            var uit = $(ui.item);
            $.ajax({
                url : '/'+basepath+'/weeklyPlan/ajaxRemoveTask4Plan',
                type : 'POST',
                dataType : 'json',
                data : {
                    wpid : uit.attr("wpid"),
                    tid : uit.attr("tid")
                },
                timeout : 10000,
                error : function(e){
                    alert("任务安排失败");
                },
                success : function(json) {
                    $('#person_'+pid+" > .person-plan-amount").text("实际数/计划数："+json.actualTasksAmount+"/"+json.planTasksAmount);
                    $('#person_'+pid+" > .person-plan-hours").text("实际量/计划量："+json.actualWorkload+"/"+json.planWorkload);

                    uit.removeAttr("wpid");
                }
            });

        } );

        $("#next_week").click(function(){
            var wo = parseInt($('#plan_week').attr("weekOffset")) + 1;

            $.post('/'+basepath+'/weeklyPlan/ajaxGetOffsetWeek', { offset: wo },
                    function(data){
                        $('#plan_week').attr("weekOffset", wo);
                        $('#plan_week').attr("year", data.OffsetWeek.year);
                        $('#plan_week').attr("week", data.OffsetWeek.week);
                        $('#plan_week').text(data.OffsetWeek.year + "年第" + data.OffsetWeek.week + "周("+ data.OffsetWeek.fd + "-" + data.OffsetWeek.ld +")计划");

                        initPlanList();
                    });


        })

        $("#prev_week").click(function(){
            var wo = parseInt($('#plan_week').attr("weekOffset")) - 1;

            if(wo >= 0){
                $.post('/'+basepath+'/weeklyPlan/ajaxGetOffsetWeek', { offset: wo },
                        function(data){
                            $('#plan_week').attr("weekOffset", wo);
                            $('#plan_week').attr("year", data.OffsetWeek.year);
                            $('#plan_week').attr("week", data.OffsetWeek.week);
                            $('#plan_week').text(data.OffsetWeek.year + "年第" + data.OffsetWeek.week + "周("+ data.OffsetWeek.fd + "-" + data.OffsetWeek.ld +")计划");

                            initPlanList();
                        });
            } else {
                alert("不允许为过去安排任务！");
            }


        })

        $(".person_tasks_list").click(function(){
            var ptl = $(this);
            var ul = ptl.parents(".person-tasks").children("ul");
            if(ul.is(":hidden")){
                ul.show();
                ptl.children("i").removeClass("glyphicon-plus").addClass("glyphicon-minus");
            } else {
                ul.hide();
                ptl.children("i").removeClass("glyphicon-minus").addClass("glyphicon-plus");
            }
        })
    })
</script>
</body>
</html>