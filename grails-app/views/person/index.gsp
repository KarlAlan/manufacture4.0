
<%@ page import="com.rcstc.manufacture.Person" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
    <ul class="nav nav-tabs" role="tablist" style="margin-left: 10px">
        <li role="presentation" class="active">
            <g:link class="list" action="index">
                系统用户列表
            </g:link>
        </li>
    </ul>

    <div title="查询条件" style="margin: 10px">
        <g:form action="index" method="post" class="form-inline" role="form">
            <div class="form-group">
                <label>姓名：</label>
                <input value="${params.people}" id="people" name="people" type="text" class="form-control" placeholder="姓名"  style="width: 100px">
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-info btn-sm">查询</button>
            </div>

        </g:form>
    </div>

    <div id="list-person" class="content scaffold-list" role="main">
    <!--
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			-->
        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <table class="table table-striped table-bordered table-hover">
            <thead>
            <tr>

                <g:sortableColumn property="name" title="${message(code: 'person.name.label', default: 'Name')}" />

                <g:sortableColumn property="company" title="${message(code: 'person.company.label', default: 'Company')}" />

                <g:sortableColumn property="jobTitle" title="${message(code: 'person.jobTitle.label', default: 'Job Title')}" />

                <g:sortableColumn property="email" title="${message(code: 'person.email.label', default: 'Email')}" />

                <g:sortableColumn property="phone" title="${message(code: 'person.phone.label', default: 'Phone')}" />



            </tr>
            </thead>
            <tbody>
            <g:each in="${personInstanceList}" status="i" var="personInstance">
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                    <td><g:link action="show" id="${personInstance.id}">${fieldValue(bean: personInstance, field: "name")}</g:link></td>

                    <td>${fieldValue(bean: personInstance, field: "company")}</td>

                    <td>${fieldValue(bean: personInstance, field: "jobTitle")}</td>

                    <td>${fieldValue(bean: personInstance, field: "email")}</td>

                    <td>${fieldValue(bean: personInstance, field: "phone")}</td>

                </tr>
            </g:each>
            </tbody>
        </table>
        <div class="pagination" style="display: block;margin:0 10px">
            <g:paginate total="${personInstanceCount ?: 0}" />
        </div>
        <!--
        <g:link class="btn btn-sm btn-success" action="create">
            <i class="ace-icon fa fa-plus-circle bigger-120"></i>
            <span class="bigger-110">新建用户</span>
        </g:link>
        -->
        <button id="importPersons" type="button" class="btn btn-info btn-sm">导入用户</button>
        <button id="invitePerson" type="button" class="btn btn-info btn-sm">邀请用户</button>
        <a href="../template/address.xlsx">下载通信录导入模板</a>
    </div>


    <!--Invite Person Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="myModalLabel">邀请用户</h4>
                </div>
                <div class="modal-body" id="desc-modal">
                    <form role="form" class="form-horizontal">
                        <div class="form-group">
                            <label for="people_name" class="col-sm-2 control-label">姓名</label>
                            <div class="col-sm-10">
                                <input id="people_name" name="people_name" type="text" class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="people_email" class="col-sm-2 control-label">邮箱</label>
                            <div class="col-sm-10">
                                <input id="people_email" name="people_email" type="email" class="form-control" required="">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label bolder blue col-sm-2">人员权限</label>
                            <div class="radio col-sm-10">
                                <label>
                                    <input name="auth_radio" type="radio" class="ace" checked value="USER"/>
                                    <span class="lbl">USER</span>
                                </label>
                                <label>
                                    <input name="auth_radio" type="radio" class="ace" value="ADMIN"/>
                                    <span class="lbl">ADMIN</span>
                                </label>
                                <sec:ifAnyGranted roles="BUSINESS,SUPERVISOR">
                                <label>
                                    <input name="auth_radio" type="radio" class="ace" value="BUSINESS"/>
                                    <span class="lbl">BUSINESS</span>
                                </label>

                                <label>
                                    <input name="auth_radio" type="radio" class="ace" value="SUPERVISOR"/>
                                    <span class="lbl">SUPERVISOR</span>
                                </label>
                                </sec:ifAnyGranted>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button id="inviteButton" type="button" class="btn btn-primary">邀请</button>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $(function(){
            var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
            basepath= basepath.substring(0,basepath.indexOf('/')) ;

            $('#invitePerson').click(function(){
                $('#myModal').modal('toggle');
            })

            $('#inviteButton').click(function(){
                $.ajax({
                    url : '/'+basepath+'/person/ajaxInviteSystemUser',
                    type : 'POST',
                    dataType : 'json',
                    data : {
                        people_name : $("#people_name").val(),
                        people_email : $("#people_email").val(),
                        auth_radio : $("input[name='auth_radio']:checked").val()
                    },
                    timeout : 10000,
                    error : function(e){
                        alert("操作失败")
                    },
                    success : function(json) {
                        alert("成功发送邀请！");
                        $("#people_name").val("");
                        $("#people_email").val("");
                    }
                });
            })

            $('#importPersons').on('click', function(){
                var modal =
                        '<div class="modal fade">\
                          <div class="modal-dialog">\
                           <div class="modal-content">\
                            <div class="modal-header">\
                                <button type="button" class="close" data-dismiss="modal">&times;</button>\
                                <h4 class="blue">导入用户</h4>\
                            </div>\
                            \
                            <g:form class="no-margin" controller="person" action="importUsersExcel">\
                             <div class="modal-body">\
                                <div class="space-4"></div>\
                                <div style="width:75%;margin-left:12%;"><input multiple type="file" name="files[]" /></div>\
                             </div>\
                            \
                             <div class="modal-footer center">\
                                <button type="submit" class="btn btn-sm btn-success"><i class="ace-icon fa fa-check"></i> 提交</button>\
                                <button type="button" class="btn btn-sm" data-dismiss="modal"><i class="ace-icon fa fa-times"></i> 取消</button>\
                             </div>\
                            </g:form>\
                          </div>\
                         </div>\
                        </div>';


                var modal = $(modal);
                modal.modal("show").on("hidden", function(){
                    modal.remove();
                });

                var working = false;

                var form = modal.find('form:eq(0)');
                var file_input = form.find('input[type=file]').eq(0);
                file_input.ace_file_input({
                    style:'well',
                    btn_choose:'点击选择用户文件',
                    btn_change:null,
                    droppable: true, //html5 browsers only
                    no_icon:'ace-icon fa fa-users',
                    thumbnail:false,
                    before_remove: function() {
                        //don't remove/reset files while being uploaded
                        return !working;
                    },
                    allowExt: ['xls', 'xlsx'],
                    allowMime: ['application/vnd.ms-excel', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet']
                });

                var ie_timeout = null;//a time for old browsers uploading via iframe

                form.on('submit', function(e) {
                    e.preventDefault();

                    var files = file_input.data('ace_input_files');
                    if( !files || files.length == 0 ) return false;//no files selected

                    var deferred ;
                    if( "FormData" in window ) {
                        //for modern browsers that support FormData and uploading files via ajax
                        //we can do >>> var formData_object = new FormData(form[0]);
                        //but IE10 has a problem with that and throws an exception
                        //and also browser adds and uploads all selected files, not the filtered ones.
                        //and drag&dropped files won't be uploaded as well

                        //so we change it to the following to upload only our filtered files
                        //and to bypass IE10's error
                        //and to include drag&dropped files as well
                        formData_object = new FormData();//create empty FormData object

                        //serialize our form (which excludes file inputs)
                        $.each(form.serializeArray(), function(i, item) {
                            //add them one by one to our FormData
                            formData_object.append(item.name, item.value);
                        });
                        //and then add files
                        form.find('input[type=file]').each(function(){
                            var field_name = $(this).attr('name');
                            //for fields with "multiple" file support, field name should be something like `myfile[]`

                            var files = $(this).data('ace_input_files');
                            if(files && files.length > 0) {
                                for(var f = 0; f < files.length; f++) {
                                    formData_object.append(field_name, files[f]);
                                }
                            }
                        });


                        upload_in_progress = true;
                        file_input.ace_file_input('loading', true);

                        deferred = $.ajax({
                            url: form.attr('action'),
                            type: form.attr('method'),
                            processData: false,//important
                            contentType: false,//important
                            dataType: 'json',
                            data: formData_object
                            /**
                             ,
                             xhr: function() {
								var req = $.ajaxSettings.xhr();
								if (req && req.upload) {
									req.upload.addEventListener('progress', function(e) {
										if(e.lengthComputable) {
											var done = e.loaded || e.position, total = e.total || e.totalSize;
											var percent = parseInt((done/total)*100) + '%';
											//percentage of uploaded file
										}
									}, false);
								}
								return req;
							},
                             beforeSend : function() {
							},
                             success : function() {
							}*/
                        })

                    }
                    else {
                        //for older browsers that don't support FormData and uploading files via ajax
                        //we use an iframe to upload the form(file) without leaving the page

                        deferred = new $.Deferred //create a custom deferred object

                        var temporary_iframe_id = 'temporary-iframe-'+(new Date()).getTime()+'-'+(parseInt(Math.random()*1000));
                        var temp_iframe =
                                $('<iframe id="'+temporary_iframe_id+'" name="'+temporary_iframe_id+'" \
								frameborder="0" width="0" height="0" src="about:blank"\
								style="position:absolute; z-index:-1; visibility: hidden;"></iframe>')
                                        .insertAfter(form)

                        form.append('<input type="hidden" name="temporary-iframe-id" value="'+temporary_iframe_id+'" />');

                        temp_iframe.data('deferrer' , deferred);
                        //we save the deferred object to the iframe and in our server side response
                        //we use "temporary-iframe-id" to access iframe and its deferred object

                        form.attr({
                            method: 'POST',
                            enctype: 'multipart/form-data',
                            target: temporary_iframe_id //important
                        });

                        upload_in_progress = true;
                        file_input.ace_file_input('loading', true);//display an overlay with loading icon
                        form.get(0).submit();


                        //if we don't receive a response after 30 seconds, let's declare it as failed!
                        ie_timeout = setTimeout(function(){
                            ie_timeout = null;
                            temp_iframe.attr('src', 'about:blank').remove();
                            deferred.reject({'status':'fail', 'message':'Timeout!'});
                        } , 30000);
                    }


                    ////////////////////////////
                    //deferred callbacks, triggered by both ajax and iframe solution
                    deferred
                            .done(function(result) {//success
                                //format of `result` is optional and sent by server
                                //in this example, it's an array of multiple results for multiple uploaded files
                                var amount = result.Person.amount;
                                var message = "成功导入"+amount+"位用户。";

                                alert(message);

                                modal.modal("hide");
                            })
                            .fail(function(result) {//failure
                                alert("导入发生错误。");
                            })
                            .always(function() {//called on both success and failure
                                if(ie_timeout) clearTimeout(ie_timeout)
                                ie_timeout = null;
                                upload_in_progress = false;
                                file_input.ace_file_input('loading', false);
                            });

                    deferred.promise();
                });


                //when "reset" button of form is hit, file field will be reset, but the custom UI won't
                //so you should reset the ui on your own
                form.on('reset', function() {
                    $(this).find('input[type=file]').ace_file_input('reset_input_ui');
                });


                if(location.protocol == 'file:') alert("For uploading to server, you should access this page using 'http' protocal, i.e. via a webserver.");


            });
        })
    </script>
	</body>


</html>
