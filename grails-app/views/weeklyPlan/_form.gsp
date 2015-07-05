<%@ page import="com.rcstc.manufacture.WeeklyPlan" %>




<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="person">
        <g:message code="weeklyPlan.person.label" default="Person" />
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-9">
        <g:select id="person" name="person.id" from="${com.rcstc.manufacture.Person.list()}" optionKey="id" required="" value="${weeklyPlanInstance?.person?.id}" class="many-to-one"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="planTasksAmount">
        <g:message code="weeklyPlan.planTasksAmount.label" default="Plan Tasks Amount" />
        
    </label>

    <div class="col-sm-9">
        <g:field name="planTasksAmount" value="${fieldValue(bean: weeklyPlanInstance, field: 'planTasksAmount')}"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="planWorkload">
        <g:message code="weeklyPlan.planWorkload.label" default="Plan Workload" />
        
    </label>

    <div class="col-sm-9">
        <g:field name="planWorkload" value="${fieldValue(bean: weeklyPlanInstance, field: 'planWorkload')}"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="actualTasksAmount">
        <g:message code="weeklyPlan.actualTasksAmount.label" default="Actual Tasks Amount" />
        
    </label>

    <div class="col-sm-9">
        <g:field name="actualTasksAmount" value="${fieldValue(bean: weeklyPlanInstance, field: 'actualTasksAmount')}"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="actualWorkload">
        <g:message code="weeklyPlan.actualWorkload.label" default="Actual Workload" />
        
    </label>

    <div class="col-sm-9">
        <g:field name="actualWorkload" value="${fieldValue(bean: weeklyPlanInstance, field: 'actualWorkload')}"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="tasks">
        <g:message code="weeklyPlan.tasks.label" default="Tasks" />
        
    </label>

    <div class="col-sm-9">
        <g:select name="tasks" from="${com.rcstc.manufacture.Task.list()}" multiple="multiple" optionKey="id" size="5" value="${weeklyPlanInstance?.tasks*.id}" class="many-to-many"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="week">
        <g:message code="weeklyPlan.week.label" default="Week" />
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-9">
        <g:field name="week" type="number" value="${weeklyPlanInstance.week}" required=""/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="year">
        <g:message code="weeklyPlan.year.label" default="Year" />
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-9">
        <g:field name="year" type="number" value="${weeklyPlanInstance.year}" required=""/>

    </div>
</div>

