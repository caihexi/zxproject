
<%@ page import="cproject.Csubject" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'csubject.label', default: 'Csubject')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-csubject" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

	<g:render template="/menu" /> 
	
		<div id="list-csubject" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="subjectName" title="${message(code: 'csubject.subjectName.label', default: 'Subject Name')}" />
					
						<th><g:message code="csubject.subjectParent.label" default="Subject Parent" /></th>
					
						<g:sortableColumn property="subjectType" title="${message(code: 'csubject.subjectType.label', default: 'Subject Type')}" />
					
						<g:sortableColumn property="subjectBalance" title="${message(code: 'csubject.subjectBalance.label', default: 'Subject Balance')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${csubjectInstanceList}" status="i" var="csubjectInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${csubjectInstance.id}">${fieldValue(bean: csubjectInstance, field: "subjectName")}</g:link></td>
					
						<td>${fieldValue(bean: csubjectInstance, field: "subjectParent")}</td>
					
						<td><g:message code="csubject.subjectType.${ csubjectInstance.subjectType}" default="unknow"/></td>
					
						<td>${fieldValue(bean: csubjectInstance, field: "subjectBalance")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${csubjectInstanceTotal}" />
			</div>

		</div>
	</body>
</html>
