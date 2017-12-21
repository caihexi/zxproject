
<%@ page import="cproject.Company" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'company.label', default: 'Company')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-company" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

	<g:render template="/menu" /> 
	
		<div id="list-company" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="companyName" title="${message(code: 'company.companyName.label', default: 'Company Name')}" />
					
						<g:sortableColumn property="companyAddress" title="${message(code: 'company.companyAddress.label', default: 'Company Address')}" />
					
						<g:sortableColumn property="companyTelphone" title="${message(code: 'company.companyTelphone.label', default: 'Company Telphone')}" />
					
						<g:sortableColumn property="memo" title="${message(code: 'company.memo.label', default: 'Memo')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${companyInstanceList}" status="i" var="companyInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${companyInstance.id}">${fieldValue(bean: companyInstance, field: "companyName")}</g:link></td>
					
						<td>${fieldValue(bean: companyInstance, field: "companyAddress")}</td>
					
						<td>${fieldValue(bean: companyInstance, field: "companyTelphone")}</td>
					
						<td>${fieldValue(bean: companyInstance, field: "memo")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${companyInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
