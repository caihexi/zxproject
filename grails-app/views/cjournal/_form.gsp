<%@ page import="cproject.Cjournal" %>

<div class="fieldcontain ${hasErrors(bean: cjournalInstance, field: 'journalDate', 'error')} required">
    <label for="journalDate">
        <g:message code="cjournal.journalDate.label" default="Journal Date" />
        <span class="required-indicator">*</span>
    </label>
    <g:datePicker id="journalDate" name="journalDate" required="" value="${cjournalInstance?.journalDate}" precision="minute"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cjournalInstance, field: 'subject0', 'error')} required">
    <label for="subject0">
        <g:message code="cjournal.subject0.label" default="Subject0" />
        <span class="required-indicator">*</span>
    </label>
    <g:select id="subject0" name="subject0.id" from="${cproject.Csubject.findAllByIdGreaterThan(3)}" optionKey="id" required="" value="${cjournalInstance?.subject0?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cjournalInstance, field: 'journalType', 'error')} required">
	<label for="journalType">
		<g:message code="cjournal.journalType.label" default="Journal Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="journalType" name="journalType" from="${cjournalInstance.constraints.journalType.inList}" required="" value="${cjournalInstance?.journalType}" valueMessagePrefix="cjournal.journalType"/>
</div>


<div class="fieldcontain ${hasErrors(bean: cjournalInstance, field: 'amount', 'error')} required">
    <label for="amount">
        <g:message code="cjournal.amount.label" default="Amount" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="amount" value="${fieldValue(bean: cjournalInstance, field: 'amount')}" required=""/>
</div>

<%--div class="fieldcontain ${hasErrors(bean: cjournalInstance, field: 'subject1', 'error')} required">
	<label for="subject1">
		<g:message code="cjournal.subject1.label" default="Subject1" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="subject1" name="subject1.id" from="" optionKey="id" required="" value="${cjournalInstance?.subject1?.id}" class="many-to-one"/>
</div--%>

<div class="fieldcontain ${hasErrors(bean: cjournalInstance, field: 'projecti', 'error')} required">
	<label for="projecti">
		<g:message code="cjournal.projecti.label" default="Projecti" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="projecti" name="projecti.id" from="${cproject.Cproject.list([sort:'projectName'])}" optionKey="id" required="" value="${cjournalInstance?.projecti?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cjournalInstance, field: 'company', 'error')} required">
	<label for="company">
		<g:message code="cjournal.company.label" default="Company" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="company" name="company.id" from="${cproject.Company.list([sort:'companyName'])}" optionKey="id" required="" value="${cjournalInstance?.company?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cjournalInstance, field: 'inputMan', 'error')} required">
    <label for="inputMan">
        <g:message code="cjournal.inputMan.label" default="Input Man" />
        <span class="required-indicator">*</span>
    </label>
    <g:hiddenField name="inputMan.id" value="${cjournalInstance?.inputMan?.id}"/>
    ${cjournalInstance?.inputMan?.toString()}
</div>

<div class="fieldcontain ${hasErrors(bean: cjournalInstance, field: 'memo', 'error')} ">
	<label for="memo">
		<g:message code="cjournal.memo.label" default="Memo" />
	</label>
	<g:textField name="memo" value="${cjournalInstance?.memo}"/>
</div>

