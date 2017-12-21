<table>
    <thead>
    <tr>
        <g:sortableColumn property="id" title="ID" />
        <g:sortableColumn property="journalDate" title="${message(code: 'cjournal.journalDate.label', default: 'Journal Date')}" />
        <g:sortableColumn property="subject0" title="${message(code: 'cjournal.subject0.label', default: 'subject0')}" />
        <g:sortableColumn property="journalType" title="${message(code: 'cjournal.journalType.label', default: 'Journal Type')}" />
        <g:sortableColumn property="amount" title="${message(code: 'cjournal.amount.label', default: 'Amount')}" />
        <g:sortableColumn property="subject0Balance" title="${message(code: 'cjournal.subject0Balance.label', default: 'subject0')}" />
        <g:sortableColumn property="projecti" title="${message(code: 'cjournal.projecti.label', default: 'projecti')}" />
        <g:sortableColumn property="company" title="${message(code: 'cjournal.company.label', default: 'company')}" />
        <g:sortableColumn property="inputMan" title="${message(code: 'cjournal.inputMan.label', default: 'inputMan')}" />
        <th><g:message code="cjournal.memo.label" default="memo"/></th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${cjournalInstanceList}" status="i" var="cjournalInstance">
        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
            <td><g:link controller="cjournal" action="show" id="${cjournalInstance.id}">${fieldValue(bean: cjournalInstance, field: "id")}</g:link></td>
            <td>${fieldValue(bean: cjournalInstance, field: "journalDate")}</td>
            <td><g:link controller="csubject" action="show" id="${cjournalInstance?.subject0.id}"> ${fieldValue(bean: cjournalInstance, field: "subject0")}</g:link></td>
            <%--td><g:link controller="csubject" action="show" id="${cjournalInstance?.subject1.id}"> ${fieldValue(bean: cjournalInstance, field: "subject1")}</g:link></td--%>
            <td><g:message code="cjournal.journalType.${cjournalInstance?.journalType}" default="unknow" /></td>
            <td>${fieldValue(bean: cjournalInstance, field: "amount")}</td>
            <td>${fieldValue(bean: cjournalInstance, field: "subject0Balance")}</td>
            <td><g:link controller="cproject" action="show" id="${cjournalInstance?.projecti.id}">${fieldValue(bean: cjournalInstance, field: "projecti")}</g:link></td>
            <td><g:link controller="company" action="show" id="${cjournalInstance?.company.id}">${fieldValue(bean: cjournalInstance, field: "company")}</g:link></td>
            <td><g:link controller="cuser" action="show" id="${cjournalInstance?.inputMan.id}">${fieldValue(bean: cjournalInstance, field: "inputMan")}</g:link></td>
            <td>${fieldValue(bean: cjournalInstance, field: "memo")}</td>
        </tr>
    </g:each>
    </tbody>
</table>

