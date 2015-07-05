<%@ page import="grails.plugin.springsecurity.SpringSecurityUtils; org.springframework.core.io.support.PropertiesLoaderUtils" %>
<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle default="Grails"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${assetPath(src: 'apple-touch-icon.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${assetPath(src: 'apple-touch-icon-retina.png')}">
    <asset:stylesheet src="application.css"/>
    <asset:javascript src="application.js"/>

    <asset:javascript src="ace/elements.fileinput.js"/>
    <asset:javascript src="ace/elements.scroller.js"/>
    <asset:javascript src="jquery.easypiechart.js"/>

    <link rel="stylesheet" href="${createLink(uri:'/css/font-awesome.min.css')}">
    <link rel="stylesheet" media="all" href="${createLink(uri:'/css/daterangepicker-bs3.css')}">
    <script src="${createLink(uri:'/js/moment.js')}"></script>
    <script src="${createLink(uri:'/js/daterangepicker.js')}"></script>

    <asset:stylesheet src="chosen.css"/>
    <asset:javascript src="chosen.jquery.js"/>

    <g:layoutHead/>

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
<body class="no-skin">

<!-- #section:basics/navbar.layout -->
<div id="navbar" class="navbar navbar-default">
<script type="text/javascript">
    try{ace.settings.check('navbar' , 'fixed')}catch(e){}
</script>

<div class="navbar-container" id="navbar-container">
<!-- #section:basics/sidebar.mobile.toggle -->
<button type="button" class="navbar-toggle menu-toggler pull-left" id="menu-toggler" data-target="#sidebar">
    <span class="sr-only">Toggle sidebar</span>

    <span class="icon-bar"></span>

    <span class="icon-bar"></span>

    <span class="icon-bar"></span>
</button>

<!-- /section:basics/sidebar.mobile.toggle -->
<div class="navbar-header pull-left">
    <!-- #section:basics/navbar.layout.brand -->
    <%
        def properties = PropertiesLoaderUtils.loadAllProperties("env.properties")
    %>
    <a href="${properties.getProperty('logo_url')}" class="navbar-brand" style="padding-top: 2px;padding-bottom: 2px">
         <img height="40px" alt="${properties.getProperty('logo_tip')}" src="${assetPath(src: properties.getProperty('logo_img'))}">
    </a>

    <!-- /section:basics/navbar.layout.brand -->

    <!-- #section:basics/navbar.toggle -->

    <!-- /section:basics/navbar.toggle -->
</div>

<!-- #section:basics/navbar.dropdown -->
<div class="navbar-buttons navbar-header pull-right" role="navigation">
<ul class="nav ace-nav">
<li class="grey">
    <a data-toggle="dropdown" class="dropdown-toggle" href="#">
        <i class="ace-icon fa fa-tasks"></i>
        <span class="badge badge-grey">4</span>
    </a>

    <ul class="dropdown-menu-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close">
        <li class="dropdown-header">
            <i class="ace-icon fa fa-check"></i>
            4 Tasks to complete
        </li>

        <li class="dropdown-content">
            <ul class="dropdown-menu dropdown-navbar">
                <li>
                    <a href="#">
                        <div class="clearfix">
                            <span class="pull-left">Software Update</span>
                            <span class="pull-right">65%</span>
                        </div>

                        <div class="progress progress-mini">
                            <div style="width:65%" class="progress-bar"></div>
                        </div>
                    </a>
                </li>

                <li>
                    <a href="#">
                        <div class="clearfix">
                            <span class="pull-left">Hardware Upgrade</span>
                            <span class="pull-right">35%</span>
                        </div>

                        <div class="progress progress-mini">
                            <div style="width:35%" class="progress-bar progress-bar-danger"></div>
                        </div>
                    </a>
                </li>

                <li>
                    <a href="#">
                        <div class="clearfix">
                            <span class="pull-left">Unit Testing</span>
                            <span class="pull-right">15%</span>
                        </div>

                        <div class="progress progress-mini">
                            <div style="width:15%" class="progress-bar progress-bar-warning"></div>
                        </div>
                    </a>
                </li>

                <li>
                    <a href="#">
                        <div class="clearfix">
                            <span class="pull-left">Bug Fixes</span>
                            <span class="pull-right">90%</span>
                        </div>

                        <div class="progress progress-mini progress-striped active">
                            <div style="width:90%" class="progress-bar progress-bar-success"></div>
                        </div>
                    </a>
                </li>
            </ul>
        </li>

        <li class="dropdown-footer">
            <a href="#">
                See tasks with details
                <i class="ace-icon fa fa-arrow-right"></i>
            </a>
        </li>
    </ul>
</li>

<li class="purple">
    <a data-toggle="dropdown" class="dropdown-toggle" href="#">
        <i class="ace-icon fa fa-bell icon-animated-bell"></i>
        <span class="badge badge-important">8</span>
    </a>

    <ul class="dropdown-menu-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-close">
        <li class="dropdown-header">
            <i class="ace-icon fa fa-exclamation-triangle"></i>
            8 Notifications
        </li>

        <li class="dropdown-content">
            <ul class="dropdown-menu dropdown-navbar navbar-pink">
                <li>
                    <a href="#">
                        <div class="clearfix">
                            <span class="pull-left">
                                <i class="btn btn-xs no-hover btn-pink fa fa-comment"></i>
                                New Comments
                            </span>
                            <span class="pull-right badge badge-info">+12</span>
                        </div>
                    </a>
                </li>

                <li>
                    <a href="#">
                        <i class="btn btn-xs btn-primary fa fa-user"></i>
                        Bob just signed up as an editor ...
                    </a>
                </li>

                <li>
                    <a href="#">
                        <div class="clearfix">
                            <span class="pull-left">
                                <i class="btn btn-xs no-hover btn-success fa fa-shopping-cart"></i>
                                New Orders
                            </span>
                            <span class="pull-right badge badge-success">+8</span>
                        </div>
                    </a>
                </li>

                <li>
                    <a href="#">
                        <div class="clearfix">
                            <span class="pull-left">
                                <i class="btn btn-xs no-hover btn-info fa fa-twitter"></i>
                                Followers
                            </span>
                            <span class="pull-right badge badge-info">+11</span>
                        </div>
                    </a>
                </li>
            </ul>
        </li>

        <li class="dropdown-footer">
            <a href="#">
                See all notifications
                <i class="ace-icon fa fa-arrow-right"></i>
            </a>
        </li>
    </ul>
</li>

<li class="green">
    <a data-toggle="dropdown" class="dropdown-toggle" href="#">
        <i class="ace-icon fa fa-envelope icon-animated-vertical"></i>
        <span class="badge badge-success">5</span>
    </a>

    <ul class="dropdown-menu-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close">
        <li class="dropdown-header">
            <i class="ace-icon fa fa-envelope-o"></i>
            5 Messages
        </li>

        <li class="dropdown-content">
            <ul class="dropdown-menu dropdown-navbar">
                <li>
                    <a href="#" class="clearfix">
                        <img src="${assetPath(src: 'avatar.png')}" class="msg-photo" alt="Alex's Avatar" />
                        <span class="msg-body">
                            <span class="msg-title">
                                <span class="blue">Alex:</span>
                                Ciao sociis natoque penatibus et auctor ...
                            </span>

                            <span class="msg-time">
                                <i class="ace-icon fa fa-clock-o"></i>
                                <span>a moment ago</span>
                            </span>
                        </span>
                    </a>
                </li>

                <li>
                    <a href="#" class="clearfix">
                        <img src="${assetPath(src: 'avatar3.png')}" class="msg-photo" alt="Susan's Avatar" />
                        <span class="msg-body">
                            <span class="msg-title">
                                <span class="blue">Susan:</span>
                                Vestibulum id ligula porta felis euismod ...
                            </span>

                            <span class="msg-time">
                                <i class="ace-icon fa fa-clock-o"></i>
                                <span>20 minutes ago</span>
                            </span>
                        </span>
                    </a>
                </li>

                <li>
                    <a href="#" class="clearfix">
                        <img src="${assetPath(src: 'avatar4.png')}" class="msg-photo" alt="Bob's Avatar" />
                        <span class="msg-body">
                            <span class="msg-title">
                                <span class="blue">Bob:</span>
                                Nullam quis risus eget urna mollis ornare ...
                            </span>

                            <span class="msg-time">
                                <i class="ace-icon fa fa-clock-o"></i>
                                <span>3:15 pm</span>
                            </span>
                        </span>
                    </a>
                </li>

                <li>
                    <a href="#" class="clearfix">
                        <img src="${assetPath(src: 'avatar2.png')}" class="msg-photo" alt="Kate's Avatar" />
                        <span class="msg-body">
                            <span class="msg-title">
                                <span class="blue">Kate:</span>
                                Ciao sociis natoque eget urna mollis ornare ...
                            </span>

                            <span class="msg-time">
                                <i class="ace-icon fa fa-clock-o"></i>
                                <span>1:33 pm</span>
                            </span>
                        </span>
                    </a>
                </li>

                <li>
                    <a href="#" class="clearfix">
                        <img src="${assetPath(src: 'avatar5.png')}" class="msg-photo" alt="Fred's Avatar" />
                        <span class="msg-body">
                            <span class="msg-title">
                                <span class="blue">Fred:</span>
                                Vestibulum id penatibus et auctor  ...
                            </span>

                            <span class="msg-time">
                                <i class="ace-icon fa fa-clock-o"></i>
                                <span>10:09 am</span>
                            </span>
                        </span>
                    </a>
                </li>
            </ul>
        </li>

        <li class="dropdown-footer">
            <a href="inbox.html">
                See all messages
                <i class="ace-icon fa fa-arrow-right"></i>
            </a>
        </li>
    </ul>
</li>

<!-- #section:basics/navbar.user_menu -->
<li class="light-blue">
    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
        <img class="nav-user-photo" src="${createLink(controller: 'person', action: 'avatar', params: [username:sec.username()])}" alt="${sec.username()}'s Photo" />
        <span class="user-info">
            <small>欢迎,</small>
            <sec:username/>
        </span>

        <i class="ace-icon fa fa-caret-down"></i>
    </a>

    <ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
        <li>
            <g:link controller="person" action="updatePassword">
                <i class="ace-icon fa fa-cog"></i>
                更新密码
            </g:link>
        </li>

        <li>

            <g:link controller="person" action="show" id="${sec.loggedInUserInfo(field: 'id')}">
                <i class="ace-icon fa fa-user"></i>
                个人资料
            </g:link>
        </li>

        <li class="divider"></li>

        <li>
            <g:form controller="logout" action="index" style="padding: 3px 12px;line-height: 10px">
                <i class="ace-icon fa fa-power-off"></i>
                <button type="submit" style="background: transparent;border: none">退出</button>
            </g:form>
        </li>
    </ul>
</li>

<!-- /section:basics/navbar.user_menu -->
</ul>
</div>

<!-- /section:basics/navbar.dropdown -->
</div><!-- /.navbar-container -->
</div>

<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
<script type="text/javascript">
    try{ace.settings.check('main-container' , 'fixed')}catch(e){}
</script>

<!-- #section:basics/sidebar -->
<div id="sidebar" class="sidebar                  responsive">
<script type="text/javascript">
    try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
</script>

<div class="sidebar-shortcuts" id="sidebar-shortcuts">
    <div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
        <button class="btn btn-success">
            <i class="ace-icon fa fa-list"></i>
        </button>

        <button class="btn btn-info">
            <i class="ace-icon fa fa-tasks"></i>
        </button>

        <!-- #section:basics/sidebar.layout.shortcuts -->
        <button class="btn btn-warning">
            <i class="ace-icon fa fa-tachometer"></i>
        </button>

        <button class="btn btn-danger">
            <i class="ace-icon fa fa-cogs"></i>
        </button>

        <!-- /section:basics/sidebar.layout.shortcuts -->
    </div>

    <div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
        <span class="btn btn-success"></span>

        <span class="btn btn-info"></span>

        <span class="btn btn-warning"></span>

        <span class="btn btn-danger"></span>
    </div>
</div><!-- /.sidebar-shortcuts -->

<ul class="nav nav-list">
<li ${controllerName == 'batch'&&actionName == 'desktop' ? ' class=active' : ''}>
    <g:link controller="batch" action="desktop">
        <i class="menu-icon fa fa-calendar"></i>
        <span class="menu-text">
            个人工作台
            <!-- #section:basics/sidebar.layout.badge -->
            <span class="badge badge-transparent tooltip-error" title="2 Important Events">
                <i class="ace-icon fa fa-exclamation-triangle red bigger-130"></i>
            </span>

            <!-- /section:basics/sidebar.layout.badge -->
        </span>
    </g:link>

    <b class="arrow"></b>
</li>

<li ${controllerName == 'demand' ? ' class=active' : ''}>
    <a href="#" class="dropdown-toggle">
        <i class="menu-icon fa fa-list"></i>
        <span class="menu-text">
            需求管理
        </span>

        <b class="arrow fa fa-angle-down"></b>
    </a>

    <b class="arrow"></b>

    <ul class="submenu">

        <li ${controllerName == 'demand'&&actionName == 'index' ? ' class=active' : ''}>
            <g:link controller="demand" action="index">
                <i class="menu-icon fa fa-caret-right"></i>
                需求管理
            </g:link>

            <b class="arrow"></b>
        </li>
        <li ${controllerName == 'demand'&&actionName == 'projectDemandStat' ? ' class=active' : ''}>
            <g:link controller="demand" action="projectDemandStat">
                <i class="menu-icon fa fa-caret-right"></i>
                需求统计
            </g:link>

            <b class="arrow"></b>
        </li>

    </ul>
</li>

<li ${controllerName == 'task' ? ' class=active' : ''}>
    <a href="#" class="dropdown-toggle">
        <i class="menu-icon fa fa-tasks"></i>
        <span class="menu-text"> 任务管理 </span>

        <b class="arrow fa fa-angle-down"></b>
    </a>

    <b class="arrow"></b>

    <ul class="submenu">
        <li ${controllerName == 'task'&&actionName == 'index' ? ' class=active' : ''}>
            <g:link controller="task" action="index">
                <i class="menu-icon fa fa-caret-right"></i>
                任务管理
            </g:link>

            <b class="arrow"></b>
        </li>
        <li ${controllerName == 'task'&&actionName == 'create' ? ' class=active' : ''}>
            <g:link controller="task" action="create">
                <i class="menu-icon fa fa-caret-right"></i>
                任务登记
            </g:link>

            <b class="arrow"></b>
        </li>
        <li ${controllerName == 'task'&&actionName == 'indexDeployTask' ? ' class=active' : ''}>
            <g:link controller="task" action="indexDeployTask">
                <i class="menu-icon fa fa-caret-right"></i>
                系统发布登记
            </g:link>

            <b class="arrow"></b>
        </li>
        <li ${controllerName == 'task'&&actionName == 'indexTroubleTask' ? ' class=active' : ''}>
            <g:link controller="task" action="indexTroubleTask">
                <i class="menu-icon fa fa-caret-right"></i>
                故障处理登记
            </g:link>

            <b class="arrow"></b>
        </li>
        <li ${controllerName == 'task'&&actionName == 'planTasksStat' ? ' class=active' : ''}>
            <g:link controller="task" action="planTasksStat">
                <i class="menu-icon fa fa-caret-right"></i>
                计划执行情况统计
            </g:link>

            <b class="arrow"></b>
        </li>
        <li ${controllerName == 'task'&&actionName == 'planingTasks' ? ' class=active' : ''}>
            <g:link controller="task" action="planingTasks">
                <i class="menu-icon fa fa-caret-right"></i>
                任务计划查询
            </g:link>

            <b class="arrow"></b>
        </li>
        <li ${controllerName == 'task'&&actionName == 'tasksStat' ? ' class=active' : ''}>
            <g:link controller="task" action="tasksStat">
                <i class="menu-icon fa fa-caret-right"></i>
                任务统计
            </g:link>

            <b class="arrow"></b>
        </li>
        <li ${controllerName == 'task'&&actionName == 'statBackwardTask' ? ' class=active' : ''}>
            <g:link controller="task" action="statBackwardTask">
                <i class="menu-icon fa fa-caret-right"></i>
                任务退回统计
            </g:link>

            <b class="arrow"></b>
        </li>
    </ul>
</li>

<li ${controllerName == 'batch'&&actionName == 'board' ? ' class=active' : ''}>
    <g:link controller="batch" action="board">
        <i class="menu-icon fa fa-tachometer "></i>
        <span class="menu-text"> 生产看板 </span>
    </g:link>

</li>

<li ${controllerName == 'project'||controllerName == 'informationSystem'||controllerName == 'weeklyReport' ? ' class=active' : ''}>
    <a href="#" class="dropdown-toggle">
        <i class="menu-icon fa fa-list-alt"></i>
        <span class="menu-text"> 项目管理 </span>

        <b class="arrow fa fa-angle-down"></b>
    </a>

    <b class="arrow"></b>

    <ul class="submenu">
        <li ${controllerName == 'project'&&actionName == 'index' ? ' class=active' : ''}>
            <g:link controller="project" action="index">
                <i class="menu-icon fa fa-caret-right"></i>
                项目管理
            </g:link>

            <b class="arrow"></b>
        </li>

        <li ${controllerName == 'project'&&actionName == 'people4Project' ? ' class=active' : ''}>
            <g:link controller="project" action="people4Project">
                <i class="menu-icon fa fa-caret-right"></i>
                项目通信录
            </g:link>

            <b class="arrow"></b>
        </li>
        <li ${controllerName == 'weeklyReport'&&actionName == 'index' ? ' class=active' : ''}>
            <g:link controller="weeklyReport" action="index">
                <i class="menu-icon fa fa-caret-right"></i>
                项目周报
            </g:link>

            <b class="arrow"></b>
        </li>
        <li ${controllerName == 'project'&&actionName == 'tracking' ? ' class=active' : ''}>
            <g:link controller="project" action="tracking">
                <i class="menu-icon fa fa-caret-right"></i>
                项目情况跟踪
            </g:link>

            <b class="arrow"></b>
        </li>
        <li ${controllerName == 'project'&&actionName == 'serviceIndicator' ? ' class=active' : ''}>
            <g:link controller="project" action="serviceIndicator">
                <i class="menu-icon fa fa-caret-right"></i>
                服务指标
            </g:link>

            <b class="arrow"></b>
        </li>
        <li ${controllerName == 'informationSystem'&&actionName == 'structure' ? ' class=active' : ''}>
            <g:link controller="informationSystem" action="structure">
                <i class="menu-icon fa fa-caret-right"></i>
                信息系统管理
            </g:link>

            <b class="arrow"></b>
        </li>
    </ul>
</li>

<li ${controllerName == 'person' ? ' class=active' : ''}>
    <a href="#" class="dropdown-toggle">
        <i class="menu-icon fa fa-users"></i>
        <span class="menu-text"> 人力资源管理 </span>

        <b class="arrow fa fa-angle-down"></b>
    </a>

    <b class="arrow"></b>

    <ul class="submenu">
        <li ${controllerName == 'person'&&actionName == 'attendanceOfCompany' ? ' class=active' : ''}>
            <g:link controller="person" action="attendanceOfCompany">
                <i class="menu-icon fa fa-caret-right"></i>
                考勤记录
            </g:link>

            <b class="arrow"></b>
        </li>
        <li ${controllerName == 'person'&&actionName == 'weeklyPersonStat' ? ' class=active' : ''}>
            <g:link controller="person" action="weeklyPersonStat">
                <i class="menu-icon fa fa-caret-right"></i>
                周工作量统计
            </g:link>

            <b class="arrow"></b>
        </li>
        <li ${controllerName == 'person'&&actionName == 'monthlyPersonStat' ? ' class=active' : ''}>
            <g:link controller="person" action="monthlyPersonStat">
                <i class="menu-icon fa fa-caret-right"></i>
                月度人员工作量统计
            </g:link>

            <b class="arrow"></b>
        </li>

    </ul>
</li>

<li ${controllerName == 'bill'||controllerName == 'contract'||controllerName == 'statementOfAccount'||controllerName == 'commission' ? ' class=active' : ''}>
    <a href="#" class="dropdown-toggle">
        <i class="menu-icon fa fa-money"></i>
        <span class="menu-text"> 财务核算 </span>

        <b class="arrow fa fa-angle-down"></b>
    </a>

    <b class="arrow"></b>

    <ul class="submenu">
        <li ${controllerName == 'contract'&&actionName == 'index' ? ' class=active' : ''}>
            <g:link controller="contract" action="index">
                <i class="menu-icon fa fa-caret-right"></i>
                合同管理
            </g:link>

            <b class="arrow"></b>
        </li>

        <li ${controllerName == 'contract'&&actionName == 'receivable' ? ' class=active' : ''}>
            <g:link controller="contract" action="receivable">
                <i class="menu-icon fa fa-caret-right"></i>
                应收查询
            </g:link>

            <b class="arrow"></b>
        </li>

        <li ${controllerName == 'contract'&&actionName == 'payable' ? ' class=active' : ''}>
            <g:link controller="contract" action="payable" params="[at:'Receivable']">
                <i class="menu-icon fa fa-caret-right"></i>
                应付查询
            </g:link>

            <b class="arrow"></b>
        </li>

        <!--


        <li ${controllerName == 'commission'&&actionName == 'index' ? ' class=active' : ''}>
            <g:link controller="commission" action="index">
                <i class="menu-icon fa fa-caret-right"></i>
                项目提成管理
            </g:link>

            <b class="arrow"></b>
        </li>
        -->
    </ul>
</li>

<li ${controllerName == 'person'||controllerName == 'setOfAccount' ? ' class=active' : ''}>
    <a href="#" class="dropdown-toggle">
        <i class="menu-icon fa fa-desktop"></i>
        <span class="menu-text"> 系统管理 </span>

        <b class="arrow fa fa-angle-down"></b>
    </a>

    <b class="arrow"></b>

    <ul class="submenu">
        <li ${controllerName == 'person'&&actionName == 'authorities' ? ' class=active' : ''}>
            <g:link controller="person" action="authorities">
                <i class="menu-icon fa fa-caret-right"></i>
                用户角色管理
            </g:link>

            <b class="arrow"></b>
        </li>

        <li ${controllerName == 'person'&&actionName == 'index' ? ' class=active' : ''}>
            <g:link controller="person" action="index">
                <i class="menu-icon fa fa-caret-right"></i>
                系统用户维护
            </g:link>

            <b class="arrow"></b>
        </li>

        <!--
        <li ${controllerName == 'setOfAccount'&&actionName == 'index' ? ' class=active' : ''}>
            <g:link controller="setOfAccount" action="index">
                <i class="menu-icon fa fa-caret-right"></i>
                帐套设置
            </g:link>

            <b class="arrow"></b>
        </li>

        <li ${controllerName == 'person'&&actionName == 'employees' ? ' class=active' : ''}>
            <g:link controller="person" action="employees">
                <i class="menu-icon fa fa-caret-right"></i>
                雇员管理
            </g:link>

            <b class="arrow"></b>
        </li>
        -->
    </ul>
</li>


</ul><!-- /.nav-list -->

<!-- #section:basics/sidebar.layout.minimize -->
<div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
    <i class="ace-icon fa fa-angle-double-left" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
</div>

<!-- /section:basics/sidebar.layout.minimize -->
<script type="text/javascript">
    try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
</script>
</div>

<!-- /section:basics/sidebar -->

<!-- /section:basics/sidebar -->
<div class="main-content">
    <div class="main-content-inner">
        <!-- #section:basics/content.breadcrumbs -->
        <div class="breadcrumbs" id="breadcrumbs">
            <script type="text/javascript">
                try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
            </script>

            <ul class="breadcrumb">
                <li>
                    <i class="ace-icon fa fa-home home-icon"></i>
                    <a href="#">Home</a>
                </li>
                <li class="active">${controllerName}</li>
            </ul><!-- /.breadcrumb -->

        <!-- #section:basics/content.searchbox -->
            <div class="nav-search" id="nav-search">
                <form class="form-search">
                    <span class="input-icon">
                        <input type="text" placeholder="Search ..." class="nav-search-input" id="nav-search-input" autocomplete="off" />
                        <i class="ace-icon fa fa-search nav-search-icon"></i>
                    </span>
                </form>
            </div><!-- /.nav-search -->

        <!-- /section:basics/content.searchbox -->
        </div>

        <!-- /section:basics/content.breadcrumbs -->

        <div class="page-content">
        <g:layoutBody/>
        </div>



    </div>
</div>

<div class="footer">
    <div class="footer-inner">
        <!-- #section:basics/footer -->
        <div class="footer-content">
            <span class="bigger-120">
                <g:message code="common.version"/>
            </span>

            <!--
            &nbsp; &nbsp;
                    <span class="action-buttons">
                        <a href="#">
                            <i class="ace-icon fa fa-twitter-square light-blue bigger-150"></i>
                        </a>

                        <a href="#">
                            <i class="ace-icon fa fa-facebook-square text-primary bigger-150"></i>
                        </a>

                        <a href="#">
                            <i class="ace-icon fa fa-rss-square orange bigger-150"></i>
                        </a>
                    </span>
                    -->
        </div>

        <!-- /section:basics/footer -->
    </div>
</div>

<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
    <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
</a>
</div>


</body>
</html>
