<!DOCTYPE html>
<html>
<head>
<title><g:message code="default.error.message" default="Error" /></title>
<meta name="layout" content="main">
<g:if env="development">
	<link rel="stylesheet"
		href="${resource(dir: 'css', file: 'errors.css')}" type="text/css">
</g:if>
</head>
<body>
	<g:if env="development">
		<g:renderException exception="${exception}" />
	</g:if>
	<g:else>
		<ul class="errors">
			<li><g:message code="default.error.message" default="Error" />:${flash.message }</li>
		</ul>
	</g:else>
</body>
</html>
