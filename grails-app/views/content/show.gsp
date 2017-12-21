
<%@ page import="cproject.Content" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'content.label', default: 'Content')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-content" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

	<g:render template="/menu" /> 
	
		<div id="show-content" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list content">
			
				<g:if test="${contentInstance?.personName}">
				<li class="fieldcontain">
					<span id="personName-label" class="property-label"><g:message code="content.personName.label" default="Person Name" /></span>
					
						<span class="property-value" aria-labelledby="personName-label"><g:fieldValue bean="${contentInstance}" field="personName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${contentInstance?.company}">
				<li class="fieldcontain">
					<span id="company-label" class="property-label"><g:message code="content.company.label" default="Company" /></span>
					
						<span class="property-value" aria-labelledby="company-label"><g:link controller="company" action="show" id="${contentInstance?.company?.id}">${contentInstance?.company?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${contentInstance?.personAddress}">
				<li class="fieldcontain">
					<span id="personAddress-label" class="property-label"><g:message code="content.personAddress.label" default="Person Address" /></span>
					
						<span class="property-value" aria-labelledby="personAddress-label"><g:fieldValue bean="${contentInstance}" field="personAddress"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${contentInstance?.personPhone}">
				<li class="fieldcontain">
					<span id="personPhone-label" class="property-label"><g:message code="content.personPhone.label" default="Person Phone" /></span>
					
						<span class="property-value" aria-labelledby="personPhone-label"><g:fieldValue bean="${contentInstance}" field="personPhone"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${contentInstance?.personBirthday}">
				<li class="fieldcontain">
					<span id="personBirthday-label" class="property-label"><g:message code="content.personBirthday.label" default="Person Birthday" /></span>
					
						<span class="property-value" aria-labelledby="personBirthday-label"><g:formatDate date="${contentInstance?.personBirthday}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${contentInstance?.personMemo}">
				<li class="fieldcontain">
					<span id="personMemo-label" class="property-label"><g:message code="content.personMemo.label" default="Person Memo" /></span>
					
						<span class="property-value" aria-labelledby="personMemo-label"><g:fieldValue bean="${contentInstance}" field="personMemo"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${contentInstance?.id}" />
					<g:link class="edit" action="edit" id="${contentInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
