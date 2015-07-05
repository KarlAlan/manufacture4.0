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
    <script src="${createLink(uri:'/js/jquery.nestable.js')}"></script>
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

    <div title="查询条件" style="margin: 10px">
        <g:form action="schedue" method="post" class="form-inline" role="form">
            <div class="form-group">
                <label><g:message code="batch.project.label" default="Project" /></label>
                <g:select id="project" name="project.id" from="${pl}" optionKey="id" required="" noSelection="['-1':'-请选择-']" value="${params.project?.id?:-1}" class="many-to-one form-control"/>
            </div>
            <div class="form-group">
                <label>任务类型：</label>
                <g:select name="task_type" from="${com.rcstc.manufacture.TaskType}" optionKey="id"
                          value="${params.task_type?:-1}" noSelection="['-1':'-请选择-']" class="form-control"/>
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
                    <div class="dd" id="nestable">
                        <ol class="dd-list">
                            <g:each in="${tasks}" status="i" var="task">
                                <li class="dd-item">
                                    <div class="dd-handle dd2-handle">
                                        <i class="normal-icon ace-icon fa fa-comments blue bigger-130"></i>

                                        <i class="drag-icon ace-icon fa fa-arrows bigger-125"></i>
                                    </div>
                                    <div class="dd2-content">
                                        <g:if test="${task.priority== com.rcstc.manufacture.Priority.EMERGENCY}">
                                            <i class="pull-right bigger-130 ace-icon fa fa-exclamation-triangle red"></i>
                                        </g:if>
                                        <div class="orange">任务序号：${task.serial}&nbsp; &nbsp; &nbsp; 预计时长：${task.planHour}小时</div>
                                        <div class="lighter grey">
                                            &nbsp; 任务内容：${task.proposal}
                                        </div>
                                        <div class="lighter grey">
                                            &nbsp; 测试方法：${task.scenario}
                                        </div>
                                    </div>
                                </li>
                            </g:each>
                        </ol>
                    </div>
                </div>

                <div class="vspace-16-sm"></div>

                <div class="col-sm-6">
                    <h3 class="header smaller lighter blue">人力资源列表</h3>
                    <g:each in="${developers}" status="i" var="developer">
                        <div class="dd dd-draghandle">
                            <div>${developer.person.name}</div>
                            <ol class="dd-list">
                                <div class="dd-empty"></div>
                            </ol>
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

    $(function(){
        $('#start_end_date').daterangepicker(null, function(start, end, label) {
            console.log(start.toISOString(), end.toISOString(), label);
        });

        $('.dd').nestable();
    })
</script>
</body>
</html>