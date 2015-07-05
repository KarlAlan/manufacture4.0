
<%@ page import="org.joda.time.DateTime; com.rcstc.manufacture.TaskStatus; com.rcstc.business.ContractStatus; com.rcstc.business.Contract" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'contract.label', default: 'Contract')}" />
    <title>任务计划查询</title>
    <asset:javascript src="bootstrap-multiselect.js"/>
    <asset:stylesheet src="bootstrap-multiselect.css"/>
</head>
<body>

<div title="查询条件" style="margin: 10px">
    <g:form action="planingTasks" method="post" class="form-inline" role="form">
        <div class="form-group">
            <label>任务序号：</label>
            <input value="${params.task_serial}" id="task_serial" name="task_serial" type="text" class="form-control" placeholder="任务序号" style="width: 100px">
        </div>
        <div class="form-group">
            <label>任务人：</label>
            <input value="${params.task_person_name}" id="task_person_name" name="task_person_name" type="text" class="form-control person" placeholder="任务人" autocomplete="off" style="width: 100px">
        </div>
        <div class="form-group">
            <label>状态：</label>
            <g:select name="task_status" from="${TaskStatus?.values().name}" keys="${TaskStatus.values()*.id}"  optionKey="id" value="${params.task_status}"
                      id="task_status" class="multiselect" multiple=""/>
        </div>

        <div class="form-group">
            <button type="submit" class="btn btn-info btn-sm">查询</button>
            <button id="reset_button" type="reset" class="btn btn-warning btn-sm">重置</button>
        </div>

    </g:form>
</div>

<div id="list-contract" class="content scaffold-list" role="main" style="overflow-x: scroll">

    <g:if test="${flash.message}">
        <div class="alert alert-block alert-success" role="status">${flash.message}</div>
    </g:if>
    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <th></th>
            <th></th>
            <th>任务序号</th>
            <th>任务内容</th>
            <th>任务人</th>
            <th>计划交付日期</th>
            <th>实际完成日期</th>
            <th>超期</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${tasks}" status="i" var="task">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                <td>${i+1}</td>
                <td>
                    <g:if test="${task[1]==TaskStatus.DEVELOP}">
                        <i class="ace-icon fa fa-circle-o blue"></i>
                    </g:if>
                    <g:elseif test="${task[1]==TaskStatus.SIT}">
                        <i class="ace-icon fa fa-adjust orange"></i>
                    </g:elseif>
                    <g:else>
                        <i class="ace-icon fa fa-circle green"></i>
                    </g:else>
                </td>
                <td><g:link action="show" id="${task[0]}">${task[2]}</g:link></td>
                <td><div style="width:300px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;">${task[7]}</div></td>
                <td>${task[3]}</td>
                <%
                    DateTime dt = new DateTime(task[4],1,1,0,0)
                    Date planDeliveryDate = dt.plusWeeks(task[5]-1).dayOfWeek().withMaximumValue().toDate()
                %>

                <td>
                <g:if test="${(task[1]==TaskStatus.DEVELOP||task[1]==TaskStatus.SIT)&&planDeliveryDate<new Date()}">
                    <span class="red">${planDeliveryDate?.format("yy-MM-dd")}</span>
                </g:if>
                <g:elseif test="${task[1]==TaskStatus.DEVELOP||task[1]==TaskStatus.SIT}">
                    <span class="yellow">${planDeliveryDate?.format("yy-MM-dd")}</span>
                </g:elseif>
                <g:else>
                    <span class="black">${planDeliveryDate?.format("yy-MM-dd")}</span>
                </g:else>
                </td>

                <td>${task[6]?.format("yy-MM-dd")}</td>

                <td>
                    <g:if test="${task[6]}">
                        <g:set var="tp" value="${task[6]-planDeliveryDate}"></g:set>
                        <g:if test="${tp>0}">
                            <span class="label label-danger">${tp}</span>
                        </g:if>
                        <g:else>
                            <span class="label label-success">${tp}</span>
                        </g:else>
                    </g:if>
                </td>
                <td>
                    <g:if test="${task[1]==TaskStatus.DEVELOP}">
                        <input wpid="${task[8]}" tid="${task[0]}" type="button" class="btn btn-xs btn-warning cancel_plan" value="取消安排" />
                    </g:if>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
    <div class="pagination">
        <g:paginate total="${taskInstanceCount ?: 0}"/>
        <span style="padding-left: 20px;position: relative;bottom: 30px">总共<span style="color: darkblue">${taskInstanceCount ?: 0}</span>条</span>
    </div>
</div>

<script type="text/javascript">
    var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
    basepath= basepath.substring(0,basepath.indexOf('/')) ;

    $(function(){

        $('.person').typeahead({
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

        $('.cancel_plan').click(function(){
            var cp = $(this);
            $.ajax({
                url : '/'+basepath+'/weeklyPlan/ajaxRemoveTask4Plan',
                type : 'POST',
                dataType : 'json',
                data : {
                    wpid : cp.attr("wpid"),
                    tid : cp.attr("tid")
                },
                timeout : 10000,
                error : function(e){
                    alert("任务安排失败");
                },
                success : function(json) {
                    cp.parents("tr").remove();
                }
            });
        })
    })
</script>
</body>
</html>
