
<%@ page import="com.rcstc.manufacture.WeeklyReport" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'weeklyReport.label', default: 'WeeklyReport')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
    <ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
        <li role="presentation">
            <g:link class="list" action="index">
                <g:message code="default.list.label" args="[entityName]" />
            </g:link>
        </li>
        <li role="presentation" class="active">
            <a href="#">
                <g:message code="default.show.label" args="[entityName]" />
            </a>
        </li>
    </ul>
    <div class="row">
		<div id="show-weeklyReport" class="col-xs-12" role="main">
            <div class="space-4"></div>
			<g:if test="${flash.message}">
			<div class="alert alert-block alert-success" role="status">${flash.message}</div>
			</g:if>
            <g:render template="weeklyReportEmail"/>
            <g:if test="${weeklyReportInstance.status=='draft'}">
                <g:form url="[resource:weeklyReportInstance, action:'delete']" method="DELETE" class="form-horizontal" role="form">
                    <div class="clearfix form-actions">
                        <div class="col-md-offset-3 col-md-9">
                            <g:link class="btn btn-info" action="edit" resource="${weeklyReportInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                            <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                        </div>
                    </div>
                </g:form>
            </g:if>
		</div>
    </div>
	</body>
</html>
