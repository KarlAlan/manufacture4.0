<%@ page import="com.rcstc.manufacture.Priority; com.rcstc.manufacture.TaskStatus" %>

<!DOCTYPE html>

<%
    def springSecurityService = grailsApplication.mainContext.getBean("springSecurityService");
    def loguser =  springSecurityService.currentUser
%>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'job.label', default: 'Job')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <style  type="text/css">

    .search_item {
        display: inline-block;
        margin: 5px;
    }

    .search_bar {

        padding: 5px;
    }
        .task_proposal:hover{
            cursor: pointer;
        }
    </style>
</head>
<body>
<ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
    <li role="presentation" class="active">
        <g:link class="list" action="personalJobs">
            <g:message code="batch.label" args="[entityName]" />
        </g:link>
    </li>
</ul>
<a href="#list-job" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
<!--<h1><g:message code="default.list.label" args="[entityName]" /></h1> -->
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>
<div title="查询条件">
    <g:form id="search_list" controller="Batch" action="personalJobs" method="post">
        <ul class="search_bar">
            <li class="search_item"><label>项目名称：</label><g:select name="pid" from="${pl}"  optionKey="id"
                                                                  value="${params.pid}" noSelection="['-1':'-所有-']" class="form-control"/></li>
            <li class="search_item"><label>序号：</label><input value="${params.job_serial}" id="job_serial" name="job_serial" class="form-control" placeholder="序号"></li>

            <li class="search_item" style="float: right"><button type="submit" class="btn btn-info">查询</button></li>

        </ul>
    </g:form>
</div>


<div id="list-job" class="content scaffold-list" role="main">

    <table class="table table-bordered">
        <thead>
        <tr>
            <th></th>
            <g:sortableColumn property="serial" title="${message(code: 'task.serial.label', default: 'Serial')}" />

            <th><g:message code="task.project.label" default="Project" /></th>

            <g:sortableColumn property="type" style="display: none" title="${message(code: 'task.type.label', default: 'Type')}" />

            <g:sortableColumn property="proposal" title="${message(code: 'task.proposal.label', default: 'Proposal')}" />

            <th>超期</th>
            <th>状态</th>
            <th>操作</th>

        </tr>
        </thead>
        <tbody>
        <g:each in="${bjs}" status="i" var="bj">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                <td>
                    <g:if test="${bj[5]==Priority.EMERGENCY}">
                        <i class="icon-warning-sign" style="color: darkred"></i>
                    </g:if>
                    <g:elseif test="${bj[5]==Priority.NORMAL}">
                        <i class="icon-info-sign" style="color: darkorange"></i>
                    </g:elseif>
                    <g:else>
                        <i class="icon-exclamation-sign" style="color: darkgreen"></i>
                    </g:else>
                </td>
                <td><g:link action="show" id="${bj[0]}">${bj[1]}</g:link></td>

                <td>${bj[2]}</td>

                <td style="display: none">${bj[10]}</td>

                <td class="task_proposal" style="width: 300px"><div style="width:300px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" >${bj[3]}</div></td>

                <td>${bj[7]-new Date()}</td>
                <td>${bj[6]}</td>
                <td>
                    <g:form id="next_step" controller="Batch" action="nextStep" method="post">
                        <input type="hidden" name="jid" value="${bj[0]}">
                        <g:if test="${bj[6]==TaskStatus.DEVELOP&&bj[11]==loguser.id}">
                            <button type="submit" class="btn btn-success btn-xs" name="submit">提交</button>
                        </g:if>
                        <g:if test="${bj[6]==TaskStatus.SIT&&bj[12]==loguser.id}">
                            <button type="submit" class="btn btn-success btn-xs" name="pass" value="Y">通过</button>
                            <button type="submit" class="btn btn-danger btn-xs" name="pass" value="N">不通过</button>
                        </g:if>
                    </g:form>
                </td>
                <td style="display: none">${bj[4]}</td>
                <td style="display: none">${bj[9]}</td>
            </tr>
        </g:each>
        </tbody>
    </table>
    <div class="pagination" style="display: block;margin:0 10px">
        <g:paginate total="${bjTotal}" />
    </div>
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
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function(){
        $(".navbar-nav").children("li:eq(0)").addClass("active");

        var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
        basepath= basepath.substring(0,basepath.indexOf('/')) ;

        $(".task_proposal").click(function(){
            var rd = $(this);
            $('#myModalLabel').text($(rd).parents('tr').children('td:eq(2)').text()+'/'+$(rd).parents('tr').children('td:eq(1)').children('a').text())
            $('#desc-modal').empty();
            $('#desc-modal').append("<pre>"+$(rd).children('div').text()+"</pre>");
            $('#desc-modal').append("<pre>"+$(rd).parents('tr').children('td:eq(8)').text()+"</pre>");
            $('#desc-modal').append("<pre>"+$(rd).parents('tr').children('td:eq(7)').text()+"</pre>");

            $('#myModal').modal('toggle');
        })

    })
</script>
</body>
</html>
