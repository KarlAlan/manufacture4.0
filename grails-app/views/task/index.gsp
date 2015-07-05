<%@ page import="com.rcstc.manufacture.Priority; com.rcstc.manufacture.Task; com.rcstc.manufacture.TaskType; com.rcstc.manufacture.TaskStatus" %>

<!DOCTYPE html>

<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'task.label', default: 'task')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <asset:javascript src="bootstrap-multiselect.js"/>
    <asset:stylesheet src="bootstrap-multiselect.css"/>
    <style  type="text/css">
    th, td {
        white-space: nowrap;
    }
    .form-group {
        margin: 5px;
    }
    .zero-hour {
        color: orangered;
    }
    </style>
</head>
<body>
<ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
    <li role="presentation" class="active">
        <g:link class="list" action="index">
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
    <li role="presentation">
        <g:link controller="weeklyPlan" class="create" action="weeklyPlan4Person">
            每周计划
        </g:link>
    </li>
    <li role="presentation">
        <g:link class="create" controller="weeklyPlan" action="schedue">
            周计划安排
        </g:link>
    </li>
</ul>

<!--<h1><g:message code="default.list.label" args="[entityName]" /></h1> -->
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>

<div title="查询条件" style="margin: 10px">
    <g:form action="index" method="post" class="form-inline" role="form">
        <div class="form-group">
            <label>项目名称：</label>
            <g:select name="pid" from="${pl}"  optionKey="id" value="${params.pid}" noSelection="['-1':'-所有-']" class="form-control"/>
        </div>
        <div class="form-group">
            <label>任务号：</label>
            <input value="${params.task_serial}" id="task_serial" name="task_serial" type="text" class="form-control" placeholder="任务号" style="width: 100px">
        </div>
        <div class="form-group">
            <label>需求号：</label>
            <input value="${params.demand_serial}" id="demand_serial" name="demand_serial" type="text" class="form-control" placeholder="需求号" style="width: 100px">
        </div>
        <div class="form-group">
            <label>状态：</label>
            <g:select name="task_status" from="${TaskStatus?.values().name}" keys="${TaskStatus.values()*.id}" optionKey="id"
                      id="task_status" class="multiselect" multiple=""/>
        </div>
        <div class="form-group">
            <label>作业类型：</label>
            <g:select name="task_type" from="${TaskType?.values().name}" keys="${TaskType.values()*.id}"  optionKey="id"
                      id="task_type"  class="multiselect" multiple=""/>
        </div>
        <div class="form-group">
            <label>优先级：</label>
            <g:select name="task_priority" from="${com.rcstc.manufacture.Priority?.values().name}" keys="${Priority.values()*.id}" optionKey="id"
                      value="${params.task_priority?:-1}" noSelection="['-1':'-所有-']" class="form-control"/>
        </div>
        <div class="form-group">
            <div class="controls">
                <div class="input-prepend input-group">
                    <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></span>
                    <div class="input-group-btn">
                        <button type="button" class="btn btn-white btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false" ><span id="pd_name">完成日期</span> <span class="caret"></span></button>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="#" class="condition_task_date" pn="createDate">创建日期</a></li>
                            <li><a href="#" class="condition_task_date" pn="finishDate">完成日期</a></li>
                            <li class="divider"></li>
                            <li><a href="#" class="condition_task_date" pn="approveDate">验收日期</a></li>
                        </ul>
                    </div><!-- /btn-group -->

                    <input type="text" readonly="readonly" style="width: 200px" name="task_date" id="task_date" class="form-control" value="${params.task_date}"/>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="controls">
                <div class="input-group">
                    <div class="input-group-btn">
                        <button type="button" class="btn btn-white btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><span id="pn_name">完成人</span> <span class="caret"></span></button>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="#" class="condition_task_person" pn="creater">创建人</a></li>
                            <li><a href="#" class="condition_task_person" pn="finisher">完成人</a></li>
                            <li class="divider"></li>
                            <li><a href="#" class="condition_task_person" pn="approver">验收人</a></li>
                        </ul>
                    </div><!-- /btn-group -->
                    <input type="text" class="form-control" aria-label="..." class="form-control" placeholder="姓名" value="${params.task_person}" id="task_person" name="task_person" autocomplete="off">
                </div><!-- /input-group -->
            </div>
        </div>
        <input type="hidden" name="task_person_type" value="${params.task_person_type?:'finisher'}">
        <input type="hidden" name="task_date_type" value="${params.task_date_type?:'finishDate'}">
        <div class="form-group">
            <button type="submit" class="btn btn-info btn-sm">查询</button>
            <button id="reset_button" type="reset" class="btn btn-warning btn-sm">重置</button>
        </div>

    </g:form>
</div>

<div id="list-task" class="content scaffold-list" role="main" style="overflow-x: scroll">

    <table class="table table-bordered">
        <thead>
        <tr>
            <th></th>
            <th></th>
            <th>状态</th>
            <th><g:message code="task.project.label" default="Project" /></th>
            <th>${message(code: 'task.type.label', default: 'Type')}</th>
            <th>${message(code: 'task.serial.label', default: 'Serial')}</th>
            <th>需求号</th>

            <!--
            <th>任务要求</th>
            <th>验收标准</th>
            -->
            <th>标题</th>

            <th>工作量(小时)</th>

            <th>创建人</th>
            <th>创建日期</th>
            <th>完成人</th>
            <th>完成日期</th>
            <th>验收人</th>
            <th>验收日期</th>
            <th>评价</th>

        </tr>
        </thead>
        <tbody>
        <g:each in="${taskInstanceList}" status="i" var="taskInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                <td>
                    ${(params.offset ? params.int('offset') : 0)+i+1}
                </td>


                <td>
                    <g:if test="${taskInstance.priority==Priority.EMERGENCY}">
                        <i class="icon-warning-sign" style="color: red"></i>
                    </g:if>
                    <g:elseif test="${taskInstance.priority==Priority.NORMAL}">
                        <i class="icon-info-sign" style="color: green"></i>
                    </g:elseif>
                    <g:else>
                        <i class="icon-exclamation-sign" style="color: darkgreen"></i>
                    </g:else>
                </td>
                <td><span class="label label-primary" >${taskInstance?.status?.name}</span></td>
                <td>${fieldValue(bean: taskInstance, field: "project")}</td>

                <td>${taskInstance?.type?.name}</td>
                <td><g:link action="show" id="${taskInstance.id}">${fieldValue(bean: taskInstance, field: "serial")}</g:link></td>
                <td>
                    <g:link controller="demand" action="show" id="${taskInstance.demand?.id}">${taskInstance.demand?.serial}</g:link>
                </td>

                <!--
                <td class="task_proposal" updateable="${taskInstance.status==TaskStatus.ARRANGE?'Y':'N'}" task_id="${taskInstance.id }"><div style="width:300px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" >${fieldValue(bean: taskInstance, field: "proposal")}</div></td>
                <td><div style="width:300px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;">${fieldValue(bean: taskInstance, field: "scenario")}</div></td>
                 -->
                <td>${taskInstance.title}</td>

                <td style="text-align: right" class="${taskInstance.planHour==0?'zero-hour':''}">
                    ${fieldValue(bean: taskInstance, field: "planHour")}
                </td>

                <td class="task_proposal" style="display: none">${fieldValue(bean: taskInstance, field: "scenario")}</td>
                <td class="task_proposal" style="display: none">${fieldValue(bean: taskInstance, field: "remark")}</td>

                <td>${taskInstance.creater?.name}</td>
                <td>${taskInstance.createDate?.format("yyyy-MM-dd")}</td>
                <td>${taskInstance.finisher?.name}</td>
                <td>${taskInstance.finishDate?.format("yyyy-MM-dd")}</td>
                <td>${taskInstance.approver?.name}</td>
                <td>${taskInstance.approveDate?.format("yyyy-MM-dd")}</td>
                <td>
                    <g:if test="${taskInstance.evaluate=='good'}">
                        <span class="label label-success arrowed">好评</span>
                    </g:if>
                    <g:if test="${taskInstance.evaluate=='normal'}">
                        <span class="label label-warning">中评</span>
                    </g:if>
                    <g:if test="${taskInstance.evaluate=='bad'}">
                        <span class="label label-danger arrowed-in">差评</span>
                    </g:if>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>
    <div class="pagination" style="display: block;margin:0 10px">
        <g:paginate total="${taskInstanceTotal}"/>
        <span style="padding-left: 20px;position: relative;bottom: 30px">总共<span style="color: darkblue">${taskInstanceTotal ?: 0}</span>条</span>
    </div>


<!--Edit Description Modal -->
<div class="modal fade bs-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel"></h4>
            </div>
            <div class="modal-body" id="desc-modal">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="updateTask" type="button" class="btn btn-primary">保存</button>
                <button id="verifyTask" type="button" class="btn btn-warning">审核</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">


    $(function(){
        var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
        basepath= basepath.substring(0,basepath.indexOf('/')) ;

        $('#task_date').daterangepicker(null, function(start, end, label) {
            console.log(start.toISOString(), end.toISOString(), label);
        });

        $('#task_person').typeahead({
            source: function(query,process) {
                return $.post('/'+basepath+'/person/ajaxPersonName', { query: query },function(data){
                    return process(data);
                });
            }
        });

        // multiselect控件
        $('.multiselect').multiselect({
            //enableFiltering: true,
            buttonClass: 'btn btn-white btn-primary',
            templates: {
                button: '<button type="button" class="multiselect dropdown-toggle" data-toggle="dropdown"></button>',
                ul: '<ul class="multiselect-container dropdown-menu"></ul>',
                filter: '<li class="multiselect-item filter"><div class="input-group"><span class="input-group-addon"><i class="fa fa-search"></i></span><input class="form-control multiselect-search" type="text"></div></li>',
                filterClearBtn: '<span class="input-group-btn"><button class="btn btn-default btn-white btn-grey multiselect-clear-filter" type="button"><i class="fa fa-times-circle red2"></i></button></span>',
                li: '<li><a href="javascript:void(0);"><label></label></a></li>',
                divider: '<li class="multiselect-item divider"></li>',
                liGroup: '<li class="multiselect-item group"><label class="multiselect-group"></label></li>'
            }
        });

        // 根据params，初始化multiselect控件
        <%
            def ts = "["
            if(params.task_status){
                if(params.task_status instanceof String){
                    ts = ts + params.task_status
                } else {
                    params.task_status.each(){
                        ts = ts + it + ","
                    }
                }
            }
            ts = ts + "]"

            def tt = "["
            if(params.task_type){
                if(params.task_type instanceof String){
                    tt = tt + params.task_type
                } else {
                    params.task_type.each(){
                        tt = tt + it + ","
                    }
                }
            }
            tt = tt + "]"
        %>
        $('#task_status').multiselect('select', ${ts});
        $('#task_type').multiselect('select', ${tt});


        // 人类型和日期类型选择
        $('.condition_task_person').click(function(){
            var ctp = $(this);
            $('#pn_name').text(ctp.text());
            $('input[type=hidden][name=task_person_type]').attr('value',ctp.attr('pn'));
        })

        $('.condition_task_date').click(function(){
            var ctp = $(this);
            $('#pd_name').text(ctp.text());
            $('input[type=hidden][name=task_date_type]').attr('value',ctp.attr('pn'));
        })

        // 根据params，初始化下拉日期选择文字
        $('#pd_name').text($('.condition_task_date[pn="${params.task_date_type?:'finishDate'}"]').text());
        $('#pn_name').text($('.condition_task_person[pn="${params.task_person_type?:'finisher'}"]').text());

        // 重置multiselect控件和下拉日期、人选择控件
        $('#reset_button').click(function(){
            $('#task_status').multiselect('deselectAll', false);
            $('#task_status').multiselect('updateButtonText');

            $('#task_type').multiselect('deselectAll', false);
            $('#task_type').multiselect('updateButtonText');

            $('#pd_name').text($('.condition_task_date[pn=finishDate]').text());
            $('input[type=hidden][name=task_date_type]').attr('value','finishDate');

            $('#task_date').val("");

            $('#pn_name').text($('.condition_task_person[pn=finisher]').text());
            $('input[type=hidden][name=task_person_type]').attr('value','finisher');
        })

        //  toggle requirement edit
        $(".task_proposal").hover(function(){
            $(this).css("cursor","pointer");
        })
        $(".task_proposal").click(function(){
            var rd = $(this);
            $('#myModalLabel').text($(rd).parents('tr').children('td:eq(3)').text()+'/'+$(rd).parents('tr').children('td:eq(2)').children('a').text())
            $('#desc-modal').empty();
            if($(rd).attr('updateable')=='N'){
                $('#desc-modal').append("<pre>"+$(rd).children('div').text()+"</pre>");
                $('#desc-modal').append("<pre>"+$(rd).parents('tr').children('td:eq(11)').text()+"</pre>");
                $('#desc-modal').append("<pre>"+$(rd).parents('tr').children('td:eq(12)').text()+"</pre>");
                $('#updateDemand').hide()
            } else {
                $('#desc-modal').append('解决方案：<textarea id="updateTaskProposal" class="form-control" rows="5" did="'+$(rd).attr('task_id')+'" >'+$(rd).children('div').text()+"</textarea>");
                $('#desc-modal').append('测试方案：<textarea id="updateTaskScenario" class="form-control" rows="5" did="'+$(rd).attr('task_id')+'" >'+$(rd).parents('tr').children('td:eq(11)').text()+"</textarea>");
                $('#desc-modal').append('备注：<textarea id="updateTaskRemark" class="form-control" rows="3" did="'+$(rd).attr('task_id')+'" >'+$(rd).parents('tr').children('td:eq(12)').text()+"</textarea>");
                $('#desc-modal').append('预估时间：<input id="devTime" type="number" name="devTime" max="30" min="1" value="'+$(rd).parents('tr').children('td:eq(8)').text()+'" class="form-control"/>');
                $('#updateTask').show()
            }

            $('#myModal').modal('toggle');
        })

        // update task
        $("#updateTask").click(function(){
            $.ajax({
                url : '/'+basepath+'/task/ajaxUpdateTask',
                type : 'POST',
                dataType : 'json',
                data : {
                    tid : $('#updateTaskProposal').attr("did"),
                    proposal: $('#updateTaskProposal').val(),
                    scenario: $('#updateTaskScenario').val(),
                    remark: $('#updateTaskRemark').val(),
                    planHour:$('#devTime').val()
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(json) {
                    var td = $('td[task_id="'+$('#updateTaskProposal').attr('did')+'"]');
                    var tr = $(td).parent('tr');
                    $(td).children('div').text($('#updateTaskProposal').val());
                    $(tr).children('td:eq(11)').text($('#updateTaskScenario').val());
                    $(tr).children('td:eq(12)').text($('#updateTaskRemark').val());
                    $(tr).children('td:eq(8)').text($('#devTime').val());
                    //alert("操作成功")
                    //window.location.reload();
                    task_tr.remove();
                }
            });
            $('#myModal').modal('hide');
        })

        // audit task
        $("#verifyTask").click(function(){
            if($('#updateTaskProposal').val()==""||$('#devTime').val()==0){
                alert("解决方案或计划时间没有填写，不能审核！！");
                return;
            }

            $.ajax({
                url : '/'+basepath+'/task/ajaxVerifyTask',
                type : 'POST',
                dataType : 'json',
                data : {
                    tid : $('#updateTaskProposal').attr("did"),
                    proposal: $('#updateTaskProposal').val(),
                    scenario: $('#updateTaskScenario').val(),
                    remark: $('#updateTaskRemark').val(),
                    planHour:$('#devTime').val()
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(json) {
                    /*
                    var td = $('td[task_id="'+$('#updateTaskProposal').attr('did')+'"]');
                    var tr = $(td).parent('tr');
                    $(tr).children('td:eq(10)').text('<g:formatDate date="${new Date()}" format="yyyy-MM-dd hh:mm"></g:formatDate> ');
                    $(tr).children('td:eq(9)').text('<sec:username/>');
                    $(tr).children('td:eq(1)').text('待安排');
                    */
                    $('#search_button').click()
                }
            });
            $('#myModal').modal('hide');
        })

        // delete task
        $(".icon-remove-sign").hover(
                function(){
                    $(this).css("cursor","pointer");
                    $(this).css("color","red");
                } ,
                function(){
                    $(this).css("color","SteelBlue");
                }
        )
        $(".icon-remove-sign").click(function(){
            if(confirm("确认要删除作业吗，该操作不能恢复？")){
                var cid = $(this);
                var task_tr = cid.parents("tr");
                //alert(cid.attr("sid"));
                $.ajax({
                    url : '/'+basepath+'/task/ajaxDeleteTask',
                    type : 'POST',
                    dataType : 'json',
                    data : {
                        jid : cid.attr("tid")
                    },
                    timeout : 10000,
                    error : function(e){
                        alert("操作失败")
                    },
                    success : function(json) {
                        //alert("操作成功")
                        //window.location.reload();
                        task_tr.remove();
                    }
                });
            }
        })

    })
</script>
</body>
</html>
