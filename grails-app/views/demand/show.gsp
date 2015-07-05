
<%@ page import="com.rcstc.manufacture.TaskStatus; com.rcstc.manufacture.DemandStatus; com.rcstc.manufacture.DemandType; com.rcstc.manufacture.DemandCharacter; com.rcstc.manufacture.Priority; com.rcstc.manufacture.Demand" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'demand.label', default: 'Demand')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
        <link rel="stylesheet" href="${createLink(uri:'/css/jquery.fileupload.css')}">
        <link rel="stylesheet" href="${createLink(uri:'/css/jquery.fileupload-ui.css')}">
        <script src="${createLink(uri:'/js/vendor/jquery.ui.widget.js')}"></script>
        <script src="${createLink(uri:'/js/jquery.iframe-transport.js')}"></script>
        <script src="${createLink(uri:'/js/jquery.fileupload.js')}"></script>
        <asset:javascript src="jquery.autosize.js"/>
        <asset:javascript src="ace/elements.spinner.js"/>
        <asset:javascript src="fuelux/fuelux.spinner.js"/>
        <asset:stylesheet src="summernote.css"/>
        <asset:javascript src="summernote.min.js"/>
        <asset:javascript src="summernote-zh-CN.js"/>
        <style type="text/css">
        .td_avatar {
            width: 200px;
            vertical-align: top;
            background-color: lavender;
            padding: 10px;
        }
        .blob_content {

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
            <a href="#" ><g:message code="demand.show" args="[entityName]" /></a>
        </li>
    </ul>
    <g:if test="${flash.message}">
        <div class="alert alert-success no-margin">
            <button type="button" class="close" data-dismiss="alert">
                <i class="ace-icon fa fa-times"></i>
            </button>

            <i class="ace-icon fa fa-umbrella bigger-120 blue"></i>
            ${flash.message}
        </div>
    </g:if>
    <div class="row" style="padding: 10px">
    <div class="col-md-9" style="padding: 10px">
    <h3 class="row header smaller lighter blue">
        <span class="col-sm-7">
            <i class="ace-icon fa fa-spinner fa-spin orange bigger-125"></i>
            需求:${demandInstance.title}(${demandInstance.serial})
        </span><!-- /.col -->

        <span class="col-sm-5">
            <label class="pull-right inline">
                <g:if test="${demandInstance.status == DemandStatus.ACCOMPLISHED || demandInstance.status == DemandStatus.CANCELED}">
                    <span class="label label-success" >${demandInstance.status?.name}</span>
                </g:if>
                <g:elseif test="${demandInstance.status == DemandStatus.DRAFT}">
                    <span class="label label-default" >${demandInstance.status?.name}</span>
                </g:elseif>
                <g:elseif test="${demandInstance.status == DemandStatus.AUDIT || demandInstance.status == DemandStatus.UAT}">
                    <span class="label label-warning" >${demandInstance.status?.name}</span>
                </g:elseif>
                <g:elseif test="${demandInstance.status == DemandStatus.ANALYSE || demandInstance.status == DemandStatus.DESIGN}">
                    <span class="label label-info" >${demandInstance.status?.name}</span>
                </g:elseif>
                <g:else>
                    <span class="label label-primary" >${demandInstance.status?.name}</span>
                </g:else>
            </label>
        </span><!-- /.col -->
    </h3>
    <div class="row" style="line-height: 2em">

        <span class="col-sm-2 text-right"><strong>项目名称:</strong></span>
        <span class="col-sm-4">${demandInstance.project?.name}</span>

        <span class="col-sm-2 text-right"><strong>模块/菜单:</strong></span>
        <span class="col-sm-4">${demandInstance.category1}/${demandInstance.category2}</span>

        <span class="col-sm-2 text-right"><strong>需求类型:</strong></span>
        <span class="col-sm-4">
            <span class="label ${demandInstance.type==DemandType.BUG?'label-warning':'label-info'}">${demandInstance.type?.name}</span>
            <span class="label ${demandInstance.demandCharacter==DemandCharacter.FUNCTIONAL||demandInstance.demandCharacter==DemandCharacter.PERFORMANCE?'label-primary':'label-default'}">${demandInstance.demandCharacter?.name}</span>
        </span>
        <span class="col-sm-2 text-right"><strong>优先程度:</strong></span>
        <span class="col-sm-4">
            <g:if test="${demandInstance.priority==Priority.EMERGENCY}">
                <span class="label label-warning">${demandInstance.priority?.name}</span>
            </g:if>
            <g:else>
                <span class="label label-default">${demandInstance.priority?.name}</span>
            </g:else>
            <g:if test="${demandInstance.urgent}">
                <span class="label label-danger">加急处理</span>
            </g:if>
        </span>

        <span class="col-sm-2 text-right"><strong>需求说明:</strong></span>
        <span class="col-sm-10 blob_content">${raw(demandInstance.description)}</span>

        <g:if test="${demandInstance.proposal}">
            <span class="col-sm-2 text-right"><strong>设计方案:</strong></span>
            <span class="col-sm-10 blob_content">${raw(demandInstance.proposal)}</span>
        </g:if>

        <g:if test="${demandInstance.scenario}">
            <span class="col-sm-2 text-right"><strong>测试方案和报告:</strong></span>
            <span class="col-sm-10 blob_content">${raw(demandInstance.scenario)}</span>
        </g:if>

        <g:if test="${demandInstance.remark}">
            <span class="col-sm-2 text-right"><strong>备注:</strong></span>
            <span class="col-sm-10 blob_content">${raw(demandInstance.remark)}</span>
        </g:if>

        <div class="col-sm-12 attch">
            <g:if test="${demandInstance.status!=DemandStatus.ACCOMPLISHED&&demandInstance!=com.rcstc.manufacture.DemandStatus.CANCELED}">
                <span class="btn btn-success btn-minier fileinput-button">
                    <i class="icon-plus icon-white"></i>
                    <span>${message(code: 'fileupload.add.files', default: '上传文件')}</span>
                    <input id="fileupload" type="file" name="files[]" multiple>
                </span>
            </g:if>
            <span class="progress" style="width: 100px;margin-bottom: 5px;display: none">
                <span class="progress-bar progress-bar-success progress-bar-striped active"  role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
                </span>
            </span>
        </div>

        <div class="col-sm-12">

            <g:each in="${tasks}" var="task" status="j">
                <h4 class="row header smaller lighter green">
                    <span class="col-sm-7">
                        <i class="ace-icon fa fa-th-large"></i>
                        开发任务：${task.serial}
                    </span><!-- /.col -->

                    <span class="col-sm-5">
                        <label class="pull-right inline">
                            <g:if test="${task.status == TaskStatus.ACCOMPLISHED}">
                                <span class="label label-success" >${task.status?.name}</span>
                            </g:if>
                            <g:elseif test="${task.status == TaskStatus.ARRANGE}">
                                <span class="label label-default" >${task.status?.name}</span>
                            </g:elseif>
                            <g:elseif test="${task.status == TaskStatus.DEVELOP}">
                                <span class="label label-info" >${task.status?.name}</span>
                            </g:elseif>
                            <g:elseif test="${task.status == TaskStatus.SIT}">
                                <span class="label label-warning" >${task.status?.name}</span>
                            </g:elseif>
                            <g:else>
                                <span class="label label-primary" >${task.status?.name}</span>
                            </g:else>
                        </label>
                    </span><!-- /.col -->
                </h4>

                <div class="row">
                    <span class="col-sm-2 text-right"><strong>开发方案:</strong></span>
                    <span class="col-sm-10 blob_content">${raw(task.proposal)}</span>

                    <g:if test="${task.scenario}">
                        <span class="col-sm-2 text-right"><strong>测试方案:</strong></span>
                        <span class="col-sm-10 blob_content">${raw(task.scenario)}</span>
                    </g:if>
                </div>

            </g:each>
            <g:if test="${demandInstance.status==DemandStatus.DEVELOP}">
                <div class="col-sm-12">
                    <span class="btn btn-success btn-minier create_task_button">
                        <i class="icon-plus icon-white"></i>
                        <span>创建开发任务</span>
                    </span>
                </div>
            </g:if>
        </div>
    </div>

    <div class="hr hr-double hr-dotted hr18"></div>

    <div class="row">
        <g:form action="forwardNextStep"  method="POST" role="form" class="form-horizontal">
            <g:hiddenField name="version" value="${demandInstance?.version}" />
            <input type="hidden" name="demand_id" value="${demandInstance.id}"/>
            <div class="col-md-12" style="padding: 20px">

                <g:if test="${demandInstance.status == com.rcstc.manufacture.DemandStatus.ANALYSE}">
                    <div class="form-group">
                        <label for="category1" class="col-sm-2 control-label"><g:message code="demand.category1" default="Category1" /></label>
                        <div class="col-sm-10">
                            <div class="input-group">
                                <div class="input-group-btn">
                                    <button type="button" class="btn btn-sm dropdown-toggle" data-toggle="dropdown">选择 <span class="caret"></span></button>
                                    <ul class="dropdown-menu" role="menu" id="category1_select">
                                    </ul>
                                </div><!-- /btn-group -->
                                <input type="text" class="form-control" id="category1" name="category1" value="${demandInstance?.category1}" required="">
                            </div><!-- /input-group -->
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="category2" class="col-sm-2 control-label"><g:message code="demand.category2" default="Category2" /></label>
                        <div class="col-sm-10">
                            <div class="input-group">
                                <div class="input-group-btn">
                                    <button type="button" class="btn btn-sm dropdown-toggle" data-toggle="dropdown">选择 <span class="caret"></span></button>
                                    <ul class="dropdown-menu" role="menu" id="category2_select">
                                    </ul>
                                </div><!-- /btn-group -->
                                <input type="text" class="form-control" id="category2" name="category2" value="${demandInstance?.category2}">
                            </div><!-- /input-group -->
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="title" class="col-sm-2 control-label"><g:message code="demand.title" default="Title" /></label>
                        <div class="col-sm-10">
                            <g:textField name="title" value="${demandInstance?.title}" class="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="description" class="col-sm-2 control-label"><g:message code="demand.description" default="Description" /></label>
                        <div class="col-sm-10">
                            <g:textArea name="description" cols="40" rows="5" maxlength="2000" required="" value="${demandInstance?.description}" class="form-control" style="display: none"/>
                            <div class="summernote">${raw(demandInstance?.description)}</div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="planStopDate" class="col-sm-2 control-label"><g:message code="demand.planStopDate" default="Plan End Date" /></label>
                        <div class="col-sm-10">
                            <div class="controls">
                                <div class="input-prepend input-group">
                                    <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></span>
                                    <input type="text" readonly="readonly" style="width: 160px" name="planStopDate" id="planStopDate" class="input_date form-control" value="${demandInstance?.planStopDate?:(new Date()+30).format('yyyy-MM-dd')}"/>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="type" class="col-sm-2 control-label"><g:message code="demand.type" default="Type" /></label>
                        <div class="col-sm-10">
                            <g:select id="type" name="type" from="${DemandType?.values()*.name}" keys="${DemandType.values()*.name()}" value="${demandInstance?.type?:DemandType.NEW_FUNCTION}" class="form-control" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="demandCharacter" class="col-sm-2 control-label"><g:message code="demand.demandCharacter" default="Type" /></label>
                        <div class="col-sm-10">
                            <g:select id="demandCharacter" name="demandCharacter" from="${DemandCharacter?.values()*.name}" keys="${DemandCharacter.values()*.name()}" value="${demandInstance?.demandCharacter?:DemandCharacter.FUNCTIONAL}" class="form-control" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="priority" class="col-sm-2 control-label"><g:message code="demand.priority" default="Priority" /></label>
                        <div class="col-sm-10">
                            <g:select id="priority" name="priority" from="${Priority?.values()*.name}" keys="${Priority.values()*.name()}" value="${demandInstance?.priority?:Priority.NORMAL}" class="form-control" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="urgent" class="col-sm-2 control-label"><g:message code="demand.urgent" default="Urgent" /></label>
                        <div class="col-sm-10">
                            <g:checkBox name="urgent" value="${demandInstance?.urgent}" class="form-control"></g:checkBox>
                        </div>
                    </div>
                </g:if>

                <g:if test="${demandInstance.status == DemandStatus.DESIGN}">
                    <div class="form-group">
                        <label for="proposal" class="col-sm-2 control-label"><g:message code="demand.proposal" default="Proposal" /></label>
                        <div class="col-sm-10">
                            <g:textArea name="proposal" cols="40" rows="5" maxlength="2000" value="${demandInstance?.proposal}" class="form-control" style="display: none"/>
                            <div class="summernote">${raw(demandInstance?.proposal)}</div>
                        </div>
                    </div>
                </g:if>

                <g:if test="${demandInstance.status == DemandStatus.DESIGN||demandInstance.status == DemandStatus.SIT}">
                    <div class="form-group">
                        <label for="scenario" class="col-sm-2 control-label"><g:message code="demand.scenario" default="Scenario" /></label>
                        <div class="col-sm-10">
                            <g:textArea name="scenario" cols="40" rows="5" maxlength="2000" value="${demandInstance?.scenario}" class="form-control" style="display: none"/>
                            <div class="summernote">${raw(demandInstance?.scenario)}</div>
                        </div>
                    </div>
                </g:if>

                <g:if test="${demandInstance.status == DemandStatus.SIT}">
                    <div class="form-group">
                        <label for="instructions" class="col-sm-2 control-label"><g:message code="demand.instructions" default="Instructions" /></label>
                        <div class="col-sm-10">
                            <g:textArea name="instructions" cols="40" rows="5" maxlength="2000" value="${demandInstance?.instructions}" class="form-control" style="display: none"/>
                            <div class="summernote">${raw(demandInstance?.instructions)}</div>
                        </div>
                    </div>
                </g:if>

                <g:if test="${demandInstance.status == DemandStatus.ANALYSE||demandInstance.status == DemandStatus.DESIGN||demandInstance.status == DemandStatus.SIT}">
                    <hr/>
                    <div class="form-group">
                        <label for="work_hour" class="col-sm-2 control-label"><g:message code="demand.workHour" default="Work Hour" /></label>
                        <div class="col-sm-10">
                            <input type="number" name="work_hour" id="work_hour" value="1" class="form-control"/>
                        </div>
                    </div>
                </g:if>

                <div class="col-sm-offset-2 col-sm-10">
                    <g:if test="${demandInstance.status==DemandStatus.DRAFT||demandInstance.status==DemandStatus.ANALYSE||demandInstance.status==DemandStatus.DESIGN||demandInstance.status==DemandStatus.AUDIT}">
                        <input type="button" id="click_to_postpone" class="btn btn-warning" value="暂缓" />
                        <input type="button" id="click_to_suspend" class="btn btn-danger" value="作废" />
                    </g:if>
                    <g:if test="${demandInstance.status==DemandStatus.DRAFT}">
                        <g:link class="btn btn-info" action="edit" resource="${demandInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                        <g:actionSubmit value="生效" class="btn btn-success" action="forwardNextStep"></g:actionSubmit>
                    </g:if>
                    <g:if test="${demandInstance.status==DemandStatus.ANALYSE}">
                        <input type="button" id="click_back_to_draft" class="btn btn-warning click_back_to" value="退回草稿" />
                        <g:actionSubmit class="btn btn-success" action="forwardNextStep" value="提交系统设计" onclick="copycode();"/>
                    </g:if>
                    <g:if test="${demandInstance.status==DemandStatus.DESIGN}">
                        <input type="button" id="click_back_to_analyse" class="btn btn-warning click_back_to" value="退回BA分析" />
                        <g:actionSubmit class="btn btn-success" action="forwardNextStep" value="提交审核确认" onclick="copycode();"/>
                    </g:if>
                    <g:if test="${demandInstance.status==DemandStatus.AUDIT}">
                        <input type="button" id="click_back_to_design" class="btn btn-warning click_back_to" value="退回SA分析" />
                        <g:actionSubmit class="btn btn-success" action="forwardNextStep" value="确认需求及解决方案" />
                    </g:if>
                    <g:if test="${demandInstance.status==DemandStatus.DEVELOP||demandInstance.status==DemandStatus.ANALYSE||demandInstance.status==DemandStatus.DESIGN||demandInstance.status==DemandStatus.AUDIT||demandInstance.status==DemandStatus.SIT}">
                        <input type="button" id="click_to_finish" class="btn btn-warning" value="直接完成" />
                    </g:if>
                    <g:if test="${demandInstance.status==DemandStatus.SIT}">
                        <g:actionSubmit class="btn btn-success" action="forwardNextStep" value="SIT通过，提交UAT" onclick="copycode();"/>
                        <input type="button" id="click_back_to_develop" class="btn btn-warning click_back_to" value="SIT不通过" />
                    </g:if>
                    <g:if test="${demandInstance.status==DemandStatus.UAT}">
                        <input type="button" id="click_forward_close" class="btn btn-success" value="UAT验证通过" />
                        <input type="button" id="click_back_to_design" class="btn btn-warning click_back_to" value="UAT验证不通过" />
                    </g:if>
                </div>

            </div>
        </g:form>



    </div>

    <div class="hr hr-double hr-dotted hr18"></div>

    <div class="widget-box transparent" id="recent-box">
        <div class="widget-header">
            <h4 class="widget-title lighter smaller">
                <i class="ace-icon fa fa-rss orange"></i>RECENT
            </h4>

            <div class="widget-toolbar no-border">
                <ul class="nav nav-tabs" id="recent-tab">
                    <li class="active">
                        <a data-toggle="tab" href="#operation-tab">操作记录</a>
                    </li>

                    <li>
                        <a data-toggle="tab" href="#comment-tab">评论</a>
                    </li>
                </ul>
            </div>
        </div>

        <div class="widget-body">
            <div class="widget-main padding-4">
                <div class="tab-content padding-8">

                    <div id="operation-tab" class="tab-pane active">
                        <!-- #section:pages/dashboard.members -->
                        <div class="clearfix">
                            <div class="comments">
                                <g:each in="${ops}" var="op" status="i">
                                    <div class="itemdiv commentdiv">
                                        <div class="user">
                                            <img alt="${op.person}'s avatar" src="${createLink(controller: 'person', action: 'avatar', params: [username: op.username])}" />
                                        </div>

                                        <div class="body">
                                            <div class="name">
                                                <a href="#">${op.person}</a>
                                            </div>

                                            <div class="time">
                                                <i class="ace-icon fa fa-clock-o"></i>
                                                <span class="green"><g:formatDate date="${op.operateDate}" format="yyyy-MM-dd"></g:formatDate></span>
                                            </div>

                                            <div class="text">
                                                <i class="ace-icon fa fa-quote-left"></i>
                                                ${op.description} &hellip;
                                            </div>
                                        </div>

                                    </div>
                                </g:each>

                            </div>
                        </div>



                        <div class="hr hr-double hr8"></div>

                        <!-- /section:pages/dashboard.members -->
                    </div><!-- /.#member-tab -->

                    <div id="comment-tab" class="tab-pane">
                        <!-- #section:pages/dashboard.comments -->
                        <div class="comments">
                            <g:each in="${ops}" var="op" status="i">
                                <div class="itemdiv commentdiv">
                                    <div class="user">
                                        <img alt="${op.person}'s avatar" src="${createLink(controller: 'person', action: 'avatar', params: [username: op.username])}" />
                                    </div>

                                    <div class="body">
                                        <div class="name">
                                            <a href="#">${op.person}</a>
                                        </div>

                                        <div class="time">
                                            <i class="ace-icon fa fa-clock-o"></i>
                                            <span class="green"><g:formatDate date="${op.operateDate}" format="yyyy-MM-dd"></g:formatDate></span>
                                        </div>

                                        <div class="text">
                                            <i class="ace-icon fa fa-quote-left"></i>
                                            ${op.description} &hellip;
                                        </div>
                                    </div>

                                </div>
                            </g:each>



                        </div>

                        <div class="hr hr8"></div>

                        <div class="center">
                            <i class="ace-icon fa fa-comments-o fa-2x green middle"></i>

                            &nbsp;
                            <a href="#" class="btn btn-sm btn-white btn-info">
                                See all comments &nbsp;
                                <i class="ace-icon fa fa-arrow-right"></i>
                            </a>
                        </div>

                        <div class="hr hr-double hr8"></div>

                        <!-- /section:pages/dashboard.comments -->
                    </div>
                </div>
            </div><!-- /.widget-main -->
        </div><!-- /.widget-body -->
    </div><!-- /.widget-box -->

    </div>
        <div class="col-md-3">
            <div style="border-radius: 5px;border: 1px darkblue dotted;padding: 15px;margin-top: 30px">
                <div>提出人：${demandInstance.submitPeople}</div>
                <div>提出日期：<g:formatDate date="${demandInstance.planStartDate}" format="yyyy-MM-dd"></g:formatDate> </div>
                <div>交付日期：<g:formatDate date="${demandInstance.planStopDate}" format="yyyy-MM-dd"></g:formatDate> </div>
                <g:if test="${demandInstance.baFinishDate}">
                    <div>分析日期：<g:formatDate date="${demandInstance.baFinishDate}" format="yyyy-MM-dd"></g:formatDate> </div>
                </g:if>
                <g:if test="${demandInstance.siFinishDate}">
                    <div>设计日期：<g:formatDate date="${demandInstance.siFinishDate}" format="yyyy-MM-dd"></g:formatDate> </div>
                </g:if>
                <g:if test="${demandInstance.deFinishDate}">
                    <div>开发日期：<g:formatDate date="${demandInstance.deFinishDate}" format="yyyy-MM-dd"></g:formatDate> </div>
                </g:if>
                <g:if test="${demandInstance.siFinishDate}">
                    <div>SIT日期：<g:formatDate date="${demandInstance.siFinishDate}" format="yyyy-MM-dd"></g:formatDate> </div>
                </g:if>
            </div>

        </div>
    </div>

    <div class="modal fade" id="modal_back_to">
        <div class="modal-dialog">
            <g:form action="backwardPrevStep"  method="POST" role="form" class="form-horizontal">
                <input type="hidden" id="operation_type" name="operation_type"/>
                <input type="hidden" name="demand_id" value="${demandInstance.id}"/>
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title">请填写直接完成、暂缓、退回或作废需求的原因</h4>
                    </div>
                    <div class="modal-body">
                        <g:textArea id="operation_reason" name="operation_reason" cols="40" rows="5" maxlength="2000" value="" class="form-control"/>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button id="make_sure_button" type="button" class="btn btn-primary">确认</button>
                    </div>
                </div><!-- /.modal-content -->
            </g:form>
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

    <!--Create Task for Demand Modal -->
    <div class="modal fade bs-example-modal-lg" id="taskModal" tabindex="-1" role="dialog" aria-labelledby="taskModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="taskModalLabel">新建任务</h4>
                </div>
                <g:form url="[resource:demandInstance, action:'buildTask4Demand']"  method="PUT" role="form" class="form-horizontal">
                    <g:hiddenField name="version" value="${demandInstance?.version}" />

                    <div class="modal-body" id="task-modal">

                        <div class="form-group">
                            <label class="col-sm-2 control-label">需求描述</label>
                            <div class="col-sm-10">
                                <pre id="re_desc">${raw(demandInstance.description)}</pre>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="task_title" class="col-sm-2 control-label">标题</label>
                            <div class="col-sm-10">
                                <g:textField id="task_title" name="task_title" class="form-control" value="${demandInstance.title}" ></g:textField>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="task_proposal" class="col-sm-2 control-label">解决方案</label>
                            <div class="col-sm-10">
                                <g:textArea id="task_proposal" name="task_proposal" class="autosize-transition form-control" style="display: none"></g:textArea>
                                <div class="summernote">${raw(demandInstance.proposal)}</div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="task_scenario" class="col-sm-2 control-label">测试方案</label>
                            <div class="col-sm-10">
                                <g:textArea id="task_scenario" name="task_scenario" class="autosize-transition form-control" style="display: none"></g:textArea>
                                <div class="summernote">${raw(demandInstance.scenario)}</div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">预计时长</label>
                            <div class="col-sm-10">
                                <input type="text" class="input-mini" name="planHour" id="planHour"/>
                            </div>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <!--
                        <g:actionSubmit class="btn btn-primary" value="确认">确认</g:actionSubmit>
                    -->
                        <input type="submit" class="btn btn-primary" value="确认" onclick="copycode();">
                    </div>
                </g:form>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
        basepath= basepath.substring(0,basepath.indexOf('/')) ;

        var copycode = function(){
            $('.summernote').each(function(){
                var su = $(this);
                var te = su.prev();

                te.val(su.code());
            })
        }

        var initCategory = function(){
            var pid = ${demandInstance.project.id};
            $("#category1_select").empty();
            $("#category2_select").empty();
            if(pid&&pid!="null"){
                $.ajax({
                    url : '/'+basepath+'/informationSystem/ajaxGetCategory1ByProject',
                    type : 'POST',
                    dataType : 'json',
                    data : {
                        pid : pid
                    },
                    timeout : 10000,
                    error : function(e){
                        console.log("操作失败");
                    },
                    success : function(json) {
                        $(json).each(function(){
                            var moudle = this;
                            $("#category1_select").append("<li ><a mid="+moudle[0]+">"+moudle[1]+"</a></li>");
                        })
                    }
                });
            };
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
                        var li = $('<span style="border: 1px solid #808080;border-radius: 2px;padding: 2px;margin: 2px" class="d_file"></span>');
                        $('<img height="16px" width="16px" style="margin-top: -3px"/>').attr('src',file.thumbnail_url).appendTo(li);

                        $('<a target="_Blank" style="bold;margin-left:3px"/>').attr('href',file.url).text(file.name).appendTo(li);
                        $('<span style="margin-left:3px;font-size: 0.6em;color: #808080 "/>').text(file.size+"字节").appendTo(li);
                        $('<i class="glyphicon glyphicon-trash file_delete" style="color: red"/>').attr('durl',file.delete_url).appendTo(li);

                        li.appendTo($('.attch'));
                    })

                }
            });
        }

        $(document).ready(function() {
            $('.input_date').daterangepicker({
                singleDatePicker: true,
                format: 'YYYY-MM-DD',
                startDate: '<g:formatDate format="yyyy-MM-dd" date="${new Date()}"/>'
            }, function(start, end, label) {
                console.log(start.toISOString(), end.toISOString(), label);
            });

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
                        var li = $('<span style="border: 1px solid #808080;border-radius: 2px;padding: 2px;margin: 2px" class="d_file"></span>');
                        $('<img height="16px" width="16px" style="margin-top: -3px"/>').attr('src',file.thumbnail_url).appendTo(li);

                        $('<a target="_Blank" style="bold;margin-left:3px"/>').attr('href',file.url).text(file.name).appendTo(li);
                        $('<span style="margin-left:3px;font-size: 0.6em;color: #808080 "/>').text(file.size+"字节").appendTo(li);
                        $('<i class="glyphicon glyphicon-trash file_delete" style="color: red"/>').attr('durl',file.delete_url).appendTo(li);

                        li.appendTo($('.attch'));
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
                        fd.parents('.d_file').remove();
                    }
                });
            });

            $('.click_back_to').click(function(){
                $('#operation_type').val('back');
                $('#modal_back_to').modal('show');
            });

            $('#click_to_suspend').click(function(){
                $('#operation_type').val('suspend');
                $('#modal_back_to').modal('show');
            });

            $('#click_to_finish').click(function(){
                $('#operation_type').val('finish');
                $('#modal_back_to').modal('show');
            });

            $('#click_to_postpone').click(function(){
                $('#operation_type').val('postpone');
                $('#modal_back_to').modal('show');
            });

            $('#make_sure_button').click(function(){
                var reason = $('#operation_reason').val();
                if(reason.length<5){
                    alert("原因字数不能少于5个字！");
                    return false;
                }

                $('#make_sure_button').parents('form').submit();
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

            $( document ).on( "click","#category1_select li a", function() {
                var cla1 = $(this);
                $("#category1").val(cla1.text());
                $("#category2_select").empty();
                $.ajax({
                    url : '/'+basepath+'/informationSystem/ajaxGetCategory2',
                    type : 'POST',
                    dataType : 'json',
                    data : {
                        mid : cla1.attr("mid")
                    },
                    timeout : 10000,
                    error : function(e){
                        console.log("操作失败")
                    },
                    success : function(json) {
                        $(json).each(function(){
                            var moudle = this;
                            $("#category2_select").append("<li><a >"+moudle[1]+"</a></li>");
                        })
                    }
                });
            });

            $( document ).on( "click","#category2_select li a", function() {
                var cla2 = $(this);
                $("#category2").val(cla2.text());
            });

            initCategory();

            $('textarea[class*=autosize]').autosize({append: "\n"});
            // open new task model
            $( document).on("click",".create_task_button", function(){
                $('#task_proposal').val("");
                $('#task_scenario').val("");
                $('#planHour').val("0");
                $('#taskModal').modal('toggle');
            })

            $('#planHour').ace_spinner({value:0,min:0,max:40,step:1, btn_up_class:'btn-info' , btn_down_class:'btn-info'})
                    .closest('.ace-spinner')
                    .on('changed.fu.spinbox', function(){
                        //alert($('#planHour').val())
                    });

            $('.summernote').summernote({
                height: 200,
                lang: 'zh-CN',
                focus: false,
                onImageUpload: function(files){
                    //sendFile(files[0], editor, welEditable);
                    var url = '/'+basepath+'/file/upload';
                    var $note = $(this);

                    data = new FormData();
                    data.append("file", files[0]);

                    $.ajax({
                        data: data,
                        type: "POST",
                        url: url,
                        cache: false,
                        contentType: false,
                        processData: false,
                        success: function(data) {
                            //alert("上传成功,请等待加载");
                            $.each(data, function (index, img) {
                                // use summernote api
                                $note.summernote('insertImage', location.protocol+"//"+location.host+img.url);
                            });

                            setTimeout(function(){
                                //$(".note-alarm").remove();
                            },3000);
                        },
                        error:function(){
                            alert("上传失败");
                            setTimeout(function(){
                                //$(".note-alarm").remove();
                            },3000);
                        }
                    });
                }
            });
        })
    </script>
	</body>
</html>
