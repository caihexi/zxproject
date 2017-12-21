<%@ page import="cproject.Company" %>



<div class="fieldcontain ${hasErrors(bean: companyInstance, field: 'companyName', 'error')} ">
	<label for="companyName">
		<g:message code="company.companyName.label" default="Company Name" />
		
	</label>
	<g:textField name="companyName" value="${companyInstance?.companyName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: companyInstance, field: 'companyAddress', 'error')} ">
	<label for="companyAddress">
		<g:message code="company.companyAddress.label" default="Company Address" />
		
	</label>
	<g:textField name="companyAddress" value="${companyInstance?.companyAddress}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: companyInstance, field: 'companyTelphone', 'error')} ">
	<label for="companyTelphone">
		<g:message code="company.companyTelphone.label" default="Company Telphone" />
		
	</label>
	<g:textField name="companyTelphone" value="${companyInstance?.companyTelphone}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: companyInstance, field: 'memo', 'error')} ">
	<label for="memo">
		<g:message code="company.memo.label" default="Memo" />
		
	</label>
	<g:textField name="memo" value="${companyInstance?.memo}"/>
</div>

