<%@ page import="com.rcstc.business.SetOfAccount" %>

<div class="form-group">
    <label for="company" class="col-sm-2 control-label"><g:message code="setOfAccount.company" default="Company" /></label>
    <div class="col-sm-10">
        <input type="text" class="form-control party" id="company" name="company" placeholder="公司名称"  value="${setOfAccountInstance?.company?:company}" autocomplete="off" <sec:ifNotGranted roles="SUPER_ADMIN">disabled</sec:ifNotGranted>>
    </div>
</div>

<div class="form-group">
    <label for="name" class="col-sm-2 control-label"><g:message code="setOfAccount.name" default="Name" /></label>
    <div class="col-sm-10">
        <g:textField name="name" required="" value="${setOfAccountInstance?.name}" class="form-control" />
    </div>
</div>

<div class="form-group">
    <label for="description" class="col-sm-2 control-label"><g:message code="setOfAccount.description" default="Description" /></label>
    <div class="col-sm-10">
        <g:textField name="description"  value="${setOfAccountInstance?.description}" class="form-control" />
    </div>
</div>

<script type="text/javascript">
    var basepath= document.location.pathname.substring(document.location.pathname.indexOf('/')+1) ;
    basepath= basepath.substring(0,basepath.indexOf('/')) ;

    $(function(){
        $('.party').typeahead({
            source: function(query,process) {
                return $.post('/'+basepath+'/project/ajaxCompanyName', { query: query },function(data){
                    return process(data);
                });
            }
        });

    })
</script>
