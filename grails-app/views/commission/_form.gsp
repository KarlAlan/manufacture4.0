<%@ page import="com.rcstc.business.Commission" %>

<div class="form-group">
    <label for="project" class="col-sm-2 control-label"><g:message code="commission.project.label" default="project" /></label>
    <div class="col-sm-10">
        <g:textField name="project" value="${commissionInstance?.project}" class="form-control" readonly=""/>
    </div>
</div>
<div class="form-group">
    <label for="contractAmount" class="col-sm-2 control-label"><g:message code="commission.contractAmount.label" default="contractAmount" /></label>
    <div class="col-sm-10">
        <g:field name="contractAmount" value="${commissionInstance?.contractAmount}" class="form-control" type="number"/>
    </div>
</div>
<div class="form-group">
    <label for="procurementCosts" class="col-sm-2 control-label"><g:message code="commission.procurementCosts.label" default="Procurement Costs" /></label>
    <div class="col-sm-10">
        <g:field name="procurementCosts" value="${commissionInstance?.procurementCosts}" class="form-control" type="number"/>
    </div>
</div>
<div class="form-group">
    <label for="rebate" class="col-sm-2 control-label"><g:message code="commission.rebate.label" default="Rebate" /></label>
    <div class="col-sm-10">
        <g:field name="rebate" value="${commissionInstance?.rebate}" class="form-control" type="number"/>
    </div>
</div>
<div class="form-group">
    <label for="tax" class="col-sm-2 control-label"><g:message code="commission.tax.label" default="Tax" /></label>
    <div class="col-sm-10">
        <g:textField name="tax" value="${commissionInstance?.tax}" class="form-control"/>
    </div>
</div>
<div class="form-group">
    <label for="planDate" class="col-sm-2 control-label"><g:message code="commission.planDate.label" default="Plan Date" /></label>
    <div class="col-sm-10">
        <div class="controls">
            <div class="input-prepend input-group">
                <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></span>
                <input type="text" readonly="readonly" style="width: 160px" name="planDate" id="planDate" class="input_date form-control" value="${commissionInstance?.planDate}"/>
            </div>
        </div>
    </div>
</div>
<div class="form-group">
    <label for="budget" class="col-sm-2 control-label"><g:message code="commission.budget.label" default="Budget" /></label>
    <div class="col-sm-10">
        <g:field name="budget" value="${commissionInstance?.budget}" class="form-control" type="number"/>
    </div>
</div>
<div class="form-group">
    <label for="actualDate" class="col-sm-2 control-label"><g:message code="commission.actualDate.label" default="actualDate" /></label>
    <div class="col-sm-10">
        <div class="controls">
            <div class="input-prepend input-group">
                <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></span>
                <input type="text" readonly="readonly" style="width: 160px" name="actualDate" id="actualDate" class="input_date form-control" value="${commissionInstance?.actualDate}"/>
            </div>
        </div>
    </div>
</div>
<div class="form-group">
    <label for="actualCost" class="col-sm-2 control-label"><g:message code="commission.actualCost.label" default="actualCost" /></label>
    <div class="col-sm-10">
        <g:field name="actualCost" value="${commissionInstance?.actualCost}" class="form-control" type="number"/>
    </div>
</div>
<div class="form-group">
    <label for="saleman" class="col-sm-2 control-label"><g:message code="commission.saleman.label" default="Saleman" /></label>
    <div class="col-sm-10">
        <g:textField name="saleman" class="form-control" value="${commissionInstance?.saleman}"/>
    </div>
</div>
<div class="form-group">
    <label for="saleRate" class="col-sm-2 control-label"><g:message code="commission.saleRate.label" default="Sale Rate" /></label>
    <div class="col-sm-10">
        <g:textField name="saleRate" value="${commissionInstance?.saleRate}" class="form-control"/>
    </div>
</div>
<div class="form-group">
    <label for="schemer" class="col-sm-2 control-label"><g:message code="commission.schemer.label" default="Schemer" /></label>
    <div class="col-sm-10">
        <g:textField name="schemer" class="form-control" value="${commissionInstance?.schemer}"/>
    </div>
</div>
<div class="form-group">
    <label for="schemeRate" class="col-sm-2 control-label"><g:message code="commission.schemeRate.label" default="Scheme Rate" /></label>
    <div class="col-sm-10">
        <g:textField name="schemeRate" value="${commissionInstance?.schemeRate}" class="form-control"/>
    </div>
</div>
<div class="form-group">
    <label for="manager" class="col-sm-2 control-label"><g:message code="commission.manager.label" default="Manager" /></label>
    <div class="col-sm-10">
        <g:textField name="manager" class="form-control" value="${commissionInstance?.manager}"/>
    </div>
</div>
<div class="form-group">
    <label for="produceRate" class="col-sm-2 control-label"><g:message code="commission.produceRate.label" default="Produce Rate" /></label>
    <div class="col-sm-10">
        <g:textField name="produceRate" value="${commissionInstance?.produceRate}" class="form-control"/>
    </div>
</div>
<div class="form-group">
    <label for="teamSize" class="col-sm-2 control-label"><g:message code="commission.teamSize.label" default="Team Size" /></label>
    <div class="col-sm-10">
        <g:field name="teamSize" value="${commissionInstance?.teamSize}" class="form-control" type="number" min="1" max="100"/>
    </div>
</div>

<script type="text/javascript">
    var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
    basepath= basepath.substring(0,basepath.indexOf('/')) ;

    $(function(){
        $('.input_date').daterangepicker({
            singleDatePicker: true,
            format: 'YYYY-MM-DD',
            startDate: '<g:formatDate format="yyyy-MM-dd" date="${new Date()}"/>'
        }, function(start, end, label) {
            console.log(start.toISOString(), end.toISOString(), label);
        });
    })
</script>

