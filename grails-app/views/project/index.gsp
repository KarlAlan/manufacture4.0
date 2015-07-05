
<%@ page import="com.rcstc.manufacture.Project" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <style type="text/css">

    th, td {
        white-space: nowrap;
    }
    </style>
</head>
<body>
<ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
    <li role="presentation" class="active">
        <g:link class="list" action="index">
            <g:message code="project.list" args="[entityName]" />
        </g:link>
    </li>
    <li role="presentation">
        <g:link class="create" action="create">
            <g:message code="project.create" args="[entityName]" />
        </g:link>
    </li>
    <li role="presentation">
        <g:link class="create" action="people4Project">
            项目通讯录
        </g:link>
    </li>
</ul>

<div id="list-project" class="content scaffold-list" role="main" style="overflow-x: scroll">
<!--
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			-->
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table class="table table-bordered">
        <thead>
        <tr>

            <g:sortableColumn property="name" title="${message(code: 'project.name.label', default: 'Name')}" />

            <g:sortableColumn property="serial" title="${message(code: 'project.serial.label', default: 'Serial')}" />
            <g:sortableColumn property="fristParty" title="${message(code: 'project.fristParty.label', default: 'Frist Party')}" />

            <g:sortableColumn property="secondParty" title="${message(code: 'project.secondParty.label', default: 'Second Party')}" />
            <g:sortableColumn property="usingDepartment" title="${message(code: 'project.usingDepartment.label', default: 'Using Department')}" />

            <g:sortableColumn property="type" title="${message(code: 'project.type.label', default: 'type')}" />

            <g:sortableColumn property="informationSystem" title="信息系统" />
            <g:sortableColumn property="budget" title="预算金额" />
            <g:sortableColumn property="approvalDate" title="立项日期" />

            <g:sortableColumn property="status" title="${message(code: 'project.status.label', default: 'Status')}" />
        </tr>
        </thead>
        <tbody>
        <g:each in="${projectInstanceList}" status="i" var="projectInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="edit" id="${projectInstance.id}">${fieldValue(bean: projectInstance, field: "name")}</g:link></td>

                <td>${fieldValue(bean: projectInstance, field: "serial")}</td>

                <td>${fieldValue(bean: projectInstance, field: "fristParty")}</td>

                <td>${fieldValue(bean: projectInstance, field: "secondParty")}</td>
                <td>${fieldValue(bean: projectInstance, field: "usingDepartment")}</td>

                <td>${fieldValue(bean: projectInstance, field: "type")}</td>
                <td>${projectInstance.informationSystem?.name}</td>
                <td><g:formatNumber number="${projectInstance.budget}" format="￥###,##0.00"></g:formatNumber></td>
                <td>${projectInstance.approvalDate?.format("yyyy-MM-dd")}</td>

                <td>${projectInstance.status}</td>
            </tr>
        </g:each>
        </tbody>
    </table>
    <div class="pagination" style="display: block;margin:0 10px">
        <g:paginate total="${projectInstanceCount ?: 0}" />
    </div>
</div>
</body>
</html>
