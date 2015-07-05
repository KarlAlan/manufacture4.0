
<%@ page import="com.rcstc.manufacture.Person" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
<ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
    <li role="presentation" class="active">
        <g:link class="list" action="employees">
            <g:message code="person.show" args="[entityName]" />
        </g:link>
    </li>
</ul>

<div id="list-person" class="content scaffold-list" role="main">
    <!--
    <h1><g:message code="default.list.label" args="[entityName]" /></h1>
    -->
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table class="table table-striped table-bordered">
        <thead>
        <tr>

            <g:sortableColumn property="name" title="${message(code: 'person.name.label', default: 'Name')}" />

            <g:sortableColumn property="company" title="${message(code: 'person.company.label', default: 'Company')}" />

            <g:sortableColumn property="department" title="${message(code: 'person.department.label', default: 'Department')}" />

            <g:sortableColumn property="jobTitle" title="${message(code: 'person.jobTitle.label', default: 'Job Title')}" />

            <g:sortableColumn property="email" title="${message(code: 'person.email.label', default: 'Email')}" />

            <g:sortableColumn property="phone" title="${message(code: 'person.phone.label', default: 'Phone')}" />

            <g:sortableColumn property="education" title="${message(code: 'person.education.label', default: 'Education')}" />

            <g:sortableColumn property="startWork" title="${message(code: 'person.startWork.label', default: 'Start Work')}" />

            <g:sortableColumn property="emtryTime" title="${message(code: 'person.emtryTime.label', default: 'Entry Time')}" />

            <g:sortableColumn property="administrativeLevel" title="${message(code: 'person.administrativeLevel.label', default: 'Administrative Level')}" />

            <g:sortableColumn property="skillLevel" title="${message(code: 'person.skillLevel.label', default: 'Skill Level')}" />

        </tr>
        </thead>
        <tbody>
        <g:each in="${employeesList}" status="i" var="personInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="edit" id="${personInstance.id}">${fieldValue(bean: personInstance, field: "name")}</g:link></td>

                <td>${fieldValue(bean: personInstance, field: "company")}</td>

                <td>${fieldValue(bean: personInstance, field: "department")}</td>

                <td>${fieldValue(bean: personInstance, field: "jobTitle")}</td>

                <td>${fieldValue(bean: personInstance, field: "email")}</td>

                <td>${fieldValue(bean: personInstance, field: "phone")}</td>

                <td>${fieldValue(bean: personInstance, field: "education")}</td>

                <td><prettytime:display date="${personInstance.startWork}" /></td>

                <td><prettytime:display date="${personInstance.emtryTime}" /></td>

                <td>${fieldValue(bean: personInstance, field: "administrativeLevel")}</td>

                <td>${fieldValue(bean: personInstance, field: "skillLevel")}</td>

            </tr>
        </g:each>
        </tbody>
    </table>
    <div class="pagination" style="display: block;margin:0 10px">
        <g:paginate total="${employeesCount ?: 0}" />
    </div>
</div>
</body>
</html>
