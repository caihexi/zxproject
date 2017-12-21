<%@ page import="cproject.Cjournal" %>
	<g:select id="s1" name="s1" from="${cproject.Csubject.findAllBySubjectType(1)}" optionKey="id" style="display:none" />
	<g:select id="s2" name="s2" from="${cproject.Csubject.findAllBySubjectType(2)}" optionKey="id" style="display:none" />
	<g:select id="s3" name="s3" from="${cproject.Csubject.findAllBySubjectType(3)}" optionKey="id" style="display:none" />
<script type="text/javascript">

	$(function(){
		  $.fn.replaceOptions = function(options,selectid) {
			    var self, $option;

			    this.empty();
			    self = this;

			    options.each(function() {
				    if (selectid == $(this).val()){
						$option = $("<option></option>").attr("selected","selected").attr("value", $(this).val()).text($(this).text());
					}
				    else{
						$option = $("<option></option>").attr("value", $(this).val()).text($(this).text());
					}
			      self.append($option);
			    });
			  };
		
		$('#journalType').change(function(){
			switch(this.value){
			case '1': 
				$('#subject0').replaceOptions($('#s3 option'),${cjournalInstance?.subject0?.id ? cjournalInstance.subject0.id : 0});
				$('#subject1').replaceOptions($('#s1 option'),${cjournalInstance?.subject1?.id ? cjournalInstance.subject1.id : 0});
				break;
			case '2': 
				$('#subject0').replaceOptions($('#s2 option'),${cjournalInstance?.subject0?.id ? cjournalInstance.subject0.id : 0});
				$('#subject1').replaceOptions($('#s3 option'),${cjournalInstance?.subject1?.id ? cjournalInstance.subject1.id : 0});
				break;
			default: 
				$('#subject0').replaceOptions($('#s3 option'),${cjournalInstance?.subject0?.id ? cjournalInstance.subject0.id : 0});
				$('#subject1').replaceOptions($('#s3 option'),${cjournalInstance?.subject1?.id ? cjournalInstance.subject1.id : 0});
				break;
			}
		});
	});

	$(document).ready(function(){
		$('#journalType').trigger("change")
	})
</script>


<div class="fieldcontain ${hasErrors(bean: cjournalInstance, field: 'journalDate', 'error')} required">
	<label for="journalDate">
		<g:message code="cjournal.journalDate.label" default="Journal Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker id="journalDate" name="journalDate" required="" value="${cjournalInstance?.journalDate}" precision="hour"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cjournalInstance, field: 'subject0', 'error')} required">
	<label for="subject0">
		<g:message code="cjournal.subject0.label" default="Subject0" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="subject" name="subject0.id" from="" optionKey="id" required="" value="${cjournalInstance?.subject0?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cjournalInstance, field: 'journalType', 'error')} required">
    <label for="journalType">
        <g:message code="cjournal.journalType.label" default="Journal Type" />
        <span class="required-indicator">*</span>
    </label>
    <g:select id="journalType" name="journalType" from="${cjournalInstance.constraints.journalType.inList}" required="" value="${cjournalInstance?.journalType}" valueMessagePrefix="cjournal.journalType"/>
</div>


<div class="fieldcontain ${hasErrors(bean: cjournalInstance, field: 'subject1', 'error')} required">
	<label for="subject1">
		<g:message code="cjournal.subject1.label" default="Subject1" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="subject1" name="subject1.id" from="" optionKey="id" required="" value="${cjournalInstance?.subject1?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cjournalInstance, field: 'projecti', 'error')} required">
	<label for="projecti">
		<g:message code="cjournal.projecti.label" default="Projecti" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="projecti" name="projecti.id" from="${cproject.Cproject.list([sort:'projectName'])}" optionKey="id" required="" value="${cjournalInstance?.projecti?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cjournalInstance, field: 'amount', 'error')} required">
	<label for="amount">
		<g:message code="cjournal.amount.label" default="Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="amount" value="${fieldValue(bean: cjournalInstance, field: 'amount')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: cjournalInstance, field: 'inputMan', 'error')} required">
	<label for="inputMan">
		<g:message code="cjournal.inputMan.label" default="Input Man" />
		<span class="required-indicator">*</span>
	</label>
	<g:hiddenField name="inputMan.id" value="${cjournalInstance?.inputMan?.id}"/>
	${cjournalInstance?.inputMan?.toString()}
</div>

<div class="fieldcontain ${hasErrors(bean: cjournalInstance, field: 'company', 'error')} required">
	<label for="company">
		<g:message code="cjournal.company.label" default="Company" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="company" name="company.id" from="${cproject.Company.list([sort:'companyName'])}" optionKey="id" required="" value="${cjournalInstance?.company?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cjournalInstance, field: 'memo', 'error')} ">
	<label for="memo">
		<g:message code="cjournal.memo.label" default="Memo" />
	</label>
	<g:textField name="memo" value="${cjournalInstance?.memo}"/>
</div>

