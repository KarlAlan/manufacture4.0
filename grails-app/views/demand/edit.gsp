<%@ page import="com.rcstc.manufacture.DemandStatus; com.rcstc.manufacture.Demand" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'demand.label', default: 'Demand')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
        <link rel="stylesheet" href="${createLink(uri:'/css/jquery.fileupload.css')}">
        <link rel="stylesheet" href="${createLink(uri:'/css/jquery.fileupload-ui.css')}">
        <script src="${createLink(uri:'/js/vendor/jquery.ui.widget.js')}"></script>
        <script src="${createLink(uri:'/js/jquery.iframe-transport.js')}"></script>
        <script src="${createLink(uri:'/js/jquery.fileupload.js')}"></script>
        <asset:stylesheet src="summernote.css"/>
        <asset:javascript src="summernote.min.js"/>
        <asset:javascript src="summernote-zh-CN.js"/>
        <style>
        .file_delete:hover {
            cursor: pointer;
        }
        .list-group-item {
            min-height: 70px;
        }
        </style>
	</head>
	<body>
    <ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
        <li role="presentation">
            <g:link class="list" action="index">
                <g:message code="demand.list" args="[entityName]" />
            </g:link>
        </li>
        <li role="presentation">
            <g:link class="create" action="create">
                <g:message code="demand.create" args="[entityName]" />
            </g:link>
        </li>
        <li role="presentation" class="active">
            <a href="#" ><g:message code="demand.edit" args="[entityName]" /></a>
        </li>
    </ul>

		<div id="edit-demand" class="content scaffold-edit" role="main">
            <!--
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			-->
			<g:if test="${flash.message}">
                <div class="alert alert-success no-margin">
                    <button type="button" class="close" data-dismiss="alert">
                        <i class="ace-icon fa fa-times"></i>
                    </button>

                    <i class="ace-icon fa fa-umbrella bigger-120 blue"></i>
                    ${flash.message}
                </div>
			</g:if>
			<g:hasErrors bean="${demandInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${demandInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
            <div class="row">
                <div class="col-md-7" style="padding: 10px">
                    <g:form url="[resource:demandInstance, action:'update']"  method="PUT" role="form" class="form-horizontal">
                        <g:hiddenField name="version" value="${demandInstance?.version}" />
                        <g:render template="form1" model="['operation':'edit']"/>
                        <div class="col-sm-offset-2 col-sm-10">
                            <g:if test="${demandInstance.status==DemandStatus.DRAFT||demandInstance.status==DemandStatus.ANALYSE||demandInstance.status==DemandStatus.DESIGN||demandInstance.status==DemandStatus.AUDIT}">
                                <g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" onclick="copycode();"/>
                            </g:if>
                        </div>
                    </g:form>
                </div>
                <div class="col-md-5">
                    <div style="padding: 10px">
                        <div class="row fileupload-buttonbar" >
                            <div>
                                <g:if test="${demandInstance.status==DemandStatus.DRAFT||demandInstance.status==DemandStatus.ANALYSE||demandInstance.status==DemandStatus.DESIGN||demandInstance.status==DemandStatus.AUDIT}">
                                    <span class="btn btn-success fileinput-button">
                                        <i class="icon-plus icon-white"></i>
                                        <span>${message(code: 'fileupload.add.files', default: '上传文件')}</span>
                                        <input id="fileupload" type="file" name="files[]" multiple>
                                    </span>
                                </g:if>
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
                                <b>需求处理跟踪</b>
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

                    <g:form url="[resource:demandInstance, action:'addDemandEvent']"  method="PUT" role="form" class="form-horizontal">
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
                            <g:actionSubmit class="btn btn-primary" action="addDemandEvent" value="${message(code: 'default.button.submit.label', default: 'Sumbit')}" />
                        </div>
                    </g:form>
                </div>
            </div>
		</div>

    <div class="modal fade" id="modal_back_to">
        <div class="modal-dialog">
            <div class="modal-content">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">请填写退回或作废需求的原因</h4>
                </div>
                <div class="modal-body">
                    <g:textArea id="modal_remark" name="modal_remark" cols="40" rows="5" maxlength="2000" value="" class="form-control"/>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button id="make_sure_button" type="button" class="btn btn-primary">确认</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <div class="modal fade" id="modal_evaluate">
        <div class="modal-dialog">
            <div class="modal-content">
                <g:form id="evaluate_form" url="[resource:demandInstance, action:'forwardClose']"  method="PUT" role="form" class="form-horizontal">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">请对我们的服务给予评价：</h4>
                </div>
                <div class="modal-body">
                    <div class="control-group">
                        <label class="control-label bolder blue">服务评价</label>
                        <div class="radio">
                            <label>
                                <input name="evaluate_radio" type="radio" class="ace evaluate_radio_go" checked value="good"/>
                                <span class="lbl">好评</span>
                            </label>
                            <label>
                                <input name="evaluate_radio" type="radio" class="ace evaluate_radio_go" value="normal"/>
                                <span class="lbl">中评</span>
                            </label>
                            <label>
                                <input id="evaluate_radio_bad" name="evaluate_radio" type="radio" class="ace" value="bad"/>
                                <span class="lbl">差评</span>
                            </label>
                        </div>
                    </div>
                    <div id="choice_bad" class="control-group" style="display: none">
                        <label class="control-label bolder blue">差评环节</label>
                        <div class="checkbox">
                            <label>
                                <input name="evaluate_bad_ba" type="checkbox" class="ace" />
                                <span class="lbl">BA分析</span>
                            </label>
                            <label>
                                <input name="evaluate_bad_au" type="checkbox" class="ace" />
                                <span class="lbl">需求审核</span>
                            </label>
                            <label>
                                <input name="evaluate_bad_sa" type="checkbox" class="ace" />
                                <span class="lbl">SA分析</span>
                            </label>
                            <label>
                                <input name="evaluate_bad_dev" type="checkbox" class="ace" />
                                <span class="lbl">开发人</span>
                            </label>
                            <label>
                                <input name="evaluate_bad_sit" type="checkbox" class="ace" />
                                <span class="lbl">SIT人员</span>
                            </label>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label bolder blue">评价说明</label>
                        <g:textArea id="evaluate_desc" name="evaluate_desc" cols="40" rows="5" maxlength="2000" value="" class="form-control"/>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button id="evaluate_button" type="button" class="btn btn-primary">确认</button>
                </div>
                </g:form>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <script type="text/javascript">
        var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
        basepath= basepath.substring(0,basepath.indexOf('/')) ;

        var copycode = function(){
            $('#description').val($('#demand-desc').code());
        }

        var listDemandFile = function(){
            $.ajax({
                url : '/'+basepath+'/file/upload?objectType=Demand&objectId='+${demandInstance.id},
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
                    data.formData = {objectType: "Demand",objectId:${demandInstance.id}};
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

            $('#click_back_to_draft').click(function(){
                $('#make_sure_button').attr('button_id','back_to_draft');
                $('#modal_back_to').modal('show');
            });

            $('#click_back_to_analyse').click(function(){
                $('#make_sure_button').attr('button_id','back_to_analyse');
                $('#modal_back_to').modal('show');
            });

            $('#click_back_to_design').click(function(){
                $('#make_sure_button').attr('button_id','back_to_design');
                $('#modal_back_to').modal('show');
            });

            $('#click_to_suspend').click(function(){
                $('#make_sure_button').attr('button_id','to_suspend');
                $('#modal_back_to').modal('show');
            });

            $('#make_sure_button').click(function(){
                var reson = $('#modal_remark').val();
                if(reson.length<5){
                    alert("原因字数不能少于5个字！");
                    return false;
                }

                $('#remark').val('${(new java.util.Date()).format("yyyy-MM-dd hh:mm")}'+'${person}'+'\n'+reson+'\n'+$('#remark').val());
                $('#modal_back_to').modal('hide');
                var bid = $('#make_sure_button').attr('button_id');
                $('#'+bid).click();
                $('#modal_back_to').modal('hide');
            })


            // evaluate modal
            $('#click_forward_close').click(function(){
                $('#modal_evaluate').modal('show');
            });

            $('#evaluate_radio_bad').click(function(){
                $('#choice_bad').show();
            });

            $('.evaluate_radio_go').click(function(){
                $('#choice_bad').hide();
            });

            $('#evaluate_button').click(function(){
                if($('#evaluate_form input[name="evaluate_radio"]:checked').val()=='bad'){
                    if($('#evaluate_form input[type=checkbox]:checked').length<1){
                        alert("至少选中一个环节！");
                        return false;
                    }
                    var desc = $('#evaluate_desc').val();
                    if(desc.length<5){
                        alert("评价说明字数不能少于5个字！");
                        return false;
                    }
                }
                $('#evaluate_form').submit();
            });

            listDemandFile();
        })
    </script>
	</body>
</html>
