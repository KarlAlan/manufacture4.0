<%@ page import="com.rcstc.manufacture.Project" %>

<div class="form-group">
    <label for="fristParty" class="col-sm-2 control-label"><g:message code="project.fristParty.label" default="Frist Party" /></label>
    <div class="col-sm-10">
        <input type="text" class="form-control party" id="fristParty" name="fristParty" placeholder="输入甲方名称" required=""  value="${projectInstance?.fristParty}" autocomplete="off">
    </div>
</div>

<div class="form-group">
    <label for="secondParty" class="col-sm-2 control-label"><g:message code="project.secondParty.label" default="Second Party" /></label>
    <div class="col-sm-10">
        <input type="text" class="form-control party" id="secondParty" name="secondParty" placeholder="输入乙方名称" required="" value="${projectInstance?.secondParty}" autocomplete="off">
    </div>
</div>

<div class="form-group">
    <label for="thirdParty" class="col-sm-2 control-label"><g:message code="project.thirdParty.label" default="Third Party" /></label>
    <div class="col-sm-10">
        <input type="text" class="form-control party" id="thirdParty" name="thirdParty" placeholder="输入第三方名称" value="${projectInstance?.thirdParty}" autocomplete="off">
    </div>
</div>

<div class="form-group">
    <label for="fourthParty" class="col-sm-2 control-label"><g:message code="project.fourthParty.label" default="Fourth Party" /></label>
    <div class="col-sm-10">
        <input type="text" class="form-control party" id="fourthParty" name="fourthParty" placeholder="输入第四方名称" value="${projectInstance?.fourthParty}" autocomplete="off">
    </div>
</div>

<div class="form-group">
    <label for="usingDepartment" class="col-sm-2 control-label"><g:message code="project.usingDepartment.label" default="Using Department" /></label>
    <div class="col-sm-10">
        <input type="text" class="form-control party" id="usingDepartment" name="usingDepartment" placeholder="输入业务单位名称" value="${projectInstance?.usingDepartment}" autocomplete="off">
    </div>
</div>

<div class="form-group">
    <label for="name" class="col-sm-2 control-label"><g:message code="project.name.label" default="Name" /></label>
    <div class="col-sm-10">
        <input type="text" class="form-control" id="name" name="name" placeholder="输入项目名称" required="" value="${projectInstance?.name}">
    </div>
</div>

<div class="form-group">
    <label for="serial" class="col-sm-2 control-label"><g:message code="project.serial.label" default="Serial" /></label>
    <div class="col-sm-10">
        <input type="text" class="form-control" id="serial" name="serial" placeholder="输入合同编号" required="" value="${projectInstance?.serial}">
    </div>
</div>

<div class="form-group">
    <label for="informationSystem" class="col-sm-2 control-label"><g:message code="project.informationSystem.label" default="信息系统" /></label>
    <div class="col-sm-10">
        <g:select name="informationSystem" class="form-control" from="${iss}" optionKey="id" required="" value="${projectInstance?.informationSystem?.id}" />
    </div>
</div>

<div class="form-group">
    <label for="type" class="col-sm-2 control-label"><g:message code="project.type.label" default="Type" /></label>
    <div class="col-sm-10">
        <g:select name="type" class="form-control" from="${com.rcstc.manufacture.ProjectType?.values()}" keys="${com.rcstc.manufacture.ProjectType.values()*.name()}" required="" value="${projectInstance?.type?.name()}" />
    </div>
</div>

<div class="form-group">
    <label for="status" class="col-sm-2 control-label"><g:message code="project.status.label" default="Status" /></label>
    <div class="col-sm-10">
        <g:select name="status" class="form-control" from="${com.rcstc.manufacture.ProjectStatus?.values()}" keys="${com.rcstc.manufacture.ProjectStatus.values()*.name()}" required="" value="${projectInstance?.status?.name()}" />
    </div>
</div>

<div class="form-group">
    <label for="budget" class="col-sm-2 control-label"><g:message code="project.budget.label" default="budget" /></label>
    <div class="col-sm-10">
        <input type="text" class="form-control" id="budget" name="budget" placeholder="输入预算金额" required="" value="${projectInstance?.budget}">
    </div>
</div>

<div class="form-group">
    <label for="approvalDate" class="col-sm-2 control-label"><g:message code="project.approvalDate.label" default="Approval Date" /></label>
    <div class="col-sm-10">
        <div class="controls">
            <div class="input-prepend input-group">
                <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></span>
                <input type="text" readonly="readonly" style="width: 160px" name="approvalDate" id="approvalDate" class="input_date form-control" value="${projectInstance?.approvalDate?.format('yyyy-MM-dd')}" />
            </div>
        </div>
    </div>
</div>

<div class="form-group">
    <label for="perfix" class="col-sm-2 control-label"><g:message code="project.perfix.label" default="Perfix" /></label>
    <div class="col-sm-10">
        <input type="text" class="form-control" id="perfix" name="perfix" placeholder="输入项目编号前缀" required="" value="${projectInstance?.perfix}">
    </div>
</div>

<div class="form-group">
    <label for="autoBuildWeeklyReport" class="col-sm-2 control-label"><g:message code="project.autoBuildWeeklyReport.label" default="Auto Build Weekly Report" /></label>
    <div class="col-sm-10">
        <g:checkBox class="form-control" id="autoBuildWeeklyReport" name="autoBuildWeeklyReport" value="${projectInstance?.autoBuildWeeklyReport}" />
    </div>
</div>

<script type="text/javascript">
    var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
    basepath= basepath.substring(0,basepath.indexOf('/')) ;

    $(document).ready(function() {
        $('.input_date').daterangepicker({
            singleDatePicker: true,
            format: 'YYYY-MM-DD',
            startDate: '<g:formatDate format="yyyy-MM-dd" date="${new Date()}"/>'
        }, function(start, end, label) {
            console.log(start.toISOString(), end.toISOString(), label);
        });
    });

    $('.party').typeahead({
        source: function(query,process) {
            return $.post('/'+basepath+'/project/ajaxCompanyName', { query: query },function(data){
                return process(data);
            });
        }
    });
</script>