
<%@ page import="com.rcstc.manufacture.Project" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <style type="text/css">

    .cat1 {
        font-size: 24px;
        font-weight: bold;
        margin: 1em 0.5em 0;
        font-style: normal;
        color: #7c9d00;
        line-height: 1.1;
    }
    .cat2 {
        font-size: 20px;
        font-weight: bold;
        margin: 1em 0.5em 0;
        font-style: normal;
        color: #7c9d00;
        line-height: 1.1;
    }
    .cat3 {
        font-size: 16px;
        font-weight: bold;
        margin: 1em 0.5em 0;
        font-style: normal;
        line-height: 1.1;
    }

    ol.cat {padding:0 0 0 20px;margin:0;list-style:none;counter-reset:a;}
    li.cat:before {counter-increment:a;content:counters(a,".")". ";}
    </style>
</head>
<body>
<ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
    <li role="presentation">
        <g:link action="demandDoc4Project" params='[pid:"${project.id}"]'>
            需求规格说明书
        </g:link>
    </li>
    <li role="presentation">
        <g:link action="designDoc4Project" params='[pid:"${project.id}"]'>
            系统设计说明书
        </g:link>
    </li>
    <li role="presentation"  class="active">
        <a href="#">
            测试报告
        </a>
    </li>
</ul>


<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>

<h1 style="text-align: center">${project.name}</h1>
<h2 style="text-align: center">测试报告</h2>
<%
    def cat1 = ""
    def cat2 = ""
    def cat3 = ""
%>
<ol class="cat">
<g:each in="${testReports}" status="i"  var="de">
    <g:if test="${de[1]!=cat1}">
        <g:if test="${cat1!=''}">
            </li>
            </ol>
            </li>
            </ol>
            <%
                cat2 = ""
            %>
        </g:if>
        <li class="cat1 cat">${de[1]}
        <ol class="cat">
        <%
            cat1 = de[1]
        %>
    </g:if>

    <g:if test="${de[2]!=cat2}">
        <g:if test="${cat2!=''}">
            </li>
            </ol>
        </g:if>
        <li class="cat2 cat">${de[2]}
        <ol class="cat">
        <%
            cat2 = de[2]
        %>
    </g:if>

    <g:if test="${de[3]!=cat3}">
        <li class="cat3 cat"><g:link controller="demand" action="show" id="${de[0]}">${de[3]}</g:link> </li>
        <%
            cat3 = de[3]
        %>
    </g:if>

    <g:if test="${de[4]}">
        <pre>${de[4]}</pre>
    </g:if>

</g:each>
</ol>


</body>
</html>
