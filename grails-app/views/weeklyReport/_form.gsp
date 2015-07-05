<%@ page import="com.rcstc.manufacture.WeeklyReport" %>




<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" >
        <g:message code="weeklyReport.project.label" default="Project" />
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-9">
        ${weeklyReportInstance?.project?.name}
    </div>
</div>

<div class="form-group">
    <label class="col-md-3 control-label">
        <g:message code="weeklyReport.startEndDate.label" default="Date" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-md-9">
        ${weeklyReportInstance?.title}
    </div>
</div>

<div class="control-group col-md-offset-3 col-md-9" style="margin-bottom: 15px">
    <label class="control-label bolder blue"><g:message code="weeklyReport.situation.label" default="Situation" /></label>

    <div class="radio">
        <label>
            <input name="situation" type="radio" class="ace" value="normal" ${weeklyReportInstance?.situation=='normal'?'checked':''}/>
            <span class="lbl">按计划进行</span>
        </label>
    </div>

    <div class="radio">
        <label>
            <input name="situation" type="radio" class="ace" value="in advance" ${weeklyReportInstance?.situation=='in advance'?'checked':''}/>
            <span class="lbl">比计划提前</span>
        </label>
    </div>

    <div class="radio">
        <label>
            <input name="situation" type="radio" class="ace" value="delay" ${weeklyReportInstance?.situation=='delay'?'checked':''}/>
            <span class="lbl">落后计划</span>
        </label>
    </div>
</div>

<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right">
        本周需求完成情况
    </label>

    <div class="col-sm-9">
        ${raw(weeklyReportInstance?.handled)}
    </div>
</div>

<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="description">
        <g:message code="weeklyReport.description.label" default="Description" />
        
    </label>

    <div class="col-sm-9">
        <g:textArea name="description" cols="40" rows="5" maxlength="2000" value="${weeklyReportInstance?.description}" style="display: none"/>
        <div class="summernote">${raw(weeklyReportInstance?.description)}</div>
    </div>
</div>

<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right">
        <g:message code="weeklyReport.finishedTask.label" default="finishedTask" />

    </label>

    <div class="col-sm-9">
        ${raw(weeklyReportInstance?.finishedTask)}
    </div>
</div>

<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right">
        <g:message code="weeklyReport.planingTask.label" default="planingTask" />

    </label>

    <div class="col-sm-9">
        ${raw(weeklyReportInstance?.planingTask)}
    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="question">
        <g:message code="weeklyReport.question.label" default="Question" />
        
    </label>

    <div class="col-sm-9">
        <g:textArea name="question" cols="40" rows="5" maxlength="2000" value="${weeklyReportInstance?.question}" style="display: none"/>
        <div class="summernote">${raw(weeklyReportInstance?.question)}</div>
    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="resource">
        <g:message code="weeklyReport.resource.label" default="Resource" />
        
    </label>

    <div class="col-sm-9">
        <g:textArea name="resource" cols="40" rows="5" maxlength="2000" value="${weeklyReportInstance?.resource}" style="display: none"/>
        <div class="summernote">${raw(weeklyReportInstance?.resource)}</div>
    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="remark">
        <g:message code="weeklyReport.remark.label" default="Remark" />
        
    </label>

    <div class="col-sm-9">
        <g:textArea name="remark" cols="40" rows="5" maxlength="2000" value="${weeklyReportInstance?.remark}" style="display: none"/>
        <div class="summernote">${raw(weeklyReportInstance?.remark)}</div>
    </div>
</div>

<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="buildPerson">
        <g:message code="weeklyReport.buildPerson.label" default="Build Person" />
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-9">
        <g:textField name="buildPerson" required="" value="${weeklyReportInstance?.buildPerson}"/>

    </div>
</div>

<script type="text/javascript">
    var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
    basepath= basepath.substring(0,basepath.indexOf('/')) ;

    var copycode = function(){
        $('.summernote').each(function(){
            var su = $(this);
            var te = su.prev();

            te.val(su.code());
        })
    }

    $(function(){
        $('#start_end_date').daterangepicker(null, function(start, end, label) {
            console.log(start.toISOString(), end.toISOString(), label);
        });

        $('.input-mini').ace_spinner({value:0,min:0,max:200,step:1, btn_up_class:'btn-info' , btn_down_class:'btn-info'})
                .closest('.ace-spinner')

        $('.summernote').summernote({
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
    })
</script>
<asset:javascript src="fuelux/fuelux.spinner.js"/>
<asset:javascript src="ace/elements.spinner.js"/>
<asset:stylesheet src="summernote.css"/>
<asset:javascript src="summernote.min.js"/>
<asset:javascript src="summernote-zh-CN.js"/>