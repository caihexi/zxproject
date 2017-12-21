<%@ page import="cproject.Content" %>



<div class="fieldcontain ${hasErrors(bean: contentInstance, field: 'personName', 'error')} ">
	<label for="personName">
		<g:message code="content.personName.label" default="Person Name" />
		
	</label>
	<g:textField name="personName" value="${contentInstance?.personName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contentInstance, field: 'company', 'error')} ">
	<label for="company">
		<g:message code="content.company.label" default="Company" />
		
	</label>
	<g:select id="company" name="company.id" from="${cproject.Company.list()}" optionKey="id" value="${contentInstance?.company?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contentInstance, field: 'personAddress', 'error')} ">
	<label for="personAddress">
		<g:message code="content.personAddress.label" default="Person Address" />
		
	</label>
	<g:textField name="personAddress" value="${contentInstance?.personAddress}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contentInstance, field: 'personPhone', 'error')} ">
	<label for="personPhone">
		<g:message code="content.personPhone.label" default="Person Phone" />
		
	</label>
	<g:textField name="personPhone" value="${contentInstance?.personPhone}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contentInstance, field: 'personBirthday', 'error')} ">
	<label for="personBirthday">
		<g:message code="content.personBirthday.label" default="Person Birthday" />
		
	</label>
	<g:datePicker name="personBirthday" precision="day"  value="${contentInstance?.personBirthday}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: contentInstance, field: 'personMemo', 'error')} ">
	<label for="personMemo">
		<g:message code="content.personMemo.label" default="Person Memo" />
		
	</label>
	<g:textField name="personMemo" value="${contentInstance?.personMemo}"/>
</div>

