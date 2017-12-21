<%@ page import="cproject.Csubject" %>

<%-->div class="fieldcontain ${hasErrors(bean: csubjectInstance, field: 'subjectType', 'error')} required">
	<label for="subjectType">
		<g:message code="csubject.subjectType.label" default="Subject Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="subjectType" from="${csubjectInstance.constraints.subjectType.inList}" required="" value="${fieldValue(bean: csubjectInstance, field: 'subjectType')}" valueMessagePrefix="csubject.subjectType"/>
</div --%>

<div class="fieldcontain ${hasErrors(bean: csubjectInstance, field: 'subjectParent', 'error')} required">
	<label for="subjectParent">
		<g:message code="csubject.subjectParent.label" default="Subject Parent" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="subjectParent" name="subjectParent.id" from="${cproject.Csubject.list()}" optionKey="id" required="" value="${csubjectInstance?.subjectParent?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: csubjectInstance, field: 'subjectName', 'error')} ">
	<label for="subjectName">
		<g:message code="csubject.subjectName.label" default="Subject Name" />
		
	</label>
	<g:textField name="subjectName" value="${csubjectInstance?.subjectName}"/>
</div>

<%--div class="fieldcontain ${hasErrors(bean: csubjectInstance, field: 'subjectBalance', 'error')} required">
	<label for="subjectBalance">
		<g:message code="csubject.subjectBalance.label" default="Subject Balance" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="subjectBalance" value="${fieldValue(bean: csubjectInstance, field: 'subjectBalance')}" required=""/>
</div--%>

