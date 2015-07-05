<%--
  Created by IntelliJ IDEA.
  User: karl
  Date: 14-8-15
  Time: 下午6:47
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'batch.label', default: 'Batch')}" />
    <title>排产</title>
    <style type="text/css">
    .list-group-item:hover{
        background-color: #dcdcdc;
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
    <!--
    <li role="presentation">
        <g:link controller="task" class="create" action="create">
        <g:message code="task.create" args="[entityName]" />
    </g:link>
    </li>
    -->
    <li role="presentation">
        <g:link controller="batch" class="create" action="index">
            生产批次管理
        </g:link>
    </li>
    <li role="presentation" class="active">
        <g:link class="create" controller="batch" action="scheduling">
            <g:message code="batch.scheduling" />
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


    <div class="row">
        <div class="col-md-4">
            <div style="margin: 5px;padding: 10px;">
                <div class="panel panel-default">
                    <!-- Default panel contents -->
                    <div class="panel-heading">待安排工作列表</div>
                    <div class="list-group" id="project_tasks_list" style="height: 400px;overflow-y:scroll;">
                        <g:each in="${tasks}" status="i" var="task">
                            <div class="list-group-item">
                                <div tid="${task.id }">
                                    <span style="font-weight: bold;padding-right: 10px">${task.serial }</span>
                                    <span style="color: DarkOrange;padding-right: 10px">${task.priority }</span>
                                    <span style="color: darkgreen">${task.type }</span>
                                    <span class='planHour' style="float: right;color: darkred">${task.planHour }</span>
                                    <pre style="padding: 0;margin: 0;background-color: transparent;border: none">${task.proposal }</pre>
                                </div>
                            </div>
                        </g:each>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">

            <g:form  class="form-horizontal" role="form" style="padding-top: 15px" action="${!batchInstance.serial?'save':''}" url="${!batchInstance.serial?'':[resource:batchInstance, action:'update']}" method="${!batchInstance.serial?'POST':'PUT'}">

                <g:if test="${batchInstance.serial}">
                    <div class="form-group">
                        <label for="serial" class="col-md-3 control-label">
                            <g:message code="batch.serial.label" default="serial" />
                            <span class="required-indicator">*</span>
                        </label>
                        <div class="col-md-9">
                            <input type="text" class="form-control" id="serial" readonly="readonly" value="${batchInstance.serial}">
                        </div>
                    </div>
                </g:if>

                <div class="form-group">
                    <label for="project" class="col-md-3 control-label">
                        <g:message code="batch.project.label" default="Project" />
                        <span class="required-indicator">*</span>
                    </label>
                    <div class="col-md-9">
                        <g:if test="${!batchInstance.serial}">
                            <g:select id="project" name="project.id" from="${pl}" optionKey="id" required="" value="${batchInstance?.project?.id}" class="many-to-one form-control"/>
                        </g:if>
                        <g:if test="${batchInstance.serial}">
                            <input type="text" class="form-control" id="project" readonly="readonly" value="${batchInstance.project.name}">
                        </g:if>
                    </div>
                </div>

                <div class="form-group">
                    <label for="start_end_date" class="col-md-3 control-label">
                        <g:message code="batch.startDate.label" default="Date" />
                        <span class="required-indicator">*</span>
                    </label>
                    <div class="col-md-9">
                        <div class="controls">
                            <div class="input-prepend input-group">
                                <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></span>
                                <input type="text" readonly="readonly" style="width: 200px" name="start_end_date" id="start_end_date" class="form-control" value="${params.start_end_date}" />
                            </div>
                        </div>
                    </div>
                </div>


                <div class="form-group">
                    <label for="planHour" class="col-md-3 control-label">
                        <g:message code="batch.planHour.label" default="Plan Hour" />
                        <span class="required-indicator">*</span>
                    </label>
                    <div class="col-md-9">
                        <g:field name="planHour" type="number" value="${batchInstance.planHour}" required="" class="form-control"/>
                    </div>
                </div>

                <div class="form-group">
                    <label for="bufferHour" class="col-md-3 control-label">
                        <g:message code="batch.bufferHour.label" default="Buffer Hour" />
                        <span class="required-indicator">*</span>
                    </label>
                    <div class="col-md-9">
                        <g:field name="bufferHour" type="number" value="${batchInstance.bufferHour}" required="" class="form-control"/>
                    </div>
                </div>

                <div class="form-group">
                    <label for="sitPeople" class="col-md-3 control-label">
                        <g:message code="batch.sitPeople.label" default="Sit People" />
                        <span class="required-indicator">*</span>
                    </label>
                    <div class="col-md-9">
                        <g:select id="sitPeople" name="sitPeople.id" from="${sits}" optionKey="id" required="" value="${batchInstance?.sitPeople?.id}" class="many-to-one form-control"/>
                    </div>
                </div>

                <div class="form-group">
                    <label for="developers" class="col-md-3 control-label">
                        <g:message code="batch.developers.label" default="Developers" />
                        <span class="required-indicator">*</span>
                    </label>
                    <div class="col-md-9">
                        <g:select id="developers" name="developer.id" from="${developers}" optionKey="id" required="" value="${batchInstance?.developer?.id}" class="many-to-one form-control"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-sm-offset-3 col-md-9">
                        <g:if test="${!batchInstance.serial}">
                            <button type="submit" class="btn btn-info">${message(code: 'default.button.create.label', default: 'Create')}</button>
                        </g:if>
                        <g:if test="${batchInstance.serial}">
                            <g:hiddenField name="id" value="${batchInstance?.id}" />
                            <g:hiddenField name="version" value="${batchInstance?.version}" />
                            <g:actionSubmit class="btn btn-warning" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />

                        </g:if>
                    </div>
                </div>

            </g:form>
        </div>
        <div class="col-md-4">
            <div style="margin: 5px;padding: 10px">
                <div class="panel panel-default">
                    <!-- Default panel contents -->
                    <div class="panel-heading">当前工作安排情况</div>
                    <!--
                        <div class="panel-body">
                            <p>...</p>
                        </div>
                        -->
                    <!-- Table -->
                    <div  style="height: 400px;overflow-y:scroll;">
                        <table id="person_batch" class="table">
                            <thead>
                            <tr>
                                <th>名称</th>
                                <th>批次号</th>
                                <th>日期</th>
                                <th>任务量</th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each in="${developers}" status="i" var="developer">
                                <tr>
                                    <td style="white-space: nowrap">${fieldValue(bean: developer, field: "name")}</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                            </g:each>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<script type="text/javascript">
    var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
    basepath= basepath.substring(0,basepath.indexOf('/')) ;

    var batch4PersonList = function(pid){
        $('#person_batch tbody').empty();
        $.ajax({
            url : '/'+basepath+'/batch/ajaxBatch4PersonInProject',
            type : 'POST',
            dataType : 'json',
            data : {
                pid : pid
            },
            timeout : 10000,
            error : function(e){
                alert("操作失败")
            },
            success : function(json) {
                $(json).each(function(){
                    var pb = this;
                    var tr = $('<tr/>');
                    $('<td />').text(pb.personName).appendTo(tr);
                    $('<td />').text(pb.batchSerials).appendTo(tr);
                    $('<td />').text(pb.lastPlanFinishDateS).appendTo(tr);
                    $('<td />').text(pb.totalPlanHours).appendTo(tr);
                    tr.appendTo($('#person_batch tbody'))
                })
            }
        });
    };

    $(function(){
        $('#start_end_date').daterangepicker(null, function(start, end, label) {
            console.log(start.toISOString(), end.toISOString(), label);
        });



        $("#project").change(function(){
            var pid = $("#project  option:selected").val();
            $("#project_tasks_list").empty();
            $("#developers").empty();
            $("#sitPeople").empty();
            $.ajax({
                url : '/'+basepath+'/batch/ajaxGetTasksList',
                type : 'POST',
                dataType : 'json',
                data : {
                    pid : pid
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(json) {
                    $(json[0]).each(function(){
                        var job = this;
                        var tn="";
                        var pn="";
                        var psd = "";
                        if(job.type){
                            tn = job.type.name;
                        }
                        if(job.priority){
                            pn = job.priority.name;
                        }
                        $("#project_tasks_list").append("<div class='list-group-item'><div tid='"+job.id+"'>"+
                                "<span style='font-weight: bold;padding-right: 10px'>"+job.serial +"</span>"+
                                "<span style='color: DarkOrange;padding-right: 10px'>"+pn +"</span>"+
                                "<span style='color: darkgreen'>"+tn +"</span>"+
                                "<span class='planHour' style='float: right;color: darkred'>"+job.planHour +"</span>"+
                                "<pre style='padding: 0;margin: 0;background-color: transparent;border: none'>"+job.proposal +"</pre>"+
                                "</div></div>");
                    })
                    $(json[1]).each(function(){
                        var dev = this;
                        $("#developers").append("<option value="+dev.id+" >"+dev.name+"</option>");
                    })
                    $(json[2]).each(function(){
                        var sit = this;
                        $("#sitPeople").append("<option value="+sit.id+" >"+sit.name+"</option>");
                    })
                    batch4PersonList(pid);
                }
            });
        })

        <g:if test="${!batchInstance.serial}">
        $( document ).on( "click", ".list-group-item", function() {
            var lgi = $(this);
            if($(lgi).hasClass('active')){
                lgi.removeClass('active');
                var ph = parseInt($("#planHour").val())-parseInt(lgi.children('div').children('.planHour').text());
                $("#planHour").val(ph);
                $("#bufferHour").val(parseInt(ph/3));
                $("input[type='hidden'][value="+lgi.children('div').attr('tid')+"]").remove();
            } else {
                lgi.addClass('active');
                var ph = parseInt($("#planHour").val())+parseInt(lgi.children('div').children('.planHour').text());
                $("#planHour").val(ph);
                $("#bufferHour").val(parseInt(ph/3));
                $("form").append("<input type='hidden' name='task' value='"+lgi.children('div').attr('tid')+"' />");
            }
        })
        </g:if>

    })
</script>
</body>
</html>