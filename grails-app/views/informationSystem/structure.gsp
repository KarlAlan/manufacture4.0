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
    <g:set var="entityName" value="${message(code: 'informationSystem.label', default: 'Information System')}" />
    <title>信息系统管理</title>
    <link rel="stylesheet" media="all" href="${createLink(uri:'/css/square/green.css')}">
    <script src="${createLink(uri:'/js/icheck.js')}"></script>
    <style type="text/css">

    .list-group-item:hover{
        background-color: #dcdcdc;
        cursor: pointer;
    }

    </style>
</head>
<body>

<div id="create-batch" class="content scaffold-create" role="main">

    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <div class="row">
        <div class="col-md-4">
            <div >
                <div class="panel panel-default">
                    <!-- Default panel contents -->
                    <div class="panel-heading">信息系统列表</div>
                    <div class="list-group" id="system_list" style="height: 400px;overflow-y:scroll;">
                        <g:each in="${systems}" status="i" var="system">
                            <div class="list-group-item system_detail">
                                <div sid="${system.id }" class="system_item" data-container="body" data-toggle="popover" title="${system.name }" data-content="${system.description }">
                                    <span>${system.name }</span>
                                    <span style="float: right;font-size: 10px;color: darkblue">${system.org }</span>
                                </div>
                            </div>
                        </g:each>
                        <div class="list-group-item create_system"  org="${company}">
                            <div style="color: orange"><span class="glyphicon glyphicon-plus" style="margin-right: 10px"></span>添加新系统</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div >
                <div class="panel panel-default">
                    <!-- Default panel contents -->
                    <div class="panel-heading">模块列表</div>
                    <div class="list-group" id="category1_list" style="height: 400px;overflow-y:scroll;">


                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div >
                <div class="panel panel-default">
                    <!-- Default panel contents -->
                    <div class="panel-heading">功能点列表</div>
                    <div class="list-group" id="category2_list" style="height: 400px;overflow-y:scroll;">


                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="pull-left alert alert-success no-margin">
    备注：长按可修改删除
    </div>


</div>

<!--Create System Modal -->
<div class="modal fade bs-example-modal-lg" id="newSystem" tabindex="-1" role="dialog" aria-labelledby="newSystemLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="newSystemLabel">新建信息系统</h4>
            </div>
            <div class="modal-body" id="desc-modal">
                <form role="form">
                    <input type="hidden" id="sys_id">
                    <div class="form-group">
                        <label for="sys_org">信息系统使用单位</label>
                        <input type="text" class="form-control party" id="sys_org" placeholder="信息系统使用单位"  value="${company}" autocomplete="off" <sec:ifNotGranted roles="SUPER_ADMIN">disabled</sec:ifNotGranted>>
                    </div>
                    <div class="form-group">
                        <label for="sys_name">系统名称</label>
                        <input type="text" class="form-control" id="sys_name" placeholder="系统名称">
                    </div>
                    <div class="form-group">
                        <label for="sys_description">系统描述</label>
                        <textarea id="sys_description" class="form-control" rows="3"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="deleteSystem" type="button" class="btn btn-danger">删除</button>
                <button id="saveSystem" type="button" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>

<!--Create Moudle Modal -->
<div class="modal fade bs-example-modal-lg" id="newModule" tabindex="-1" role="dialog" aria-labelledby="newModuleLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="newModuleLabel">新建信息系统</h4>
            </div>
            <div class="modal-body" id="module_desc-modal">
                <form role="form">
                    <input type="hidden" id="mod_id">
                    <div class="form-group">
                        <label for="mod_name">模块名称</label>
                        <input type="text" class="form-control" id="mod_name" placeholder="模块名称">
                    </div>
                    <div class="form-group">
                        <label for="mod_description">模块描述</label>
                        <textarea id="mod_description" class="form-control" rows="3"></textarea>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" id="mod_important"> 关键模块
                        </label>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="deleteModule" type="button" class="btn btn-danger">删除</button>
                <button id="saveModule" type="button" class="btn btn-primary">保存</button>
                <button id="saveModule2" type="button" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function(){
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-green',
            radioClass: 'iradio_square-green'
            //increaseArea: '20%' // optional
        });
        $('input').on('ifChecked', function(event){
            $("#mod_important").attr("checked",true);
        });
        $('input').on('ifUnchecked', function(event){
            $("#mod_important").attr("checked",false);
        });

        var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
        basepath= basepath.substring(0,basepath.indexOf('/')) ;

        // 系统的增删、查改
        $( document ).on( "click", "#system_list .system_detail", function() {

            $("#category1_list").empty();
            $("#category2_list").empty();

            var rla = $(this);
            $("#system_list .list-group-item").removeClass('active');
            rla.addClass('active');

            $.ajax({
                url : '/'+basepath+'/informationSystem/ajaxGetCategory1',
                type : 'POST',
                dataType : 'json',
                data : {
                    sid : rla.children('div').attr('sid')
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(json) {
                    $(json).each(function(){
                        var moudle = this;
                        var cd = "<div class='list-group-item category1_detail'><div class='category_item' mid='"+moudle[0]+"' data-container='body' data-toggle='popover' title="+moudle[1]+" data-content='"+moudle[2]+"'>";
                        if(moudle[3]){
                            cd = cd + "<div><span class='glyphicon glyphicon-star-empty' style='margin-right: 10px;color: red'></span>"+ moudle[1] +"</div>";
                        } else {
                            cd = cd + "<div>"+ moudle[1] +"</div>";
                        }
                        cd = cd + "</div></div>";
                        $("#category1_list").append(cd);
                    })
                    $("#category1_list").append("<div class='list-group-item create_category1'><div style='color: orange'>"+
                            "<span class='glyphicon glyphicon-plus' style='margin-right: 10px'></span>新建模块"+
                            "</div></div>");
                }
            });
        })

        $( document ).on( "mouseover", ".system_item", function() {
            $(this).popover('show');
        })
        $( document ).on( "mouseout", ".system_item", function() {
            $(this).popover('hide');
        })
        $( document ).on( "mousedown", ".system_item", function() {
            var sitem = $(this);
            timeout = setTimeout(function() {
                $("#sys_id").val($(sitem).attr('sid'));
                $("#sys_org").val($(sitem).children('span:eq(1)').text());
                $("#sys_name").val($(sitem).children('span:eq(0)').text());
                $("#sys_description").val($(sitem).attr('data-content'));
                $("#deleteSystem").show();
                $('#newSystem').modal('toggle');
            }, 1000);
        })
        $( document ).on( "mouseup", ".system_item", function() {
            clearTimeout(timeout);
        })

        $( document ).on( "click", "#system_list .create_system", function() {
            $("#category1_list").empty();
            $("#category2_list").empty();

            var rla = $(this);
            $("#system_list .list-group-item").removeClass('active');
            rla.addClass('active');

            $("#sys_id").val('');
            $("#sys_org").val($(this).attr('org'));
            $("#sys_name").val('');
            $("#sys_description").val('');
            $("#deleteSystem").hide();
            $('#newSystem').modal('toggle');

        })

        $('#saveSystem').click(function(){
            $.ajax({
                url : '/'+basepath+'/informationSystem/ajaxSaveSystem',
                type : 'POST',
                dataType : 'json',
                data : {
                    isid: $("#sys_id").val(),
                    org : $("#sys_org").val(),
                    name :  $("#sys_name").val(),
                    description:$("#sys_description").val()
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(json) {
                    $("div[sid='"+$("#sys_id").val()+"']").parents(".system_detail").remove();
                    $("#system_list").prepend("<div class='list-group-item system_detail'><div sid='"+json.id+"'  class='system_item' data-container='body' data-toggle='popover' title="+json.name+" data-content='"+json.description+"'>"+
                            "<span>"+ json.name +"</span>"+
                            "<span style='float: right;font-size: 10px;color: darkblue'>"+ json.org +"</span>"+
                            "</div></div>");
                }
            });
            $('#newSystem').modal('hide');
        })

        $('#deleteSystem').click(function(){
            $.ajax({
                url : '/'+basepath+'/informationSystem/ajaxDeleteSystem',
                type : 'POST',
                dataType : 'json',
                data : {
                    isid: $("#sys_id").val()
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(json) {
                    $("div[sid='"+$("#sys_id").val()+"']").parents(".system_detail").remove();
                }
            });
            $("#category1_list").empty();
            $("#category2_list").empty();
            $('#newSystem').modal('hide');
        })


        // 模块的增删、查改
        $( document ).on( "click", "#category1_list .category1_detail", function() {
            $("#category2_list").empty();

            var rla = $(this);
            $("#category1_list .list-group-item").removeClass('active');
            rla.addClass('active');

            $.ajax({
                url : '/'+basepath+'/informationSystem/ajaxGetCategory2',
                type : 'POST',
                dataType : 'json',
                data : {
                    mid : rla.children('div').attr('mid')
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(json) {
                    $(json).each(function(){
                        var moudle = this;
                        var cd = "<div class='list-group-item category2_detail'><div class='category_item' mid='"+moudle[0]+"' data-placement='left' data-container='body' data-toggle='popover' title="+moudle[1]+" data-content='"+moudle[2]+"'>";
                        if(moudle[3]){
                            cd = cd + "<div><span class='glyphicon glyphicon-star-empty' style='margin-right: 10px;color: red'></span>"+ moudle[1] +"</div>";
                        } else {
                            cd = cd + "<div>"+ moudle[1] +"</div>";
                        }
                        cd = cd + "</div></div>";
                        $("#category2_list").append(cd);
                    })
                    $("#category2_list").append("<div class='list-group-item create_category2'><div style='color: orange'>"+
                            "<span class='glyphicon glyphicon-plus' style='margin-right: 10px'></span>新建功能点"+
                            "</div></div>");
                }
            });

        })

        $( document ).on( "click", "#category1_list .create_category1", function() {
            $("#category2_list").empty();

            var rla = $(this);
            $("#category1_list .list-group-item").removeClass('active');
            rla.addClass('active');

            $("#mod_id").val('');
            $("#mod_name").val('');
            $("#mod_description").val('');
            $("#deleteModule").hide();
            $("#saveModule").show();
            $("#saveModule2").hide();
            $('#newModule').modal('toggle');

        })
        $( document ).on( "click", "#category2_list .create_category2", function() {

            var rla = $(this);
            $("#category2_list .list-group-item").removeClass('active');
            rla.addClass('active');

            $("#mod_id").val('');
            $("#mod_name").val('');
            $("#mod_description").val('');
            $("#deleteModule").hide();
            $("#saveModule").hide();
            $("#saveModule2").show();
            $('#newModule').modal('toggle');

        })

        $('#saveModule').click(function(){
            $.ajax({
                url : '/'+basepath+'/informationSystem/ajaxSaveCategory1',
                type : 'POST',
                dataType : 'json',
                data : {
                    iid : $("#system_list .active").children('div').attr('sid'),
                    mid : $("#mod_id").val(),
                    name :  $("#mod_name").val(),
                    description:$("#mod_description").val(),
                    important:$("#mod_important").attr("checked")
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(json) {
                    $("div[mid='"+$("#mod_id").val()+"']").parents(".category1_detail").remove();
                    var cd = "<div class='list-group-item category1_detail'><div class='category_item' mid='"+json.id+"' data-container='body' data-toggle='popover' title="+json.name+" data-content='"+json.description+"'>";
                    if(json.important){
                        cd = cd + "<div><span class='glyphicon glyphicon-star-empty' style='margin-right: 10px;color: red'></span>"+ json.name +"</div>";
                    } else {
                        cd = cd + "<div>"+ json.name +"</div>";
                    }
                    cd = cd + "</div></div>";
                    $("#category1_list").prepend(cd);
                }
            });
            $('#newModule').modal('hide');
        })

        $('#saveModule2').click(function(){
            $.ajax({
                url : '/'+basepath+'/informationSystem/ajaxSaveCategory2',
                type : 'POST',
                dataType : 'json',
                data : {
                    pid : $("#category1_list .active").children('div').attr('mid'),
                    mid : $("#mod_id").val(),
                    name :  $("#mod_name").val(),
                    description:$("#mod_description").val(),
                    important:$("#mod_important").attr("checked")
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(json) {
                    $("div[mid='"+$("#mod_id").val()+"']").parents(".category2_detail").remove();
                    var cd = "<div class='list-group-item category2_detail'><div class='category_item' mid='"+json.id+"' data-placement='left' data-container='body' data-toggle='popover' title="+json.name+" data-content='"+json.description+"'>";
                    if(json.important){
                        cd = cd + "<div><span class='glyphicon glyphicon-star-empty' style='margin-right: 10px;color: red'></span>"+ json.name +"</div>";
                    } else {
                        cd = cd + "<div>"+ json.name +"</div>";
                    }
                    cd = cd + "</div></div>";
                    $("#category2_list").prepend(cd);
                }
            });
            $('#newModule').modal('hide');
        })

        $('#deleteModule').click(function(){
            $.ajax({
                url : '/'+basepath+'/informationSystem/ajaxDeleteModule',
                type : 'POST',
                dataType : 'json',
                data : {
                    mid: $("#mod_id").val()
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(json) {
                    if($("div[mid='"+$("#mod_id").val()+"']").parents(".category1_detail").size()>0){
                        $("div[mid='"+$("#mod_id").val()+"']").parents(".category1_detail").remove();
                        $("#category2_list").empty();
                    } else {
                        $("div[mid='"+$("#mod_id").val()+"']").parents(".category2_detail").remove();
                    }
                }
            });

            $('#newModule').modal('hide');
        })

        $( document ).on( "mousedown", ".category_item", function() {
            var sitem = $(this);
            timeout = setTimeout(function() {
                $("#mod_id").val($(sitem).attr('mid'));
                $("#mod_name").val($(sitem).children('div:eq(0)').text());
                $("#mod_description").val($(sitem).attr('data-content'));
                if($(sitem).children('div').children('span').is(".glyphicon")){
                    $("#mod_important").iCheck('check',function(){
                        $("#mod_important").attr("checked",true);
                    });
                } else {
                    $("#mod_important").iCheck('uncheck',function(){
                        $("#mod_important").attr("checked",false);
                    });
                }

                $("#deleteModule").show();

                if($(sitem).parent().is('.category1_detail')){
                    $("#saveModule").show();
                    $("#saveModule2").hide();
                }  else {
                    $("#saveModule").hide();
                    $("#saveModule2").show();
                }

                $('#newModule').modal('toggle');
            }, 1000);
        })
        $( document ).on( "mouseup", ".category_item", function() {
            clearTimeout(timeout);
        })

        $( document ).on( "mouseover", ".category_item", function() {
            $(this).popover('show');
        })
        $( document ).on( "mouseout", ".category_item", function() {
            $(this).popover('hide');
        })

        $('.party').typeahead({
            source: function(query,process) {
                return $.post('/'+basepath+'/project/ajaxCompanyName', { query: query },function(data){
                    return process(data);
                });
            }
        });

    })
</script>
</body>
</html>