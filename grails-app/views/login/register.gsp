<%@ page import="com.rcstc.manufacture.Person" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name='layout' content='general'/>
    <title>新用户注册</title>
</head>
<body>

<div id="create-user" class="content scaffold-create" role="main">
    <h1>新用户注册</h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${personInstance}">
        <ul class="errors" role="alert">
            <g:eachError bean="${personInstance}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form action="createPerson" >
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

        <div class="fieldcontain ${hasErrors(bean: personInstance, field: 'name', 'error')} required">
            <label for="name">
                <g:message code="person.name.label" default="Name" />
                <span class="required-indicator">*</span>
            </label>
            <g:textField name="name" required="" value="${personInstance?.name}"/>
        </div>

        <div class="fieldcontain ${hasErrors(bean: personInstance, field: 'email', 'error')} required">
            <label for="email">
                <g:message code="person.email.label" default="Email" />
                <span class="required-indicator">*</span>
            </label>
            <g:textField name="email" required="" value="${personInstance?.email}"/>
        </div>

        <div class="fieldcontain ${hasErrors(bean: personInstance, field: 'phone', 'error')} required">
            <label for="phone">
                <g:message code="person.phone.label" default="Phone" />
                <span class="required-indicator">*</span>
            </label>
            <g:textField name="phone" required="" value="${personInstance?.phone}"/>
        </div>

        <div class="fieldcontain ${hasErrors(bean: personInstance, field: 'company', 'error')} ">
            <label for="company">
                <g:message code="person.company.label" default="Company" />

            </label>
            <g:textField name="company" value="${personInstance?.company}"/>
        </div>

        <div class="fieldcontain ${hasErrors(bean: personInstance, field: 'jobTitle', 'error')} ">
            <label for="jobTitle">
                <g:message code="person.jobTitle.label" default="Job Title" />

            </label>
            <g:textField name="jobTitle" value="${personInstance?.jobTitle}"/>
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
        <fieldset class="buttons">
            <g:submitButton name="create" class="save" value="${message(code: 'user.register', default: 'Register')}" />
        </fieldset>
        -->
        <div class="fieldcontain" >
            <label>
            </label>
            <button type="button" class="btn btn-primary" onclick="form.submit();">${message(code: 'user.register', default: 'Register')}</button>
        </div>
    </g:form>
</div>

<script type="text/javascript">
    $(function(){
        /*
        $("form").submit(function(){
            if($("#password").val() != $("#password2").val()){
                alert("Two entered passwords do not match")
                return false
            }else
                return true;
        });
        */
    });
</script>
</body>
</html>
