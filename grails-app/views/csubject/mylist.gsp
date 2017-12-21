
<%@ page import="cproject.Csubject" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'csubject.label', default: 'Csubject')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<resource:treeView />
	</head>
	<body>
		<a href="#list-csubject" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

	<g:render template="/menu" /> 
	
		<div id="list-csubject" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:set var="myhref" value="${createLinkTo(dir: 'csubject/show')}/" />
			<richui:treeView xml="${data}" onLabelClick="document.location.href = '${myhref}' + id;" />

		</div>
		<div id="operator"></div>
	</body>
</html>
