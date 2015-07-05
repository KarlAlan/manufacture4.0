<%@ page import="com.rcstc.business.Contract" %>




<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="serial">
        <g:message code="contract.serial.label" default="Serial" />
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-9">
        <g:textField name="serial" required="" value="${contractInstance?.serial}"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="name">
        <g:message code="contract.name.label" default="Name" />
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-9">
        <g:textField name="name" required="" value="${contractInstance?.name}"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="firstParty">
        <g:message code="contract.firstParty.label" default="First Party" />
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-9">
        <g:textField name="firstParty" class="party" required="" value="${contractInstance?.firstParty}" autocomplete="off"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="secondParty">
        <g:message code="contract.secondParty.label" default="Second Party" />
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-9">
        <g:textField name="secondParty" class="party" required="" value="${contractInstance?.secondParty?contractInstance?.secondParty:currentPerson?.company}" autocomplete="off"/>

    </div>
</div>

<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="projects">
        <g:message code="contract.project.label" default="Project" />

    </label>

    <div class="col-sm-9">
        <g:select id="projects" name="projects" from="${pl}" multiple="multiple" optionKey="id" value="${contractInstance?.projects*.id}" class="many-to-many multiselect"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="batch">
        <g:message code="contract.batch.label" default="Batch" />

    </label>

    <div class="col-sm-9">
        <g:textField name="batch" value="${contractInstance?.batch}"/>

    </div>
</div>


<div class="form-group">
    <label for="signDate" class="col-sm-3 control-label">
        <g:message code="contract.signDate.label" default="Sign Date" />
    </label>
    <div class="col-sm-9">
        <div class="controls">
            <div class="input-prepend input-group">
                <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></span>
                <input type="text" readonly="readonly" style="width: 160px" name="signDate" id="signDate" class="input_date form-control" value="${contractInstance?.signDate?:new Date().format('yyyy-MM-dd')}"/>
            </div>
        </div>
    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="contractAmount">
        <g:message code="contract.contractAmount.label" default="Contract Amount" />
        
    </label>

    <div class="col-sm-9">
        <g:textField required="" name="contractAmount" value="${fieldValue(bean: contractInstance, field: 'contractAmount')}"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="status">
        <g:message code="contract.status.label" default="Status" />
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-9">
        <g:select name="status" from="${com.rcstc.business.ContractStatus?.values().name}" keys="${com.rcstc.business.ContractStatus.values()*.name()}" required="" value="${contractInstance?.status?.name()}" />

    </div>
</div>





<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="remark">
        <g:message code="contract.remark.label" default="Remark" />
        
    </label>

    <div class="col-sm-9">
        <g:textArea name="remark" cols="40" rows="5" maxlength="2000" value="${contractInstance?.remark}"/>

    </div>
</div>

<!--
<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="bills">
        <g:message code="contract.bills.label" default="Bills" />
        
    </label>

    <div class="col-sm-9">

<ul class="one-to-many">
<g:each in="${contractInstance?.bills?}" var="b">
    <li><g:link controller="bill" action="show" id="${b.id}">${b?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="bill" action="create" params="['contract.id': contractInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'bill.label', default: 'Bill')])}</g:link>
</li>
</ul>


    </div>
</div>
-->

<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="fpPersons">
        <g:message code="contract.fpPersons.label" default="Fp Persons" />
        
    </label>

    <div class="col-sm-9">
        <g:select name="fpPersons" from="${com.rcstc.manufacture.Person.list()}"  multiple="multiple" optionKey="id" size="5" value="${contractInstance?.fpPersons*.id}" class="many-to-many multiselect"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="spPersons">
        <g:message code="contract.spPersons.label" default="Sp Persons" />
        
    </label>

    <div class="col-sm-9">
        <g:select name="spPersons" from="${com.rcstc.manufacture.Person.list()}" multiple="multiple" optionKey="id" size="5" value="${contractInstance?.spPersons*.id}" class="many-to-many multiselect"/>

    </div>
</div>

<script type="text/javascript">
    var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
    basepath= basepath.substring(0,basepath.indexOf('/')) ;

    $(document).ready(function() {
        $('.input_date').daterangepicker({
            singleDatePicker: true,
            format: 'YYYY-MM-DD',
            startDate: '<g:formatDate format="yyyy-MM-dd" date="${new Date()}"/>'
        }, function(start, end, label) {
            console.log(start.toISOString(), end.toISOString(), label);
        });

        $('.party').typeahead({
            source: function(query,process) {
                return $.post('/'+basepath+'/project/ajaxCompanyName', { query: query },function(data){
                    return process(data);
                });
            }
        });

        // multiselect控件
        $('.multiselect').multiselect({
            enableFiltering: true,
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
    });


</script>