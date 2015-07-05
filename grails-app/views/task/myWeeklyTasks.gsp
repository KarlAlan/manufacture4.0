<%@ page import="org.joda.time.DateTime; com.rcstc.manufacture.Priority; com.rcstc.manufacture.Task; com.rcstc.manufacture.TaskType; com.rcstc.manufacture.TaskStatus" %>

<!DOCTYPE html>

<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'task.label', default: 'task')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <style  type="text/css">
    th, .nowrap {
        white-space: nowrap;
    }
        .warp {
            width: 300px;
        }
        .sit {
            color: lightgrey;
        }
    </style>
</head>
<body>

<!--<h1><g:message code="default.list.label" args="[entityName]" /></h1> -->
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>

<div id="list-task" class="content scaffold-list" role="main" style="overflow-x: scroll">

    <table class="table table-bordered">
        <thead>
        <tr>
            <th></th>
            <th>序号</th>
            <th>项目</th>
            <th>模块</th>
            <th>菜单</th>
            <th></th>
            <th>需求说明</th>
            <th>任务描述</th>
            <th>测试方法</th>
        </tr>
        </thead>
        <tbody>
        <%
            def dt = new DateTime()
            int year = dt.getWeekyear()
            int week = dt.getWeekOfWeekyear()


        %>
        <g:each in="${tasks}" status="i" var="task">
            <g:if test="${task[0] < year}"><tr style="background-color: lemonchiffon" class="${task[8]==com.rcstc.manufacture.TaskStatus.SIT?'sit':''}"></g:if>
            <g:if test="${task[0] > year}"><tr style="background-color: lightcyan" class="${task[8]==com.rcstc.manufacture.TaskStatus.SIT?'sit':''}"></g:if>
            <g:if test="${task[0] == year && task[1] < week}"><tr style="background-color: lemonchiffon" class="${task[8]==com.rcstc.manufacture.TaskStatus.SIT?'sit':''}"></g:if>
            <g:if test="${task[0] == year && task[1] == week}"><tr style="background-color: lightgreen" class="${task[8]==com.rcstc.manufacture.TaskStatus.SIT?'sit':''}"></g:if>
            <g:if test="${task[0] == year && task[1] > week}"><tr style="background-color: lightcyan" class="${task[8]==com.rcstc.manufacture.TaskStatus.SIT?'sit':''}"></g:if>

                <td class="nowrap">${i+1}</td>
                <td class="nowrap"><g:link controller="demand" action="edit" id="${task[13]}">${task[12]}</g:link>/<g:link action="show" id="${task[2]}">${task[3]}</g:link></td>
            <td class="nowrap">${task[7]}</td>
            <td class="nowrap">${task[10]}</td>
            <td class="nowrap">${task[11]}</td>
            <td class="nowrap">
                <g:if test="${task[6]==Priority.EMERGENCY}">
                    <i class="ace-icon fa icon-warning-sign bigger-120" style="color: red"></i>
                </g:if>
                <g:elseif test="${task[6]==Priority.NORMAL}">
                    <i class="ace-icon fa icon-info-sign bigger-120" style="color: green"></i>
                </g:elseif>
                <g:else>
                    <i class="ace-icon fa icon-exclamation-sign bigger-120" style="color: darkgreen"></i>
                </g:else>
            </td>
            <td class="warp">${raw(task[9])}</td>
            <td class="warp">${raw(task[4])}</td>
            <td class="warp">${raw(task[5])}</td>



            </tr>
        </g:each>
        </tbody>
    </table>

</div>

<!--Edit Description Modal -->
<div class="modal fade bs-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel"></h4>
            </div>
            <div class="modal-body" id="desc-modal">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="updateTask" type="button" class="btn btn-primary">保存</button>
                <button id="verifyTask" type="button" class="btn btn-warning">审核</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">


    $(function(){
        $(".navbar-nav").children("li:eq(2)").addClass("active");

        var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
        basepath= basepath.substring(0,basepath.indexOf('/')) ;

        //  toggle requirement edit
        $(".task_proposal").hover(function(){
            $(this).css("cursor","pointer");
        })
        $(".task_proposal").click(function(){
            var rd = $(this);
            $('#myModalLabel').text($(rd).parents('tr').children('td:eq(3)').text()+'/'+$(rd).parents('tr').children('td:eq(2)').children('a').text())
            $('#desc-modal').empty();
            if($(rd).attr('updateable')=='N'){
                $('#desc-modal').append("<pre>"+$(rd).children('div').text()+"</pre>");
                $('#desc-modal').append("<pre>"+$(rd).parents('tr').children('td:eq(11)').text()+"</pre>");
                $('#desc-modal').append("<pre>"+$(rd).parents('tr').children('td:eq(12)').text()+"</pre>");
                $('#updateDemand').hide()
            } else {
                $('#desc-modal').append('解决方案：<textarea id="updateTaskProposal" class="form-control" rows="5" did="'+$(rd).attr('task_id')+'" >'+$(rd).children('div').text()+"</textarea>");
                $('#desc-modal').append('测试方案：<textarea id="updateTaskScenario" class="form-control" rows="5" did="'+$(rd).attr('task_id')+'" >'+$(rd).parents('tr').children('td:eq(11)').text()+"</textarea>");
                $('#desc-modal').append('备注：<textarea id="updateTaskRemark" class="form-control" rows="3" did="'+$(rd).attr('task_id')+'" >'+$(rd).parents('tr').children('td:eq(12)').text()+"</textarea>");
                $('#desc-modal').append('预估时间：<input id="devTime" type="number" name="devTime" max="30" min="1" value="'+$(rd).parents('tr').children('td:eq(8)').text()+'" class="form-control"/>');
                $('#updateTask').show()
            }

            $('#myModal').modal('toggle');
        })

        // update task
        $("#updateTask").click(function(){
            $.ajax({
                url : '/'+basepath+'/task/ajaxUpdateTask',
                type : 'POST',
                dataType : 'json',
                data : {
                    tid : $('#updateTaskProposal').attr("did"),
                    proposal: $('#updateTaskProposal').val(),
                    scenario: $('#updateTaskScenario').val(),
                    remark: $('#updateTaskRemark').val(),
                    planHour:$('#devTime').val()
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(json) {
                    var td = $('td[task_id="'+$('#updateTaskProposal').attr('did')+'"]');
                    var tr = $(td).parent('tr');
                    $(td).children('div').text($('#updateTaskProposal').val());
                    $(tr).children('td:eq(11)').text($('#updateTaskScenario').val());
                    $(tr).children('td:eq(12)').text($('#updateTaskRemark').val());
                    $(tr).children('td:eq(8)').text($('#devTime').val());
                    //alert("操作成功")
                    //window.location.reload();
                    task_tr.remove();
                }
            });
            $('#myModal').modal('hide');
        })

        // audit task
        $("#verifyTask").click(function(){
            if($('#updateTaskProposal').val()==""||$('#devTime').val()==0){
                alert("解决方案或计划时间没有填写，不能审核！！");
                return;
            }

            $.ajax({
                url : '/'+basepath+'/task/ajaxVerifyTask',
                type : 'POST',
                dataType : 'json',
                data : {
                    tid : $('#updateTaskProposal').attr("did"),
                    proposal: $('#updateTaskProposal').val(),
                    scenario: $('#updateTaskScenario').val(),
                    remark: $('#updateTaskRemark').val(),
                    planHour:$('#devTime').val()
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(json) {
                    /*
                     var td = $('td[task_id="'+$('#updateTaskProposal').attr('did')+'"]');
                     var tr = $(td).parent('tr');
                     $(tr).children('td:eq(10)').text('<g:formatDate date="${new Date()}" format="yyyy-MM-dd hh:mm"></g:formatDate> ');
                     $(tr).children('td:eq(9)').text('<sec:username/>');
                     $(tr).children('td:eq(1)').text('待安排');
                     */
                    $('#search_button').click()
                }
            });
            $('#myModal').modal('hide');
        })

        // delete task
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
            if(confirm("确认要删除作业吗，该操作不能恢复？")){
                var cid = $(this);
                var task_tr = cid.parents("tr");
                //alert(cid.attr("sid"));
                $.ajax({
                    url : '/'+basepath+'/task/ajaxDeleteTask',
                    type : 'POST',
                    dataType : 'json',
                    data : {
                        jid : cid.attr("tid")
                    },
                    timeout : 10000,
                    error : function(e){
                        alert("操作失败")
                    },
                    success : function(json) {
                        //alert("操作成功")
                        //window.location.reload();
                        task_tr.remove();
                    }
                });
            }
        })

    })
</script>
</body>
</html>
