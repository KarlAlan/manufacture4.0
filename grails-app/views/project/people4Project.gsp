<%--
  Created by IntelliJ IDEA.
  User: karl
  Date: 14-8-15
  Time: 下午6:47
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'batch.label', default: 'Batch')}" />
    <title>项目通信录</title>
    <style type="text/css">

    .list-group-item:hover{
        background-color: #dcdcdc;
        cursor: pointer;
    }

    .person_item {
        position: relative;
    }

    </style>
</head>
<body>
<ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
    <li role="presentation">
        <g:link class="list" action="index">
            <g:message code="project.list" args="[entityName]" />
        </g:link>
    </li>
    <li role="presentation">
        <g:link class="create" action="create">
            <g:message code="project.create" args="[entityName]" />
        </g:link>
    </li>
    <li role="presentation" class="active">
        <g:link class="create" action="people4Project">
            项目通讯录
        </g:link>
    </li>
</ul>

<div id="create-batch" class="content scaffold-create" role="main">

    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <div class="row">
        <div class="col-md-4">
            <div style="margin: 5px;padding: 10px;">
                <div class="panel panel-default">
                    <!-- Default panel contents -->
                    <div class="panel-heading">项目列表</div>
                    <div class="list-group" id="project_list" style="height: 400px;overflow-y:scroll;">
                        <g:each in="${projects}" status="i" var="project">
                            <div class="list-group-item">
                                <div tid="${project.id }">
                                    <span style="font-weight: bold;font-size: 1.2em;color: darkgreen">${project.name }：${project.informationSystem?.name }</span>
                                    <span style="float: right;color: darkred">${project.status }</span>
                                    <div style="color: darkblue">甲方：${project.fristParty }</div>
                                    <div style="color: darkblue">乙方：${project.secondParty }</div>
                                </div>
                            </div>
                        </g:each>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div style="margin: 5px;padding: 10px;">
                <div class="panel panel-default">
                    <!-- Default panel contents -->
                    <div class="panel-heading">项目人员列表</div>
                    <div class="list-group" id="person_list" style="height: 400px;overflow-y:scroll; overflow-x:hidden;padding: 10px">


                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4"></div>
    </div>

</div>

<!--Add Person Modal -->
<div class="modal fade bs-example-modal-lg" id="addPerson" tabindex="-1" role="dialog" aria-labelledby="addPersonLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="addPersonLabel">添加项目组成员</h4>
            </div>
            <div class="modal-body" id="desc-modal">
                <form role="form" class="form-horizontal">
                    <div class="form-group">
                        <label for="project" class="col-sm-2 control-label">项目</label>
                        <div class="col-sm-10">
                            <g:select name="project" class="form-control" from="${com.rcstc.manufacture.Project.list()}" optionKey="id" required=""  disabled="true"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="person" class="col-sm-2 control-label">人员</label>
                        <div class="col-sm-10">
                            <!--
                            <g:select name="person" class="form-control" from="${com.rcstc.manufacture.Person.list()}" optionKey="id" required=""  />
                            -->
                            <input type="email" id="person_email" name="person_email" required="" placeholder="邮箱地址" autocomplete="off">
                            <!--
                            <input type="text" name="person_name" disabled placeholder="姓名">
                            -->
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="projectRole" class="col-sm-2 control-label">项目中角色</label>
                        <div class="col-sm-10">
                            <g:select name="projectRole" class="form-control" from="${com.rcstc.manufacture.ProjectRole?.values()}" keys="${com.rcstc.manufacture.ProjectRole.values()*.name()}" required=""  />
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="savePersonProject" type="button" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function(){
        var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
        basepath= basepath.substring(0,basepath.indexOf('/')) ;

        $('#person_email').typeahead({
            source: function(query,process) {
                return $.post('/'+basepath+'/person/ajaxPersonEmail', { query: query },function(data){
                    return process(data);
                });
            }
        });

        $("#project_list .list-group-item").on('click',function(){
            $("#person_list").empty();

            var rla = $(this);
            $("#project_list .list-group-item").removeClass('active');
            rla.addClass('active');

            $.ajax({
                url : '/'+basepath+'/project/ajaxPeople4Project',
                type : 'POST',
                dataType : 'json',
                data : {
                    pid : rla.children('div').attr('tid')
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(json) {
                    $(json).each(function(){
                        var human = this;
                        var role = "";
                        if(human[2]){
                            role = human[2].name;
                        }

                        /*
                        var cb = "<div class='list-group-item' style='width: 470px'><div class='person_item' tid='"+human[0]+"'>";
                        cb = cb + "<span style='font-weight: bold;font-size: 1.2em;color: darkgreen'>"+human[1] +"</span>";
                        cb = cb + "<div style='float: right;color: darkred;font-size: 2.5em'><span class='glyphicon glyphicon-trash' style='margin-right: 10px;margin-left: 30px' pid='"+human[6]+"' pr='"+human[2].name+"'></span></div>";
                        cb = cb + "<div style='float: right;color: DarkOrange'>"+role +"</div>";
                        if(human[5])
                            cb = cb + "<div>"+human[5]+"</div>";
                        if(human[4])
                            cb = cb + "<div>电话："+human[4]+"</div>";
                        if(human[3])
                            cb = cb + "<div>邮箱："+human[3]+"</div>";
                        cb = cb + "</div></div>"
                        $("#person_list").append(cb);
                         */

                        var avatarPath = "${createLink(controller: 'person', action: 'avatar')}"+"?username="+human[8];
                        var cb = $('<div class="commentdiv itemdiv"></div>');
                        $('<div class="pull-right action-buttons delete_team_member"><a href="#"><i class="ace-icon fa fa-times red bigger-125"></i></a></div>').attr("pid",human[6]).attr("pr",human[2].name).appendTo(cb);
                        $('<div class="user"><img src='+avatarPath+' /></div>').appendTo(cb);
                        var bo = $('<div class="body"></div>').appendTo(cb);;
                        $('<div class="name"><a href="#">'+human[1]+'</a></div>').appendTo(bo);

                        var te = $('<div class="text"></div>').appendTo(bo);
                        $('<span class="label label-warning arrowed arrowed-in-right"></span>').text(role).appendTo(te);
                        if(human[5])
                            $('<span style="display: block"></span>').text(human[5]).appendTo(te);

                        if(human[4])
                            $('<span style="display: block"></span>').text("电话："+human[4]).appendTo(te);
                        if(human[3])
                            $('<span style="display: block"></span>').text("邮箱："+human[3]).appendTo(te);
                        $("#person_list").append(cb);
                    })
                    $("#person_list").append("<div class='list-group-item add_person'><div style='color: orange'>"+
                            "<span class='glyphicon glyphicon-plus' style='margin-right: 10px'></span>添加项目组成员"+
                            "</div></div>");
                }
            });
        })

        $( document ).on( "click", "#person_list .add_person", function() {
            $('#project').val($("#project_list > .active").children("div").attr("tid"));
            $('#person').empty();
            $.ajax({
                url : '/'+basepath+'/project/ajaxPeopleInProject',
                type : 'POST',
                dataType : 'json',
                data : {
                    project : $("#project_list > .active").children("div").attr("tid")
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(json) {
                    $(json).each(function(){
                        var human = this;
                        var option = $("<option>").val(human.id).text(human.name + " " + human.company);

                        $("#person").append(option);
                    })
                }
            });
            $('#addPerson').modal('toggle');

        })

        $("#savePersonProject").click(function(){
            $.ajax({
                url : '/'+basepath+'/project/ajaxAddPeopleInProject',
                type : 'POST',
                dataType : 'json',
                data : {
                    project : $('#project').val(),
                    person_email : $('#person_email').val(),
                    pp : $('#projectRole').val()
                },
                timeout : 10000,
                error : function(e){
                    alert("人员不存在系统或操作失败。")
                },
                success : function(json) {
                    $("#project_list .active").click();
                }
            });
            $('#addPerson').modal('hide');
        })

        // delete people in project
        $( document ).on( "click", ".delete_team_member", function() {
            var gt = $(this);

            $.ajax({
                url : '/'+basepath+'/project/ajaxDeletePeopleInProject',
                type : 'POST',
                dataType : 'json',
                data : {
                    project : $("#project_list > .active").children("div").attr("tid"),
                    person : $(gt).attr("pid"),
                    pp : $(gt).attr("pr")
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(json) {
                    $(gt).parents(".commentdiv").remove();
                }
            });
        })
    })
</script>
</body>
</html>