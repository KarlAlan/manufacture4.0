<%@ page import="org.springframework.core.io.support.PropertiesLoaderUtils" %>
<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:message code="springSecurity.login.title"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${assetPath(src: 'apple-touch-icon.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${assetPath(src: 'apple-touch-icon-retina.png')}">
    <asset:stylesheet src="application.css"/>
    <asset:javascript src="application.js"/>

    <link rel="stylesheet" href="${createLink(uri:'/css/font-awesome.min.css')}">
    <link rel="stylesheet" media="all" href="${createLink(uri:'/css/daterangepicker-bs3.css')}">
    <script src="${createLink(uri:'/js/moment.js')}"></script>
    <script src="${createLink(uri:'/js/daterangepicker.js')}"></script>

    <!--[if lte IE 9]>
    <asset:stylesheet src="ace-part2.css" class="ace-main-stylesheet" />
    <![endif]-->

    <!--[if lte IE 9]>
    <asset:stylesheet src="ace-ie.css"/>
    <![endif]-->

    <!-- inline styles related to this page -->

    <!-- ace settings handler -->
    <asset:javascript src="ace-extra.js"/>

    <!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->

    <!--[if lte IE 8]>
    <asset:javascript src="html5shiv.js"/>
    <asset:javascript src="respond.js"/>
    <![endif]-->
</head>

<body class="login-layout blur-login">
<%
    def properties = PropertiesLoaderUtils.loadAllProperties("env.properties")
%>
<div class="main-container">
<div class="main-content">
<div class="row">
<div class="col-sm-10 col-sm-offset-1">
<div class="login-container">
<div class="center">
    <h1>
        <!--
        <i class="ace-icon fa fa-leaf green"></i>
        <span class="red">Ace</span>
        -->
        <span class="white" id="id-text2">${properties.getProperty('sys_name')}</span>
    </h1>
    <h4 class="light-blue" id="id-company-text">&copy; ${properties.getProperty('logo_tip')}</h4>
</div>

<div class="space-6"></div>

<div class="position-relative">
    <div id="login-box" class="login-box visible widget-box no-border">
        <div class="widget-body">
            <div class="widget-main">
                <h4 class="header blue lighter bigger">
                    <i class="ace-icon fa fa-coffee green"></i>
                    请输入登录账号
                </h4>

                <div class="space-6"></div>

                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>

                <form action='${postUrl}' method='POST' id='loginForm' autocomplete='off'>
                    <fieldset>
                        <label class="block clearfix">
                            <span class="block input-icon input-icon-right">
                                <input type="text" class="form-control" placeholder="Username" autocapitalize="off" autocomplete="off" id="j_username" name="j_username"/>
                                <i class="ace-icon fa fa-user"></i>
                            </span>
                        </label>

                        <label class="block clearfix">
                            <span class="block input-icon input-icon-right">
                                <input type="password" class="form-control" placeholder="Password" autocapitalize="off" id="j_password" name="j_password"/>
                                <i class="ace-icon fa fa-lock"></i>
                            </span>
                        </label>

                        <div class="space"></div>

                        <div class="clearfix">
                            <label class="inline">
                                <input type="checkbox" class="ace" name='${rememberMeParameter}' id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if>/>
                                <span class="lbl">记住我</span>
                            </label>

                            <button type="button" class="width-35 pull-right btn btn-sm btn-primary" onclick="form.submit();">
                                <i class="ace-icon fa fa-key"></i>
                                <span class="bigger-110">${message(code: "springSecurity.login.button")}</span>
                            </button>
                        </div>

                        <div class="space-4"></div>
                    </fieldset>
                </form>

                <!--
                <div class="social-or-login center">
                    <span class="bigger-110">Or Login Using</span>
                </div>

                <div class="space-6"></div>

                <div class="social-login center">
                    <a class="btn btn-primary">
                        <i class="ace-icon fa fa-facebook"></i>
                    </a>

                    <a class="btn btn-info">
                        <i class="ace-icon fa fa-twitter"></i>
                    </a>

                    <a class="btn btn-danger">
                        <i class="ace-icon fa fa-google-plus"></i>
                    </a>
                </div>
                -->
            </div><!-- /.widget-main -->

            <div class="toolbar clearfix">
                <div>
                    <!--
                    <a href="#" data-target="#forgot-box" class="forgot-password-link">
                        <i class="ace-icon fa fa-arrow-left"></i>
                        忘记密码？
                    </a>
                    -->
                </div>

                <div>
                    <a href="#" data-target="#signup-box" class="user-signup-link">
                        新用户注册
                        <i class="ace-icon fa fa-arrow-right"></i>
                    </a>
                </div>
            </div>
        </div><!-- /.widget-body -->
    </div><!-- /.login-box -->

    <div id="forgot-box" class="forgot-box widget-box no-border">
        <div class="widget-body">
            <div class="widget-main">
                <h4 class="header red lighter bigger">
                    <i class="ace-icon fa fa-key"></i>
                    Retrieve Password
                </h4>

                <div class="space-6"></div>
                <p>
                    Enter your email and to receive instructions
                </p>

                <form>
                    <fieldset>
                        <label class="block clearfix">
                            <span class="block input-icon input-icon-right">
                                <input type="email" class="form-control" placeholder="Email" />
                                <i class="ace-icon fa fa-envelope"></i>
                            </span>
                        </label>

                        <div class="clearfix">
                            <button type="button" class="width-35 pull-right btn btn-sm btn-danger">
                                <i class="ace-icon fa fa-lightbulb-o"></i>
                                <span class="bigger-110">Send Me!</span>
                            </button>
                        </div>
                    </fieldset>
                </form>
            </div><!-- /.widget-main -->

            <div class="toolbar center">
                <a href="#" data-target="#login-box" class="back-to-login-link">
                    Back to login
                    <i class="ace-icon fa fa-arrow-right"></i>
                </a>
            </div>
        </div><!-- /.widget-body -->
    </div><!-- /.forgot-box -->

    <div id="signup-box" class="signup-box widget-box no-border">
        <div class="widget-body">
            <div class="widget-main">
                <h4 class="header green lighter bigger">
                    <i class="ace-icon fa fa-users blue"></i>
                    新用户注册
                </h4>

                <div class="space-6"></div>
                <p> 请输入您的个人注册资料: </p>

                <g:form controller="login" action="createPerson">
                    <fieldset>


                        <label class="block clearfix">
                            <span class="block input-icon input-icon-right">
                                <input type="text" class="form-control" required="" placeholder="用户名" name="username" value="${params.username?:''}"/>
                                <i class="ace-icon fa fa-user"></i>
                            </span>
                        </label>

                        <label class="block clearfix">
                            <span class="block input-icon input-icon-right">
                                <input type="password" class="form-control" required="" placeholder="密码" name="password"/>
                                <i class="ace-icon fa fa-lock"></i>
                            </span>
                        </label>

                        <label class="block clearfix">
                            <span class="block input-icon input-icon-right">
                                <input type="password" class="form-control" required="" placeholder="重复密码" />
                                <i class="ace-icon fa fa-retweet"></i>
                            </span>
                        </label>

                        <label class="block clearfix">
                            <span class="block input-icon input-icon-right">
                                <input type="text" class="form-control" required="" placeholder="姓名" name="name" value="${params.name?:''}"/>
                                <i class="ace-icon fa fa-user"></i>
                            </span>
                        </label>

                        <!--
                        <label class="block clearfix">
                            <span class="block input-icon input-icon-right">
                                <input type="email" class="form-control" required="" placeholder="Email" name="email" value="${params.email?:''}"/>
                                <i class="ace-icon fa fa-envelope"></i>
                            </span>
                        </label>
                        -->

                        <label class="block clearfix">
                            <span class="block input-icon input-icon-right">
                                <input type="text" class="form-control" required="" placeholder="联系电话" name="phone" value="${params.phone?:''}"/>
                                <i class="ace-icon fa fa-phone"></i>
                            </span>
                        </label>

                        <label class="block clearfix">
                            <span class="block input-icon input-icon-right">
                                <input type="text" class="form-control" required="" placeholder="所属公司名称" name="company" value="${params.company?:''}"/>
                                <i class="ace-icon fa fa-building"></i>
                            </span>
                        </label>

                        <label class="block clearfix">
                            <span class="block input-icon input-icon-right">
                                <input type="text" class="form-control" placeholder="邀请码" name="inviteCode" required=""/>
                                <i class="ace-icon fa fa-user-md"></i>
                            </span>
                        </label>

                        <label class="block">
                            <input type="checkbox" class="ace" />
                            <span class="lbl">
                                我接受
                                <a href="#">用户条款</a>
                            </span>
                        </label>

                        <div class="space-24"></div>

                        <div class="clearfix">
                            <button type="reset" class="width-30 pull-left btn btn-sm">
                                <i class="ace-icon fa fa-refresh"></i>
                                <span class="bigger-110">重设</span>
                            </button>

                            <button type="submit" class="width-65 pull-right btn btn-sm btn-success">
                                <span class="bigger-110">注册</span>

                                <i class="ace-icon fa fa-arrow-right icon-on-right"></i>
                            </button>
                        </div>
                    </fieldset>
                </g:form>
            </div>

            <div class="toolbar center">
                <a href="#" data-target="#login-box" class="back-to-login-link">
                    <i class="ace-icon fa fa-arrow-left"></i>
                    返回登录
                </a>
            </div>
        </div><!-- /.widget-body -->
    </div><!-- /.signup-box -->
</div><!-- /.position-relative -->

<!--
<div class="navbar-fixed-top align-right">
    <br />
    &nbsp;
    <a id="btn-login-dark" href="#">Dark</a>
    &nbsp;
    <span class="blue">/</span>
    &nbsp;
    <a id="btn-login-blur" href="#">Blur</a>
    &nbsp;
    <span class="blue">/</span>
    &nbsp;
    <a id="btn-login-light" href="#">Light</a>
    &nbsp; &nbsp; &nbsp;
</div>
-->
</div>
</div><!-- /.col -->
</div><!-- /.row -->
</div><!-- /.main-content -->
</div><!-- /.main-container -->

<!-- basic scripts -->

<!--[if !IE]> -->
<script type="text/javascript">
    window.jQuery || document.write("<script src='../assets/js/jquery.js'>"+"<"+"/script>");
</script>

<!-- <![endif]-->

<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='../assets/js/jquery1x.js'>"+"<"+"/script>");
</script>
<![endif]-->
<script type="text/javascript">
    if('ontouchstart' in document.documentElement) document.write("<script src='../assets/js/jquery.mobile.custom.js'>"+"<"+"/script>");
</script>

<!-- inline scripts related to this page -->
<script type="text/javascript">
    jQuery(function($) {
        $(document).on('click', '.toolbar a[data-target]', function(e) {
            e.preventDefault();
            var target = $(this).data('target');
            $('.widget-box.visible').removeClass('visible');//hide others
            $(target).addClass('visible');//show target
        });
    });



    //you don't need this, just used for changing background
    jQuery(function($) {
        $('#btn-login-dark').on('click', function(e) {
            $('body').attr('class', 'login-layout');
            $('#id-text2').attr('class', 'white');
            $('#id-company-text').attr('class', 'blue');

            e.preventDefault();
        });
        $('#btn-login-light').on('click', function(e) {
            $('body').attr('class', 'login-layout light-login');
            $('#id-text2').attr('class', 'grey');
            $('#id-company-text').attr('class', 'blue');

            e.preventDefault();
        });
        $('#btn-login-blur').on('click', function(e) {
            $('body').attr('class', 'login-layout blur-login');
            $('#id-text2').attr('class', 'white');
            $('#id-company-text').attr('class', 'light-blue');

            e.preventDefault();
        });

    });
</script>
</body>
</html>
