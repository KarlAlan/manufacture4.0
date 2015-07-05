<%@ page import="com.rcstc.business.Bill" %>




<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="contract">
        <g:message code="bill.contract.label" default="Contract" />
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-9">
        <g:select id="contract" name="contract.id" from="${com.rcstc.business.Contract.list()}" optionKey="id" required="" value="${billInstance?.contract?.id}" class="many-to-one"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="title">
        <g:message code="bill.title.label" default="Title" />
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-9">
        <g:textField name="title" required="" value="${billInstance?.title}"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="amount">
        <g:message code="bill.amount.label" default="Amount" />
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-9">
        <g:textField name="amount" value="${fieldValue(bean: billInstance, field: 'amount')}" required=""/>

    </div>
</div>


<div class="form-group">
    <label for="expireDate" class="col-sm-3 control-label">
        <g:message code="bill.expireDate.label" default="Expire Date" />
    </label>
    <div class="col-sm-9">
        <div class="controls">
            <div class="input-prepend input-group">
                <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></span>
                <input type="text" readonly="readonly" style="width: 160px" name="expireDate" id="expireDate" class="input_date form-control" value="${billInstance?.expireDate?:new Date().format('yyyy-MM-dd')}"/>
            </div>
        </div>
    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="remark">
        <g:message code="bill.remark.label" default="Remark" />
        
    </label>

    <div class="col-sm-9">
        <g:textArea name="remark" cols="40" rows="5" maxlength="2000" value="${billInstance?.remark}"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="fpPerson">
        <g:message code="bill.fpPerson.label" default="Fp Person" />
        
    </label>

    <div class="col-sm-9">
        <g:textField name="fpPerson" value="${billInstance?.fpPerson}" class="person" autocomplete="off"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="spPerson">
        <g:message code="bill.spPerson.label" default="Sp Person" />
        
    </label>

    <div class="col-sm-9">
        <g:textField name="spPerson" value="${billInstance?.spPerson}" class="person" autocomplete="off"/>

    </div>
</div>

<!--
<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="invoices">
        <g:message code="bill.invoices.label" default="Invoices" />
        
    </label>

    <div class="col-sm-9">
        
<ul class="one-to-many">
<g:each in="${billInstance?.invoices?}" var="i">
    <li><g:link controller="invoice" action="show" id="${i.id}">${i?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="invoice" action="create" params="['bill.id': billInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'invoice.label', default: 'Invoice')])}</g:link>
</li>
</ul>


    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="funds">
        <g:message code="bill.funds.label" default="Funds" />
        
    </label>

    <div class="col-sm-9">
        
<ul class="one-to-many">
<g:each in="${billInstance?.funds?}" var="f">
    <li><g:link controller="fund" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="fund" action="create" params="['bill.id': billInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'fund.label', default: 'Fund')])}</g:link>
</li>
</ul>


    </div>
</div>
-->

<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="status">
        <g:message code="bill.status.label" default="Status" />
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-9">
        <g:select name="status" from="${com.rcstc.business.ContractStatus?.values().name}" keys="${com.rcstc.business.ContractStatus.values()*.name()}" required="" value="${billInstance?.status?.name()}" />

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="verification">
        <g:message code="bill.verification.label" default="Verification" />
        
    </label>

    <div class="col-sm-9">
        <g:checkBox name="verification" value="${billInstance?.verification}" />

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

        $('.person').typeahead({
            source: function(query,process) {
                return $.post('/'+basepath+'/person/ajaxPersonName', { query: query },function(data){
                    return process(data);
                });
            }
        });
    });


</script>