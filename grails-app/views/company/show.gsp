
<%@ page import="cproject.Company" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'company.label', default: 'Company')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-company" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

	<g:render template="/menu" /> 
	
		<div id="show-company" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list company">
			
				<g:if test="${companyInstance?.companyName}">
				<li class="fieldcontain">
					<span id="companyName-label" class="property-label"><g:message code="company.companyName.label" default="Company Name" /></span>
					
						<span class="property-value" aria-labelledby="companyName-label"><g:fieldValue bean="${companyInstance}" field="companyName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${companyInstance?.companyAddress}">
				<li class="fieldcontain">
					<span id="companyAddress-label" class="property-label"><g:message code="company.companyAddress.label" default="Company Address" /></span>
					
						<span class="property-value" aria-labelledby="companyAddress-label"><g:fieldValue bean="${companyInstance}" field="companyAddress"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${companyInstance?.companyTelphone}">
				<li class="fieldcontain">
					<span id="companyTelphone-label" class="property-label"><g:message code="company.companyTelphone.label" default="Company Telphone" /></span>
					
						<span class="property-value" aria-labelledby="companyTelphone-label"><g:fieldValue bean="${companyInstance}" field="companyTelphone"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${companyInstance?.memo}">
				<li class="fieldcontain">
					<span id="memo-label" class="property-label"><g:message code="company.memo.label" default="Memo" /></span>
					
						<span class="property-value" aria-labelledby="memo-label"><g:fieldValue bean="${companyInstance}" field="memo"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${companyInstance?.id}" />
					<g:link class="edit" action="edit" id="${companyInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
    <g:render template="/cjournal/list" />
    </body>
</html>
