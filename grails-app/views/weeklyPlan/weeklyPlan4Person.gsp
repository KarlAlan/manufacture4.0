
<%@ page import="com.rcstc.manufacture.WeeklyPlan" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'weeklyPlan.label', default: 'WeeklyPlan')}" />
    <title>每周人员任务安排表</title>
</head>
<body>
<ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
    <li role="presentation" >
        <g:link controller="task" class="list" action="index">
            <g:message code="task.list" args="[entityName]" />
        </g:link>
    </li>
    <li role="presentation" class="active">
        <g:link controller="weeklyPlan" class="create" action="weeklyPlan4Person">
            每周计划
        </g:link>
    </li>
    <li role="presentation">
        <g:link class="create" controller="weeklyPlan" action="schedue">
            周计划安排
        </g:link>
    </li>
</ul>
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>
<g:form action="weeklyPlan4Person">
    <g:hiddenField id="offset" name="offset" value="${params.offset}" />
    <g:actionSubmit value="下一周" action="weeklyPlan4Person" onclick="changeOffset(1);" class="btn btn-xs btn-info pull-right" style="margin-top: 8px"></g:actionSubmit>
    <g:actionSubmit value="上一周" action="weeklyPlan4Person" onclick="changeOffset(-1);" class="btn btn-xs btn-info pull-left" style="margin-top: 8px"></g:actionSubmit>
</g:form>
<h4 id="title_week" style="text-align: center">${year}年第${week}周(${fd}-${ld})任务安排及完成情况</h4>

<div id="list-weeklyPlan" class="content scaffold-list" role="main">

    <g:if test="${flash.message}">
        <div class="alert alert-block alert-success" role="status">${flash.message}</div>
    </g:if>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th></th>
            <th></th>
            <th><g:message code="weeklyPlan.person.label" default="Person" /></th>

            <g:sortableColumn property="planTasksAmount" title="${message(code: 'weeklyPlan.planTasksAmount.label', default: 'Plan Tasks Amount')}" />

            <g:sortableColumn property="planWorkload" title="${message(code: 'weeklyPlan.planWorkload.label', default: 'Plan Workload')}" />

            <g:sortableColumn property="actualTasksAmount" title="${message(code: 'weeklyPlan.actualTasksAmount.label', default: 'Actual Tasks Amount')}" />

            <g:sortableColumn property="actualWorkload" title="${message(code: 'weeklyPlan.actualWorkload.label', default: 'Actual Workload')}" />

        </tr>
        </thead>
        <tbody>
        <g:each in="${wps}" status="i" var="weeklyPlanInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                <td>
                    ${(params.offset ? params.int('offset') : 0)+i+1}
                </td>
                <td>
                    <i class="glyphicon glyphicon-plus" style="color: darkgreen" wpid="${weeklyPlanInstance.id }"></i>
                </td>
                <td><g:link action="show" id="${weeklyPlanInstance.id}">${fieldValue(bean: weeklyPlanInstance, field: "person")}</g:link></td>

                <td>${fieldValue(bean: weeklyPlanInstance, field: "planTasksAmount")}</td>

                <td>${fieldValue(bean: weeklyPlanInstance, field: "planWorkload")}</td>

                <td>${fieldValue(bean: weeklyPlanInstance, field: "actualTasksAmount")}</td>

                <td>${fieldValue(bean: weeklyPlanInstance, field: "actualWorkload")}</td>

            </tr>
            <tr class="task_tr" style="display: none">
                <td colspan="18" style="padding: 0">
                    <table class="table table-bordered" style="margin: 0;font-size: 0.7em">
                        <thead>
                        <tr style="background: beige">
                            <th>任务号</th>
                            <th>状态</th>
                            <th>任务内容</th>
                            <th>测试方案</th>
                            <th>预计时长（小时）</th>
                            <th>任务人</th>
                            <th>完成时间</th>
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
<script type="text/javascript">
    var changeOffset = function(offset){
        var val = parseInt($('#offset').attr("value")) + offset;
        $('#offset').attr("value", val);
    }

    var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
    basepath= basepath.substring(0,basepath.indexOf('/')) ;

    $(function(){
        // open hide task
        $( document).on("click",".glyphicon-plus", function(){
            var dt = $(this)

            $.ajax({
                url : '/'+basepath+'/weeklyPlan/ajaxTasks4WeeklyPlan',
                type : 'POST',
                dataType : 'json',
                data : {
                    wpid : dt.attr('wpid')
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

                    var tb = dt.parents("tr").next().children("td").children("table").children("tbody");
                    tb.empty();
                    $(json).each(function(){
                        var tr = $("<tr />");
                        //$("<td><i class='glyphicon glyphicon-trash'  style='color: orangered' tid='"+this.tid+"'></i></td>").appendTo(tr);
                        $("<td />").text(this.serial).appendTo(tr);
                        $("<td />").text(this.status).appendTo(tr);
                        $("<td />").text(this.proposal).appendTo(tr);
                        $("<td />").text(this.sc).appendTo(tr);
                        $("<td />").text(this.ph).appendTo(tr);
                        $("<td />").text(this.dev).appendTo(tr);
                        $("<td />").text(this.fd).appendTo(tr);

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
    })

</script>
</body>
</html>
