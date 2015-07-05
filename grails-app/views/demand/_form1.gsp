<%@ page import="com.rcstc.manufacture.DemandType" %>
<%@ page import="com.rcstc.manufacture.Priority" %>
<%@ page import="com.rcstc.manufacture.DemandCharacter" %>


<div class="form-group">
    <label for="project" class="col-sm-2 control-label"><g:message code="demand.project" default="Project" /></label>
    <div class="col-sm-10">
        <g:select id="project" name="project.id" from="${pl}" optionKey="id" required="" noSelection="${['null':'选择']}" value="${demandInstance?.project?.id}" class="many-to-one form-control" disabled="${operation.equals('edit')}"/>
    </div>
</div>

<div class="form-group">
    <label for="category1" class="col-sm-2 control-label"><g:message code="demand.category1" default="Category1" /></label>
    <div class="col-sm-10">
        <div class="input-group">
            <div class="input-group-btn">
                <button type="button" class="btn btn-sm dropdown-toggle" data-toggle="dropdown">选择 <span class="caret"></span></button>
                <ul class="dropdown-menu" role="menu" id="category1_select">
                </ul>
            </div><!-- /btn-group -->
            <input type="text" class="form-control" id="category1" name="category1" value="${demandInstance?.category1}" required="">
        </div><!-- /input-group -->
    </div>


</div>

<div class="form-group">
    <label for="category2" class="col-sm-2 control-label"><g:message code="demand.category2" default="Category2" /></label>
    <div class="col-sm-10">
        <div class="input-group">
            <div class="input-group-btn">
                <button type="button" class="btn btn-sm dropdown-toggle" data-toggle="dropdown">选择 <span class="caret"></span></button>
                <ul class="dropdown-menu" role="menu" id="category2_select">
                </ul>
            </div><!-- /btn-group -->
            <input type="text" class="form-control" id="category2" name="category2" value="${demandInstance?.category2}">
        </div><!-- /input-group -->
    </div>
</div>

<div class="form-group">
    <label for="title" class="col-sm-2 control-label"><g:message code="demand.title" default="Title" /></label>
    <div class="col-sm-10">
        <g:textField name="title" value="${demandInstance?.title}" class="form-control" />
    </div>
</div>

<div class="form-group">
    <label for="description" class="col-sm-2 control-label"><g:message code="demand.description" default="Description" /></label>
    <div class="col-sm-10">
        <g:textArea id="description" name="description" cols="40" rows="5" maxlength="2000" required="" value="${demandInstance?.description}" class="form-control" style="display: none"/>
        <div id="demand-desc">${raw(demandInstance?.description)}</div>
    </div>
</div>

<div class="form-group">
    <label for="planStartDate" class="col-sm-2 control-label"><g:message code="demand.planStartDate" default="Plan Start Date" /></label>
    <div class="col-sm-10">
        <div class="controls">
            <div class="input-prepend input-group">
                <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></span>
                <input type="text" readonly="readonly" style="width: 160px" name="planStartDate" id="planStartDate" class="input_date form-control" value="${demandInstance?.planStartDate?:new Date().format('yyyy-MM-dd')}"/>
            </div>
        </div>
    </div>
</div>

<div class="form-group">
    <label for="planStopDate" class="col-sm-2 control-label"><g:message code="demand.planStopDate" default="Plan End Date" /></label>
    <div class="col-sm-10">
        <div class="controls">
            <div class="input-prepend input-group">
                <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></span>
                <input type="text" readonly="readonly" style="width: 160px" name="planStopDate" id="planStopDate" class="input_date form-control" value="${demandInstance?.planStopDate?:(new Date()+30).format('yyyy-MM-dd')}"/>
            </div>
        </div>
    </div>
</div>

<div class="form-group">
    <label for="type" class="col-sm-2 control-label"><g:message code="demand.type" default="Type" /></label>
    <div class="col-sm-10">
        <g:select id="type" name="type" from="${DemandType?.values()*.name}" keys="${DemandType.values()*.name()}" value="${demandInstance?.type?:DemandType.NEW_FUNCTION}" class="form-control" />
    </div>
</div>

<div class="form-group">
    <label for="demandCharacter" class="col-sm-2 control-label"><g:message code="demand.demandCharacter" default="Type" /></label>
    <div class="col-sm-10">
        <g:select id="demandCharacter" name="demandCharacter" from="${DemandCharacter?.values()*.name}" keys="${DemandCharacter.values()*.name()}" value="${demandInstance?.demandCharacter?:DemandCharacter.FUNCTIONAL}" class="form-control" />
    </div>
</div>

<div class="form-group">
    <label for="priority" class="col-sm-2 control-label"><g:message code="demand.priority" default="Priority" /></label>
    <div class="col-sm-10">
        <g:select id="priority" name="priority" from="${Priority?.values()*.name}" keys="${Priority.values()*.name()}" value="${demandInstance?.priority?:Priority.NORMAL}" class="form-control" />
    </div>
</div>

<div class="form-group">
    <label for="urgent" class="col-sm-2 control-label"><g:message code="demand.urgent" default="Urgent" /></label>
    <div class="col-sm-10">
        <g:checkBox name="urgent" value="${demandInstance?.urgent}" class="form-control"></g:checkBox>
     </div>
</div>

<div class="form-group">
    <label for="submitPeople" class="col-sm-2 control-label"><g:message code="demand.submitPeople" default="Submit People" /></label>
    <div class="col-sm-10">
        <g:textField name="submitPeople" required="" value="${demandInstance?.submitPeople?:person}" class="form-control" />
    </div>
</div>

<div class="form-group">
    <label for="remark" class="col-sm-2 control-label"><g:message code="demand.remark" default="Remark" /></label>
    <div class="col-sm-10">
        <g:textArea id="remark" name="remark" cols="40" rows="5" maxlength="2000" value="${demandInstance?.remark}" class="form-control"/>
    </div>
</div>


<script type="text/javascript">
    var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
    basepath= basepath.substring(0,basepath.indexOf('/')) ;

    var initCategory = function(){
        var pid = $("#project  option:selected").val();
        $("#category1_select").empty();
        $("#category2_select").empty();
        if(pid&&pid!="null"){
            $.ajax({
                url : '/'+basepath+'/informationSystem/ajaxGetCategory1ByProject',
                type : 'POST',
                dataType : 'json',
                data : {
                    pid : pid
                },
                timeout : 10000,
                error : function(e){
                    console.log("操作失败");
                },
                success : function(json) {
                    $(json).each(function(){
                        var moudle = this;
                        $("#category1_select").append("<li ><a mid="+moudle[0]+">"+moudle[1]+"</a></li>");
                    })
                }
            });
        };
    }

    $(document).ready(function() {
        $('.input_date').daterangepicker({
            singleDatePicker: true,
            format: 'YYYY-MM-DD',
            startDate: '<g:formatDate format="yyyy-MM-dd" date="${new Date()}"/>'
        }, function(start, end, label) {
            console.log(start.toISOString(), end.toISOString(), label);
        });

        $("#project").change(
            initCategory
        );

        $( document ).on( "click","#category1_select li a", function() {
            var cla1 = $(this);
            $("#category1").val(cla1.text());
            $("#category2_select").empty();
            $.ajax({
                url : '/'+basepath+'/informationSystem/ajaxGetCategory2',
                type : 'POST',
                dataType : 'json',
                data : {
                    mid : cla1.attr("mid")
                },
                timeout : 10000,
                error : function(e){
                    console.log("操作失败")
                },
                success : function(json) {
                    $(json).each(function(){
                        var moudle = this;
                        $("#category2_select").append("<li><a >"+moudle[1]+"</a></li>");
                    })
                }
            });
        });

        $( document ).on( "click","#category2_select li a", function() {
            var cla2 = $(this);
            $("#category2").val(cla2.text());
        });

        initCategory();

        $('#demand-desc').summernote({
            height: 200,
            lang: 'zh-CN',
            focus: false,
            onImageUpload: function(files){
                //sendFile(files[0], editor, welEditable);
                var url = '/'+basepath+'/file/upload';
                var $note = $(this);

                data = new FormData();
                data.append("file", files[0]);

                $.ajax({
                    data: data,
                    type: "POST",
                    url: url,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function(data) {
                        //alert("上传成功,请等待加载");
                        $.each(data, function (index, img) {
                            // use summernote api
                            $note.summernote('insertImage', location.protocol+"//"+location.host+img.url);
                        });

                        setTimeout(function(){
                            //$(".note-alarm").remove();
                        },3000);
                    },
                    error:function(){
                        alert("上传失败");
                        setTimeout(function(){
                            //$(".note-alarm").remove();
                        },3000);
                    }
                });
            }
        });
    });


</script>