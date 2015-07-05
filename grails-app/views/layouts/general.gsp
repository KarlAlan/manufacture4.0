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
    <title><g:layoutTitle default="Grails"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${assetPath(src: 'apple-touch-icon.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${assetPath(src: 'apple-touch-icon-retina.png')}">
    <asset:stylesheet src="application.css"/>
    <asset:javascript src="application.js"/>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="${createLink(uri:'/css/bootstrap.min.css')}">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" href="${createLink(uri:'/css/font-awesome.min.css')}">
    <style>
    body {
        background: #ebebeb;
        background-image: url(${resource(dir: 'images', file: 'login_bg.jpg')});
        color: #666;
        height: 100%;
    }

    .footer {
        position: fixed;
        bottom: 0;
        width: 100%;
    }

    </style>
    <g:layoutHead/>
    <script src="${createLink(uri:'/js/bootstrap.min.js')}"></script>
</head>
<body>
    <div id="grailsLogo" role="banner">
        <%
            def properties = PropertiesLoaderUtils.loadAllProperties("env.properties")
        %>
        <a href="${properties.getProperty('logo_url')}">
            <asset:image src="${properties.getProperty('logo_img')}" alt="${properties.getProperty('logo_tip')}"/>
        </a>
    </div>

    <g:layoutBody/>
    <div class="footer" role="contentinfo">
        <g:message code="common.version"/>
    </div>
<div id="spinner" class="spinner" style="display:none;">
    <g:message code="spinner.alt" default="Loading&hellip;"/>
</div>
</body>
</html>
