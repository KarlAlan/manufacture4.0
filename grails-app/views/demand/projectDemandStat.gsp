<%@ page import="com.rcstc.manufacture.Priority; com.rcstc.manufacture.Task; com.rcstc.manufacture.TaskType; com.rcstc.manufacture.TaskStatus" %>

<!DOCTYPE html>

<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'task.label', default: 'task')}" />
    <title>项目需求统计</title>
    <style  type="text/css">

    </style>
</head>
<body>


<!--<h1><g:message code="default.list.label" args="[entityName]" /></h1> -->
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>
<div title="查询条件" style="margin: 10px">
    <g:form action="projectDemandStat" method="post" class="form-inline" role="form">

        <div class="form-group">
            <label>项目名称：</label>
            <g:select name="pid" from="${pl}"  optionKey="id" value="${params.pid}" class="form-control"/>
        </div>

        <div class="form-group">
            <button type="submit" class="btn btn-info btn-sm">查询</button>
        </div>

    </g:form>
</div>

<div class="row">
    <div class="col-md-8">
        <div class="panel panel-info" style="margin: 10px">
            <!-- Default panel contents -->
            <div class="panel-heading">
                需求情况一览表
            </div>

            <!-- Table -->
            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>模块</th>
                    <th>新需求数量</th>
                    <th>需求变更数量</th>
                    <th>BUG数量</th>
                    <th>未完成数量</th>
                    <th>完成数量</th>
                    <th>完成率</th>
                </tr>
                </thead>
                <tbody>
                <%
                    def d3 = 0, d4 = 0, d5 = 0, d6 = 0, d7 = 0
                    %>
                <g:each in="${demands}" status="i" var="pt">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                        <td>${pt[2]}</td>
                        <td style="text-align: right"><span class="label label-primary">${pt[3]!=0?pt[3]:''}</span></td>
                        <td style="text-align: right"><span class="label label-purple">${pt[4]!=0?pt[4]:''}</span></td>
                        <td style="text-align: right"><span class="label label-warning">${pt[5]!=0?pt[5]:''}</span></td>
                        <td style="text-align: right"><span class="label label-info">${pt[7]!=0?pt[7]:''}</span></td>
                        <td style="text-align: right"><span class="label label-success">${pt[6]!=0?pt[6]:''}</span></td>
                        <td>
                            <div class="progress" style="margin-bottom: 0px">
                                <%
                                    int fr = 0
                                    if(pt[6]+pt[7]!=0)
                                        fr = pt[6]/(pt[6]+pt[7])*100
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
                    <%

                        d3 = d3 + pt[3]
                        d4 = d4 + pt[4]
                        d5 = d5 + pt[5]
                        d6 = d6 + pt[6]
                        d7 = d7 + pt[7]
                    %>
                </g:each>
                    <tr>
                        <td><b>合计</b></td>

                        <td style="text-align: right"><span class="label label-primary">${d3}</span></td>
                        <td style="text-align: right"><span class="label label-purple">${d4}</span></td>
                        <td style="text-align: right"><span class="label label-warning">${d5}</span></td>
                        <td style="text-align: right"><span class="label label-info">${d7}</span></td>
                        <td style="text-align: right"><span class="label label-success">${d6}</span></td>
                        <td>
                            <div class="progress" style="margin-bottom: 0px">
                                <%
                                    int fr1 = 0
                                    if(d6+d7!=0)
                                        fr1 = d6/(d6+d7)*100
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

        <div class="space-6"></div>

        <div class="panel panel-info" style="margin: 10px">
            <!-- Default panel contents -->
            <div class="panel-heading">
                需求处理情况一览表
            </div>

            <!-- Table -->
            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>模块</th>
                    <th>草稿</th>
                    <th>BA分析</th>
                    <th>审核</th>
                    <th>系统设计</th>
                    <th>开发</th>
                    <th>SIT</th>
                    <th>UAT</th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${r2}" status="i" var="ds">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                        <td>${ds[2]}</td>
                        <td style="text-align: right"><g:link controller="demand" action="index" params='[pid:"${ds[0]}",demand_status:"1" ]'><span class="label label-info">${ds[3]!=0?ds[3]:''}</span></g:link></td>
                        <td style="text-align: right"><g:link controller="demand" action="index" params='[pid:"${ds[0]}",demand_status:"10" ]'><span class="label label-info">${ds[4]!=0?ds[4]:''}</span></g:link></td>
                        <td style="text-align: right"><g:link controller="demand" action="index" params='[pid:"${ds[0]}",demand_status:"12" ]'><span class="label label-info">${ds[5]!=0?ds[5]:''}</span></g:link></td>
                        <td style="text-align: right"><g:link controller="demand" action="index" params='[pid:"${ds[0]}",demand_status:"20" ]'><span class="label label-info">${ds[6]!=0?ds[6]:''}</span></g:link></td>
                        <td style="text-align: right"><g:link controller="demand" action="index" params='[pid:"${ds[0]}",demand_status:"30" ]'><span class="label label-info">${ds[7]!=0?ds[7]:''}</span></g:link></td>
                        <td style="text-align: right"><g:link controller="demand" action="index" params='[pid:"${ds[0]}",demand_status:"31" ]'><span class="label label-info">${ds[8]!=0?ds[8]:''}</span></g:link></td>
                        <td style="text-align: right"><g:link controller="demand" action="index" params='[pid:"${ds[0]}",demand_status:"32" ]'><span class="label label-info">${ds[9]!=0?ds[9]:''}</span></g:link></td>

                    </tr>
                </g:each>



                </tbody>
            </table>
        </div>
    </div>
    <div class="col-md-4">
        <div class="panel panel-success" style="margin: 10px">
            <!-- Default panel contents -->
            <div class="panel-heading">
                过去三周需求动态
            </div>

            <!-- Table -->
            <table class="table table-striped table-bordered" style="font-size: 0.8em">
                <thead>
                <tr>
                    <th></th>
                    <th>新增数量</th>
                    <th>完成数量</th>
                    <th>UAT数量</th>
                </tr>
                </thead>
                <tbody>
                <%
                    for (int i = 3 ; i>=0 ; i--){
                %>
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                    <g:if test="${i==0}">
                        <td>本周</td>
                    </g:if>
                    <g:else>
                        <td>前${i}周</td>
                    </g:else>

                        <td style="text-align: right"><span class="label label-warning">${nd[i]==0?'':nd[i]}</span></td>
                        <td style="text-align: right"><span class="label label-info">${fd[i]==0?'':fd[i]}</span></td>
                        <td style="text-align: right"><span class="label label-success">${ud[i]==0?'':ud[i]}</span></td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>


    </div>
</div>

<script type="text/javascript">
    $(function(){
        var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
        basepath= basepath.substring(0,basepath.indexOf('/')) ;

    })
</script>
</body>
</html>
