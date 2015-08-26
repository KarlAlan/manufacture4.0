
<%@ page import="org.joda.time.DateTime; com.rcstc.manufacture.TaskStatus; com.rcstc.business.ContractStatus; com.rcstc.business.Contract" %>
<!DOCTYPE html>
<html>
<head>
  <meta name="layout" content="main">
  <g:set var="entityName" value="${message(code: 'contract.label', default: 'Contract')}" />
  <title>周计划统计报表</title>
  <asset:javascript src="bootstrap-multiselect.js"/>
  <asset:stylesheet src="bootstrap-multiselect.css"/>
</head>
<body>

<div title="查询条件" style="margin: 10px">
  <g:form action="weekplanReport1" method="post" class="form-inline" role="form">
    <div class="form-group">
      <label>年：</label>
      <input value="${params.demand_year}" id="demand_year" name="demand_year" type="text" class="form-control" placeholder="年" style="width: 100px">
    </div>
    <div class="form-group">
      <label>周：</label>
      <input value="${params.demand_week}" id="demand_week" name="demand_week" type="text" class="form-control" placeholder="周" style="width: 100px">
    </div>
    <!--
    <div class="form-group">
      <label>项目：</label>
      <g:select name="demand_pids" from="${pl}"  optionKey="id" value="${params.demand_pids}"
                id="demand_pids" class="multiselect" multiple=""/>
    </div>
    -->
    <div class="form-group">
      <button type="submit" class="btn btn-info btn-sm">查询</button>
      <button id="reset_button" type="reset" class="btn btn-warning btn-sm">重置</button>
    </div>

  </g:form>
</div>

<div id="list-contract" class="content scaffold-list" role="main" style="overflow-x: scroll">

  <g:if test="${flash.message}">
    <div class="alert alert-block alert-success" role="status">${flash.message}</div>
  </g:if>
  <table class="table table-bordered table-striped">
    <thead>
    <tr>
      <th>周</th>
      <th>优先级</th>
      <th>需求序号</th>
      <th>需求标题</th>
      <th>项目</th>
      <th>是否完成</th>
      <th>是否通过</th>
      <th>是否发布</th>
      <th>状态</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${demands}" status="i" var="demand">
      <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
        <td>${params.demand_week}</td>
        <td>
          ${demand[0]==com.rcstc.manufacture.Priority.EMERGENCY?"紧急":"正常"}
        </td>
        <td>
          ${demand[1]}
        </td>
        <td>
          ${demand[2]}
        </td>
        <td>
          ${demand[3]}
        </td>
        <td>
          ${demand[4]==1?"是":"否"}
        </td>
        <td>
          ${demand[5]==1?"是":"否"}
        </td>
        <td>
          ${demand[6]==1?"是":"否"}
        </td>
        <td>
          ${demand[7].name}
        </td>
      </tr>
    </g:each>
    </tbody>
  </table>
  <div class="pagination">
    <g:paginate total="${demandsCount ?: 0}"/>
    <span style="padding-left: 20px;position: relative;bottom: 30px">总共<span style="color: darkblue">${demandsCount ?: 0}</span>条</span>
  </div>
</div>

<script type="text/javascript">
  var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
  basepath= basepath.substring(0,basepath.indexOf('/')) ;

  $(function(){

    // multiselect控件
    $('.multiselect').multiselect({
      //enableFiltering: true,
      buttonClass: 'btn btn-white btn-primary',
      templates: {
        button: '<button type="button" class="multiselect dropdown-toggle" data-toggle="dropdown"></button>',
        ul: '<ul class="multiselect-container dropdown-menu"></ul>',
        filter: '<li class="multiselect-item filter"><div class="input-group"><span class="input-group-addon"><i class="fa fa-search"></i></span><input class="form-control multiselect-search" type="text"></div></li>',
        filterClearBtn: '<span class="input-group-btn"><button class="btn btn-default btn-white btn-grey multiselect-clear-filter" type="button"><i class="fa fa-times-circle red2"></i></button></span>',
        li: '<li><a href="javascript:void(0);"><label></label></a></li>',
        divider: '<li class="multiselect-item divider"></li>',
        liGroup: '<li class="multiselect-item group"><label class="multiselect-group"></label></li>'
      }
    });

  })
</script>
</body>
</html>
