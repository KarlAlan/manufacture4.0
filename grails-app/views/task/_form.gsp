<%@ page import="com.rcstc.manufacture.DemandCharacter; com.rcstc.manufacture.DemandType; com.rcstc.manufacture.TaskType; com.rcstc.manufacture.Task; com.rcstc.manufacture.Priority" %>

<style type="text/css">

</style>



<div class="row">
    <div class="col-md-8" style="padding: 20px">
        <div class="form-group">
            <label for="project" class="col-sm-2 control-label"><g:message code="task.project.label" default="Project" /></label>
            <div class="col-sm-10">
                <g:select id="project" name="project.id" from="${pl}" optionKey="id" required="" value="${taskInstance?.project?.id}" class="many-to-one form-control" />
            </div>
        </div>
        <div class="form-group">
            <label for="type" class="col-sm-2 control-label"><g:message code="task.type.label" default="Type" /></label>
            <div class="col-sm-10">
                <g:select id="type" name="type" from="${tt*.name}" keys="${tt*.name()}" value="${taskInstance?.type?.name()?:TaskType.MAINTENANCE_TASK}" class="form-control" />
            </div>
        </div>
        <!--
        <div class="form-group">
            <label for="description" class="col-sm-2 control-label"><g:message code="task.description.label" default="Description" /></label>
            <div class="col-sm-10">
                <g:textArea name="description" cols="40" rows="5" maxlength="2000" value="${taskInstance?.description}" class="form-control"/>
            </div>
        </div>
        -->
        <div class="form-group">
            <label for="title" class="col-sm-2 control-label">标题</label>
            <div class="col-sm-10">
                <g:textField name="title" value="${taskInstance.title}" required="" class="form-control"/>
            </div>
        </div>
        <div class="form-group">
            <label for="proposal" class="col-sm-2 control-label">任务内容说明</label>
            <div class="col-sm-10">
                <g:textArea name="proposal" cols="40" rows="5" maxlength="2000" required="" value="${taskInstance?.proposal}" class="form-control"/>
            </div>
        </div>
        <div class="form-group">
            <label for="scenario" class="col-sm-2 control-label">任务验收办法</label>
            <div class="col-sm-10">
                <g:textArea name="scenario" cols="40" rows="5" maxlength="2000" value="${taskInstance?.scenario}" class="form-control"/>
            </div>
        </div>
        <div class="form-group">
            <label for="priority" class="col-sm-2 control-label"><g:message code="task.priority.label" default="Priority" /></label>
            <div class="col-sm-10">
                <g:select id="priority" name="priority" from="${Priority?.values()*.name}" keys="${Priority.values()*.name()}" value="${taskInstance?.priority?.name()?:Priority.NORMAL}" class="form-control" />
            </div>
        </div>

        <div class="form-group">
            <label for="planHour" class="col-sm-2 control-label">所花时间</label>
            <div class="col-sm-10">
                <g:field name="planHour" type="number" value="${taskInstance.planHour}" required="" class="form-control"/>
            </div>
        </div>
        <div class="form-group">
            <label for="remark" class="col-sm-2 control-label"><g:message code="task.remark.label" default="Remark" /></label>
            <div class="col-sm-10">
                <g:textArea name="remark" cols="40" rows="5" maxlength="2000" value="${taskInstance?.remark}" class="form-control"/>
            </div>
        </div>
        <div class="form-group">
            <label for="verifier" class="col-sm-2 control-label"><g:message code="task.verifier.label" default="Verifier" /></label>
            <div class="col-sm-10">
                <g:textField name="verifier"  value="${taskInstance?.verifier}" class="form-control"/>
            </div>
        </div>
    </div>

</div>


<script type="text/javascript">
    $(function(){
        var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
        basepath= basepath.substring(0,basepath.indexOf('/')) ;



    })
</script>
