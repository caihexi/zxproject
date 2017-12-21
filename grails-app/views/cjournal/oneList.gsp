
<%@ page import="cproject.Csubject;cproject.Cjournal;"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<title><g:message code="cjournal.onelist.label" default="journal onelist"/></title>
</head>
<body>
	<a href="#list-cjournal" class="skip" tabindex="-1"><g:message
			code="default.link.skip.label" default="Skip to content&hellip;" /></a>

	<g:render template="/menu" />

		<div id="list-cjournal" class="content scaffold-list" role="main">
			<h1>
				<g:message code="cjournal.onelist.label" default="journal onelist"/>
			</h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">
					${flash.message}
				</div>
			</g:if>
	<g:if test="${params.id}">
	<g:set var = "subjectone" value="${Csubject.get(params.id)}"/>
			<h1>
				${subjectone}
			</h1>
			<%--table>
				<thead>
					<tr>
						<g:sortableColumn property="id" title="ID" />
						<g:sortableColumn property="journalType"
							title="${message(code: 'cjournal.journalType.label', default: 'Journal Type')}" />
						<g:sortableColumn property="journalDate"
							title="${message(code: 'cjournal.journalDate.label', default: 'Journal Date')}" />
						<g:sortableColumn property="amount"
							title="${message(code: 'cjournal.amount.label', default: 'Amount')}" />
						<th><g:message code="cjournal.subject.label"
								default="subject" /></th>
						<th><g:message code="cjournal.subjectBalance.label"
								default="subject" /></th>
						<g:sortableColumn property="projecti"
							title="${message(code: 'cjournal.projecti.label', default: 'projecti')}" />
						<g:sortableColumn property="company"
							title="${message(code: 'cjournal.company.label', default: 'company')}" />
						<g:sortableColumn property="inputMan"
							title="${message(code: 'cjournal.inputMan.label', default: 'inputMan')}" />
					</tr>
				</thead>
				<tbody>
					<g:each in="${cjournalInstanceList}" status="i"
						var="cjournalInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
							<td><g:link action="show" id="${cjournalInstance.id}">
									${fieldValue(bean: cjournalInstance, field: "id")}
								</g:link></td>
							<td><g:message
									code="cjournal.journalType.${cjournalInstance?.journalType}"
									default="unknow" /></td>
							<td>
								${fieldValue(bean: cjournalInstance, field: "journalDate")}
							</td>
							<td>
								${fieldValue(bean: cjournalInstance, field: "amount")}
							</td>
							<g:if test="${cjournalInstance?.subject1 == subjectone}">
								<td>
									<g:link controller="cjournal" action="show" id="${cjournalInstance?.subject0?.id }" >${fieldValue(bean: cjournalInstance, field: "subject0")}</g:link>
								</td>
								<td>
									${fieldValue(bean: cjournalInstance, field: "subject1Balance")}
								</td>
							</g:if>
							<g:else>
								<td>
									<g:link controller="cjournal" action="show" id="${cjournalInstance?.subject0?.id }" >${fieldValue(bean: cjournalInstance, field: "subject0")}</g:link>
								</td>
								<td>
									${fieldValue(bean: cjournalInstance, field: "subject0Balance")}
								</td>
							</g:else>
							<td>
								${fieldValue(bean: cjournalInstance, field: "projecti")}
							</td>
							<td>
								${fieldValue(bean: cjournalInstance, field: "company")}
							</td>
							<td>
								${fieldValue(bean: cjournalInstance, field: "inputMan")}
							</td>
						</tr>
					</g:each>
				</tbody>
			</table--%>
        <g:render template="/cjournal/list" />
			<div class="pagination">
				<g:paginate total="${cjournalInstanceTotal}" params="${params }" />
			</div>
	</g:if>
		    <div class="buttons">
      <g:form action="oneList" method="post">
      <g:message code="cjournal.subjectName.label" default="journalDate" />:
      <g:select optionKey="id" from="${cproject.Csubject.list()}" name="id" value="${params.id}" noSelection="['null':'全部（导出有效）']"/>
      <g:message code="cjournal.journalDate.label" default="journalDate" />:
      <g:datePicker name="myfromday" value="${params.myfromday}" precision="day"/>-
      <g:datePicker name="mytoday" value="${params.mytoday}" precision="day"/>
      <g:message code="cjournal.projecti.label" default="projecti" />:
      <g:select optionKey="id" from="${cproject.Cproject.list()}" name="projectid" value="${params.projectid}" noSelection="['null':'']"/>
       <g:message code="cjournal.inputMan.label" default="inputMan" />:
      <g:select optionKey="id" from="${cproject.Cuser.list()}" name="inputManid" value="${params.inputManid}" noSelection="['null':'']"/>
      <g:message code="cjournal.company.label" default="company" />:
      <g:select optionKey="id" from="${cproject.Company.list()}" name="companyid" value="${params.companyid}" noSelection="['null':'']"/>
	  <g:submitButton name="oneList" value="${message(code: 'default.button.filter.label', default: 'filter')}" class="filter"/>
	  <g:actionSubmit action="oneListDownload" name="oneListDownload" value="${message(code: 'default.button.download.label', default: 'download')}" class="filter"/>
		</g:form>
		</div>
		</div>
</body>
</html>
