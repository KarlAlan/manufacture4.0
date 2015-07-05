<%@ page import="com.rcstc.business.Fund" %>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="bill">
        <g:message code="fund.bill.label" default="Bill" />
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-9">
        <g:select id="bill" name="bill.id" from="${com.rcstc.business.Bill.list()}" optionKey="id" required="" value="${fundInstance?.bill?.id}" class="many-to-one"/>

    </div>
</div>

<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="bank">
        <g:message code="fund.bank.label" default="Bank" />
        
    </label>

    <div class="col-sm-9">
        <g:textField name="bank" value="${fundInstance?.bank}"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="refNo">
        <g:message code="fund.refNo.label" default="Ref No" />
        
    </label>

    <div class="col-sm-9">
        <g:textField name="refNo" value="${fundInstance?.refNo}"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="checkNumber">
        <g:message code="fund.checkNumber.label" default="Check Number" />
        
    </label>

    <div class="col-sm-9">
        <g:textField name="checkNumber" value="${fundInstance?.checkNumber}"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="payer">
        <g:message code="fund.payer.label" default="Payer" />
        
    </label>

    <div class="col-sm-9">
        <g:textField name="payer" value="${fundInstance?.payer}" class="party" autocomplete="off"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="payee">
        <g:message code="fund.payee.label" default="Payee" />
        
    </label>

    <div class="col-sm-9">
        <g:textField name="payee" value="${fundInstance?.payee}" class="party" autocomplete="off"/>

    </div>
</div>


<div class="form-group">
    <label for="occurrenceDate" class="col-sm-3 control-label">
        <g:message code="fund.occurrenceDate.label" default="Occurrence Date" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-9">
        <div class="controls">
            <div class="input-prepend input-group">
                <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></span>
                <input type="text" readonly="readonly" style="width: 160px" name="occurrenceDate" id="occurrenceDate" class="input_date form-control" value="${fundInstance?.occurrenceDate?:new Date().format('yyyy-MM-dd')}"/>
            </div>
        </div>
    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="debit">
        <g:message code="fund.debit.label" default="Debit" />
        
    </label>

    <div class="col-sm-9">
        <g:textField name="debit" value="${fieldValue(bean: fundInstance, field: 'debit')}"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="credit">
        <g:message code="fund.credit.label" default="Credit" />
        
    </label>

    <div class="col-sm-9">
        <g:textField name="credit" value="${fieldValue(bean: fundInstance, field: 'credit')}"/>

    </div>
</div>


<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="particulars">
        <g:message code="fund.particulars.label" default="Particulars" />
        
    </label>

    <div class="col-sm-9">
        <g:textField name="particulars" value="${fundInstance?.particulars}"/>

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




