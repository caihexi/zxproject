
<%@ page import="cproject.Cjournal" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cjournal.label', default: 'Cjournal')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-cjournal" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

	<g:render template="/menu" /> 
	
		<div id="show-cjournal" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list cjournal">

                <g:if test="${cjournalInstance?.journalDate}">
                    <li class="fieldcontain">
                        <span id="journalDate-label" class="property-label"><g:message code="cjournal.journalDate.label" default="Journal Datee" /></span>

                        <span class="property-value" aria-labelledby="journalDate-label"><g:fieldValue bean="${cjournalInstance}" field="journalDate"/></span>

                    </li>
                </g:if>

                <g:if test="${cjournalInstance?.subject0}">
                    <li class="fieldcontain">
                        <span id="subject0-label" class="property-label"><g:message code="cjournal.subject0.label" default="Subject0" /></span>

                        <span class="property-value" aria-labelledby="subject0-label">
                            <g:link title="${cjournalInstance?.subject0?.encodeAsHTML()}" controller="csubject" action="show" id="${cjournalInstance?.subject0?.id}">${cjournalInstance?.subject0?.encodeAsHTML()}</g:link></span>

                    </li>
                </g:if>

            <%--g:if test="${cjournalInstance?.subject1}">
            <li class="fieldcontain">
                <span id="subject1-label" class="property-label"><g:message code="cjournal.subject1.label" default="Subject1" /></span>

                    <span class="property-value" aria-labelledby="subject1-label">
                    <g:link title="${cjournalInstance?.subject1Balance?.encodeAsHTML()}" controller="csubject" action="show" id="${cjournalInstance?.subject1?.id}">${cjournalInstance?.subject1?.encodeAsHTML()}</g:link>
                    </span>
            </li>
            </g:if--%>

				<g:if test="${cjournalInstance?.journalType}">
				<li class="fieldcontain">
					<span id="journalType-label" class="property-label"><g:message code="cjournal.journalType.label" default="Journal Type" /></span>
					
						<span class="property-value" aria-labelledby="journalType-label"><g:message code="cjournal.journalType.${cjournalInstance.journalType}" default="unknow" /></span>
					
				</li>
				</g:if>

                <g:if test="${cjournalInstance?.amount}">
                    <li class="fieldcontain">
                        <span id="amount-label" class="property-label"><g:message code="cjournal.amount.label" default="Amount" /></span>

                        <span class="property-value" aria-labelledby="amount-label"><g:fieldValue bean="${cjournalInstance}" field="amount"/></span>

                    </li>
                </g:if>

                <g:if test="${cjournalInstance?.subject0Balance}">
                    <li class="fieldcontain">
                        <span id="subject0Balance-label" class="property-label"><g:message code="cjournal.subject0Balance.label" default="subject0Balance" /></span>

                        <span class="property-value" aria-labelledby="subject0Balance-label">
                            <g:fieldValue bean="${cjournalInstance}" field="subject0Balance"/></span>

                    </li>
                </g:if>


                <g:if test="${cjournalInstance?.projecti}">
				<li class="fieldcontain">
					<span id="projecti-label" class="property-label"><g:message code="cjournal.projecti.label" default="Projecti" /></span>
					
						<span class="property-value" aria-labelledby="projecti-label"><g:link controller="cproject" action="show" id="${cjournalInstance?.projecti?.id}">${cjournalInstance?.projecti?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>

				<g:if test="${cjournalInstance?.company}">
				<li class="fieldcontain">
					<span id="company-label" class="property-label"><g:message code="cjournal.company.label" default="Company" /></span>
					
						<span class="property-value" aria-labelledby="company-label"><g:link controller="company" action="show" id="${cjournalInstance?.company?.id}">${cjournalInstance?.company?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>


                <g:if test="${cjournalInstance?.inputMan}">
                    <li class="fieldcontain">
                        <span id="inputMan-label" class="property-label"><g:message code="cjournal.inputMan.label" default="Input Man" /></span>

                        <span class="property-value" aria-labelledby="inputMan-label"><g:link controller="cuser" action="show" id="${cjournalInstance?.inputMan?.id}">${cjournalInstance?.inputMan?.encodeAsHTML()}</g:link></span>

                    </li>
                </g:if>

				<g:if test="${cjournalInstance?.memo}">
				<li class="fieldcontain">
					<span id="memo-label" class="property-label"><g:message code="cjournal.memo.label" default="Memo" /></span>
					
						<span class="property-value" aria-labelledby="memo-label"><g:fieldValue bean="${cjournalInstance}" field="memo"/></span>
					
				</li>
				</g:if>
			
			</ol>
				<fieldset class="buttons">
                    <g:form>
                        <g:hiddenField name="id" value="${cjournalInstance?.id}" />
                        <g:link class="edit" action="edit" id="${cjournalInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                        <g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                        <g:actionSubmit class="edit" action="create" value="再记一笔" />
                    </g:form>
                </fieldset>
		</div>
	</body>
</html>
