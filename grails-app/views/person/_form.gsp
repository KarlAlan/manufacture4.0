<%@ page import="com.rcstc.manufacture.Person" %>


<!--
<div class="fieldcontain ${hasErrors(bean: personInstance, field: 'username', 'error')} required">
	<label for="username">
		<g:message code="person.username.label" default="Username" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="username" required="" value="${personInstance?.username}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: personInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="person.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="password" required="" value="${personInstance?.password}"/>

</div>
-->

<div class="form-group">
    <label for="name" class="col-sm-2 control-label"><g:message code="person.name.label" default="Name" /></label>
    <div class="col-sm-10">
        <input type="text" class="form-control" required="" id="name" name="name" placeholder="姓名"  value="${personInstance?.name}" autocomplete="off" >
    </div>
</div>

<div class="form-group">
    <label for="email" class="col-sm-2 control-label"><g:message code="person.email.label" default="Email" /></label>
    <div class="col-sm-10">
        <input type="email" class="form-control" required="" id="email" name="email" placeholder="邮件地址"  value="${personInstance?.email}" >
    </div>
</div>

<div class="form-group">
    <label for="phone" class="col-sm-2 control-label"><g:message code="person.phone.label" default="Phone" /></label>
    <div class="col-sm-10">
        <input type="text" class="form-control" required="" id="phone" name="phone" placeholder="联系电话"  value="${personInstance?.phone}" >
    </div>
</div>

<div class="form-group">
    <label for="company" class="col-sm-2 control-label"><g:message code="person.company.label" default="company" /></label>
    <div class="col-sm-10">
        <input type="text" class="form-control" required="" id="company" name="company" placeholder="所属公司名称"  value="${personInstance?.company}" >
    </div>
</div>

<div class="form-group">
    <label for="department" class="col-sm-2 control-label"><g:message code="person.department.label" default="department" /></label>
    <div class="col-sm-10">
        <input type="text" class="form-control" id="department" name="department" placeholder="所属部门名称"  value="${personInstance?.department}" >
    </div>
</div>

<div class="form-group">
    <label for="jobTitle" class="col-sm-2 control-label"><g:message code="person.jobTitle.label" default="Job Title" /></label>
    <div class="col-sm-10">
        <input type="text" class="form-control" id="jobTitle" name="jobTitle" placeholder="职衔"  value="${personInstance?.jobTitle}" >
    </div>
</div>

<!--
<div class="fieldcontain ${hasErrors(bean: personInstance, field: 'accountExpired', 'error')} ">
	<label for="accountExpired">
		<g:message code="person.accountExpired.label" default="Account Expired" />
		
	</label>
	<g:checkBox name="accountExpired" value="${personInstance?.accountExpired}" />

</div>

<div class="fieldcontain ${hasErrors(bean: personInstance, field: 'accountLocked', 'error')} ">
	<label for="accountLocked">
		<g:message code="person.accountLocked.label" default="Account Locked" />
		
	</label>
	<g:checkBox name="accountLocked" value="${personInstance?.accountLocked}" />

</div>

<div class="fieldcontain ${hasErrors(bean: personInstance, field: 'enabled', 'error')} ">
	<label for="enabled">
<g:message code="person.enabled.label" default="Enabled" />

</label>
<g:checkBox name="enabled" value="${personInstance?.enabled}" />

</div>

<div class="fieldcontain ${hasErrors(bean: personInstance, field: 'passwordExpired', 'error')} ">
	<label for="passwordExpired">
<g:message code="person.passwordExpired.label" default="Password Expired" />

</label>
<g:checkBox name="passwordExpired" value="${personInstance?.passwordExpired}" />

</div>
-->

<g:if test="${personInstance?.type==com.rcstc.manufacture.PersonType.雇员}">

    <div class="form-group">
        <label for="education" class="col-sm-2 control-label"><g:message code="person.education.label" default="Education" /></label>
        <div class="col-sm-10">
            <input type="text" class="form-control" id="education" name="education" placeholder="学历"  value="${personInstance?.education}" >
        </div>
    </div>

    <div class="form-group">
        <label for="startWork" class="col-sm-2 control-label"><g:message code="person.startWork.label" default="Start Work" /></label>
        <div class="col-sm-10">
            <div class="controls">
                <div class="input-prepend input-group">
                    <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></span>
                    <input type="text" readonly="readonly" style="width: 160px" name="startWork" id="startWork" class="input_date form-control" value="${personInstance?.startWork}"/>
                </div>
            </div>
        </div>
    </div>

    <div class="form-group">
        <label for="emtryTime" class="col-sm-2 control-label"><g:message code="person.emtryTime.label" default="Entry Time" /></label>
        <div class="col-sm-10">
            <div class="controls">
                <div class="input-prepend input-group">
                    <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></span>
                    <input type="text" readonly="readonly" style="width: 160px" name="emtryTime" id="emtryTime" class="input_date form-control" value="${personInstance?.emtryTime}"/>
                </div>
            </div>
        </div>
    </div>

    <div class="form-group">
        <label for="administrativeLevel" class="col-sm-2 control-label"><g:message code="person.administrativeLevel.label" default="administrativeLevel" /></label>
        <div class="col-sm-10">
            <input type="text" class="form-control" id="administrativeLevel" name="administrativeLevel" placeholder="行政级别"  value="${personInstance?.administrativeLevel}" >
        </div>
    </div>

    <div class="form-group">
        <label for="skillLevel" class="col-sm-2 control-label"><g:message code="person.skillLevel.label" default="skillLevel" /></label>
        <div class="col-sm-10">
            <input type="text" class="form-control" id="skillLevel" name="education" placeholder="技能级别"  value="${personInstance?.skillLevel}" >
        </div>
    </div>

</g:if>


<div class="form-group">
    <label for="type" class="col-sm-2 control-label"><g:message code="person.type.label" default="Type" /></label>
    <div class="col-sm-10">
        <g:select name="type" from="${com.rcstc.manufacture.PersonType?.values()}" keys="${com.rcstc.manufacture.PersonType.values()*.name()}" required="" value="${personInstance?.type?.name()}" class="many-to-one form-control"/>
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


</script>