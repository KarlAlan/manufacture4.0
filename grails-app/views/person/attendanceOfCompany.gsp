
<%@ page import="org.joda.time.DateTime; com.rcstc.manufacture.Person" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <style>
        .check-time {
            width: 57px;
            height: 60px;
            padding: 5px;
            min-width: 57px;
            min-height: 53px;
        }
        .holiday {
            background-color: lavender;
        }
        .time {
            text-align: center;
            color: white;
            margin-top: 1px;
        }
    </style>
</head>
<body>


<div id="list-person" class="content scaffold-list" role="main">
    <g:if test="${flash.message}">
        <div class="alert alert-block alert-success" role="status">${flash.message}</div>
    </g:if>
    <div class="tabbable">
        <ul class="nav nav-tabs padding-18">
            <li class="active">
                <a data-toggle="tab" href="#home">
                    <i class="green ace-icon fa fa-user bigger-120"></i>
                    考勤记录
                </a>
            </li>

            <li>
                <a data-toggle="tab" href="#apply">
                    <i class="orange ace-icon fa fa-rss bigger-120"></i>
                    申请处理
                </a>
            </li>
        </ul>

        <div class="tab-content no-border padding-24">
            <div id="home" class="tab-pane in active">
                <div title="查询条件" style="margin: 10px">
                    <g:form id="search_list" action="attendanceOfCompany" method="post" class="form-inline" role="form">
                        <div class="form-group">
                            <label for="year">年份：</label>
                            <g:select name="year" from="${2014..<2021}"  value="${params.year}"  class="form-control"/>
                        </div>
                        <div class="form-group">
                            <label>月份：</label>
                            <g:select name="month" from="${1..<13}"  value="${params.month}"  class="form-control"/>
                        </div>
                        <button type="submit" class="btn btn-info btn-sm pull-right">查询</button>
                    </g:form>
                </div>
                <table class="table table-bordered pull-left" style="width: 30px">
                    <thead>
                    <tr><td style="white-space: nowrap;text-align: center;vertical-align: middle">姓名</td></tr>
                    </thead>
                    <tbody>
                    <g:each in="${presons}" status="i" var="person">
                        <tr><td class="check-time" style="white-space: nowrap;text-align: center;vertical-align: middle"><g:link action="show" id="${person.id}">${person.name}</g:link></td></tr>
                        <g:if test="${i!=0&&i%6==0}">
                            <tr>
                                <td style="white-space: nowrap;text-align: center;vertical-align: middle;background-color: lightgrey">姓名</td>
                            </tr>
                        </g:if>
                    </g:each>
                    </tbody>
                </table>
                <div style="overflow-x: scroll">
                    <table class="table table-bordered table-hover">

                        <thead>
                        <tr>
                            <%
                                DateTime dt = new DateTime(params.int("year"),params.int("month"),1,9,0)
                            %>
                            <g:each in="${(0..<(dt.dayOfMonth().getMaximumValue()))}" status="i" var="l1">
                                <th style="text-align: center;">${i+1}</th>
                            </g:each>
                        </tr>
                        </thead>

                        <tbody>
                        <g:each in="${presons}" status="i" var="person">
                            <tr>
                                <g:each in="${(0..<(dt.dayOfMonth().getMaximumValue()))}" status="j" var="l1">
                                    <%
                                        int w = dt.dayOfMonth().setCopy(j+1).getDayOfWeek()
                                    %>
                                    <td class="check-time ${w==6||w==7?'holiday':''}" >
                                        <%
                                            def st1 = "transparent"
                                            if(morns[i][j][0]&&!morns[i][j][1]){
                                                st1 = "MediumSeaGreen"
                                            }
                                            if(morns[i][j][1]){
                                                st1 = "Crimson"
                                            }
                                            if(morns[i][j][2]=="Apply"){
                                                st1 = "RoyalBlue"
                                            }
                                            def st2 = "transparent"
                                            if(aftes[i][j][0]&&!aftes[i][j][1]){
                                                st2 = "MediumSeaGreen"
                                            }
                                            if(aftes[i][j][1]){
                                                st2 = "Crimson"
                                            }
                                            if(aftes[i][j][2]=="Apply"){
                                                st2 = "RoyalBlue"
                                            }
                                        %>
                                        <div class="time" style="background-color: ${st1}">${morns[i][j][0]}&nbsp;</div>
                                        <div class="time" style="background-color: ${st2}">${aftes[i][j][0]}&nbsp;</div>
                                    </td>
                                </g:each>
                            </tr>
                            <g:if test="${i!=0&&i%6==0}">
                                <tr>
                                    <g:each in="${(0..<(dt.dayOfMonth().getMaximumValue()))}" status="z" var="l1">
                                        <th style="text-align: center; background-color: lightgrey">${z+1}</th>
                                    </g:each>
                                </tr>
                            </g:if>
                        </g:each>
                        </tbody>
                    </table>
                </div>
                <div>
                    <span><i class="ace-icon fa fa-circle bigger-120" style="color: Crimson"></i>迟到/旷工</span>
                    <span><i class="ace-icon fa fa-circle bigger-120" style="color: MediumSeaGreen"></i>正常</span>
                    <span><i class="ace-icon fa fa-circle bigger-120" style="color: RoyalBlue"></i>申请修改中</span>
                </div>
            </div>
            <div id="apply" class="tab-pane">
                <div class="row">
                    <div class="col-sm-6">
                        <h4 class="smaller lighter green">
                            <i class="ace-icon fa fa-list"></i>
                            申请列表
                        </h4>

                <!-- #section:pages/dashboard.tasks -->
                <ul id="tasks" class="item-list">
                    <g:each in="${applings}" status="i" var="att" >
                        <li class="item-red clearfix">
                            <label class="inline">
                                <!--
                            <input type="checkbox" class="ace" />
                            -->
                                <%
                                    def op
                                    if(att.operation=="Check In"){
                                        op = "签到"
                                    }
                                    if(att.operation=="Check Out"){
                                        op = "签出"
                                    }
                                %>
                                <span class="lbl">${att.person.name}申请修改${att.attendanceDate.format("yyyy-MM-dd")}${op}记录</span>
                                <div>原因：${att.description}</div>
                            </label>

                            <!-- #section:custom/extra.action-buttons -->
                            <div class="pull-right action-buttons">
                                <a href="#" class="blue">
                                    <i class="ace-icon glyphicon glyphicon-ok bigger-130 passApply" aid = ${att.id}></i>
                                </a>

                                <span class="vbar"></span>

                                <a href="#" class="red">
                                    <i class="ace-icon glyphicon glyphicon-remove bigger-130 noPassApply" aid = ${att.id}></i>
                                </a>
                            </div>

                            <!-- /section:custom/extra.action-buttons -->
                        </li>
                    </g:each>
                </ul>

                <!-- /section:pages/dashboard.tasks -->
                        </div>
                    </div>
            </div>
        </div>
    </div>
</div>
<script>
    var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
    basepath= basepath.substring(0,basepath.indexOf('/')) ;

    $(function(){
        $( document ).on( "mouseover", ".check-time", function() {
            $(this).popover('show');
        })
        $( document ).on( "mouseout", ".check-time", function() {
            $(this).popover('hide');
        })

        $(".passApply").click(function(){
            var pa = $(this);
            $.ajax({
                url : '/'+basepath+'/attendance/ajaxHandleAttendanceApply',
                type : 'POST',
                dataType : 'json',
                data : {
                    aid : pa.attr("aid"),
                    result : "Pass"
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(json) {
                    pa.parents("li").remove();
                }
            });
        });

        $(".noPassApply").click(function(){
            var pa = $(this);
            $.ajax({
                url : '/'+basepath+'/attendance/ajaxHandleAttendanceApply',
                type : 'POST',
                dataType : 'json',
                data : {
                    aid : pa.attr("aid"),
                    result : "Reject"
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(json) {
                    pa.parents("li").remove();
                }
            });
        });
    })
</script>
</body>
</html>
