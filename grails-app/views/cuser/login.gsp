<%@ page import="cproject.Cuser"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'cuser.label', default: 'Cuser')}" />
<title><g:message code="default.button.login.label" /></title>
</head>
<body>
	<div id="create-cuser" class="content scaffold-create" role="main">
		<h1>
			<g:message code="default.button.login.label" default="login" />
		</h1>
		<g:if test="${flash.message}">
			<div class="message" role="status">
				${flash.message}
			</div>
		</g:if>
		<g:hasErrors bean="${cuserInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${cuserInstance}" var="error">
					<li
						<g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
							error="${error}" /></li>
				</g:eachError>
			</ul>
		</g:hasErrors>
		<g:form action="handleLogin">
			<fieldset class="form">
				<div
					class="fieldcontain ${hasErrors(bean: cuserInstance, field: 'login', 'error')} ">
					<label for="login"> <g:message code="cuser.login.label"
							default="Login" />
					</label>
					<g:textField name="login" value="${params?.login}" />
				</div>

				<div
					class="fieldcontain ${hasErrors(bean: cuserInstance, field: 'userPassword', 'error')} ">
					<label for="userPassword"> <g:message
							code="cuser.userPassword.label" default="User Password" />

					</label>
					<g:passwordField name="userPassword"
						value="${params?.userPassword}" />
				</div>
			</fieldset>
			<fieldset class="buttons">
				<g:submitButton name="handleLogin" class="login"
					value="${message(code: 'default.button.login.label', default: 'login')}" />
			</fieldset>
		</g:form>
	</div>
</body>
</html>
