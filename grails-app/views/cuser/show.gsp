
<%@ page import="cproject.Cuser"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'cuser.label', default: 'Cuser')}" />
<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
	<a href="#show-cuser" class="skip" tabindex="-1"><g:message
			code="default.link.skip.label" default="Skip to content&hellip;" /></a>

	<g:render template="/menu" /> 
	
	<div id="show-cuser" class="content scaffold-show" role="main">
		<h1>
			<g:message code="default.show.label" args="[entityName]" />
		</h1>
		<g:if test="${flash.message}">
			<div class="message" role="status">
				${flash.message}
			</div>
		</g:if>
		<ol class="property-list cuser">

			<g:if test="${cuserInstance?.userName}">
				<li class="fieldcontain"><span id="userName-label"
					class="property-label"><g:message
							code="cuser.userName.label" default="User Name" /></span> <span
					class="property-value" aria-labelledby="userName-label"><g:fieldValue
							bean="${cuserInstance}" field="userName" /></span></li>
			</g:if>

			<g:if test="${cuserInstance?.login}">
				<li class="fieldcontain"><span id="login-label"
					class="property-label"><g:message code="cuser.login.label"
							default="Login" /></span> <span class="property-value"
					aria-labelledby="login-label"><g:fieldValue
							bean="${cuserInstance}" field="login" /></span></li>
			</g:if>

			<%-- >g:if test="${cuserInstance?.userPassword}">
				<li class="fieldcontain"><span id="userPassword-label"
					class="property-label"><g:message
							code="cuser.userPassword.label" default="User Password" /></span> <span
					class="property-value" aria-labelledby="userPassword-label"><g:fieldValue
							bean="${cuserInstance}" field="userPassword" /></span></li>
			</g:if --%>

			<g:if test="${cuserInstance?.userRole}">
				<li class="fieldcontain"><span id="userRole-label"
					class="property-label"><g:message
							code="cuser.userRole.label" default="User Role" /></span> <span
					class="property-value" aria-labelledby="userRole-label">
					<%-- >g:fieldValue
							bean="${cuserInstance}" field="userRole" /--%>
					${cuserInstance?.roleName()}
					</span></li>
			</g:if>

		</ol>
		<g:form>
			<fieldset class="buttons">
				<g:hiddenField name="id" value="${cuserInstance?.id}" />
				<g:link class="edit" action="edit" id="${cuserInstance?.id}">
					<g:message code="default.button.edit.label" default="Edit" />
				</g:link>
				<g:actionSubmit class="delete" action="delete"
					value="${message(code: 'default.button.delete.label', default: 'Delete')}"
					onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				<g:actionSubmit class="edit" action="resetPassword"
					value="${message(code: 'button.resetPassword.label', default: 'resetPassword')}" />
				<g:actionSubmit class="edit" action="changePassword"
					value="${message(code: 'button.changePassword.label', default: 'changePassword')}" />
			</fieldset>
		</g:form>
	</div>
</body>
</html>
