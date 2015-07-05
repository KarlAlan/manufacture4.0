<%@ page import="com.rcstc.manufacture.Batch" %>




<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="serial">
        <g:message code="batch.serial.label" default="Serial" />
        
    </label>

    <div class="col-sm-9">
        <g:textField name="serial" value="${batchInstance?.serial}"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="project">
        <g:message code="batch.project.label" default="Project" />
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-9">
        <g:select id="project" name="project.id" from="${com.rcstc.manufacture.Project.list()}" optionKey="id" required="" value="${batchInstance?.project?.id}" class="many-to-one"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="description">
        <g:message code="batch.description.label" default="Description" />
        
    </label>

    <div class="col-sm-9">
        <g:textArea name="description" cols="40" rows="5" maxlength="2000" value="${batchInstance?.description}"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="startDate">
        <g:message code="batch.startDate.label" default="Start Date" />
        
    </label>

    <div class="col-sm-9">
        <g:datePicker name="startDate" precision="day"  value="${batchInstance?.startDate}" default="none" noSelection="['': '']" />

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="planFinishDate">
        <g:message code="batch.planFinishDate.label" default="Plan Finish Date" />
        
    </label>

    <div class="col-sm-9">
        <g:datePicker name="planFinishDate" precision="day"  value="${batchInstance?.planFinishDate}" default="none" noSelection="['': '']" />

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="planHour">
        <g:message code="batch.planHour.label" default="Plan Hour" />
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-9">
        <g:field name="planHour" type="number" value="${batchInstance.planHour}" required=""/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="bufferHour">
        <g:message code="batch.bufferHour.label" default="Buffer Hour" />
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-9">
        <g:field name="bufferHour" type="number" value="${batchInstance.bufferHour}" required=""/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="developer">
        <g:message code="batch.developer.label" default="Developer" />
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-9">
        <g:select id="developer" name="developer.id" from="${com.rcstc.manufacture.Person.list()}" optionKey="id" required="" value="${batchInstance?.developer?.id}" class="many-to-one"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="sitPeople">
        <g:message code="batch.sitPeople.label" default="Sit People" />
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-9">
        <g:select id="sitPeople" name="sitPeople.id" from="${com.rcstc.manufacture.Person.list()}" optionKey="id" required="" value="${batchInstance?.sitPeople?.id}" class="many-to-one"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="remark">
        <g:message code="batch.remark.label" default="Remark" />
        
    </label>

    <div class="col-sm-9">
        <g:textArea name="remark" cols="40" rows="5" maxlength="2000" value="${batchInstance?.remark}"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="isDone">
        <g:message code="batch.isDone.label" default="Is Done" />
        
    </label>

    <div class="col-sm-9">
        <g:checkBox name="isDone" value="${batchInstance?.isDone}" />

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="finishDate">
        <g:message code="batch.finishDate.label" default="Finish Date" />
        
    </label>

    <div class="col-sm-9">
        <g:datePicker name="finishDate" precision="day"  value="${batchInstance?.finishDate}" default="none" noSelection="['': '']" />

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="task">
        <g:message code="batch.task.label" default="Task" />
        
    </label>

    <div class="col-sm-9">
        
<ul class="one-to-many">
<g:each in="${batchInstance?.task?}" var="t">
    <li><g:link controller="task" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="task" action="create" params="['batch.id': batchInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'task.label', default: 'Task')])}</g:link>
</li>
</ul>


    </div>
</div>

