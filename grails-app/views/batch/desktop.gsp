<%--
  Created by IntelliJ IDEA.
  User: karl
  Date: 14-8-15
  Time: 下午6:47
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="org.joda.time.DateTime" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'batch.label', default: 'Batch')}" />
    <title>个人工作台</title>
    <script src="${createLink(uri:'/ace/assets/js/jquery-ui.js')}"></script>
    <!--
    <script src="https://togetherjs.com/togetherjs-min.js"></script>
    -->
    <style type="text/css">


    .task_serial {
        color: darkolivegreen;
        padding-right: 10px;
        width: 100px;
        display: inline-block;
    }
    .task_proposal {
        color: #808080;

    }
    .task_name {
        font-weight: bold;
        font-size: 1em;
        color: darkgreen;
        width: 200px;
        display: inline-block
    }
    #pending_task_list {
        overflow-y:scroll;
    }
    .serial {
        font-weight: bold;
        padding-right: 10px;
        color: darkblue
    }
    pre {
        padding: 2px;
        background-color: transparent;
        border: none;
    }
    .project_list {
        font-weight: bold;
        font-size: 1em;
        color: darkgreen
    }
    .company_name {
        font-size: 0.8em;
        color: darkblue
    }
    .person_desc {
        color: #ffffff;
        font-size: 0.8em;
    }

    .star-rating .caption {
        display: none;
    }

    .star-rating .clear-rating {
        display: none;
    }
    </style>
</head>
<body>

<g:if test="${flash.message}">
    <div class="alert alert-success no-margin">
        <button type="button" class="close" data-dismiss="alert">
            <i class="ace-icon fa fa-times"></i>
        </button>

        <i class="ace-icon fa fa-umbrella bigger-120 blue"></i>
        ${flash.message}
    </div>
</g:if>

<div class="row">

<div class="col-xs-12">
<!-- PAGE CONTENT BEGINS -->
<div class="tabbable">
<ul class="nav nav-tabs padding-18">
    <li class="active">
        <a data-toggle="tab" href="#desktop">
            <i class="green ace-icon fa fa-user bigger-120"></i>
            个人桌面
        </a>
    </li>

    <li>
        <a data-toggle="tab" href="#tasks">
            <i class="blue ace-icon fa fa-tasks bigger-120"></i>
            我的任务
        </a>
    </li>



</ul>
<div class="tab-content no-border padding-24">
<div id="desktop" class="tab-pane in active">
    <div class="row">
        <div class="col-sm-6">

            <div class="widget-box transparent">
                <div class="widget-header widget-header-flat">
                    <h4 class="widget-title lighter">
                        <i class="ace-icon fa fa-star orange"></i>
                        月得分排行榜
                    </h4>

                    <div class="widget-toolbar">
                        <a href="#" data-action="collapse">
                            <i class="ace-icon fa fa-chevron-up"></i>
                        </a>
                    </div>
                </div>

                <div class="widget-body">
                    <div class="widget-main no-padding">
                        <table class="table table-bordered table-striped">
                            <thead class="thin-border-bottom">
                            <tr>
                                <th>
                                    <i class="ace-icon fa fa-caret-right blue"></i>排名
                                </th>

                                <th>
                                    <i class="ace-icon fa fa-caret-right blue"></i>姓名
                                </th>

                                <th>
                                    <i class="ace-icon fa fa-caret-right blue"></i>得分
                                </th>
                            </tr>
                            </thead>

                            <tbody>
                            <g:each in="${mps}" var="mp" status="i">
                                <g:if test="${i<10}">
                                    <tr>
                                        <td>${i+1}</td>
                                        <td>${mp[0]}</td>

                                        <td style="text-align: right">
                                            <b class="green">${mp[1]}</b>
                                        </td>

                                    </tr>
                                </g:if>
                            </g:each>



                            </tbody>
                        </table>
                    </div><!-- /.widget-main -->
                </div><!-- /.widget-body -->
            </div><!-- /.widget-box -->
        </div>

        <div class="col-sm-6" >
            <div class="widget-box">
                <div class="widget-body">
                    <div class="widget-main">
                        <div class="clearfix">
                            <div class="grid2">
                                <div class="infobox-data">
                                    <div class="infobox-content">当月得分：<span id="monthPoint" class="pull-right">0</span></div>
                                    <div class="infobox-content">累计得分：<span id="totalPoint" class="pull-right">0</span></div>
                                </div>
                            </div>
                            <div class="grid2">
                                <div class="pull-left">
                                    <div class="grey">
                                        <i class="ace-icon glyphicon glyphicon-log-in blue"></i>
                                        <span class="bigger" id="cin" style="padding-left: 5px">0</span>
                                    </div>
                                    <div class="grey">
                                        <i class="ace-icon glyphicon glyphicon-log-in purple"></i>
                                        <span class="bigger" id="cout" style="padding-left: 5px">0</span>
                                    </div>
                                </div>
                                <div class="pull-right">
                                    <button class="btn btn-warning btn-xs" value="签到" id="check_in">签到</button>
                                    <button class="btn btn-warning btn-xs" value="签出" id="check_out">签出</button>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <!-- Default panel contents -->
                <div class="panel-heading" style="text-align: center">
                    项目通信录
                    <button id="back_project_list" type="button" class="btn btn-info btn-xs" style="float: right">返回</button>
                </div>
                <div class="comments" id="project_list" style="height: 400px;overflow-y:scroll;padding: 0px">
                </div>
            </div>
        </div>
    </div>
</div>
<div id="tasks" class="tab-pane">
    <div class="row">
        <div class="col-sm-8">
            <!--
                <div class="widget-box transparent" id="recent-box">
                    <div class="widget-header">
                        <h4 class="widget-title lighter smaller">
                            <i class="ace-icon fa fa-rss orange"></i>待处理任务
                        </h4>

                        <button id="back_pending_task" type="button" class="btn btn-info btn-xs pull-right" >返回</button>
                    </div>

                    <div class="widget-body">
                        <div class="widget-main padding-4" >
                            <ul class="item-list" id="pending_task_list">

                            </ul>
                        </div>
                    </div>
                </div>
                -->
            <div class="widget-box transparent" id="developer_task-box">
                <div class="widget-header">

                    <h4 class="widget-title lighter smaller">
                        <i class="ace-icon fa fa-rss orange"></i>我的任务
                    </h4>
                </div>

                <div class="widget-body">
                    <div class="widget-main padding-4" >

                        <div id="design_tasks">
                            <h5 class="lighter smaller">
                                分析与设计任务
                            </h5>
                            <ul class="item-list" id="pending_design_task_list">

                            </ul>
                        </div>

                        <div id="develop_tasks">
                            <g:link controller="task" action="myWeeklyTasks" class="pull-right" style="margin-right: 5px">详细>></g:link>
                            <h5 class="lighter smaller">
                                开发任务
                            </h5>
                            <ul class="item-list" id="pending_developer_task_list">

                            </ul>
                        </div>
                        <div id="sit_tasks">
                            <h5 class="lighter smaller">
                                SIT任务
                            </h5>
                            <ul class="item-list" id="pending_sit_task_list">

                            </ul>
                        </div>
                        <!--
                        <div id="uat_tasks">
                            <h5 class="lighter smaller">
                                UAT任务
                            </h5>
                            <ul class="item-list" id="pending_uat_task_list">

                            </ul>
                        </div>
                        <div id="other_tasks">
                            <h5 class="lighter smaller">
                                其他任务
                            </h5>
                            <ul class="item-list" id="pending_other_task_list">

                            </ul>
                        </div>
                         -->
                    </div>
                </div>
            </div>
            <!--
                <div class="widget-box transparent" id="sit_task-box">
                    <div class="widget-header">

                        <h4 class="widget-title lighter smaller">
                            <i class="ace-icon fa fa-rss orange"></i>待处理测试任务
                        </h4>
                    </div>

                    <div class="widget-body">
                        <div class="widget-main padding-4" >
                            <ul class="item-list" id="pending_sit_task_list">

                            </ul>
                        </div>
                    </div>
                </div>
                -->
        </div>
        <div class="col-sm-4">
            <div class="widget-box transparent">
                <div class="widget-header widget-header-flat">
                    <h4 class="widget-title lighter">
                        <i class="ace-icon fa fa-star orange"></i>
                        本周任务完成情况
                    </h4>

                    <div class="widget-toolbar">
                        <a href="#" data-action="collapse">
                            <i class="ace-icon fa fa-chevron-up"></i>
                        </a>
                    </div>
                </div>

                <div class="widget-body">
                    <div class="widget-main no-padding">
                        <table class="table table-bordered table-striped">
                            <thead class="thin-border-bottom">
                            <tr>
                                <th>
                                    <i class="ace-icon fa fa-caret-right blue"></i>日期
                                </th>

                                <th>
                                    <i class="ace-icon fa fa-caret-right blue"></i>提交SIT量
                                </th>

                                <th>
                                    <i class="ace-icon fa fa-caret-right blue"></i>完成工作量
                                </th>
                            </tr>
                            </thead>

                            <tbody>
                            <%
                                def sumFinish = 0
                            %>
                            <g:each in="${dayWork}" var="dw" status="i">
                                <tr>
                                    <td>${dw[1]}号</td>

                                    <td style="text-align: right">
                                        <b class="green">${dw[2]}</b>
                                    </td>
                                    <td style="text-align: right">
                                        <b class="green">${dw[3]}</b>
                                    </td>

                                </tr>
                                <%
                                    if(dw[3])
                                        sumFinish = sumFinish + dw[3]
                                %>
                            </g:each>
                            <tr>
                                <td>合计</td>
                                <td></td>
                                <td style="text-align: right">
                                    <b class="green">${sumFinish}</b>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div><!-- /.widget-main -->
                </div><!-- /.widget-body -->
            </div><!-- /.widget-box -->

        <!-- /section:pages/dashboard.infobox -->
            <div class="space-6"></div>

            <div class="infobox infobox-green infobox-small infobox-dark">
                <div class="infobox-icon">
                    <i class="ace-icon glyphicon glyphicon-list"></i>
                </div>

                <div class="infobox-data">
                    <div class="infobox-content">月完成量</div>
                    <div class="infobox-content">${mw}h</div>
                </div>
            </div>

            <!-- #section:pages/dashboard.infobox.dark -->
            <div class="infobox infobox-orange infobox-small infobox-dark">
                <div class="infobox-progress">
                    <%
                        def dp = 0

                        if(ut&&ut[0]+ut[1]+ut[2]!=0){
                            dp = (ut[0]/(ut[0]+ut[1]+ut[2]))*100
                        }
                    %>
                    <!-- #section:pages/dashboard.infobox.easypiechart -->
                    <div class="easy-pie-chart percentage" data-percent="${dp}" data-size="39">
                        <span class="percent"><g:formatNumber number="${dp}" format="###,##0" /></span>%
                    </div>

                    <!-- /section:pages/dashboard.infobox.easypiechart -->
                </div>

                <div class="infobox-data">
                    <div class="infobox-content">本月评价</div>
                    <g:if test="${ut}">
                        <div class="infobox-content">${ut[0]} ${ut[1]} ${ut[2]}</div>
                    </g:if>

                </div>
            </div>
        </div>
    </div>
</div>



</div>
</div>
<!-- PAGE CONTENT ENDS -->
</div><!-- /.col -->
</div>




<script type="text/javascript">
    var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
    basepath= basepath.substring(0,basepath.indexOf('/')) ;

    var reward = function(){
        $.ajax({
            url : '/'+basepath+'/person/ajaxRewardCount',
            type : 'POST',
            dataType : 'json',
            timeout : 10000,
            error : function(e){
                alert("操作失败")
            },
            success : function(json) {
                $('#gn').text(json.RewardStat.good+"/"+json.RewardStat.normal);
                $('#bad').text(json.RewardStat.bad);
                $('#totalPoint').text(json.RewardStat.totalPoint);
                $('#monthPoint').text(json.RewardStat.monthPoint);
            }
        });
    }

    var attendance = function(){
        $.ajax({
            url : '/'+basepath+'/attendance/ajaxAttendanceCount',
            type : 'POST',
            dataType : 'json',
            timeout : 10000,
            error : function(e){
                alert("操作失败")
            },
            success : function(json) {
                $('#cin').text(json.AttendanceStat.cin);
                $('#cout').text(json.AttendanceStat.cout);
            }
        });
    }

    var myProjectList = function(){
        $("#project_list").empty();
        $.ajax({
            url : '/'+basepath+'/personProject/ajaxMyProjectList',
            type : 'POST',
            dataType : 'json',
            timeout : 10000,
            error : function(e){
                alert("操作失败")
            },
            success : function(json) {
                $(json).each(function(){

                    var project = this;
                    var pro = $('<div></div>');
                    $('<div class="project_list"></div>').text("项目名称："+project.name).appendTo(pro);
                    //$('<div class="company_name"></div>').text("甲方："+project.fristParty).appendTo(pro);
                    //$('<div class="company_name"></div>').text("乙方："+project.secondParty).appendTo(pro);
                    var ssl = $('<div class="sidebar-shortcuts-mini"></div>');
                    $('<button class="btn btn-success btn-sm project_detail" style="margin-right: 5px"><i class="ace-icon fa fa-users"></i></button>').attr("pid",project.id).appendTo(ssl);
                    $('<button class="btn btn-info btn-sm project_doc" style="margin-right: 5px"><i class="ace-icon fa fa-book"></i></button>').attr("pid",project.id).appendTo(ssl);
                    ssl.appendTo(pro);

                    var lgi = $('<div class="list-group-item" style="margin: 1px;border-left: 0;border-right: 0;border-top: 0"></div>').append(pro);
                    $("#project_list").append(lgi);
                })
            }
        });
    }

    var myAddressList = function(pid){
        $("#project_list").empty();
        $.ajax({
            url : '/'+basepath+'/project/ajaxPeople4Project',
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
                $('#back_project_list').show();
                $(json).each(function(){
                    var human = this;
                    var role = "";
                    if(human[2]){
                        role = human[2].name;
                    }

                    var avatarPath = "${createLink(controller: 'person', action: 'avatar')}"+"?username="+human[8];
                    var cb = $('<div class="commentdiv itemdiv"></div>');
                    $('<div class="user"><img src='+avatarPath+' /></div>').appendTo(cb);

                    var bo = $('<div class="body"></div>').appendTo(cb);;
                    $('<div class="name"><a href="#">'+human[1]+'</a></div>').appendTo(bo);
                    $('<div class="time"><i class="ace-icon fa fa-user-md"></i><span class="green">'+role+'</span></div>').appendTo(bo);



                    //var cb = "<div class='list-group-item itemdiv'><div class='person_item' tid='"+human[0]+"'>";
                    //cb = cb + "<span style='font-weight: bold;font-size: 1.2em;color: darkgreen'>"+human[1] +"</span>";
                    //cb = cb + "<div style='float: right;color: DarkOrange'>"+role +"</div>";
                    var te = $('<div class="text"></div>').appendTo(bo);
                    if(human[5])
                        //cb = cb + "<div>"+human[5]+"</div>";
                        $('<span style="display: block"></span>').text(human[5]).appendTo(te);

                    if(human[4])
                        //cb = cb + "<div>电话："+human[4]+"</div>";
                        $('<span style="display: block"></span>').text("电话："+human[4]).appendTo(te);
                    if(human[3])
                        //cb = cb + "<div>邮箱："+human[3]+"</div>";
                        $('<span style="display: block"></span>').text("邮箱："+human[3]).appendTo(te);
                    //cb = cb + "</div></div>"
                    $("#project_list").append(cb);
                })
            }
        });
    }


    // 开发任务列表
    var pendingDeveloperTaskList = function(){
        $("#pending_developer_task_list").empty();
        $.ajax({
            url : '/'+basepath+'/weeklyPlan/ajaxWeeklyTasks4Person',
            type : 'POST',
            dataType : 'json',
            timeout : 10000,
            error : function(e){
                alert("操作失败")
            },
            success : function(json) {
                if(json.length > 0){
                    $(json).each(function(){

                        var task = this;
                        var pending = $('<label class="inline"></label>');
                        var lgiinput = $('<input type="checkbox" class="ace" />');
                        lgiinput.attr("tid",task[2]).appendTo(pending);
                        var url = "/"+basepath+"/task/show/"+task[2];
                        var au = $('<a href="'+url+'"></a> ').text(task[3]);
                        $('<span class="task_serial lbl"></span>').append(au).appendTo(pending);

                        $('<span class="task_title lbl"></span>').text(task[9]).appendTo(pending);
                        //$('<span class="lbl"></span>').text(task[3]).appendTo(pending);

                        var lgi = $('<li class="clearfix"></li>').attr("tid",task[2]).append(pending);

                        <%
                        def dt = new DateTime()
                        int year = dt.getWeekyear()
                        int week = dt.getWeekOfWeekyear()
                    %>

                        if(task[0]<${year}){
                            lgi.addClass("item-orange");
                        }
                        if(task[0]==${year}){
                            if(task[1]<${week}){
                                lgi.addClass("item-orange");
                            }
                            if(task[1]==${week}){
                                lgi.addClass("item-green");
                            }
                            if(task[1]>${week}){
                                lgi.addClass("item-blue");
                            }
                        }
                        if(task[0]>${year}){
                            lgi.addClass("item-blue");
                        }

                        if(task[6].name=='紧急'){
                            var bu = $('<div class="action-buttons pull-right"></div>');
                            $('<a href="#" class="red"><i class="ace-icon fa fa-bell-o bigger-130"></i></a>').appendTo(bu);
                            //$('<span class="vbar"></span>').appendTo(bu);
                            //$('<a href="#" class="green"><i class="ace-icon fa fa-flag bigger-130"></i></a>').appendTo(bu);
                            bu.appendTo(lgi);
                        }

                        if(task[8].name=='SIT'){
                            lgi.addClass("selected");
                            lgiinput.attr("checked","");
                        }

                        $("#pending_developer_task_list").append(lgi);
                    })
                } else {
                    $("#develop_tasks").remove();
                }

            }
        });
    }

    // SIT任务列表
    var pendingSitTaskList = function(){
        $("#pending_sit_task_list").empty();
        $.ajax({
            url : '/'+basepath+'/weeklyPlan/ajaxSitTasks4Person',
            type : 'POST',
            dataType : 'json',
            timeout : 10000,
            error : function(e){
                alert("操作失败")
            },
            success : function(json) {
                if(json.length > 0){
                    $(json).each(function(){

                        var task = this;
                        var pending = $('<label class="inline"></label>');
                        //var lgiinput = $('<input type="checkbox" class="ace" />');
                        //lgiinput.attr("tid",task[0]).appendTo(pending);
                        var url = "/"+basepath+"/demand/show/"+task[0];
                        var au = $('<a href="'+url+'"></a> ').text(task[1]);
                        $('<span class="task_serial lbl"></span>').append(au).appendTo(pending);

                        $('<span class="task_proposal lbl"></span>').text(task[2]).appendTo(pending);
                        //$('<span class="lbl"></span>').text(task[3]).appendTo(pending);

                        var lgi = $('<li class="clearfix"></li>').attr("did",task[0]).append(pending);

                        if(task[3].name=='紧急'){
                            lgi.addClass("item-red");
                        } else {
                            lgi.addClass("item-blue");
                        }

                        //var bu = $('<div class="action-buttons pull-right"></div>');
                        //$('<a href="#" class="forward_uat green"><i class="ace-icon glyphicon glyphicon-ok bigger-130"></i></a>').appendTo(bu);
                        //$('<span class="vbar"></span>').appendTo(bu);
                        //$('<a href="#" class="back_develop red"><i class="ace-icon fa fa-undo bigger-130"></i></a>').appendTo(bu);
                        //bu.appendTo(lgi);

                        $("#pending_sit_task_list").append(lgi);
                    })
                } else {
                    $("#sit_tasks").remove();
                }

            }
        });
    }

    // 分析与设计任务列表
    var pendingDesignTaskList = function(){
        $("#pending_design_task_list").empty();
        $.ajax({
            url : '/'+basepath+'/weeklyPlan/ajaxWeeklyDesignTasks4Person',
            type : 'POST',
            dataType : 'json',
            timeout : 10000,
            error : function(e){
                alert("操作失败")
            },
            success : function(json) {
                if(json.length > 0){
                    $(json).each(function(){

                        var task = this;
                        var pending = $('<label class="inline"></label>');
                        var url = "/"+basepath+"/demand/show/"+task[2];
                        var au = $('<a href="'+url+'"></a> ').text(task[3]);
                        $('<span class="task_serial lbl"></span>').append(au).appendTo(pending);

                        $('<span class="task_title lbl"></span>').text(task[4]).appendTo(pending);
                        var lgi = $('<li class="clearfix"></li>').attr("did",task[2]).append(pending);


                        $("#pending_design_task_list").append(lgi);
                    })
                } else {
                    $("#design_tasks").remove();
                }

            }
        });
    }

    var pendingMyDevelopTasks = function(pid){
        $("#pending_task_list").empty();
        $.ajax({
            url : '/'+basepath+'/task/ajaxMyDevelopTasks',
            type : 'POST',
            dataType : 'json',
            data : {
                pid : pid
            },
            timeout : 10000,
            error : function(e){
                alert("操作失败")
            },
            success : function(tasks) {
                $('#back_pending_task').show();
                $(tasks).each(function(){
                    var task = this;
                    var developTask = $('<div class="developTask"></div>');
                    $('<i class="icon-warning-sign" style="color: red"></i>').appendTo(developTask);
                    $('<span class="serial"></span>').text(task[1]).appendTo(developTask);
                    $('<button type="button" class="btn btn-success forward_sit" style="float: right">提交SIT</button>').attr("tid",task[0]).appendTo(developTask);
                    $('<span ></span>').text(task[4]).appendTo(developTask);
                    $('<span ></span>').text(task[5]).appendTo(developTask);
                    $('<pre></pre>').text(task[3]).appendTo(developTask);
                    var lgi = $('<li class="list-group-item item-blue clearfix"></li>').append(developTask);
                    $("#pending_task_list").append(lgi);
                })
            }
        });
    }

    var pendingMySitTasks = function(pid){
        $("#pending_task_list").empty();
        $.ajax({
            url : '/'+basepath+'/task/ajaxMySitTasks',
            type : 'POST',
            dataType : 'json',
            data : {
                pid : pid
            },
            timeout : 10000,
            error : function(e){
                alert("操作失败")
            },
            success : function(tasks) {
                $('#back_pending_task').show();
                $(tasks).each(function(){
                    var task = this;
                    var sitTask = $('<div class="sitTask"></div>');
                    $('<i class="icon-warning-sign" style="color: red"></i>').appendTo(sitTask);
                    $('<span class="serial"></span>').text(task[1]).appendTo(sitTask);
                    $('<button type="button" class="btn btn-success forward_uat" style="float: right; margin-left: 5px">提交UAT</button>').attr("tid",task[0]).appendTo(sitTask);
                    $('<button type="button" class="btn btn-danger back_develop" style="float: right">退回开发</button>').attr("tid",task[0]).appendTo(sitTask);
                    $('<span ></span>').text(task[4]).appendTo(sitTask);
                    $('<span ></span>').text(task[5]).appendTo(sitTask);
                    $('<pre></pre>').text(task[3]).appendTo(sitTask);
                    var lgi = $('<div class="list-group-item"></div>').append(sitTask);
                    $("#pending_task_list").append(lgi);
                })
            }
        });
    }

    $(function(){
        reward();
        attendance();

        $('#back_pending_task').hide();

        pendingDeveloperTaskList();
        pendingSitTaskList();
        pendingDesignTaskList();

        $('#back_project_list').hide();
        myProjectList();

        // pending click handle
        $( document ).on( "click", ".demand_page", function() {
            var pe = $(this);
            location.href = "/"+basepath+"/demand/index?pid="+pe.attr('pid')+"&task_status="+pe.attr('ts');
        })

        // pending click handle
        $( document ).on( "click", ".develop_task_page", function() {
            var pe = $(this);
            pendingMyDevelopTasks(pe.attr('pid'));
        })

        // pending click handle
        $( document ).on( "click", ".sit_task_page", function() {
            var pe = $(this);
            pendingMySitTasks(pe.attr('pid'));
        })

        $('#back_pending_task').click(function(){
            pendingTaskList();
            $('#back_pending_task').hide();
        })

        // pending click handle
        $( document ).on( "click", ".forward_sit", function() {
            var fs = $(this);
            $.ajax({
                url : '/'+basepath+'/task/ajaxForwardSIT',
                type : 'POST',
                dataType : 'json',
                data : {
                    tid : fs.attr("tid")
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(tasks) {
                    fs.parents(".list-group-item").remove();
                }
            });
        })

        $( document ).on( "click", ".forward_uat", function() {
            var fs = $(this).parents("li");
            $.ajax({
                url : '/'+basepath+'/demand/ajaxForwardUAT',
                type : 'POST',
                dataType : 'json',
                data : {
                    did : fs.attr("did")
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(tasks) {
                    fs.remove();
                }
            });
        })

        $( document ).on( "click", ".back_develop", function() {
            var fs = $(this).parents("li");
            $.ajax({
                url : '/'+basepath+'/demand/ajaxBackDevelop',
                type : 'POST',
                dataType : 'json',
                data : {
                    did : fs.attr("did")
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(tasks) {
                    fs.remove();
                }
            });
        })

        $('#back_project_list').click(function(){
            myProjectList();
            $('#back_project_list').hide();
        })

        // pending click handle
        $( document ).on( "click", ".project_detail", function() {
            var pe = $(this);
            myAddressList(pe.attr('pid'));
        })

        //
        $(document).on("click",".project_doc",function(){
            var pid = $(this).attr("pid");
            window.location='project/demandDoc4Project?pid='+pid;
        })

        // init check in and check button
        $('#check_in').hide();
        $('#check_out').hide();
        $.ajax({
            url : '/'+basepath+'/attendance/ajaxGetAttendanceStatus',
            type : 'POST',
            dataType : 'json',
            timeout : 10000,
            error : function(e){
                alert("操作失败")
            },
            success : function(data) {
                var st = data.AttendanceStatus.status
                if(st == "None"){
                    $('#check_in').show();
                }
                if(st == "Reached"){
                    $('#check_out').show();
                }
            }
        });

        // check in
        $('#check_in').click(function(){
            $.ajax({
                url : '/'+basepath+'/attendance/ajaxWorkAttendance',
                type : 'POST',
                dataType : 'json',
                data : {
                    op : "Check In"
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(data) {
                    $('#check_in').hide();
                    $('#check_out').show();
                    $('#cin').text(parseInt($('#cin').text())+1);
                }
            });
        })

        // check out
        $('#check_out').click(function(){
            $.ajax({
                url : '/'+basepath+'/attendance/ajaxWorkAttendance',
                type : 'POST',
                dataType : 'json',
                data : {
                    op : "Check Out"
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(data) {
                    $('#check_out').hide();
                    $('#cout').text(parseInt($('#cout').text())+1);
                }
            });
        })

        $('#pending_developer_task_list').sortable({
                    opacity:0.8,
                    revert:true,
                    forceHelperSize:true,
                    placeholder: 'draggable-placeholder',
                    forcePlaceholderSize:true,
                    tolerance:'pointer',
                    stop: function( event, ui ) {
                        //just for Chrome!!!! so that dropdowns on items don't appear below other items after being moved
                        $(ui.item).css('z-index', 'auto');
                    }
                }
        );
        //$('#pending_developer_task_list').disableSelection();
        $( document).on('click','#pending_developer_task_list input:checkbox', function(){
            var ic = $(this);
            if(this.checked) {
                $.ajax({
                    url : '/'+basepath+'/task/ajaxForwardSIT',
                    type : 'POST',
                    dataType : 'json',
                    data : {
                        tid : ic.attr("tid")
                    },
                    timeout : 10000,
                    error : function(e){
                        alert("操作失败")
                    },
                    success : function() {
                        ic.closest('li').addClass('selected');
                    }
                });
            }
            else {
                $.ajax({
                    url : '/'+basepath+'/task/ajaxBackDevelop',
                    type : 'POST',
                    dataType : 'json',
                    data : {
                        tid : ic.attr("tid")
                    },
                    timeout : 10000,
                    error : function(e){
                        alert("操作失败")
                    },
                    success : function() {
                        ic.closest('li').removeClass('selected');
                    }
                });
            }
        });

        $('.easy-pie-chart.percentage').each(function(){
            var $box = $(this).closest('.infobox');
            var barColor = $(this).data('color') || (!$box.hasClass('infobox-dark') ? $box.css('color') : 'rgba(255,255,255,0.95)');
            var trackColor = barColor == 'rgba(255,255,255,0.95)' ? 'rgba(255,255,255,0.25)' : '#E2E2E2';
            var size = parseInt($(this).data('size')) || 50;
            $(this).easyPieChart({
                barColor: barColor,
                trackColor: trackColor,
                scaleColor: false,
                lineCap: 'butt',
                lineWidth: parseInt(size/10),
                animate: /msie\s*(8|7|6)/.test(navigator.userAgent.toLowerCase()) ? false : 1000,
                size: size
            });
        })
    })
</script>
</body>
</html>