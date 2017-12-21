
<%@ page import="cproject.Cuser"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'cuser.label', default: 'Cuser')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
	<a href="#list-cuser" class="skip" tabindex="-1"><g:message
			code="default.link.skip.label" default="Skip to content&hellip;" /></a>

	<g:render template="/menu" /> 
	
	<div id="list-cuser" class="content scaffold-list" role="main">
		<h1>
			<g:message code="default.list.label" args="[entityName]" />
		</h1>
		<g:if test="${flash.message}">
			<div class="message" role="status">
				${flash.message}
			</div>
		</g:if>
		<table>
			<thead>
				<tr>

					<g:sortableColumn property="userName"
						title="${message(code: 'cuser.userName.label', default: 'User Name')}" />

					<g:sortableColumn property="login"
						title="${message(code: 'cuser.login.label', default: 'Login')}" />

					<g:sortableColumn property="userRole"
						title="${message(code: 'cuser.userRole.label', default: 'User Role')}" />

					<g:sortableColumn property="state"
						title="${message(code: 'cuser.state.label', default: 'User Role')}" />
				</tr>
			</thead>
			<tbody>
				<g:each in="${cuserInstanceList}" status="i" var="cuserInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

						<td><g:link action="show" id="${cuserInstance.id}">
								${fieldValue(bean: cuserInstance, field: "userName")}
							</g:link></td>

						<td>
							${fieldValue(bean: cuserInstance, field: "login")}
						</td>

						<td>
							${fieldValue(bean: cuserInstance, field: "userRole")}
						</td>
						
						<td>
							<g:message code="cuser.state.${cuserInstance.status}.label" default=""/>
						</td>

					</tr>
				</g:each>
			</tbody>
		</table>
		<div class="pagination">
			<g:paginate total="${cuserInstanceTotal}" />
		</div>
	</div>
</body>
</html>
