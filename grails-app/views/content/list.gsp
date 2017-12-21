
<%@ page import="cproject.Content" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'content.label', default: 'Content')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-content" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

	<g:render template="/menu" /> 
	
		<div id="list-content" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="personName" title="${message(code: 'content.personName.label', default: 'Person Name')}" />
					
						<th><g:message code="content.company.label" default="Company" /></th>
					
						<g:sortableColumn property="personAddress" title="${message(code: 'content.personAddress.label', default: 'Person Address')}" />
					
						<g:sortableColumn property="personPhone" title="${message(code: 'content.personPhone.label', default: 'Person Phone')}" />
					
						<g:sortableColumn property="personBirthday" title="${message(code: 'content.personBirthday.label', default: 'Person Birthday')}" />
					
						<g:sortableColumn property="personMemo" title="${message(code: 'content.personMemo.label', default: 'Person Memo')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${contentInstanceList}" status="i" var="contentInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${contentInstance.id}">${fieldValue(bean: contentInstance, field: "personName")}</g:link></td>
					
						<td><g:link controller="company" action="show" id="${contentInstance?.company?.id}">${fieldValue(bean: contentInstance, field: "company")}</g:link></td>
					
						<td>${fieldValue(bean: contentInstance, field: "personAddress")}</td>
					
						<td>${fieldValue(bean: contentInstance, field: "personPhone")}</td>
					
						<td><g:formatDate date="${contentInstance.personBirthday}" /></td>
					
						<td>${fieldValue(bean: contentInstance, field: "personMemo")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${contentInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
