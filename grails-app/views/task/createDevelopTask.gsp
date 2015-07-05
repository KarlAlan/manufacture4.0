<%@ page import="com.rcstc.manufacture.DemandCharacter; com.rcstc.manufacture.DemandType; com.rcstc.manufacture.TaskType; com.rcstc.manufacture.Task; com.rcstc.manufacture.Priority" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'task.label', default: 'Task')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
    <link rel="stylesheet" href="${createLink(uri:'/css/jquery.fileupload.css')}">
    <link rel="stylesheet" href="${createLink(uri:'/css/jquery.fileupload-ui.css')}">
    <script src="${createLink(uri:'/js/vendor/jquery.ui.widget.js')}"></script>
    <script src="${createLink(uri:'/js/jquery.iframe-transport.js')}"></script>
    <script src="${createLink(uri:'/js/jquery.fileupload.js')}"></script>
    <style>
    .file_delete:hover {
        cursor: pointer;
    }
    .list-group-item {
        min-height: 70px;
    }
    .demand_desc {
        background: #ffffff;
        margin-bottom: 15px;
        border-radius: 4px;
        border: solid 1px lightgrey;
        padding: 10px;
    }

    .demand_desc pre {
        padding: 2px;
        background-color: transparent;
        border: none;
    }
    </style>
</head>
<body>

<ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
    <li role="presentation">
        <g:link class="list" action="index">
            <g:message code="task.list" args="[entityName]" />
        </g:link>
    </li>
    <li role="presentation" class="active">
        <g:link class="create" action="create">
            <g:message code="task.create" args="[entityName]" />
        </g:link>
    </li>
</ul>
<div id="create-task" class="content scaffold-create" role="main">
<!--
			<h1><g:message code="default.create.label" args="[entityName]" /></h1>
			-->
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${taskInstance}">
        <ul class="errors" role="alert">
            <g:eachError bean="${demandInstance}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <div class="row">
        <div class="col-md-8" style="padding: 10px">
            <g:form url="[resource:taskInstance, action:'save']" role="form" class="form-horizontal">
                <g:hiddenField name="type" value="${taskInstance?.type?.name()?:TaskType.DEVELOP_TASK}" />
                <g:hiddenField name="description" value="${taskInstance?.description}" />
                <g:hiddenField name="demand.id" value="${taskInstance?.demand?.id}" />
                <div class="form-group">
                    <label for="project" class="col-sm-2 control-label"><g:message code="task.project.label" default="Project" /></label>
                    <div class="col-sm-10">
                        <g:select id="project" name="project.id" from="${pl}" optionKey="id" required="" value="${taskInstance?.project?.id}" readonly="" class="many-to-one form-control" />
                    </div>
                </div>

                <div class="col-sm-offset-2 col-sm-10 demand_desc" tid="${taskInstance.demand.id }">
                    <div>
                        <g:if test="${taskInstance.demand.priority==Priority.EMERGENCY}">
                            <i class="icon-warning-sign" style="color: red"></i>
                        </g:if>
                        <g:else>
                            <i class="icon-info-sign" style="color: lawngreen"></i>
                        </g:else>
                        <span style="font-weight: bold;padding-right: 10px;color: darkblue">${taskInstance.demand.serial }</span>
                        <span style="float: right;color: darkred">${taskInstance.demand.planStopDate?.format("yy-MM-dd") }</span>
                        <span style="float: right;padding-right: 10px">${taskInstance.demand.submitPeople }</span>
                        <span style="font-size: 0.8em" class="label ${taskInstance.demand.demandCharacter==DemandCharacter.FUNCTIONAL||taskInstance.demand.demandCharacter==DemandCharacter.PERFORMANCE?'label-primary':'label-default'}">${taskInstance.demand.demandCharacter}</span>
                        <span style="font-size: 0.8em" class="label ${taskInstance.demand.type==DemandType.BUG?'label-warning':'label-info'}">${taskInstance.demand.type}</span>
                    </div>
                    <div>
                        <span style="color: maroon">${taskInstance.demand.category1 }/${taskInstance.demand.category2 }</span>

                    </div>
                    <pre>${taskInstance.demand.description }</pre>
                </div>

                <div class="form-group">
                    <label for="proposal" class="col-sm-2 control-label"><g:message code="task.proposal.label" default="Proposal" /></label>
                    <div class="col-sm-10">
                        <g:textArea name="proposal" cols="40" rows="5" maxlength="2000" required="" value="${taskInstance?.proposal}" class="form-control"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="scenario" class="col-sm-2 control-label"><g:message code="task.scenario.label" default="Scenario" /></label>
                    <div class="col-sm-10">
                        <g:textArea name="scenario" cols="40" rows="5" maxlength="2000" value="${taskInstance?.scenario}" class="form-control"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="priority" class="col-sm-2 control-label"><g:message code="task.priority.label" default="Priority" /></label>
                    <div class="col-sm-10">
                        <g:select id="priority" name="priority" from="${Priority?.values()}" keys="${Priority.values()*.name()}" value="${taskInstance?.priority?.name()?:Priority.NORMAL}" class="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="planHour" class="col-sm-2 control-label"><g:message code="task.planHour.label" default="Plan Hour" /></label>
                    <div class="col-sm-10">
                        <g:field name="planHour" type="number" value="${taskInstance.planHour}" required="" class="form-control"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="remark" class="col-sm-2 control-label"><g:message code="task.remark.label" default="Remark" /></label>
                    <div class="col-sm-10">
                        <g:textArea name="remark" cols="40" rows="5" maxlength="2000" value="${taskInstance?.remark}" class="form-control"/>
                    </div>
                </div>
                <div class="col-sm-offset-2 col-sm-10">
                    <g:submitButton name="create" class="btn btn-success" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                </div>
            </g:form>
        </div>
        <div class="col-md-4">
            <div style="padding: 10px">
                <div class="list-group" style="width: 380px">
                </div>
            </div>
            <!--
                <div style="padding: 10px">
                    <div class="row fileupload-buttonbar" >
                        <div>
                            <span class="btn btn-success fileinput-button">
                                <i class="icon-plus icon-white"></i>
                                <span>${message(code: 'fileupload.add.files', default: '上传文件')}</span>
                                <input id="fileupload" type="file" name="files[]" multiple>
                            </span>
                            <button type="button" class="btn btn-danger delete">
                                <i class="icon-trash icon-white"></i>
                                <span>${message(code: 'fileupload.delete', default: '删除')}</span>
                            </button>

                        </div>

                        <div class="progress" style="width: 380px;margin-bottom: 5px;display: none">
                            <div class="progress-bar progress-bar-success progress-bar-striped active"  role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
                            </div>
                        </div>


                    </div>
                </div>
                -->
        </div>
    </div>

</div>


<script type="text/javascript">
    var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
    basepath= basepath.substring(0,basepath.indexOf('/')) ;


    var listDemandFile = function(){
        $.ajax({
            url : '/'+basepath+'/file/upload?objectType=demand&objectId='+${taskInstance.demand.id},
            type : 'GET',
            dataType : 'json',
            data : {
            },
            timeout : 10000,
            error : function(e){
                alert("操作失败")
            },
            success : function(json) {

                $.each(json,function(index,file){
                    var li = $('<div class="list-group-item"></div>');
                    $('<img style="float: left"/>').attr('src',file.thumbnail_url).appendTo(li);
                    $('<i class="glyphicon glyphicon-trash file_delete" style="float: right;font-size: 20px; color: red;margin-top:10px"/>').attr('durl',file.delete_url).appendTo(li);
                    $('<a target="_Blank" style="font:16px bold;margin-left:10px"/>').attr('href',file.url).text(file.name).appendTo(li);
                    $('<div style="font:16px;margin-left:60px "/>').text(file.size+"字节").appendTo(li);

                    li.appendTo($('.list-group'));
                })

            }
        });
    }

    $(document).ready(function() {
        listDemandFile();
    })
</script>

</body>
</html>
