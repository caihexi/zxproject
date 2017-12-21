<%@ page import="cproject.Cuser"%>


<g:if test="${isChangePassword }">
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
<div
	class="fieldcontain ${hasErrors(bean: cuserInstance, field: 'userPassword', 'error')} ">
	<label for="userPassword"> <g:message
			code="cuser.userPassword.label" default="User Password" />

	</label>
	<g:passwordField name="userPassword" value="${cuserInstance?.userPassword}" />
</div>
</g:if>
<g:else>
<div
	class="fieldcontain ${hasErrors(bean: cuserInstance, field: 'userName', 'error')} ">
	<label for="userName"> <g:message code="cuser.userName.label"
			default="User Name" />

	</label>
	<g:textField name="userName" value="${cuserInstance?.userName}" />
</div>

<div
	class="fieldcontain ${hasErrors(bean: cuserInstance, field: 'login', 'error')} ">
	<label for="login"> <g:message code="cuser.login.label"
			default="Login" />

	</label>
	<g:textField name="login" value="${cuserInstance?.login}" />
</div>

</g:else>
<div
	class="fieldcontain ${hasErrors(bean: cuserInstance, field: 'userRole', 'error')} ">
	<label for="userRole"> <g:message code="cuser.userRole.label"
			default="User Role" />

	</label>
	<g:if test="${cuserInstance?.userRole == 'admin' }">
		${cuserInstance.roleName('admin') }
	</g:if>
	<g:else>
	<g:checkBox name="userRole_content" value="${cuserInstance?.userRole?.indexOf('content')>=0 }"/>${cuserInstance.roleName('content') }
	<g:checkBox name="userRole_project" value="${cuserInstance?.userRole?.indexOf('project')>=0 }"/>${cuserInstance.roleName('project') }
	<g:checkBox name="userRole_account" value="${cuserInstance?.userRole?.indexOf('account')>=0 }"/>${cuserInstance.roleName('account') }
	<g:checkBox name="userRole_user" value="${cuserInstance?.userRole?.indexOf('user')>=0 }"/>${cuserInstance.roleName('user') }
	</g:else>
	<%--g:textField name="userRole" value="${cuserInstance?.userRole}" /--%>
</div>

