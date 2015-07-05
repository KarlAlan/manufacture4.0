<%@ page import="com.rcstc.manufacture.Project" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
        <link rel="stylesheet" href="${createLink(uri:'/css/jquery.fileupload.css')}">
        <link rel="stylesheet" href="${createLink(uri:'/css/jquery.fileupload-ui.css')}">
        <script src="${createLink(uri:'/js/vendor/jquery.ui.widget.js')}"></script>
        <script src="${createLink(uri:'/js/jquery.iframe-transport.js')}"></script>
        <script src="${createLink(uri:'/js/jquery.fileupload.js')}"></script>
	</head>
	<body>
    <ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
        <li role="presentation" class="active">
            <a href="#">
                <g:message code="project.edit" args="[entityName]" />
            </a>
        </li>
        <li role="presentation">
            <g:link class="list" action="index">
                <g:message code="project.list" args="[entityName]" />
            </g:link>
        </li>
        <li role="presentation">
            <g:link class="create" action="create">
                <g:message code="project.create" args="[entityName]" />
            </g:link>
        </li>
    </ul>
		<div id="edit-project" class="content scaffold-edit" role="main">
            <!--
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			-->
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${projectInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${projectInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
            <div class="row">
                <div class="col-md-6" style="padding: 10px">
                    <g:form url="[resource:projectInstance, action:'update']"  method="PUT" role="form" class="form-horizontal">
                        <g:hiddenField name="version" value="${projectInstance?.version}" />
                        <g:render template="form"/>
                        <div class="col-sm-offset-2 col-sm-10">
                            <g:actionSubmit action="update" class="btn btn-success" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                        </div>
                    </g:form>
                </div>
                <div class="col-md-6" style="padding: 10px">
                    <div style="padding: 10px">
                        <div class="row fileupload-buttonbar" >
                            <div>

                                <span class="btn btn-success fileinput-button">
                                    <i class="icon-plus icon-white"></i>
                                    <span>${message(code: 'fileupload.add.files', default: '上传文件')}</span>
                                    <input id="fileupload" type="file" name="files[]" multiple>
                                </span>

                                <!--
                                <button type="button" class="btn btn-danger delete">
                                    <i class="icon-trash icon-white"></i>
                                    <span>${message(code: 'fileupload.delete', default: '删除')}</span>
                                </button>
                                -->
                            </div>
                            <!-- The global progress bar -->
                            <div class="progress" style="width: 300px;margin-bottom: 5px;display: none">
                                <div class="progress-bar progress-bar-success progress-bar-striped active"  role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
                                </div>
                            </div>
                            <!-- file -->
                            <div class="list-group" style="width: 300px">
                            </div>
                        </div>
                    </div>

                    <!-- #section:pages/timeline -->
                    <div class="timeline-container">
                        <div class="timeline-label">
                            <!-- #section:pages/timeline.label -->
                            <span class="label label-primary arrowed-in-right label-lg">
                                <b>项目进度跟踪</b>
                            </span>

                            <!-- /section:pages/timeline.label -->
                        </div>

                        <div class="timeline-items">
                            <g:each in="${ops}" var="op" status="i">
                                <!-- #section:pages/timeline.item -->
                                <div class="timeline-item clearfix">
                                    <!-- #section:pages/timeline.info -->
                                    <div class="timeline-info">
                                        <img src="${createLink(controller: 'person', action: 'avatar', params: [username: op.username])}" alt="${op.person}'s avatar" />
                                        <span class="label label-info label-sm"><prettytime:display date="${op.operateDate}" /></span>
                                    </div>

                                    <!-- /section:pages/timeline.info -->
                                    <div class="widget-box transparent">
                                        <div class="widget-header widget-header-small">
                                            <h5 class="widget-title smaller">
                                                <a href="#" class="blue">${op.person}</a>
                                                <span class="grey">${op.operation}</span>
                                            </h5>

                                            <span class="widget-toolbar no-border">
                                                <i class="ace-icon fa fa-clock-o bigger-110"></i>
                                                ${op.operateDate.format("yy-MM-dd HH:MM")}
                                            </span>

                                            <span class="widget-toolbar">

                                                <a href="#" data-action="collapse">
                                                    <i class="ace-icon fa fa-chevron-up"></i>
                                                </a>
                                            </span>
                                        </div>

                                        <div class="widget-body">
                                            <div class="widget-main">
                                                ${op.description}
                                            </div>
                                        </div>
                                    </div>
                                </div>


                            </g:each>

                        <!-- /section:pages/timeline.item -->

                        </div><!-- /.timeline-items -->
                    </div><!-- /.timeline-container -->

                    <g:form url="[resource:projectInstance, action:'addProjectEvent']"  method="PUT" role="form" class="form-horizontal">
                        <div class="form-group">
                            <label for="operation" class="col-sm-3 control-label"><g:message code="operationRecord.event" default="Event" /></label>
                            <div class="col-sm-9">
                                <g:textField name="operation" cols="40" rows="5" maxlength="2000" required="" value="" class="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="opdescription" class="col-sm-3 control-label"><g:message code="operationRecord.description" default="Description" /></label>
                            <div class="col-sm-9">
                                <g:textArea name="opdescription" cols="40" rows="5" maxlength="2000" required="" value="" class="form-control"/>
                            </div>
                        </div>

                        <div class="col-sm-offset-3 col-sm-9">
                            <g:actionSubmit class="btn btn-primary" action="addProjectEvent" value="${message(code: 'default.button.submit.label', default: 'Sumbit')}" />
                        </div>
                    </g:form>
                </div>
            </div>
		</div>

    <script type="text/javascript">
        var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
        basepath= basepath.substring(0,basepath.indexOf('/')) ;


        var listProjectFile = function(){
            $.ajax({
                url : '/'+basepath+'/file/upload?objectType=Project&objectId='+${projectInstance.id},
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
            //文件上传地址
            var url = '/'+basepath+'/file/upload';
            //初始化，主要是设置上传参数，以及事件处理方法(回调函数)
            $('#fileupload').fileupload({
                dataType: 'json',
                autoUpload: true,//是否自动上传
                url: url,//上传地址
                submit: function(e,data){
                    data.formData = {objectType: "Project",objectId:${projectInstance.id}};
                },
                done: function (e, data) {//设置文件上传完毕事件的回调函数
                    $.each(data.result, function (index, file) {
                        var li = $('<div class="list-group-item"></div>');
                        $('<img style="float: left"/>').attr('src',file.thumbnail_url).appendTo(li);
                        $('<i class="glyphicon glyphicon-trash file_delete" style="float: right;font-size: 20px; color: red;margin-top:10px"/>').attr('durl',file.delete_url).appendTo(li);
                        $('<a style="font:16px bold;margin-left:10px"/>').attr('href',file.url).text(file.name).appendTo(li);
                        $('<div style="font:16px;margin-left:60px "/>').text(file.size+"字节").appendTo(li);

                        li.appendTo($('.list-group'));
                    });
                    $('.progress').hide();
                },
                progressall: function (e, data) {//设置上传进度事件的回调函数
                    $('.progress').show();
                    var progress = parseInt(data.loaded / data.total * 100, 10);
                    $('.progress-bar').css(
                            'width',
                            progress + '%'
                    );
                }

            });

            $( document ).on( "click", ".file_delete", function() {
                var fd = $(this);
                $.ajax({
                    url : fd.attr('durl'),
                    type : 'GET',
                    dataType : 'json',
                    data : {
                    },
                    timeout : 10000,
                    error : function(e){
                        alert("操作失败")
                    },
                    success : function(json) {
                        fd.parents('.list-group-item').remove();
                    }
                });
            });

            listProjectFile();
        })
    </script>
	</body>
</html>
