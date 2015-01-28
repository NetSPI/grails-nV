<html>
    <head>
        <title>Session Fixation - grails_nV</title>
        <meta name="layout" content="tutorials" />
    </head>
    <body>
		<div class="page-header">
			<h1><span class="text-light-gray">Tutorials / </span>Session Fixation</h1>
		</div> <!-- / .page-header -->
			<div class="col-sm-12">
				<div class="panel-group panel-group-success" id="vuln-accordion">
					<div class="panel">
						<div class="panel-heading">
							<a class="accordion-toggle" data-toggle="collapse" data-parent="#vuln-accordion" href="#collapseDescription">
								Description
							</a>
						</div> <!-- / .panel-heading -->
						<div id="collapseDescription" class="panel-collapse in">
							<div class="panel-body">
								Session Fixation is a vulnerability in which the user session identifier (often <code>JSESSIONID</code> for Java servers) is not changed often enough, so an attacker who forces it to a certain value is able to login as the target without having to directly compromise their username and password<br/><br/>

								During session fixation, an attacker forces the session ID before login to a certain known string. After login, if the session identifier is not changed, the attacker will have full control of the session which is now attached to the known session identifier.
							</div> <!-- / .panel-body -->
						</div> <!-- / .collapse -->
					</div> <!-- / .panel -->

					<div class="panel">
						<div class="panel-heading">
							<a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#vuln-accordion" href="#collapseHint">
								Hint
							</a>
						</div> <!-- / .panel-heading -->
						<div id="collapseHint" class="panel-collapse collapse">
							<div class="panel-body">
								How does FindMeAJob's login work?
							</div> <!-- / .panel-body -->
						</div> <!-- / .collapse -->
					</div> <!-- / .panel -->

					<div class="panel">
						<div class="panel-heading">
							<a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#vuln-accordion" href="#collapseBug">
								Problem
							</a>
						</div> <!-- / .panel-heading -->
						<div id="collapseBug" class="panel-collapse collapse">
							<div class="panel-body">
								In Grails, session management is handed by the Java server hosting the Grails application. Unfortunately, Tomcat (a common production server and the server used for built-in dev) assigns session identifiers even when not logged in, and does not swap out the session identifiers on authentication by default. By default, FindMeAJob doesn't provide any better protection.
								<pre class="line-numbers"><code class="language-groovy">session["user"] = user</code></pre>
								Simply setting a value to the session is not enough to give the session a new <code>JSESSIONID</code>.
							</div> <!-- / .panel-body -->
						</div> <!-- / .collapse -->
					</div> <!-- / .panel -->

					<div class="panel">
						<div class="panel-heading">
							<a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#vuln-accordion" href="#collapseSolution">
								Solution
							</a>
						</div> <!-- / .panel-heading -->
						<div id="collapseSolution" class="panel-collapse collapse">
							<div class="panel-body">
								In order to completely null the session and its <code>JSESSIONID</code>, we must call <code>session.invalidate()</code>, as is done when the user logs out. However, this clears the session and renders us unable to reset it in the context of the same request.<br/><br/>

								To get around this issue, we will update the <code>SessionFilters</code> filters to check for a special param, and reset the session when it is seen.
								<pre class="line-numbers"><code class="language-groovy">if (flash.userid) {
	session.user = User.get(flash.userid)
}</code></pre>
								Now, we just call <code>session.invalidate()</code> when the user logs in, and then set <code>flash.userid</code>. The SessionFilter detects that we are logged in, and restores our session. This way, we can securely reset the user's <code>JSESSONID</code> and still maintain our session in a single action.
							</div> <!-- / .panel-body -->
						</div> <!-- / .collapse -->
					</div> <!-- / .panel -->

			</div> <!-- / .panel-group -->
</body>
</html>