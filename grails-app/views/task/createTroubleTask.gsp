<%@ page import="com.rcstc.manufacture.Priority; com.rcstc.manufacture.TaskType" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'task.label', default: 'Task')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
</head>
<body>


<div id="create-task" class="content scaffold-create" role="main">
<!--
			<h1><g:message code="default.create.label" args="[entityName]" /></h1>
			-->
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${taskInstance}">
        <ul class="errors" role="alert">
            <g:eachError bean="${taskInstance}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form url="[resource:taskInstance, action:'saveTroubleTask']" role="form" class="form-horizontal">
        <input type="hidden" name="type" value="${TaskType.TROUBLE_SHOOTING_TASK}">
        <input type="hidden" name="project" value="${project.id}">
        <div class="row">
            <div class="col-md-8" style="padding: 20px">
                <div class="form-group">
                    <label for="project_name" class="col-sm-2 control-label"><g:message code="task.project.label" default="Project" /></label>
                    <div class="col-sm-10">
                        <g:textField name="project_name" value="${project.name}" disabled=""></g:textField>
                    </div>
                </div>

                <div class="form-group">
                    <label for="proposal" class="col-sm-2 control-label">故障表现</label>
                    <div class="col-sm-10">
                        <g:textArea name="proposal" cols="40" rows="5" maxlength="2000" value="${taskInstance?.proposal}" class="form-control"/>
                    </div>
                </div>

                <div class="form-group">
                    <label for="priority" class="col-sm-2 control-label">严重程度</label>
                    <div class="col-sm-10">
                        <g:select id="priority" name="priority" from="${Priority?.values()*.name}" keys="${Priority.values()*.name()}" value="${taskInstance?.priority?.name()?:Priority.NORMAL}" class="form-control" />
                    </div>
                </div>

                <div class="form-group">
                    <label for="scenario" class="col-sm-2 control-label">原因与解决方法</label>
                    <div class="col-sm-10">
                        <g:textArea name="scenario" cols="40" rows="5" maxlength="2000" value="${taskInstance?.scenario}" class="form-control"/>
                    </div>
                </div>

                <div class="form-group">
                    <label for="planHour" class="col-sm-2 control-label">所花时间</label>
                    <div class="col-sm-10">
                        <g:field name="planHour" type="number" value="1" required="" class="form-control"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="remark" class="col-sm-2 control-label"><g:message code="task.remark.label" default="Remark" /></label>
                    <div class="col-sm-10">
                        <g:textArea name="remark" cols="40" rows="5" maxlength="2000" value="${taskInstance?.remark}" class="form-control"/>
                    </div>
                </div>
            </div>

        </div>
        <div class="col-sm-offset-2 col-sm-10">
            <g:submitButton name="create" class="btn btn-success" value="${message(code: 'default.button.create.label', default: 'Create')}" />
        </div>
    </g:form>
</div>
<script type="text/javascript">
    var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
    basepath= basepath.substring(0,basepath.indexOf('/')) ;

    $(function(){


    })
</script>
</body>
</html>
