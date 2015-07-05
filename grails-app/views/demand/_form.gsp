<%@ page import="com.rcstc.manufacture.Demand" %>



<div class="fieldcontain ${hasErrors(bean: demandInstance, field: 'project', 'error')} required">
	<label for="project">
		<g:message code="demand.project" default="Project" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="project" name="project.id" from="${pl}" optionKey="id" required="" value="${demandInstance?.project?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: demandInstance, field: 'category1', 'error')} required">
	<label for="category1">
		<g:message code="demand.category1" default="Category1" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="category1" required="" value="${demandInstance?.category1}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: demandInstance, field: 'category2', 'error')} required">
	<label for="category2">
		<g:message code="demand.category2" default="Category2" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="category2" required="" value="${demandInstance?.category2}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: demandInstance, field: 'category3', 'error')} ">
	<label for="category3">
		<g:message code="demand.category3" default="Category3" />
		
	</label>
	<g:textField name="category3" value="${demandInstance?.category3}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: demandInstance, field: 'description', 'error')} required">
	<label for="description">
		<g:message code="demand.description" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="description" cols="40" rows="5" maxlength="2000" required="" value="${demandInstance?.description}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: demandInstance, field: 'planStartDate', 'error')} required">
	<label for="planStartDate">
		<g:message code="demand.planStartDate" default="Plan Start Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="planStartDate" precision="day"  value="${demandInstance?.planStartDate}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: demandInstance, field: 'planStopDate', 'error')} ">
	<label for="planStopDate">
		<g:message code="demand.planStopDate" default="Plan Stop Date" />
		
	</label>
	<g:datePicker name="planStopDate" precision="day"  value="${demandInstance?.planStopDate}" default="none" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: demandInstance, field: 'closeDate', 'error')} ">
	<label for="closeDate">
		<g:message code="demand.closeDate.label" default="Close Date" />
		
	</label>
	<g:datePicker name="closeDate" precision="day"  value="${demandInstance?.closeDate}" default="none" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: demandInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="demand.type" default="Type" />
		
	</label>
	<g:select name="type" from="${com.rcstc.manufacture.DemandType?.values()*.name}" keys="${com.rcstc.manufacture.DemandType.values()*.name()}" value="${demandInstance?.type?.name()}"  noSelection="['': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: demandInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="demand.status" default="Status" />
		
	</label>
	<g:select name="status" from="${com.rcstc.manufacture.DemandStatus?.values()*.name}" keys="${com.rcstc.manufacture.DemandStatus.values()*.name()}" value="${demandInstance?.status?.name()}"  noSelection="['': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: demandInstance, field: 'priority', 'error')} required">
	<label for="priority">
		<g:message code="demand.priority" default="Priority" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="priority" from="${com.rcstc.manufacture.Priority?.values()*.name}" keys="${com.rcstc.manufacture.Priority.values()*.name()}" required="" value="${demandInstance?.priority?.name()}" />

</div>

<div class="fieldcontain ${hasErrors(bean: demandInstance, field: 'proposal', 'error')} ">
	<label for="proposal">
		<g:message code="demand.proposal" default="Proposal" />
		
	</label>
	<g:textArea name="proposal" cols="40" rows="5" maxlength="2000" value="${demandInstance?.proposal}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: demandInstance, field: 'remark', 'error')} required">
	<label for="remark">
		<g:message code="demand.remark" default="Remark" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="remark" cols="40" rows="5" maxlength="2000" required="" value="${demandInstance?.remark}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: demandInstance, field: 'updateDate', 'error')} ">
	<label for="updateDate">
		<g:message code="demand.updateDate" default="Update Date" />
		
	</label>
	<g:datePicker name="updateDate" precision="day"  value="${demandInstance?.updateDate}" default="none" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: demandInstance, field: 'picPeople', 'error')} ">
	<label for="picPeople">
		<g:message code="demand.picPeople" default="Pic People" />
		
	</label>
	<g:textField name="picPeople" value="${demandInstance?.picPeople}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: demandInstance, field: 'serial', 'error')} required">
	<label for="serial">
		<g:message code="demand.serial" default="Serial" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="serial" required="" value="${demandInstance?.serial}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: demandInstance, field: 'submitPeople', 'error')} required">
	<label for="submitPeople">
		<g:message code="demand.submitPeople" default="Submit People" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="submitPeople" required="" value="${demandInstance?.submitPeople}"/>

</div>

