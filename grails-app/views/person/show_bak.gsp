
<%@ page import="com.rcstc.manufacture.Person" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
<ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
    <li role="presentation">
        <g:link class="list" action="employees">
            <g:message code="person.show" args="[entityName]" />
        </g:link>
    </li>
    <li role="presentation" class="active">
        <g:link class="list" action="show">
            <g:message code="person.show" args="[entityName]" />
        </g:link>
    </li>
</ul>

<div id="show-person" class="content scaffold-show" role="main">
<!--
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			-->
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list person">

        <g:if test="${personInstance?.username}">
            <li class="fieldcontain">
                <span id="username-label" class="property-label"><g:message code="person.username.label" default="Username" /></span>

                <span class="property-value" aria-labelledby="username-label"><g:fieldValue bean="${personInstance}" field="username"/></span>

            </li>
        </g:if>

        <g:if test="${personInstance?.name}">
            <li class="fieldcontain">
                <span id="name-label" class="property-label"><g:message code="person.name.label" default="Name" /></span>

                <span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${personInstance}" field="name"/></span>

            </li>
        </g:if>

        <g:if test="${personInstance?.email}">
            <li class="fieldcontain">
                <span id="email-label" class="property-label"><g:message code="person.email.label" default="Email" /></span>

                <span class="property-value" aria-labelledby="email-label"><g:fieldValue bean="${personInstance}" field="email"/></span>

            </li>
        </g:if>

        <g:if test="${personInstance?.phone}">
            <li class="fieldcontain">
                <span id="phone-label" class="property-label"><g:message code="person.phone.label" default="Phone" /></span>

                <span class="property-value" aria-labelledby="phone-label"><g:fieldValue bean="${personInstance}" field="phone"/></span>

            </li>
        </g:if>

        <g:if test="${personInstance?.company}">
            <li class="fieldcontain">
                <span id="company-label" class="property-label"><g:message code="person.company.label" default="Company" /></span>

                <span class="property-value" aria-labelledby="company-label"><g:fieldValue bean="${personInstance}" field="company"/></span>

            </li>
        </g:if>

        <g:if test="${personInstance?.department}">
            <li class="fieldcontain">
                <span id="department-label" class="property-label"><g:message code="person.department.label" default="department" /></span>

                <span class="property-value" aria-labelledby="department-label"><g:fieldValue bean="${personInstance}" field="department"/></span>

            </li>
        </g:if>

        <g:if test="${personInstance?.jobTitle}">
            <li class="fieldcontain">
                <span id="jobTitle-label" class="property-label"><g:message code="person.jobTitle.label" default="Job Title" /></span>

                <span class="property-value" aria-labelledby="jobTitle-label"><g:fieldValue bean="${personInstance}" field="jobTitle"/></span>

            </li>
        </g:if>

        <g:if test="${personInstance?.education}">
            <li class="fieldcontain">
                <span id="education-label" class="property-label"><g:message code="person.education.label" default="Education" /></span>

                <span class="property-value" aria-labelledby="education-label"><g:fieldValue bean="${personInstance}" field="education"/></span>

            </li>
        </g:if>

        <g:if test="${personInstance?.startWork}">
            <li class="fieldcontain">
                <span id="startWork-label" class="property-label"><g:message code="person.startWork.label" default="Start Work" /></span>

                <span class="property-value" aria-labelledby="startWork-label"><g:formatDate date="${personInstance?.startWork}" /></span>

            </li>
        </g:if>

        <g:if test="${personInstance?.emtryTime}">
            <li class="fieldcontain">
                <span id="emtryTime-label" class="property-label"><g:message code="person.emtryTime.label" default="Emtry Time" /></span>

                <span class="property-value" aria-labelledby="emtryTime-label"><g:formatDate date="${personInstance?.emtryTime}" /></span>

            </li>
        </g:if>

        <g:if test="${personInstance?.administrativeLevel}">
            <li class="fieldcontain">
                <span id="administrativeLevel-label" class="property-label"><g:message code="person.administrativeLevel.label" default="Administrative Level" /></span>

                <span class="property-value" aria-labelledby="administrativeLevel-label"><g:fieldValue bean="${personInstance}" field="administrativeLevel"/></span>

            </li>
        </g:if>

        <g:if test="${personInstance?.skillLevel}">
            <li class="fieldcontain">
                <span id="skillLevel-label" class="property-label"><g:message code="person.skillLevel.label" default="Skill Level" /></span>

                <span class="property-value" aria-labelledby="skillLevel-label"><g:fieldValue bean="${personInstance}" field="skillLevel"/></span>

            </li>
        </g:if>




    </ol>
    <g:form url="[resource:personInstance, action:'delete']" method="DELETE">
        <fieldset class="buttons">
            <g:link class="edit" action="edit" resource="${personInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
            <g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
        </fieldset>
    </g:form>
</div>
</body>
</html>
