<%@ page import="cproject.Cproject" %>



<div class="fieldcontain ${hasErrors(bean: cprojectInstance, field: 'projectName', 'error')} ">
	<label for="projectName">
		<g:message code="cproject.projectName.label" default="Project Name" />
		
	</label>
	<g:textField name="projectName" value="${cprojectInstance?.projectName}"/>
</div>

