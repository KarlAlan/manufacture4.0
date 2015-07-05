<%@ page import="com.rcstc.manufacture.PersonProject" %>



<div class="fieldcontain ${hasErrors(bean: personProjectInstance, field: 'person', 'error')} required">
	<label for="person">
		<g:message code="personProject.person.label" default="Person" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="person" name="person.id" from="${com.rcstc.manufacture.Person.list()}" optionKey="id" required="" value="${personProjectInstance?.person?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: personProjectInstance, field: 'project', 'error')} required">
	<label for="project">
		<g:message code="personProject.project.label" default="Project" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="project" name="project.id" from="${com.rcstc.manufacture.Project.list()}" optionKey="id" required="" value="${personProjectInstance?.project?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: personProjectInstance, field: 'projectRole', 'error')} required">
	<label for="projectRole">
		<g:message code="personProject.projectRole.label" default="Project Role" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="projectRole" from="${com.rcstc.manufacture.ProjectRole?.values()}" keys="${com.rcstc.manufacture.ProjectRole.values()*.name()}" required="" value="${personProjectInstance?.projectRole?.name()}" />

</div>

