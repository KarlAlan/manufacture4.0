<%@ page import="com.rcstc.business.Invoice" %>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="bill">
        <g:message code="invoice.bill.label" default="Bill" />
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-9">
        <g:select id="bill" name="bill.id" from="${com.rcstc.business.Bill.list()}" optionKey="id" required="" value="${invoiceInstance?.bill?.id}" class="many-to-one"/>

    </div>
</div>

<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="invoiceNo">
        <g:message code="invoice.invoiceNo.label" default="Invoice No" />
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-9">
        <g:textField name="invoiceNo" required="" value="${invoiceInstance?.invoiceNo}"/>

    </div>
</div>

<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="type">
        <g:message code="invoice.type.label" default="Invoice Type" />

    </label>

    <div class="col-sm-9">
        <g:select name="type" from="${com.rcstc.business.InvoiceType?.values().name}" keys="${com.rcstc.business.InvoiceType.values()*.name()}" value="${invoiceInstance?.type?.name()}"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="invoiceTitle">
        <g:message code="invoice.invoiceTitle.label" default="Invoice Title" />
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-9">
        <g:textField name="invoiceTitle" required="" value="${invoiceInstance?.invoiceTitle}" class="party" autocomplete="off"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="invoiceAmount">
        <g:message code="invoice.invoiceAmount.label" default="Invoice Amount" />
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-9">
        <g:textField name="invoiceAmount" value="${fieldValue(bean: invoiceInstance, field: 'invoiceAmount')}" required=""/>

    </div>
</div>


<div class="form-group">
    <label for="invoiceDate" class="col-sm-3 control-label">
        <g:message code="invoice.invoiceDate.label" default="Invoice Date" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-9">
        <div class="controls">
            <div class="input-prepend input-group">
                <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></span>
                <input type="text" readonly="readonly" style="width: 160px" name="invoiceDate" id="invoiceDate" class="input_date form-control" value="${invoiceInstance?.invoiceDate?:new Date().format('yyyy-MM-dd')}"/>
            </div>
        </div>
    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="drawer">
        <g:message code="invoice.drawer.label" default="Drawer" />
        
    </label>

    <div class="col-sm-9">
        <g:textField name="drawer" value="${invoiceInstance?.drawer}" class="person" autocomplete="off"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="receiver">
        <g:message code="invoice.receiver.label" default="Receiver" />
        
    </label>

    <div class="col-sm-9">
        <g:textField name="receiver" value="${invoiceInstance?.receiver}" class="person" autocomplete="off"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="status">
        <g:message code="invoice.status.label" default="Status" />
        
    </label>

    <div class="col-sm-9">
        <g:select name="status" from="${com.rcstc.business.ContractStatus?.values().name}" keys="${com.rcstc.business.ContractStatus.values()*.name()}" value="${invoiceInstance?.status?.name()}"/>

    </div>
</div>

<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="tax">
        <g:message code="invoice.tax.label" default="Tax" />
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-9">
        <g:textField name="tax" value="${fieldValue(bean: invoiceInstance, field: 'tax')}"/>

    </div>
</div>

<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="isRebates">
        <g:message code="invoice.isRebates.label" default="isRebates" />

    </label>

    <div class="col-sm-9">
        <g:checkBox name="isRebates" value="${invoiceInstance?.isRebates}" />

    </div>
</div>

<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="rebatesTax">
        <g:message code="invoice.rebatesTax.label" default="Rebates Tax" />
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-9">
        <g:textField name="rebatesTax" value="${fieldValue(bean: invoiceInstance, field: 'rebatesTax')}"/>

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

        $('.party').typeahead({
            source: function(query,process) {
                return $.post('/'+basepath+'/project/ajaxCompanyName', { query: query },function(data){
                    return process(data);
                });
            }
        });
    });


</script>


