
<%@ page import="cproject.Csubject" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'csubject.label', default: 'Csubject')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-csubject" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

	<g:render template="/menu" /> 
	
		<div id="show-csubject" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list csubject">
			
				<g:if test="${csubjectInstance?.subjectBalance}">
				<li class="fieldcontain">
					<span id="subjectBalance-label" class="property-label"><g:message code="csubject.subjectBalance.label" default="Subject Balance" /></span>
					
						<span class="property-value" aria-labelledby="subjectBalance-label"><g:fieldValue bean="${csubjectInstance}" field="subjectBalance"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${csubjectInstance?.subjectName}">
				<li class="fieldcontain">
					<span id="subjectName-label" class="property-label"><g:message code="csubject.subjectName.label" default="Subject Name" /></span>
					
						<span class="property-value" aria-labelledby="subjectName-label"><g:fieldValue bean="${csubjectInstance}" field="subjectName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${csubjectInstance?.subjectParent}">
				<li class="fieldcontain">
					<span id="subjectParent-label" class="property-label"><g:message code="csubject.subjectParent.label" default="Subject Parent" /></span>
					
						<span class="property-value" aria-labelledby="subjectParent-label"><g:link controller="csubject" action="show" id="${csubjectInstance?.subjectParent?.id}">${csubjectInstance?.subjectParent?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${csubjectInstance?.subjectType}">
				<li class="fieldcontain">
					<span id="subjectType-label" class="property-label"><g:message code="csubject.subjectType.label" default="Subject Type" /></span>
					
						<span class="property-value" aria-labelledby="subjectType-label"><g:message code="csubject.subjectType.${csubjectInstance?.subjectType}" default="unknow"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${csubjectInstance?.id}" />
					<g:link class="edit" action="edit" id="${csubjectInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:link class="show" action="mylist" id="${csubjectInstance?.id}"><g:message code="csubject.seeChilen.label" default="see chilen" /></g:link>
                    <g:link class="create" controller="cjournal" action="create" params="['subject0.id':csubjectInstance?.id,'journalType':1]"><g:message code="cjournal.create.1.label" default="create journal"/></g:link>
                    <g:link class="create" controller="cjournal" action="create" params="['subject0.id':csubjectInstance?.id,'journalType':2]"><g:message code="cjournal.create.2.label" default="create journal"/></g:link>
					<%--g:if test="${csubjectInstance.subjectType==1 }">
					<g:link class="create" controller="cjournal" action="create" params="['subject0.id':csubjectInstance?.id,'journalType':1]"><g:message code="cjournal.create.1.label" default="create journal"/></g:link>
					</g:if>
					<g:elseif test="${csubjectInstance.subjectType==2 }">
					<g:link class="create" controller="cjournal" action="create" params="['subject0.id':csubjectInstance?.id,'journalType':2]"><g:message code="cjournal.create.2.label" default="create journal"/></g:link>
					</g:elseif>
					<g:else>
					<g:link class="create" controller="cjournal" action="create" params="['subject1.id':csubjectInstance?.id,'journalType':1]"><g:message code="cjournal.create.1.label" default="create journal"/></g:link>
					<g:link class="create" controller="cjournal" action="create" params="['subject0.id':csubjectInstance?.id,'journalType':2]"><g:message code="cjournal.create.2.label" default="create journal"/></g:link>
					<g:link class="create" controller="cjournal" action="create" params="['subject0.id':csubjectInstance?.id,'subject1.id':csubjectInstance?.id,'journalType':3]"><g:message code="cjournal.create.3.label" default="create journal"/></g:link>
					</g:else--%>
					<g:link class="list" controller="cjournal" action="oneList" id="${csubjectInstance?.id}"><g:message code="cjournal.onelist.label" default="journal onelist"/></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
    <g:render template="/cjournal/list" />
	</body>
</html>
