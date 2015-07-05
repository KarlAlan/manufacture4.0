
<%@ page import="com.rcstc.manufacture.Person" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}" />
		<title>个人资料</title>
        <link rel="stylesheet" href="${createLink(uri:'/css/star-rating.min.css')}">
        <script src="${createLink(uri:'/js/star-rating.min.js')}"></script>
        <style>
        .check-time {
            width: 57px;
            height: 77px;
            padding: 5px;
            min-width: 57px;
            min-height: 53px;
        }
        .holiday {
            background-color: lavender;
        }
        .time {
            text-align: center;
            color: white;
            margin-top: 1px;
        }
        </style>
	</head>
	<body>
    <g:if test="${flash.message}">
        <div class="alert alert-success no-margin">
            <button type="button" class="close" data-dismiss="alert">
                <i class="ace-icon fa fa-times"></i>
            </button>

            <i class="ace-icon fa fa-umbrella bigger-120 blue"></i>
            ${flash.message}
        </div>
    </g:if>

    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

        <div id="user-profile-2" class="user-profile">
        <div class="tabbable">
        <ul class="nav nav-tabs padding-18">
            <li class="active">
                <a data-toggle="tab" href="#home">
                    <i class="green ace-icon fa fa-user bigger-120"></i>
                    个人资料
                </a>
            </li>

            <li>
                <a data-toggle="tab" href="#friends">
                    <i class="blue ace-icon fa fa-users bigger-120"></i>
                    同事
                </a>
            </li>

            <li>
                <a data-toggle="tab" href="#attendance">
                    <i class="purple ace-icon fa fa-book bigger-120"></i>
                    考勤记录
                </a>
            </li>

            <li>
                <a data-toggle="tab" href="#feed">
                    <i class="orange ace-icon fa fa-rss bigger-120"></i>
                    最近活动
                </a>
            </li>

        </ul>

        <div class="tab-content no-border padding-24">
        <div id="home" class="tab-pane in active">
        <div class="row">
            <div class="col-xs-12 col-sm-3 center">
                <span class="profile-picture">
                    <img class="editable img-responsive" alt="${sec.username()}'s Avatar" id="avatar2" src="${createLink(controller: 'person', action: 'avatar', params: [username: personInstance.username, thum:'false'])}" />
                </span>

                <div class="space space-4"></div>

                <g:link class="btn btn-sm btn-block btn-success" action="edit" resource="${personInstance}">
                    <i class="ace-icon fa fa-plus-circle bigger-120"></i>
                    <span class="bigger-110">编辑个人资料</span>
                </g:link>

                <!--
                <a href="#" class="btn btn-sm btn-block btn-primary">
                    <i class="ace-icon fa fa-envelope-o bigger-110"></i>
                    <span class="bigger-110">Send a message</span>
                </a>
                -->
            </div><!-- /.col -->

            <div class="col-xs-12 col-sm-9">
                <h4 class="blue">
                    <span class="middle">${personInstance?.name}</span>

                    <span class="label label-purple arrowed-in-right">
                        <i class="ace-icon fa fa-circle smaller-80 align-middle"></i>
                        online
                    </span>
                </h4>

                <div class="profile-user-info">
                    <div class="profile-info-row">
                        <div class="profile-info-name"> <g:message code="person.username.label" default="Username" /> </div>

                        <div class="profile-info-value">
                            <span>${personInstance?.username}</span>
                        </div>
                    </div>

                    <div class="profile-info-row">
                        <div class="profile-info-name"> <g:message code="person.email.label" default="Email" /> </div>

                        <div class="profile-info-value">
                            <span>${personInstance?.email}</span>
                        </div>
                    </div>

                    <div class="profile-info-row">
                        <div class="profile-info-name"> <g:message code="person.phone.label" default="Phone" /> </div>

                        <div class="profile-info-value">
                            <span>${personInstance?.phone}</span>
                        </div>
                    </div>

                    <div class="profile-info-row">
                        <div class="profile-info-name"> <g:message code="person.company.label" default="Company" /> </div>

                        <div class="profile-info-value">
                            <span>${personInstance?.company}</span>
                        </div>
                    </div>

                    <div class="profile-info-row">
                        <div class="profile-info-name"> <g:message code="person.department.label" default="department" /> </div>

                        <div class="profile-info-value">
                            <span>${personInstance?.department}</span>
                        </div>
                    </div>

                    <div class="profile-info-row">
                        <div class="profile-info-name"> <g:message code="person.jobTitle.label" default="Job Title" /> </div>

                        <div class="profile-info-value">
                            <span>${personInstance?.jobTitle}</span>
                        </div>
                    </div>
                </div>

                <div class="hr hr-8 dotted"></div>


                <div class="profile-user-info">
                    <div class="profile-info-row">
                        <div class="profile-info-name"> 评价 </div>

                        <div class="profile-info-value">
                            <input id="person_rating" type="number" class="rating" min=0 max=5 step=0.5 data-size="ls" value="3">
                        </div>
                    </div>

                    <div class="profile-info-row">
                        <div class="profile-info-name"> 积分 </div>

                        <div class="profile-info-value">
                            <span>${point}</span>
                        </div>
                    </div>
                    <!--
                    <div class="profile-info-row">
                        <div class="profile-info-name"> Website </div>

                        <div class="profile-info-value">
                            <a href="#" target="_blank">www.alexdoe.com</a>
                        </div>
                    </div>

                    <div class="profile-info-row">
                        <div class="profile-info-name">
                            <i class="middle ace-icon fa fa-facebook-square bigger-150 blue"></i>
                        </div>

                        <div class="profile-info-value">
                            <a href="#">Find me on Facebook</a>
                        </div>
                    </div>

                    <div class="profile-info-row">
                        <div class="profile-info-name">
                            <i class="middle ace-icon fa fa-twitter-square bigger-150 light-blue"></i>
                        </div>

                        <div class="profile-info-value">
                            <a href="#">Follow me on Twitter</a>
                        </div>
                    </div>
                    -->
                </div>


            </div><!-- /.col -->
        </div><!-- /.row -->

        <div class="space-20"></div>

        <div class="row">
            <div class="col-xs-12 col-sm-6">
                <div class="widget-box transparent">
                    <div class="widget-header widget-header-small">
                        <h4 class="widget-title smaller">
                            <i class="ace-icon fa fa-check-square-o bigger-110"></i>
                            个人简介
                        </h4>
                    </div>

                    <div class="widget-body">
                        <div class="widget-main">
                            <p>
                                My job is mostly lorem ipsuming and dolor sit ameting as long as consectetur adipiscing elit.
                            </p>
                            <p>
                                Sometimes quisque commodo massa gets in the way and sed ipsum porttitor facilisis.
                            </p>
                            <p>
                                The best thing about my job is that vestibulum id ligula porta felis euismod and nullam quis risus eget urna mollis ornare.
                            </p>
                            <p>
                                Thanks for visiting my profile.
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xs-12 col-sm-6">
                <div class="widget-box transparent">
                    <div class="widget-header widget-header-small header-color-blue2">
                        <h4 class="widget-title smaller">
                            <i class="ace-icon fa fa-lightbulb-o bigger-120"></i>
                            我的技能
                        </h4>
                    </div>

                    <div class="widget-body">
                        <div class="widget-main padding-16">
                            <div class="clearfix">
                                <div class="grid3 center">
                                    <!-- #section:plugins/charts.easypiechart -->
                                    <div class="easy-pie-chart percentage" data-percent="45" data-color="#CA5952">
                                        <span class="percent">45</span>%
                                    </div>

                                    <!-- /section:plugins/charts.easypiechart -->
                                    <div class="space-2"></div>
                                    Graphic Design
                                </div>

                                <div class="grid3 center">
                                    <div class="center easy-pie-chart percentage" data-percent="90" data-color="#59A84B">
                                        <span class="percent">90</span>%
                                    </div>

                                    <div class="space-2"></div>
                                    HTML5 & CSS3
                                </div>

                                <div class="grid3 center">
                                    <div class="center easy-pie-chart percentage" data-percent="80" data-color="#9585BF">
                                        <span class="percent">80</span>%
                                    </div>

                                    <div class="space-2"></div>
                                    Javascript/jQuery
                                </div>
                            </div>

                            <div class="hr hr-16"></div>

                            <!-- #section:pages/profile.skill-progress -->
                            <div class="profile-skills">
                                <div class="progress">
                                    <div class="progress-bar" style="width:80%">
                                        <span class="pull-left">HTML5 & CSS3</span>
                                        <span class="pull-right">80%</span>
                                    </div>
                                </div>

                                <div class="progress">
                                    <div class="progress-bar progress-bar-success" style="width:72%">
                                        <span class="pull-left">Javascript & jQuery</span>

                                        <span class="pull-right">72%</span>
                                    </div>
                                </div>

                                <div class="progress">
                                    <div class="progress-bar progress-bar-purple" style="width:70%">
                                        <span class="pull-left">PHP & MySQL</span>

                                        <span class="pull-right">70%</span>
                                    </div>
                                </div>

                                <div class="progress">
                                    <div class="progress-bar progress-bar-warning" style="width:50%">
                                        <span class="pull-left">Wordpress</span>

                                        <span class="pull-right">50%</span>
                                    </div>
                                </div>

                                <div class="progress">
                                    <div class="progress-bar progress-bar-danger" style="width:38%">
                                        <span class="pull-left">Photoshop</span>

                                        <span class="pull-right">38%</span>
                                    </div>
                                </div>
                            </div>

                            <!-- /section:pages/profile.skill-progress -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div><!-- /#home -->



        <div id="friends" class="tab-pane">
        <!-- #section:pages/profile.friends -->
        <div class="profile-users clearfix">
            <g:each in="${coleagues}" status="i" var="coleague">
                <div class="itemdiv memberdiv">
                    <div class="inline pos-rel">
                        <div class="user">
                            <a href="#">
                                <img src="${createLink(controller: 'person', action: 'avatar', params: [username: coleague.username])}" alt="${coleague.name}'s avatar" />
                            </a>
                        </div>

                        <div class="body">
                            <div class="name">
                                <a href="#">
                                    <span class="user-status status-online"></span>
                                    ${coleague.name}
                                </a>
                            </div>
                        </div>

                        <div class="popover">
                            <div class="arrow"></div>

                            <div class="popover-content">
                                <div class="bolder">${coleague.department}</div>
                                <div class="normal">${coleague.jobTitle}</div>

                                <!--
                                <div class="time">
                                    <i class="ace-icon fa fa-clock-o middle bigger-120 orange"></i>
                                    <span class="green"> 20 mins ago </span>
                                </div>
                                -->

                                <div class="hr dotted hr-8"></div>

                                <div class="tools action-buttons">
                                    <a href="mailto:${coleague.email}">
                                        <i class="ace-icon fa fa-envelope-square blue bigger-150"></i>
                                    </a>

                                    <a href="#">
                                        <i class="ace-icon fa fa-phone-square light-blue bigger-150"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </g:each>
        </div>

        <!-- /section:pages/profile.friends -->
        <div class="hr hr10 hr-double"></div>

        </div><!-- /#friends -->

        <div id="attendance" class="tab-pane">
            <div class="row clearfix">
                <div class="col-xs-12 col-sm-6">
                    <button id="prev_month" class="btn btn-xs btn-info pull-left"><i class="ace-icon bigger-120 icon-chevron-left"></i></button>
                    <button id="next_month" class="btn btn-xs btn-info pull-right"><i class="ace-icon bigger-120 icon-chevron-right"></i></button>
                    <h4 id="title_month" month="0" style="text-align: center">${new Date().format("yyyy年M月")}</h4>
                    <table class="table table-bordered">
                        <thead>
                        <tr>
                            <th>周日</th>
                            <th>周一</th>
                            <th>周二</th>
                            <th>周三</th>
                            <th>周四</th>
                            <th>周五</th>
                            <th>周六</th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:each in="${0..5}" status="i" var="v">
                        <tr>
                            <td class="check-time holiday" id="day_${i*7+1}"></td>
                            <td class="check-time" id="day_${i*7+2}"></td>
                            <td class="check-time" id="day_${i*7+3}"></td>
                            <td class="check-time" id="day_${i*7+4}"></td>
                            <td class="check-time" id="day_${i*7+5}"></td>
                            <td class="check-time" id="day_${i*7+6}"></td>
                            <td class="check-time holiday" id="day_${i*7+7}"></td>
                        </tr>
                        </g:each>
                        </tbody>
                    </table>
                    <div>
                        <span><i class="ace-icon fa fa-circle bigger-120" style="color: Crimson"></i>迟到/旷工</span>
                        <span><i class="ace-icon fa fa-circle bigger-120" style="color: MediumSeaGreen"></i>正常</span>
                        <span><i class="ace-icon fa fa-circle bigger-120" style="color: RoyalBlue"></i>申请修改中</span>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-6">
                    <h4 style="text-align: center">考勤记录修改申请</h4>
                    <div class="form-horizontal" role="form">
                        <div class="form-group">
                            <label for="applyDate" class="col-md-3 control-label">修改日期</label>
                            <div class="col-md-9">
                                <div class="controls">
                                    <div class="input-prepend input-group">
                                        <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></span>
                                        <input type="text" readonly="readonly" style="width: 160px" name="applyDate" id="applyDate" class="input_date form-control" value=""/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="operation" class="col-md-3 control-label">修改类型</label>
                            <div class="col-md-9">
                                <g:select id="operation" name="operation" from="${['签到', '签出']}" required=""
                                            class="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label" for="description">
                                申请说明
                            </label>

                            <div class="col-md-9">
                                <g:textArea id="description" name="description" cols="40" rows="5" maxlength="2000" value="" class="form-control"/>

                            </div>
                        </div>

                        <div class="clearfix">
                            <div class="col-md-offset-3 col-md-9">
                                <button id="apply_button" name="apply_button" class="btn btn-info" >提交申请</button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <div id="feed" class="tab-pane">
            <div class="profile-feed row">
                <g:each in="${ors}" status="i" var="or">
                    <g:if test="${i==0||i==5}">
                        <div class="col-sm-6">
                    </g:if>

                    <div class="profile-activity clearfix">
                        <div>
                            <i class="pull-left thumbicon fa fa-check btn-success no-hover"></i>
                            <a class="user" href="#"> ${or.person} </a>
                            ${or.description}

                            <div class="time">
                                <i class="ace-icon fa fa-clock-o bigger-110"></i>
                                <prettytime:display date="${or.operateDate}" />
                            </div>
                        </div>

                        <div class="tools action-buttons">
                            <a href="#" class="blue">
                                <i class="ace-icon fa fa-pencil bigger-125"></i>
                            </a>

                            <a href="#" class="red">
                                <i class="ace-icon fa fa-times bigger-125"></i>
                            </a>
                        </div>
                    </div>


                    <g:if test="${i==4||i==9||i==ors.size()}">
                        </div><!-- /.col -->
                    </g:if>
                </g:each>

            </div><!-- /.row -->

        <!--
        <div class="space-12"></div>

        <div class="center">
            <button type="button" class="btn btn-sm btn-primary btn-white btn-round">
                <i class="ace-icon fa fa-rss bigger-150 middle orange2"></i>
                <span class="bigger-110">View more activities</span>

                <i class="icon-on-right ace-icon fa fa-arrow-right"></i>
            </button>
        </div>
        -->
        </div><!-- /#feed -->
        </div>
        </div>
        </div>
            <!-- PAGE CONTENT ENDS -->
        </div><!-- /.col -->
    </div><!-- /.row -->

    <!-- inline scripts related to this page -->
    <script type="text/javascript">
        var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
        basepath= basepath.substring(0,basepath.indexOf('/')) ;

        var personAttendanceList = function(monthOffset){
            $.ajax({
                url : '/'+basepath+'/attendance/ajaxAttendancePersonRecord',
                type : 'POST',
                dataType : 'json',
                data : {
                    pid : ${personInstance?.id},
                    monthOffset : monthOffset
                },
                timeout : 10000,
                error : function(e){
                    alert("操作失败")
                },
                success : function(json) {
                    $(".check-time").empty();
                    $(json).each(function(){
                        $("#title_month").text(json.AttendancePersonPecord.month);
                        var we = json.AttendancePersonPecord.weekdays;
                        var morn = json.AttendancePersonPecord.morn;
                        var aftr = json.AttendancePersonPecord.aftr;
                        $(morn).each(function(index,element){
                            var da = $('#day_'+(index+parseInt(we)+1));
                            $('<div/>').append(index+1).appendTo(da);
                            var el0 = element[0];
                            var el1 = element[1];
                            var el3 = element[3];
                            var morning = $('<div class="time" /> ');
                            if(el1){
                                morning.css("background-color","Crimson");
                            } else {
                                morning.css("background-color","MediumSeaGreen");
                            }
                            if(el3=="Apply"){
                                morning.css("background-color","RoyalBlue");
                            }
                            if(!el0){
                                el0 = "&nbsp;";
                                morning.css("background-color","transparent");
                            }
                            morning.append(el0).appendTo(da);
                        });
                        $(aftr).each(function(index,element){
                            var da = $('#day_'+(index+parseInt(we)+1));
                            var el0 = element[0];
                            var el1 = element[1];
                            var el3 = element[3];
                            var afternoon = $('<div class="time" /> ');
                            if(el1){
                                afternoon.css("background-color","Crimson");
                            } else {
                                afternoon.css("background-color","MediumSeaGreen");
                            }
                            if(el3=="Apply"){
                                afternoon.css("background-color","RoyalBlue");
                            }
                            if(!el0){
                                el0 = "&nbsp;";
                                afternoon.css("background-color","transparent");
                            }
                            afternoon.append(el0).appendTo(da);
                        })
                    })
                }
            });
        };

        jQuery(function($) {
            $('.input_date').daterangepicker({
                singleDatePicker: true,
                format: 'YYYY-MM-DD',
                startDate: '<g:formatDate format="yyyy-MM-dd" date="${new Date()}"/>',
                maxDate: '<g:formatDate format="yyyy-MM-dd" date="${new Date()}"/>',
                minDate: '<g:formatDate format="yyyy-MM-dd" date="${new Date() - 30}"/>'
            }, function(start, end, label) {
                console.log(start.toISOString(), end.toISOString(), label);
            });

                //another option is using modals
            $('#avatar2').on('click', function(){
                var modal =
                        '<div class="modal fade">\
                          <div class="modal-dialog">\
                           <div class="modal-content">\
                            <div class="modal-header">\
                                <button type="button" class="close" data-dismiss="modal">&times;</button>\
                                <h4 class="blue">改变头像</h4>\
                            </div>\
                            \
                            <g:uploadForm action="uploadAvatar" class="no-margin">\
                             <div class="modal-body">\
                                <div class="space-4"></div>\
                                <div style="width:75%;margin-left:12%;"><input type="file" name="avatar_file" /></div>\
                             </div>\
                            \
                             <div class="modal-footer center">\
                                <button type="submit" class="btn btn-sm btn-success"><i class="ace-icon fa fa-check"></i> 提交</button>\
                                <button type="button" class="btn btn-sm" data-dismiss="modal"><i class="ace-icon fa fa-times"></i> 取消</button>\
                             </div>\
                            </g:uploadForm>\
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
                    btn_choose:'Click to choose new avatar',
                    btn_change:null,
                    no_icon:'ace-icon fa fa-picture-o',
                    thumbnail:'small',
                    before_remove: function() {
                        //don't remove/reset files while being uploaded
                        return !working;
                    },
                    allowExt: ['jpg', 'jpeg', 'png', 'gif'],
                    allowMime: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']
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
                                form.find('button').removeAttr('disabled');
                                form.find('input[type=file]').ace_file_input('enable');
                                form.find('.modal-body > :last-child').remove();

                                modal.modal("hide");

                                //var thumb = file_input.next().find('img').data('thumb');
                                //if(thumb) $('#avatar2').get(0).src = thumb;

                                $('.profile-picture img').attr('src','${createLink(controller: "person", action: "avatar", params: [username: sec.username()])}'+'&thum=true&rnd=' + Math.random());

                                working = false;
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



            //////////////////////////////
            $('#profile-feed-1').ace_scroll({
                height: '250px',
                mouseWheelLock: true,
                alwaysVisible : true
            });

            $('a[ data-original-title]').tooltip();

            $('.easy-pie-chart.percentage').each(function(){
                var barColor = $(this).data('color') || '#555';
                var trackColor = '#E2E2E2';
                var size = parseInt($(this).data('size')) || 72;
                $(this).easyPieChart({
                    barColor: barColor,
                    trackColor: trackColor,
                    scaleColor: false,
                    lineCap: 'butt',
                    lineWidth: parseInt(size/10),
                    animate:false,
                    size: size
                }).css('color', barColor);
            });

            ///////////////////////////////////////////

            //right & left position
            //show the user info on right or left depending on its position
            $('#user-profile-2 .memberdiv').on('mouseenter touchstart', function(){
                var $this = $(this);
                var $parent = $this.closest('.tab-pane');

                var off1 = $parent.offset();
                var w1 = $parent.width();

                var off2 = $this.offset();
                var w2 = $this.width();

                var place = 'left';
                if( parseInt(off2.left) < parseInt(off1.left) + parseInt(w1 / 2) ) place = 'right';

                $this.find('.popover').removeClass('right left').addClass(place);
            }).on('click', function(e) {
                        e.preventDefault();
                    });




            ///////////////////////////////////////////////

            //显示当前人指定月份的考勤记录
            personAttendanceList(0);

            $("#prev_month").click(function(){
                var m = $("#title_month").attr("month")
                var mo = parseInt(m) + 1;
                $("#title_month").attr("month",mo);
                personAttendanceList(mo);
            });

            $("#next_month").click(function(){
                var m = $("#title_month").attr("month")
                var mo = parseInt(m) - 1;
                $("#title_month").attr("month",mo);
                personAttendanceList(mo);
            });

            //申请修改考勤记录
            $("#apply_button").click(function(){
                if($('#applyDate').val()==""){
                    alert("申请日期不能为空！");
                    return false;
                };
                if($('#description').val()==""){
                    alert("申请说明不能为空！");
                    return false;
                };
                $.ajax({
                    url : '/'+basepath+'/attendance/ajaxApplyAttendanceResult',
                    type : 'POST',
                    dataType : 'json',
                    data : {
                        op : $('#operation').val(),
                        opd : $('#applyDate').val(),
                        desc : $('#description').val()
                    },
                    timeout : 10000,
                    error : function(e){
                        alert("申请已存在，不能再申请。");
                    },
                    success : function(json) {
                        $('#description').val("");
                        alert("申请已提交，等待答复。");
                        personAttendanceList(0);
                    }
                });
            });
        });
    </script>
	</body>
</html>
