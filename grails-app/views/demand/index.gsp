
<%@ page import="com.rcstc.manufacture.TaskType; com.rcstc.manufacture.DemandCharacter; com.rcstc.manufacture.Priority; com.rcstc.manufacture.DemandStatus; com.rcstc.manufacture.TaskStatus; com.rcstc.manufacture.DemandType; com.rcstc.manufacture.Demand" %>

<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName"
           value="${message(code: 'demand.label', default: 'Demand')}" />
    <title><g:message code="demand.list" args="[entityName]" /></title>
    <asset:javascript src="ace/elements.spinner.js"/>
    <asset:javascript src="fuelux/fuelux.spinner.js"/>
    <asset:javascript src="jquery.autosize.js"/>
    <asset:javascript src="bootstrap-multiselect.js"/>
    <asset:stylesheet src="bootstrap-multiselect.css"/>
    <style type="text/css">

    th, td {
        white-space: nowrap;
    }
    .form-group {
        margin: 5px;
    }
    .glyphicon {
        cursor: pointer;
    }
    </style>
</head>
<body>
<ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
    <li role="presentation" class="active">
        <g:link class="list" action="index">
            <g:message code="demand.list" args="[entityName]" />
        </g:link>
    </li>
    <li role="presentation">
        <g:link class="create" action="create">
            <g:message code="demand.create" args="[entityName]" />
        </g:link>
    </li>
    <li role="presentation">
        <g:link class="create" action="demandImport">
            需求导入
        </g:link>
    </li>
</ul>

<g:if test="${flash.message}">
    <div class="message" role="status">
        ${flash.message}
    </div>
</g:if>

<div title="查询条件" style="margin: 10px">
    <g:form action="index" method="post" class="form-inline" role="form">
        <div class="form-group">
            <label>项目名称：</label>
            <g:select name="pid" from="${pl}"  optionKey="id" value="${params.pid}" noSelection="['-1':'-所有-']" class="form-control"/>
        </div>
        <div class="form-group">
            <label>需求序号：</label>
            <input value="${params.demand_serial}" id="demand_serial" name="demand_serial" type="text" class="form-control" placeholder="需求序号" style="width: 100px">
        </div>
        <div class="form-group">
            <label>模块：</label>
            <input value="${params.demand_category1}" id="demand_category1" name="demand_category1" type="text" class="form-control" placeholder="模块名" style="width: 100px">
        </div>
        <div class="form-group">
            <label>菜单：</label>
            <input value="${params.demand_category2}" id="demand_category2" name="demand_category2" type="text" class="form-control" placeholder="菜单名" style="width: 100px">
        </div>
        <div class="form-group">
            <label>需求描述：</label>
            <input value="${params.demand_description}" id="demand_description" name="demand_description" type="text" class="form-control" placeholder="需求描述">
        </div>
        <div class="form-group">
            <div class="controls">
                <div class="input-prepend input-group">
                    <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></span>
                    <div class="input-group-btn">
                        <button type="button" class="btn btn-white btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false" ><span id="pd_name">要求完成日期</span> <span class="caret"></span></button>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="#" class="condition_demand_date" pn="planStartDate">提出日期</a></li>
                            <li><a href="#" class="condition_demand_date" pn="planStopDate">要求完成日期</a></li>
                            <li class="divider"></li>
                            <li><a href="#" class="condition_demand_date" pn="updateDate">需求生效日期</a></li>
                            <li><a href="#" class="condition_demand_date" pn="baFinishDate">BA分析完成日期</a></li>
                            <li><a href="#" class="condition_demand_date" pn="saFinishDate">SA设计完成日期</a></li>
                            <li><a href="#" class="condition_demand_date" pn="planDeliveryDate">计划交付日期</a></li>
                            <li><a href="#" class="condition_demand_date" pn="deFinishDate">开发完成日期</a></li>
                            <li><a href="#" class="condition_demand_date" pn="siFinishDate">SIT完成日期</a></li>
                            <li class="divider"></li>
                            <li><a href="#" class="condition_demand_date" pn="uaFinishDate">UAT完成日期</a></li>
                            <li><a href="#" class="condition_demand_date" pn="deployDate">发布生产环境日期</a></li>
                            <li><a href="#" class="condition_demand_date" pn="closeDate">关闭日期</a></li>
                        </ul>
                    </div><!-- /btn-group -->
                    <input type="text" readonly="readonly" style="width: 200px" name="demand_date" id="demand_date" class="form-control" value="${params.demand_date}"/>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label>状态：</label>
            <g:select name="demand_status" from="${DemandStatus?.values().name}" keys="${DemandStatus.values()*.id}" optionKey="id"
                      id="demand_status"  class="multiselect" multiple=""/>
        </div>
        <div class="form-group">
            <label>需求类型：</label>
            <g:select name="demand_type" from="${DemandType?.values().name}" keys="${DemandType.values()*.id}" optionKey="id"
                      value="${params.demand_type?:-1}" noSelection="['-1':'-所有-']" class="form-control"/>
        </div>
        <div class="form-group">
            <label>需求特性：</label>
            <g:select name="demand_character" from="${DemandCharacter?.values().name}" keys="${DemandCharacter.values()*.id}" optionKey="id"
                      value="${params.demand_character?:-1}" noSelection="['-1':'-所有-']" class="form-control"/>
        </div>
        <div class="form-group">
            <label>优先级：</label>
            <g:select name="demand_priority" from="${Priority?.values().name}" keys="${Priority.values()*.id}" optionKey="id"
                      value="${params.demand_priority?:-1}" noSelection="['-1':'-所有-']" class="form-control"/>
        </div>
        <div class="form-group">
            <label>提出人：</label>
            <input value="${params.sumb_people}" id="sumb_people" name="sumb_people" type="text" class="form-control" placeholder="提出人"  style="width: 100px" autocomplete="off">
        </div>
        <input type="hidden" name="demand_date_type" value="${params.demand_date_type?:'planStopDate'}">
        <div class="form-group">
            <button type="submit" class="btn btn-info btn-sm">查询</button>
            <button id="reset_button" type="reset" class="btn btn-warning btn-sm">重置</button>
        </div>

    </g:form>
</div>

<div id="list-task" class="content scaffold-list" role="main" style="overflow-x: scroll">

    <table class="table table-bordered  table-hover">
        <thead>
        <tr>
            <th></th>
            <th></th>
            <th></th>
            <th>状态</th>
            <g:sortableColumn property="serial"  titleKey="demand.serial" />
            <th>项目名称</th>

            <g:sortableColumn property="category1"  title="业务模块" />
            <g:sortableColumn property="category2" title="系统菜单" />
            <th>类型</th>
            <th>特性</th>

            <th>标题</th>
            <g:sortableColumn property="planStartDate" title="提出日期" />
            <g:sortableColumn property="planStopDate" title="要求完成日期" />
            <th>超期</th>
            <g:sortableColumn property="updateDate" title="需求生效日期" />
            <g:sortableColumn property="baFinishDate" title="BA分析完成日期" />
            <g:sortableColumn property="saFinishDate" title="SA设计完成日期" />
            <th>计划交付日期</th>
            <th>开发完成日期</th>
            <th>SIT完成日期</th>
            <th>UAT完成日期</th>
            <th>发布生产环境日期</th>
            <th>关闭日期</th>
            <g:sortableColumn property="submitPeople" title="提出人" />
            <th>评价</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${demandInstanceList}" status="i" var="demandInstance">
            <tr>
                <td>
                    <g:if test="${demandInstance.backward==true}">
                        <i class="icon-reply demand_backward" sid='${demandInstance.id }' style="color: SteelBlue;font-size: 0.8em" data-container="body" data-toggle="popover" title="${demandInstance.serial }" data-content="${demandInstance.remark }"></i>
                    </g:if>
                    <g:else>
                        ${(params.offset ? params.int('offset') : 0)+i+1}
                    </g:else>
                </td>
                <td>
                    <g:if test="${demandInstance.status!=DemandStatus.DRAFT}">
                        <i class="glyphicon glyphicon-plus" style="color: darkgreen" did="${demandInstance.id }"></i>
                    </g:if>
                </td>
                <td>
                    <g:if test="${demandInstance.priority==Priority.EMERGENCY}">
                        <i class="ace-icon fa icon-warning-sign bigger-120" style="color: red"></i>
                    </g:if>
                    <g:elseif test="${demandInstance.priority==Priority.NORMAL}">
                        <i class="ace-icon fa icon-info-sign bigger-120" style="color: green"></i>
                    </g:elseif>
                    <g:else>
                        <i class="ace-icon fa icon-exclamation-sign bigger-120" style="color: darkgreen"></i>
                    </g:else>
                </td>
                <td class="demand_status" nextable="${(demandInstance.status==DemandStatus.DRAFT||demandInstance.status==DemandStatus.ANALYSE||demandInstance.status==DemandStatus.AUDIT)?'Y':'N'}" did="${demandInstance.id }">
                    <span class="label label-primary" >${demandInstance.status?.name}</span>
                </td>
                <td id="tid" class="bianhao" bh="${demandInstance.id }">
                    <g:link action="show" id="${demandInstance.id }">
                        ${fieldValue(bean: demandInstance, field: "serial")}
                    </g:link>
                </td>
                <td style="white-space:nowrap;">${demandInstance.project?.name}</td>
                <td style="white-space:nowrap;">
                    ${fieldValue(bean: demandInstance, field: "category1")}
                </td>
                <td style="white-space:nowrap;">
                    ${fieldValue(bean: demandInstance, field: "category2")}
                </td>
                <td style="white-space:nowrap;">
                    <span class="label ${demandInstance.type==DemandType.BUG?'label-warning':'label-info'}">${demandInstance.type?.name}</span>
                </td>
                <td style="white-space:nowrap;">
                    <span class="label ${demandInstance.demandCharacter==DemandCharacter.FUNCTIONAL||demandInstance.demandCharacter==DemandCharacter.PERFORMANCE?'label-primary':'label-default'}">${demandInstance.demandCharacter?.name}</span>
                </td>

                <td class="requirement_description" updateable="${demandInstance.status==DemandStatus.DRAFT?'Y':'N'}" demand_id="${demandInstance.id }">
                    <div class="demand_desc" style="width:300px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" data-container="body" data-toggle="popover" title="${demandInstance.serial }" data-content="${demandInstance.description }">${demandInstance.title}</div>
                </td>

                <td>
                    ${demandInstance.planStartDate?.format("yy-MM-dd")}
                </td>
                <td style="color: ${demandInstance.planStopDate>new Date()?'orange':'darkblue'}" >
                    <!--
                    <prettytime:display date="${demandInstance.planStopDate}" />
                    -->
                    ${demandInstance.planStopDate?.format("yy-MM-dd")}
                </td>
                <td>
                    <g:if test="${demandInstance.status==DemandStatus.ACCOMPLISHED}">
                        <span class="label label-default">${(demandInstance.closeDate?:new Date())-(demandInstance.planStopDate?:new Date())}</span>
                    </g:if>
                    <g:else>
                        <span class="label ${(new Date()-(demandInstance.planStopDate?:new Date())>0)?'label-danger':'label-success'}">${new Date()-(demandInstance.planStopDate?:new Date())}</span>
                    </g:else>
                <!--
                    <span class="label label-warning">${demandInstance.planStopDate && demandInstance.closeDate?demandInstance.closeDate-demandInstance.planStopDate:(demandInstance.planStopDate?new Date()-demandInstance.planStopDate:'') }</span>
                    -->
                </td>
                <td>
                    ${demandInstance.updateDate?.format("yy-MM-dd")}
                </td>
                <td>
                    ${demandInstance.baFinishDate?.format("yy-MM-dd")}
                </td>
                <td>
                    ${demandInstance.saFinishDate?.format("yy-MM-dd")}
                </td>
                <td style="color: ${demandInstance.planDeliveryDate>demandInstance.planStopDate?'orange':'darkblue'}">
                    ${demandInstance.planDeliveryDate?.format("yy-MM-dd")}
                </td>
                <td>
                    ${demandInstance.deFinishDate?.format("yy-MM-dd")}
                </td>
                <td>
                    ${demandInstance.siFinishDate?.format("yy-MM-dd")}
                </td>
                <td>
                    ${demandInstance.uaFinishDate?.format("yy-MM-dd")}
                </td>
                <td>
                    ${demandInstance.deployDate?.format("yy-MM-dd")}
                </td>
                <td>
                    ${demandInstance.closeDate?.format("yy-MM-dd")}
                </td>
                <td>
                    ${fieldValue(bean: demandInstance, field: "submitPeople")}
                </td>
                <td>
                    <g:if test="${demandInstance.evaluate=='good'}">
                        <span class="label label-success arrowed">好评</span>
                    </g:if>
                    <g:if test="${demandInstance.evaluate=='normal'}">
                        <span class="label label-warning">中评</span>
                    </g:if>
                    <g:if test="${demandInstance.evaluate=='bad'}">
                        <span class="label label-danger arrowed-in">差评</span>
                    </g:if>
                </td>

            </tr>
            <tr class="task_tr" style="display: none">
                <td colspan="25" style="padding: 0">
                    <table class="table table-bordered" style="margin: 0;font-size: 0.7em">
                        <thead>
                        <tr style="background: beige">
                            <th>
                                <i class="glyphicon glyphicon-pencil" style="color: darkgreen" did="${demandInstance.id }"></i>
                            </th>
                            <th>任务号</th>
                            <th>状态</th>
                            <th>任务类型</th>
                            <th>任务内容</th>
                            <th>测试方案</th>
                            <th>预计时长（小时）</th>
                            <th>创建人</th>
                            <th>创建日期</th>
                            <th>完成人</th>
                            <th>完成日期</th>
                            <th>验收人</th>
                            <th>验收日期</th>
                            <th>评价</th>
                        </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>
    <div class="pagination" style="display: block;margin:0 10px">
        <g:paginate total="${demandInstanceCount}" />
        <span style="padding-left: 20px;position: relative;bottom: 30px">总共<span style="color: darkblue">${demandInstanceCount ?: 0}</span>条</span>
    </div>




<!--Edit Description Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel"></h4>
            </div>
            <div class="modal-body" id="desc-modal">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="updateDemand" type="button" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>

<!--Analyz Demand Modal -->
<div class="modal fade bs-example-modal-lg" id="taskModal" tabindex="-1" role="dialog" aria-labelledby="taskModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="taskModalLabel">新建任务</h4>
            </div>
            <div class="modal-body" id="task-modal">
                <form role="form" class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">需求描述</label>
                        <div class="col-sm-10">
                            <pre id="re_desc"></pre>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="title" class="col-sm-2 control-label">标题</label>
                        <div class="col-sm-10">
                            <g:textField id="title" name="title" class="form-control"></g:textField>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="proposal" class="col-sm-2 control-label">解决方案</label>
                        <div class="col-sm-10">
                            <g:textArea id="proposal" name="proposal" class="autosize-transition form-control"></g:textArea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="scenario" class="col-sm-2 control-label">测试方案</label>
                        <div class="col-sm-10">
                            <g:textArea id="scenario" name="scenario" class="autosize-transition form-control"></g:textArea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">预计时长</label>
                        <div class="col-sm-10">
                            <input type="text" class="input-mini" id="planHour" />
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="createTask" type="button" class="btn btn-primary">确认</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function(){

        var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
        basepath= basepath.substring(0,basepath.indexOf('/')) ;

        $('#demand_date').daterangepicker(null, function(start, end, label) {
            console.log(start.toISOString(), end.toISOString(), label);
        });

        $('#sumb_people').typeahead({
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
            if(params.demand_status){
                if(params.demand_status instanceof String){
                    ts = ts + params.demand_status
                } else {
                    params.demand_status.each(){
                        ts = ts + it + ","
                    }
                }
            }
            ts = ts + "]"
        %>
        $('#demand_status').multiselect('select', ${ts});

        // 日期类型选择
        $('.condition_demand_date').click(function(){
            var ctp = $(this);
            $('#pd_name').text(ctp.text());
            $('input[type=hidden][name=demand_date_type]').attr('value',ctp.attr('pn'));
        })

        // 根据params，初始化下拉日期选择文字
        $('#pd_name').text($('.condition_demand_date[pn="${params.demand_date_type?:'planStopDate'}"]').text());

        // 重置multiselect控件和下拉日期、人选择控件
        $('#reset_button').click(function(){
            $('#demand_status').multiselect('deselectAll', false);
            $('#demand_status').multiselect('updateButtonText');

            $('#pd_name').text($('.condition_demand_date[pn=planStopDate]').text());
            $('input[type=hidden][name=demand_date_type]').attr('value','planStopDate');

            $('#demand_date').val("");

        })


        // 快速修改状态方法
        /*
        $(".demand_status").hover(function(){
            if($(this).attr('nextable')=='Y'){
                $(this).css("cursor","pointer");
            }
        })
        $(".demand_status").click(function(){
            var ds = $(this);
            if($(ds).attr('nextable')=='Y'){
                $.ajax({
                    url : '/'+basepath+'/demand/ajaxForwardNext',
                    type : 'POST',
                    dataType : 'json',
                    data : {
                        did : ds.attr('did')
                    },
                    timeout : 10000,
                    error : function(e){
                        alert("操作失败")
                    },
                    success : function(json) {
                        var na = json.status.name;
                        ds.children('span').text(na);
                        if(na=="分析"||(na=="设计"&&json.type.name=="BUG")){
                            ds.prev().prev().append('<i class="glyphicon glyphicon-plus" style="color: darkgreen" did="'+ds.attr('did')+'"></i>');
                        }
                    }
                });
            }
        })
        */


        //  toggle requirement edit
        $(".requirement_description").hover(function(){
            $(this).css("cursor","pointer");
        })
        $(".requirement_description").click(function(){
            var rd = $(this);
            $('#myModalLabel').text($(rd).parents('tr').children('td:eq(4)').text()+'/'+$(rd).parents('tr').children('td:eq(5)').text()+'/'+$(rd).parents('tr').children('td:eq(3)').children('a').text())
            $('#desc-modal').empty();
            if($(rd).attr('updateable')=='N'){
                $('#desc-modal').append("<pre>"+$(rd).children('div').text()+"</pre>");
                $('#updateDemand').hide()
            } else {
                $('#desc-modal').append('<textarea id="updateDemandDesc" did="'+$(rd).attr('demand_id')+'" class="form-control" rows="10">'+$(rd).children('div').text()+"</textarea>");
                $('#updateDemand').show()
            }

            $('#myModal').modal('toggle');
        })

        /*
        $('#updateDemand').click(function(){
            $.ajax({
                url : '/'+basepath+'/demand/ajaxUpdateDemandAttr',
                type : 'POST',
                dataType : 'json',
                data : {
                    tid : $('#updateDemandDesc').attr('did'),
                    attr: 'description',
                    val : $('#updateDemandDesc').val()
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(json) {
                    $('td[demand_id="'+$('#updateDemandDesc').attr('did')+'"] div').text($('#updateDemandDesc').val());
                }
            });
            $('#myModal').modal('hide');
        })
        */

        // suspend requirement
        /*
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
            var cid = $(this);
            $.ajax({
                url : '/'+basepath+'/demand/ajaxSuspend',
                type : 'POST',
                dataType : 'json',
                data : {
                    cid : cid.attr("sid")
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(json) {
                    $(cid).parents('tr').remove();
                }
            });
        })
        */

        $( document ).on( "mouseover", ".demand_desc", function() {
            $(this).popover('show');
        })
        $( document ).on( "mouseout", ".demand_desc", function() {
            $(this).popover('hide');
        })

        $( document ).on( "mouseover", ".demand_backward", function() {
            $(this).popover('show');
        })
        $( document ).on( "mouseout", ".demand_backward", function() {
            $(this).popover('hide');
        })

        // open hide task
        $( document).on("click",".glyphicon-plus", function(){
            var dt = $(this)

            $.ajax({
                url : '/'+basepath+'/demand/ajaxTasks4Demand',
                type : 'POST',
                dataType : 'json',
                data : {
                    did : dt.attr('did')
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(json) {
                    $(".glyphicon-minus").click();
                    dt.parents("tr").next().show();
                    dt.removeClass("glyphicon-plus");
                    dt.addClass("glyphicon-minus");
                    dt.css("color","red");

                    var st = dt.parents("td").next().next().children("span").text();
                    if(st != "${DemandStatus.DESIGN.name}" && st != "${DemandStatus.DEVELOP.name}"){
                        dt.parents("tr").next().children("td").children("table").children("thead").children("tr").children("th:eq(0)").children("i").hide();
                    }

                    var tb = dt.parents("tr").next().children("td").children("table").children("tbody");
                    tb.empty();
                    $(json).each(function(){
                        var tr = $("<tr />");
                        if(this.ty!="${TaskType.DEVELOP_TASK.name}"||this.status=="${DemandStatus.ACCOMPLISHED.name}"||this.status=="${DemandStatus.SIT.name}")
                        {
                            $("<td />").appendTo(tr);
                        } else {
                            $("<td><i class='glyphicon glyphicon-trash'  style='color: orangered' tid='"+this.tid+"'></i></td>").appendTo(tr);
                        }
                        var lin = $('<a href="/'+basepath+'/task/show/'+this.tid+ '/"></a>').text(this.serial);
                        $("<td />").append(lin).appendTo(tr);
                        var sp = $('<span class="label label-primary" ></span>').text(this.status);
                        $("<td />").append(sp).appendTo(tr);
                        $("<td />").text(this.ty).appendTo(tr);
                        $("<td />").text(this.proposal).appendTo(tr);
                        $("<td />").text(this.sc).appendTo(tr);
                        $("<td />").text(this.ph).appendTo(tr);
                        $("<td />").text(this.cp).appendTo(tr);
                        $("<td />").text(this.cd).appendTo(tr);
                        $("<td />").text(this.pe).appendTo(tr);
                        $("<td />").text(this.fd).appendTo(tr);
                        $("<td />").text(this.ap).appendTo(tr);
                        $("<td />").text(this.ad).appendTo(tr);
                        var ev = $("<span />");
                        if(this.ev == "good"){
                            ev.text("好评").addClass("label label-success arrowed");
                        } else if (this.ev == "normal" ) {
                            ev.text("中评").addClass("label label-warning");
                        } else if (this.ev == "bad") {
                            ev.text("差评").addClass("label label-danger arrowed-in");
                        } else {

                        }
                        $("<td />").append(ev).appendTo(tr);

                        tr.appendTo(tb);
                    })
                }
            });
        })

        // hide task
        $( document).on("click",".glyphicon-minus", function(){
            var dt = $(this)

            $(".task_tr").hide();

            dt.removeClass("glyphicon-minus");
            dt.addClass("glyphicon-plus");
            dt.css("color","darkgreen");
        })

        $('textarea[class*=autosize]').autosize({append: "\n"});
        // open new task model
        $( document).on("click",".glyphicon-pencil", function(){
            var r = $(".glyphicon-minus").parents('tr').children('td:eq(10)').children('div').text();
            $('#re_desc').text(r);
            $('#proposal').val("");
            $('#scenario').val("");
            $('#planHour').val("0");
            $('#taskModal').modal('toggle');
        })

        $("#createTask").click(function(){
            $.ajax({
                url : '/'+basepath+'/demand/ajaxCreateTask4Demand',
                type : 'POST',
                dataType : 'json',
                data : {
                    did :  $(".glyphicon-minus").parents('tr').children('td:eq(4)').attr('bh'),
                    title: $('#title').val(),
                    proposal : $('#proposal').val(),
                    scenario : $('#scenario').val(),
                    planHour : $('#planHour').val()
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(json) {
                    var gm = $(".glyphicon-minus").parents('td');
                    $(".glyphicon-minus").click();
                    gm.children(".glyphicon-plus").click();
                }
            });
            $('#taskModal').modal('hide');
        })

        // delete task
        $( document).on("click",".glyphicon-trash", function(){
            //TODO
            var dt = $(this)

            $.ajax({
                url : '/'+basepath+'/demand/ajaxDeleteTask4Demand',
                type : 'POST',
                dataType : 'json',
                data : {
                    tid : dt.attr('tid')
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(json) {
                    dt.parent().parent().remove();
                }
            });
        })

        $('#planHour').ace_spinner({value:0,min:0,max:40,step:1, btn_up_class:'btn-info' , btn_down_class:'btn-info'})
                .closest('.ace-spinner')
                .on('changed.fu.spinbox', function(){
                    //alert($('#planHour').val())
                });

    })


</script>

</body>


</html>
