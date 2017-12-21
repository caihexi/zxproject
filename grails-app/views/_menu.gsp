<link rel="stylesheet" type="text/css"
	href="${resource(dir: 'css', file: 'superfish.css')}" />

<script type=”text/javascript”
	src=”http://jqueryjs.googlecode.com/files/jquery-1.3.2.min.js“></script>
<script type=”text/javascript” src=”${resource(dir:'js' , file: 'hoverIntent.js')}”></script>
<script type=”text/javascript” src=”${resource(dir:'js', file: 'superfish.js')}”></script>
<script type=”text/javascript” src=”${resource(dir:'js', file: 'supersubs.js')}”></script>
<script type=”text/javascript” src=”${resource(dir:'js', file: 'jquery.bgiframe.min.js')}”></script>

<script type=”text/javascript”>
 
    $(document).ready(function() {
        $(‘ul.sf-menu’).superfish({
            delay:       1000,                            // one second delay on mouseout
            animation:   {opacity:’show’,height:’show’},  // fade-in and slide-down animation
            speed:       ‘fast’,                          // faster animation speed
            autoArrows:  false,                           // disable generation of arrow mark-up
            dropShadows: false                            // disable drop shadows
        }).find('ul').bgIframe({opacity:false});
    });

</script>

<div class="mynav">
	<ul class="sf-menu">
		<li><g:link controller="cuser" action="index">
				<g:message code="default.home.label" default="home" />
			</g:link></li>
		<li><a href="#"><g:message code="cjournal.label" default="cjournal" /></a>
			<ul>
                <li><g:link controller="cjournal" action="create">
                    记账
                </g:link></li>
				<li><g:link controller="cjournal" action="list">
						<g:message code="default.list.label"
							args="[message(code:'cjournal.label')]" />
					</g:link></li>
				<li><g:link controller="cjournal" action="oneList">
						<g:message code="cjournal.onelist.label"/>
					</g:link></li>
			</ul></li>
		<li><a href="#"><g:message code="csubject.label" default="csubject" /></a>
			<ul>
				<li><g:link controller="csubject" action="list">
						<g:message code="default.list.label"
							args="[message(code:'csubject.label')]" />
					</g:link></li>
				<li><g:link controller="csubject" action="mylist">
						<g:message code="csubject.mylist.label"/>
					</g:link></li>
				<li><g:link controller="csubject" action="create">
						<g:message code="default.create.label"
							args="[message(code:'csubject.label')]" />
					</g:link></li>
			</ul></li>
		<li><a href="#"><g:message code="cproject.label" default="cproject" /></a>
			<ul>
				<li><g:link controller="cproject" action="list">
						<g:message code="default.list.label"
							args="[message(code:'cproject.label')]" />
					</g:link></li>
				<li><g:link controller="cproject" action="create">
						<g:message code="default.create.label"
							args="[message(code:'cproject.label')]" />
					</g:link></li>
			</ul></li>
		<li><a href="#"><g:message code="company.label" default="company" />
		<g:message code="default.and.label" default="&" />
		<g:message code="content.label" default="content" /></a>
			<ul>
				<li><g:link controller="company" action="list">
						<g:message code="default.list.label"
							args="[message(code:'company.label')]" />
					</g:link></li>
				<li><g:link controller="company" action="create">
						<g:message code="default.create.label"
							args="[message(code:'company.label')]" />
					</g:link></li>
				<li><g:link controller="content" action="list">
						<g:message code="default.list.label"
							args="[message(code:'content.label')]" />
					</g:link></li>
				<li><g:link controller="content" action="create">
						<g:message code="default.create.label"
							args="[message(code:'content.label')]" />
					</g:link></li>
			</ul></li>
		<li><a href="#"><g:message code="cuser.label" default="user" /></a>
			<ul>
				<li><g:link controller="cuser" action="list">
						<g:message code="default.list.label"
							args="[message(code:'cuser.label')]" />
					</g:link></li>
				<li><g:link controller="cuser" action="create">
						<g:message code="default.create.label"
							args="[message(code:'cuser.label')]" />
					</g:link></li>
				<li><g:link controller="cuser" action="changePassword">
						<g:message code="button.changePassword.label" default="change Password" />
					</g:link></li>
				<li><g:link controller="cuser" action="logout">
						<g:message code="default.logout.label" default="logout" />
					</g:link></li>
			</ul></li>
	</ul>
</div>
<br />
<br />
<br />
