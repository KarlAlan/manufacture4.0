<%@ page import="com.rcstc.manufacture.Person" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>


<div >
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <div title="查询条件" style="margin: 10px">
        <g:form action="authorities" method="post" class="form-inline" role="form">
            <div class="form-group">
                <label>姓名：</label>
                <input value="${params.people}" id="people" name="people" type="text" class="form-control" placeholder="姓名"  style="width: 100px">
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-info btn-sm">查询</button>
            </div>

        </g:form>
    </div>

    <table class="table table-bordered">
        <thead>
        <tr>

            <g:sortableColumn property="username" title="${message(code: 'user.username.label', default: 'Username')}" />

            <th>姓名</th>
            <!--<g:sortableColumn property="password" title="${message(code: 'user.password.label', default: 'Password')}" /> -->

            <g:sortableColumn property="enabled" title="${message(code: 'user.enabled.label', default: 'Enabled')}" />
            <g:sortableColumn property="accountExpired" title="${message(code: 'user.accountExpired.label', default: 'Account Expired')}" />

            <g:sortableColumn property="accountLocked" title="${message(code: 'user.accountLocked.label', default: 'Account Locked')}" />
            <g:sortableColumn property="passwordExpired" title="${message(code: 'user.passwordExpired.label', default: 'Password Expired')}" />

            <th>角色</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${personInstanceList}" status="i" var="personInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td>
                    <g:link controller="person" action="edit" id="${personInstance.id}">${fieldValue(bean: personInstance, field: "username")}</g:link>
                </td>

                <!--<td>${fieldValue(bean: personInstance, field: "password")}</td> -->

                <td>
                ${personInstance.name}
                </td>

                <td><g:checkBox class="account_op" pid="${personInstance.id}" op="enabled" name="${personInstance.id}_enabled" value="${personInstance.enabled}" ></g:checkBox></td>
                <td><g:checkBox class="account_op" pid="${personInstance.id}" op="accountExpired" name="${personInstance.id}_accountExpired" value="${personInstance.accountExpired}" ></g:checkBox></td>
                <td><g:checkBox class="account_op" pid="${personInstance.id}" op="accountLocked" name="${personInstance.id}_accountLocked" value="${personInstance.accountLocked}" ></g:checkBox></td>
                <td><g:checkBox class="account_op" pid="${personInstance.id}" op="passwordExpired" name="${personInstance.id}_passwordExpired" value="${personInstance.passwordExpired}" ></g:checkBox></td>
                <!--
                        <td><g:formatBoolean boolean="${personInstance.accountExpired}" /></td>
						<td><g:formatBoolean boolean="${personInstance.accountLocked}" /></td>
						<td><g:formatBoolean boolean="${personInstance.enabled}" /></td>
                         -->
                <td>
                    <g:each in="${com.rcstc.acl.Role.list()}" status="roles" var="role">
                        <sec:ifNotGranted roles="SUPER_ADMIN">
                            <g:if test="${role.authority!='SUPER_ADMIN'&&role.authority!='FINANCE'}">
                                <g:checkBox name="${personInstance.id}_${role.authority}" value="${personInstance.getAuthorities().contains(role)}" class="roleAssign" pid="${personInstance.id}" authority="${role.id}"></g:checkBox>
                                <label>${role.authority}</label>
                            </g:if>
                        </sec:ifNotGranted>
                        <sec:ifAnyGranted roles="SUPER_ADMIN">
                            <g:checkBox name="${personInstance.id}_${role.authority}" value="${personInstance.getAuthorities().contains(role)}" class="roleAssign" pid="${personInstance.id}" authority="${role.id}"></g:checkBox>
                            <label>${role.authority}</label>
                        </sec:ifAnyGranted>
                    </g:each>

                </td>
                <td>
                    <g:form url="[resource:personInstance, action:'delete']" method="DELETE">
                        <g:actionSubmit class="delete btn btn-xs btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                        <input type="button" class="reset_pw btn btn-xs btn-warning" pid="${personInstance.id}" value="重置密码">
                    </g:form>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
    <div class="pagination">
        <g:paginate total="${personInstanceCount ?: 0}" />
        <span style="padding-left: 20px;position: relative;bottom: 30px">总共<span style="color: darkblue">${personInstanceCount ?: 0}</span>条</span>
    </div>

<script type="text/javascript">
    $(function(){

        var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
        basepath= basepath.substring(0,basepath.indexOf('/')) ;

        $(".roleAssign").click(function(){
            var ra = $(this);
            $.ajax({
                url : '/'+basepath+'/person/ajaxAssignAuthority',
                type : 'POST',
                dataType : 'json',
                data : {
                    pid : ra.attr("pid"),
                    authority : ra.attr("authority")
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(json) {
                    //alert("操作成功")
                    //window.location.reload();
                }
            });
        })

        $(".reset_pw").click(function(){
            var rp = $(this);
            $.ajax({
                url : '/'+basepath+'/person/ajaxResetPassword',
                type : 'POST',
                dataType : 'json',
                data : {
                    pid : rp.attr("pid")
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(json) {
                    alert("成功重置密码，并发送给用户。")
                    //window.location.reload();
                }
            });
        })

        $(".account_op").click(function(){
            var ra = $(this);
            $.ajax({
                url : '/'+basepath+'/person/ajaxSetAccount',
                type : 'POST',
                dataType : 'json',
                data : {
                    pid : ra.attr("pid"),
                    op : ra.attr("op")
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(json) {
                    //alert("操作成功")
                    //window.location.reload();
                }
            });
        })

    })
</script>
</div>
</body>
</html>
