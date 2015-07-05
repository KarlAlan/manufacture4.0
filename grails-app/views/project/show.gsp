
<%@ page import="com.rcstc.manufacture.Project" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
    <ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
        <li role="presentation" class="active">
            <a href="#">
                <g:message code="project.show" args="[entityName]" />
            </a>
        </li>
        <li role="presentation">
            <g:link class="list" action="index">
                <g:message code="project.list" args="[entityName]" />
            </g:link>
        </li>
        <li role="presentation">
            <g:link class="create" action="create">
                <g:message code="project.create" args="[entityName]" />
            </g:link>
        </li>
        <li role="presentation">
            <g:link class="create" action="people4Project">
                项目通讯录
            </g:link>
        </li>
    </ul>
		<div id="show-project" class="content scaffold-show" role="main">
            <!--
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			-->
			<g:if test="${flash.message}">
                <div class="alert alert-success no-margin">
                    <button type="button" class="close" data-dismiss="alert">
                        <i class="ace-icon fa fa-times"></i>
                    </button>

                    <i class="ace-icon fa fa-umbrella bigger-120 blue"></i>
                    ${flash.message}
                </div>
			</g:if>
			<ol class="property-list project">
			
				<g:if test="${projectInstance?.fristParty}">
				<li class="fieldcontain">
					<span id="fristParty-label" class="property-label"><g:message code="project.fristParty.label" default="Frist Party" /></span>
					
						<span class="property-value" aria-labelledby="fristParty-label"><g:fieldValue bean="${projectInstance}" field="fristParty"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${projectInstance?.secondParty}">
				<li class="fieldcontain">
					<span id="secondParty-label" class="property-label"><g:message code="project.secondParty.label" default="Second Party" /></span>
					
						<span class="property-value" aria-labelledby="secondParty-label"><g:fieldValue bean="${projectInstance}" field="secondParty"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${projectInstance?.thirdParty}">
				<li class="fieldcontain">
					<span id="thirdParty-label" class="property-label"><g:message code="project.thirdParty.label" default="Third Party" /></span>
					
						<span class="property-value" aria-labelledby="thirdParty-label"><g:fieldValue bean="${projectInstance}" field="thirdParty"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${projectInstance?.fourthParty}">
				<li class="fieldcontain">
					<span id="fourthParty-label" class="property-label"><g:message code="project.fourthParty.label" default="Fourth Party" /></span>
					
						<span class="property-value" aria-labelledby="fourthParty-label"><g:fieldValue bean="${projectInstance}" field="fourthParty"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${projectInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="project.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${projectInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${projectInstance?.serial}">
				<li class="fieldcontain">
					<span id="serial-label" class="property-label"><g:message code="project.serial.label" default="Serial" /></span>
					
						<span class="property-value" aria-labelledby="serial-label"><g:fieldValue bean="${projectInstance}" field="serial"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${projectInstance?.type}">
				<li class="fieldcontain">
					<span id="type-label" class="property-label"><g:message code="project.type.label" default="Type" /></span>
					
						<span class="property-value" aria-labelledby="type-label"><g:fieldValue bean="${projectInstance}" field="type"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${projectInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="project.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${projectInstance}" field="status"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${projectInstance?.sales}">
				<li class="fieldcontain">
					<span id="sales-label" class="property-label"><g:message code="project.sales.label" default="Sales" /></span>
					
						<span class="property-value" aria-labelledby="sales-label"><g:fieldValue bean="${projectInstance}" field="sales"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${projectInstance?.picPeople}">
				<li class="fieldcontain">
					<span id="picPeople-label" class="property-label"><g:message code="project.picPeople.label" default="Pic People" /></span>
					
						<span class="property-value" aria-labelledby="picPeople-label"><g:fieldValue bean="${projectInstance}" field="picPeople"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${projectInstance?.subjectMatter}">
				<li class="fieldcontain">
					<span id="subjectMatter-label" class="property-label"><g:message code="project.subjectMatter.label" default="Subject Matter" /></span>
					
						<span class="property-value" aria-labelledby="subjectMatter-label"><g:fieldValue bean="${projectInstance}" field="subjectMatter"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${projectInstance?.planDate}">
				<li class="fieldcontain">
					<span id="planDate-label" class="property-label"><g:message code="project.planDate.label" default="Plan Date" /></span>
					
						<span class="property-value" aria-labelledby="planDate-label"><g:formatDate date="${projectInstance?.planDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${projectInstance?.signDate}">
				<li class="fieldcontain">
					<span id="signDate-label" class="property-label"><g:message code="project.signDate.label" default="Sign Date" /></span>
					
						<span class="property-value" aria-labelledby="signDate-label"><g:formatDate date="${projectInstance?.signDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${projectInstance?.closeDate}">
				<li class="fieldcontain">
					<span id="closeDate-label" class="property-label"><g:message code="project.closeDate.label" default="Close Date" /></span>
					
						<span class="property-value" aria-labelledby="closeDate-label"><g:formatDate date="${projectInstance?.closeDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${projectInstance?.perfix}">
				<li class="fieldcontain">
					<span id="perfix-label" class="property-label"><g:message code="project.perfix.label" default="Perfix" /></span>
					
						<span class="property-value" aria-labelledby="perfix-label"><g:fieldValue bean="${projectInstance}" field="perfix"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${projectInstance?.requirmentSerial}">
				<li class="fieldcontain">
					<span id="requirmentSerial-label" class="property-label"><g:message code="project.requirmentSerial.label" default="Requirment Serial" /></span>
					
						<span class="property-value" aria-labelledby="requirmentSerial-label"><g:fieldValue bean="${projectInstance}" field="requirmentSerial"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${projectInstance?.jobSerial}">
				<li class="fieldcontain">
					<span id="jobSerial-label" class="property-label"><g:message code="project.jobSerial.label" default="Job Serial" /></span>
					
						<span class="property-value" aria-labelledby="jobSerial-label"><g:fieldValue bean="${projectInstance}" field="jobSerial"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${projectInstance?.batchSerial}">
				<li class="fieldcontain">
					<span id="batchSerial-label" class="property-label"><g:message code="project.batchSerial.label" default="Batch Serial" /></span>
					
						<span class="property-value" aria-labelledby="batchSerial-label"><g:fieldValue bean="${projectInstance}" field="batchSerial"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:projectInstance, action:'delete']" method="DELETE">
                <div class="col-sm-offset-2 col-sm-10">
                    <g:link class="btn btn-info" action="edit" resource="${projectInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <g:actionSubmit action="delete" class="btn btn-danger" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                </div>
			</g:form>
		</div>
	</body>
</html>
