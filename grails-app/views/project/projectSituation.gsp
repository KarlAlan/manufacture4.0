
<%@page import="java.text.SimpleDateFormat"%>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="layout" content="main">
    <g:set var="entityName"
           value="${message(code: 'demand.label', default: 'Demand')}" />
    <title><g:message code="demand.list" args="[entityName]" /></title>
</head>
<body>

<form id="search_list" action="projectSituation" method="post" class="form-inline" role="form"	style="padding: 0 10px 10px 10px">
    <div class="form-group">
        <label for="pid">项目名称：</label>
        <g:select name="pid" from="${pl}"  optionKey="id" value="${params.pid}" noSelection="['-1':'-所有-']" class="form-control"/>
    </div>


    <button type="submit" class="btn btn-info btn-sm" style="float: right">查询</button>
</form>

<div id="list-task" class="content scaffold-list" role="main">
    <g:if test="${flash.message}">
        <div class="message" role="status">
            ${flash.message}
        </div>
    </g:if>
    <table class="table table-striped table-bordered">
        <thead>
        <tr>
            <th>模块</th>
            <th>功能</th>
            <th>新需求</th>
            <th>需求变更</th>
            <th>Bug</th>
            <th>完成度</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <%
            int new_emergency_total = 0
            int new_total = 0
            int mod_emergency_total = 0
            int mod_total = 0
            int bug_emergency_total = 0
            int bug_total = 0
            int finish_total = 0
            int total_total = 0

        %>
        <g:each in="${ps}" status="i" var="ds">
            <%
                new_emergency_total = new_emergency_total + ds.new_emergency_amount
                new_total = new_total + ds.new_amount
                mod_emergency_total = mod_emergency_total + ds.mod_emergency_amount
                mod_total = mod_total + ds.mod_amount
                bug_emergency_total = bug_emergency_total + ds.bug_emergency_amount
                bug_total = bug_total + ds.bug_amount
                finish_total = finish_total + ds.finish_amount
                total_total = total_total + ds.total_amount
            %>
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                <td>${ds.category1}</td>
                <td>${ds.category2}</td>
                <td style="text-align: right"><span class="label label-danger">${ds.new_emergency_amount!=0?ds.new_emergency_amount:''}</span><span class="label label-info">${(ds.new_amount+ds.new_emergency_amount)!=0?(ds.new_amount+ds.new_emergency_amount):''}</span></td>
                <td style="text-align: right"><span class="label label-danger">${ds.mod_emergency_amount!=0?ds.mod_emergency_amount:''}</span><span class="label label-info">${(ds.mod_amount+ds.mod_emergency_amount)!=0?(ds.mod_amount+ds.mod_emergency_amount):''}</span></td>
                <td style="text-align: right"><span class="label label-danger">${ds.bug_emergency_amount!=0?ds.bug_emergency_amount:''}</span><span class="label label-info">${(ds.bug_amount+ds.bug_emergency_amount)!=0?(ds.bug_amount+ds.bug_emergency_amount):''}</span></td>
                <td style="text-align: right"><span class="label label-success">${ds.finish_amount!=0?ds.finish_amount:''}</span><span class="label label-primary">${(ds.finish_amount+ds.total_amount)!=0?(ds.finish_amount+ds.total_amount):''}</span></td>
                <td>
                    <div class="progress" style="margin-bottom: 0px">
                        <%
                            int fr = 0
                            if(ds.finish_amount+ds.total_amount!=0)
                                fr = ds.finish_amount/(ds.finish_amount+ds.total_amount)*100
                        %>
                        <g:if test="${fr<40}">
                            <div class="progress-bar progress-bar-danger progress-bar-striped active" role="progressbar" aria-valuenow="${fr}" aria-valuemin="0" aria-valuemax="100" style="width: ${fr}%;">
                                ${fr}%
                            </div>
                        </g:if>
                        <g:elseif test="${fr<80}">
                            <div class="progress-bar progress-bar-warning progress-bar-striped active" role="progressbar" aria-valuenow="${fr}" aria-valuemin="0" aria-valuemax="100" style="width: ${fr}%;">
                                ${fr}%
                            </div>
                        </g:elseif>
                        <g:else>
                            <div class="progress-bar progress-bar-success progress-bar-striped active" role="progressbar" aria-valuenow="${fr}" aria-valuemin="0" aria-valuemax="100" style="width: ${fr}%;">
                                ${fr}%
                            </div>
                        </g:else>

                    </div>
                </td>
            </tr>
        </g:each>

        <tr style="font: 16px bold; background: lightcyan;color: darkblue;text-align: right">
            <td>合计</td>
            <td></td>
            <td style="text-align: right"><span class="label label-danger">${new_emergency_total!=0?new_emergency_total:''}</span><span class="label label-info">${(new_total+new_emergency_total)!=0?(new_total+new_emergency_total):''}</span></td>
            <td style="text-align: right"><span class="label label-danger">${mod_emergency_total!=0?mod_emergency_total:''}</span><span class="label label-info">${(mod_total+mod_emergency_total)!=0?(mod_total+mod_emergency_total):''}</span></td>
            <td style="text-align: right"><span class="label label-danger">${bug_emergency_total!=0?bug_emergency_total:''}</span><span class="label label-info">${(bug_total+bug_emergency_total)!=0?(bug_total+bug_emergency_total):''}</span></td>
            <td style="text-align: right"><span class="label label-success">${finish_total!=0?finish_total:''}</span><span class="label label-primary">${(finish_total+total_total)!=0?(finish_total+total_total):''}</span></td>
            <td>
                <div class="progress" style="margin-bottom: 0px">
                    <%
                        int fr1 = 0
                        if(finish_total+total_total!=0)
                            fr1 = finish_total/(finish_total+total_total)*100
                    %>
                    <g:if test="${fr1<40}">
                        <div class="progress-bar progress-bar-danger progress-bar-striped active" role="progressbar" aria-valuenow="${fr1}" aria-valuemin="0" aria-valuemax="100" style="width: ${fr1}%;">
                            ${fr1}%
                        </div>
                    </g:if>
                    <g:elseif test="${fr1<80}">
                        <div class="progress-bar progress-bar-warning progress-bar-striped active" role="progressbar" aria-valuenow="${fr1}" aria-valuemin="0" aria-valuemax="100" style="width: ${fr1}%;">
                            ${fr1}%
                        </div>
                    </g:elseif>
                    <g:else>
                        <div class="progress-bar progress-bar-success progress-bar-striped active" role="progressbar" aria-valuenow="${fr1}" aria-valuemin="0" aria-valuemax="100" style="width: ${fr1}%;">
                            ${fr1}%
                        </div>
                    </g:else>

                </div>
            </td>
        </tr>
        </tbody>
    </table>
</div>

<script type="text/javascript">
    $(document).ready(function() {

    });
</script>

</body>


</html>
