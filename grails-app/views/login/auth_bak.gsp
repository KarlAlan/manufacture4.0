<%@ page import="org.springframework.core.io.support.PropertiesLoaderUtils" %>
<html>
<head>
    <meta name='layout' content='general'/>
    <title><g:message code="springSecurity.login.title"/></title>
    <style>
    *,
    *:after,
    *:before {
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        -ms-box-sizing: border-box;
        -o-box-sizing: border-box;
        box-sizing: border-box;
        padding: 0;
        margin: 0;
    }

    section {
        margin: 100px auto;
        padding: 20px;
        background-color: rgba(250,250,250,0.5);
        border-radius: 5px;
        box-shadow: 0px 0px 5px 0px rgba(0, 0, 0, 0.2),
        inset 0px 1px 0px 0px rgba(250, 250, 250, 0.5);
        border: 1px solid rgba(0, 0, 0, 0.3);
        min-width: 300px;
        max-width: 360px;
    }

    section h1 {
        font-family: 'Raleway', 'Lato', Arial, sans-serif;
        font-size: 24px;
        margin: 0;
        text-align: center;
        padding: 5px 0;
        text-shadow: 2px 2px 0 rgba(255,255,255,0.8);
    }

    section input[type=text],
    section input[type=password] {
        font-family: 'Lato', Calibri, Arial, sans-serif;
        font-size: 16px;
        font-weight: 400;
        text-shadow: 0 1px 0 rgba(255,255,255,0.8);

        /* Size and position */
        width: 100%;
        padding: 8px 18px 6px 45px;

        /* Styles */
        border: none; /* Remove the default border */
        box-shadow:
            inset 0 0 5px rgba(0,0,0,0.1),
            inset 0 3px 2px rgba(0,0,0,0.1);
        border-radius: 3px;
        background: #f9f9f9;
        color: #777;
        transition: color 0.3s ease-out;
    }

    section i {
        /* Size and position */
        left: 0px;
        top: 0px;
        position: absolute;
        height: 36px;
        width: 36px;

        /* Line */
        border-right: 1px solid rgba(0, 0, 0, 0.1);
        box-shadow: 1px 0 0 rgba(255, 255, 255, 0.7);

        /* Styles */
        color: #777777;
        text-align: center;
        line-height: 42px;
        transition: all 0.3s ease-out;
        pointer-events: none;
    }

    section input[type=text] {
        margin-bottom: 10px;
    }

    section input[type=text]:hover ~ i,
    section input[type=password]:hover ~ i {
        color: #52cfeb;
    }

    section input[type=text]:focus ~ i,
    section input[type=password]:focus ~ i {
        color: #42A2BC;
    }

    section input[type=text]:focus,
    section input[type=password]:focus,
    section button[type=submit]:focus {
        outline: none;
    }



    </style>
</head>

<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-6 col-md-4"></div>

        <div class="col-xs-6 col-md-4">
            <section>
                <form action='${postUrl}' method='POST' id='loginForm' class='cssform' autocomplete='off'>
                    <%
                        def properties = PropertiesLoaderUtils.loadAllProperties("env.properties")
                    %>
                    <h1>${properties.getProperty('sys_name')}</h1>
                    <p style="position: relative;margin-top: 10px">
                        <input autocapitalize="off" autocomplete="off" id="j_username" name="j_username" placeholder="Username" type="text" required>
                        <i class="icon-user icon-large" style="height: 36px;width: 36px;line-height: 36px"></i>
                    </p>
                    <p style="position: relative;margin-top: 10px">
                        <input autocapitalize="off" id="j_password" name="j_password" placeholder="Password" type="password" required>
                        <i class="icon-lock icon-large"  style="height: 36px;width: 36px;line-height: 36px"></i>
                    </p>
                    <p id="remember_me_holder">
                        <input type='checkbox' class='chk' name='${rememberMeParameter}' id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if>/>
                        <g:message code="springSecurity.login.remember.me.label"/>
                        <span style="float: right">
                            <g:link controller="login" action="register">新用户注册</g:link>
                        </span>
                    </p>
                    <g:if test='${flash.message}'>
                        <div class='login_message'>${flash.message}</div>
                    </g:if>
                    <p>
                        <button type="button" class="btn btn-primary btn-block" onclick="form.submit();">${message(code: "springSecurity.login.button")}</button>
                    </p>
                </form>
            </section>
        </div>
        <div class="col-xs-6 col-md-4"></div>
    </div>

</div>

<script type='text/javascript'>
    <!--
    (function() {
        document.forms['loginForm'].elements['j_username'].focus();
    })();
    // -->
</script>
</body>
</html>
