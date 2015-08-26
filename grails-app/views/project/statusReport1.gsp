
<%@ page import="org.joda.time.DateTime; com.rcstc.manufacture.TaskStatus; com.rcstc.business.ContractStatus; com.rcstc.business.Contract" %>
<!DOCTYPE html>
<html>
<head>
  <meta name="layout" content="main">
  <g:set var="entityName" value="${message(code: 'contract.label', default: 'Contract')}" />
  <title>项目需求状态统计</title>
  <asset:javascript src="bootstrap-multiselect.js"/>
  <asset:stylesheet src="bootstrap-multiselect.css"/>
</head>
<body>

<div title="查询条件" style="margin: 10px">
  <!--
  <g:form action="planingTasks" method="post" class="form-inline" role="form">
    <div class="form-group">
      <label>任务序号：</label>
      <input value="${params.task_serial}" id="task_serial" name="task_serial" type="text" class="form-control" placeholder="任务序号" style="width: 100px">
    </div>
    <div class="form-group">
      <label>任务人：</label>
      <input value="${params.task_person_name}" id="task_person_name" name="task_person_name" type="text" class="form-control person" placeholder="任务人" autocomplete="off" style="width: 100px">
    </div>
    <div class="form-group">
      <label>项目：</label>
    <g:select name="demand_pids" from="${pl}"  optionKey="id" value="${params.demand_pids}"
              id="demand_pids" class="multiselect" multiple=""/>
    </div>

    <div class="form-group">
      <button type="submit" class="btn btn-info btn-sm">查询</button>
      <button id="reset_button" type="reset" class="btn btn-warning btn-sm">重置</button>
    </div>

  </g:form>
  -->
</div>

<div id="list-contract" class="content scaffold-list" role="main" style="overflow-x: scroll">

  <g:if test="${flash.message}">
    <div class="alert alert-block alert-success" role="status">${flash.message}</div>
  </g:if>
  <table class="table table-bordered table-striped">
    <thead>
    <tr>
      <th>序号</th>
      <th>项目</th>
      <th>草稿</th>
      <th>分析</th>
      <th>设计</th>
      <th>确认</th>
      <th>开发</th>
      <th>SIT</th>
      <th>UAT</th>
      <th>作废</th>
      <th>关闭</th>
      <th>合计</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${stat}" status="i" var="st">
      <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
        <td>${i+1}</td>
        <td>
          ${st[1]}
        </td>
        <td>
          ${st[2]}
        </td>
        <td>
          ${st[3]}
        </td>
        <td>
          ${st[4]}
        </td>
        <td>
          ${st[5]}
        </td>
        <td>
          ${st[6]}
        </td>
        <td>
          ${st[7]}
        </td>
        <td>
          ${st[8]}
        </td>
        <td>
          ${st[9]}
        </td>
        <td>
          ${st[10]}
        </td>
        <td>
          ${st[11]}
        </td>
      </tr>
    </g:each>
    </tbody>
  </table>
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
