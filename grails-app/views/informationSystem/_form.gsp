<%@ page import="com.rcstc.manufacture.InformationSystem" %>



<div class="fieldcontain ${hasErrors(bean: informationSystemInstance, field: 'org', 'error')} required">
	<label for="org">
		<g:message code="informationSystem.org.label" default="Org" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="org" required="" value="${informationSystemInstance?.org}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: informationSystemInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="informationSystem.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${informationSystemInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: informationSystemInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="informationSystem.description.label" default="Description" />
		
	</label>
	<g:textArea name="description" cols="40" rows="5" maxlength="2000" value="${informationSystemInstance?.description}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: informationSystemInstance, field: 'modules', 'error')} ">
	<label for="modules">
		<g:message code="informationSystem.modules.label" default="Modules" />
		
	</label>
	<g:select name="modules" from="${com.rcstc.manufacture.Module.list()}" multiple="multiple" optionKey="id" size="5" value="${informationSystemInstance?.modules*.id}" class="many-to-many"/>

</div>

