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
    <g:form url="[resource:taskInstance, action:'saveDeployTask']" role="form" class="form-horizontal">
        <input type="hidden" name="type" value="${TaskType.DEPLOYMENT_TASK}">
        <input type="hidden" name="priority" value="${Priority.NORMAL}">
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
                    <label class="control-label bolder blue col-sm-2">待发布需求</label>
                    <div class="col-sm-10" style="max-height: 300px; overflow-y: scroll">
                    <!-- #section:custom/checkbox -->
                        <g:each in="${demands}" status="i" var="demand">
                            <div class="checkbox" style="background-color: #dcdcdc;margin: 1px">
                                <label>
                                    <input name="deploy_demand" type="checkbox" class="ace deploy_demand" dd="${demand.id}"/>
                                    <span class="lbl">
                                        ${demand.serial}>>${demand.category1}
                                        <g:if test="${demand.category2}">
                                            >>${demand.category2}
                                        </g:if>
                                        <div style="width:300px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;">
                                        >>${demand.description}
                                        </div>
                                    </span>
                                </label>
                            </div>
                        </g:each>
                    <!-- /section:custom/checkbox -->
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


    $(function(){
        var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
        basepath= basepath.substring(0,basepath.indexOf('/')) ;

        $('.deploy_demand').click(function(){
            var dd = $(this);

            if(dd.is(':checked')){
                $('<input type="hidden" name="deploy_name">').attr("value",dd.attr("dd")).appendTo($('form'));
            } else {
                $('input[type=hidden][name=deploy_name][value='+dd.attr('dd')+']').remove();
            }

        })
    })
</script>
</body>
</html>
