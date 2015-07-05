
<%@page import="java.text.SimpleDateFormat"%>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="layout" content="main">
    <link href="${createLink(uri:'/css/plist.css') }" rel="stylesheet" />
    <g:set var="entityName"
           value="${message(code: 'demand.label', default: 'Demand')}" />
    <title><g:message code="demand.list" args="[entityName]" /></title>
</head>
<body>
<ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
    <li role="presentation" class="active">
        <g:link class="list" action="humanCostsDetail4Project">
            项目人力成本明细表
        </g:link>
    </li>
</ul>
<a href="#list-task" class="skip" tabindex="-1"><g:message
        code="default.link.skip.label" default="Skip to content&hellip;" /></a>

<form id="search_list" action="humanCostsDetail4Project" method="post" 	>
    <div class="row" style="margin: 20px 0">
        <div class="col-lg-6">
            <g:select name="pid" from="${pl}"  optionKey="id" value="${params.pid}" noSelection="['-1':'-所有-']" class="form-control"/>
        </div><!-- /.col-lg-6 -->
        <div class="col-lg-6">
            <button style="float: right" type="submit" class="btn btn-info">查询</button>
        </div><!-- /.col-lg-6 -->
    </div><!-- /.row -->
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
            <th width="200px">项目名称</th>
            <th>人员</th>
            <th>开始日期</th>
            <th>结束日期</th>
            <th>天数</th>
            <th>人日单价</th>
            <th>总价</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${detail}" status="i" var="ds">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td>${ds[1]}</td>
                <td>${ds[3]}</td>
                <td>${ds[5]}</td>
                <td>${ds[7]}</td>
                <td></td>
                <td>${ds[4]}</td>
                <td></td>
            </tr>
        </g:each>
        </tbody>
    </table>
    <div class="pagination" style="display: block;margin:0 10px">
        <g:paginate total="${totalCount ?: 0}" />
    </div>
</div>

</body>


</html>
