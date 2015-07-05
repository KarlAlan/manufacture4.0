
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'demand.label', default: 'Demand')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
    <link rel="stylesheet" href="${createLink(uri:'/css/jquery.fileupload.css')}">
    <link rel="stylesheet" href="${createLink(uri:'/css/jquery.fileupload-ui.css')}">
    <script src="${createLink(uri:'/js/vendor/jquery.ui.widget.js')}"></script>
    <script src="${createLink(uri:'/js/jquery.iframe-transport.js')}"></script>
    <script src="${createLink(uri:'/js/jquery.fileupload.js')}"></script>
    <style>
    .file_delete:hover {
        cursor: pointer;
    }
    .list-group-item {
        min-height: 70px;
    }
    </style>
</head>
<body>

<ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
    <li role="presentation">
        <g:link class="list" action="index">
            <g:message code="demand.list" args="[entityName]" />
        </g:link>
    </li>
    <li role="presentation">
        <g:link class="create" action="create">
            <g:message code="demand.create" args="[entityName]" />
        </g:link>
    </li>
    <li role="presentation" class="active">
        <a href="#">需求导入</a>
    </li>
</ul>
<div id="create-demand" class="content scaffold-create" role="main">
<!--
			<h1><g:message code="default.create.label" args="[entityName]" /></h1>
			-->
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${demandInstance}">
        <ul class="errors" role="alert">
            <g:eachError bean="${demandInstance}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <div class="row">
        <div class="col-md-8" style="padding: 10px">
            <div style="padding: 10px">
                <div class="row fileupload-buttonbar" style="margin-left: 10px">
                    <div>
                        <span class="btn btn-success fileinput-button">
                            <i class="icon-plus icon-white"></i>
                            <span>${message(code: 'fileupload.add.files', default: '上传文件')}</span>
                            <input id="fileupload" type="file" name="files[]" multiple>
                        </span>
                        <!--
                        <button type="button" class="btn btn-danger delete">
                            <i class="icon-trash icon-white"></i>
                            <span>${message(code: 'fileupload.delete', default: '删除')}</span>
                        </button>
                        -->

                    </div>

                    <div class="progress" style="width: 380px;margin-bottom: 5px;display: none">
                        <div class="progress-bar progress-bar-success progress-bar-striped active"  role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
                        </div>
                    </div>

                    <div id="import_size"></div>

                    <div class="list-group" style="width: 380px">
                    </div>
                </div>
            </div>
            <a href="../template/demands.xlsx">下载导入需求模板</a>
        </div>
        <div class="col-md-4">
            <!--

                -->

        </div>
    </div>

</div>


<script type="text/javascript">
    var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
    basepath= basepath.substring(0,basepath.indexOf('/')) ;

    $(document).ready(function() {
        //文件上传地址
        var url = '/'+basepath+'/demand/importDemandExcel';
        //初始化，主要是设置上传参数，以及事件处理方法(回调函数)
        $('#fileupload').fileupload({
            dataType: 'json',
            autoUpload: true,//是否自动上传
            url: url,//上传地址
            done: function (e, data) {//设置文件上传完毕事件的回调函数
                var amount = data.result.Demand.amount;
                /*
                $.each(data.result, function (index, file) {
                    var li = $('<div class="list-group-item"></div>');
                    $('<img style="float: left"/>').attr('src',file.thumbnail_url).appendTo(li);
                    $('<i class="glyphicon glyphicon-trash file_delete" style="float: right;font-size: 20px; color: red;margin-top:10px"/>').attr('durl',file.delete_url).appendTo(li);
                    $('<a style="font:16px bold;margin-left:10px"/>').attr('href',file.url).text(file.name).appendTo(li);
                    $('<div style="font:16px;margin-left:60px "/>').text(file.size+"字节").appendTo(li);

                    li.appendTo($('.list-group'));
                });
                */
                $('#import_size').text("成功导入"+amount+"条需求。");
                $('.progress').hide();
            },
            progressall: function (e, data) {//设置上传进度事件的回调函数
                $('.progress').show();
                var progress = parseInt(data.loaded / data.total * 100, 10);
                $('.progress-bar').css(
                        'width',
                        progress + '%'
                );
            }

        });

    })
</script>

</body>
</html>
