<html>
    <head>
        <title>Username Enumeration - grails_nV</title>
        <meta name="layout" content="tutorials" />
    </head>
    <body>
		<div class="page-header">
			<h1><span class="text-light-gray">Tutorials / </span>Username Enumeration</h1>
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
								Username Enumeration is a type of information disclosure vulnerability, in which the application unintentionally reveals information about which usernames are already registered in its system. Once the attacker obtains a list of usernames that exist, they will have a more information with which to search for passwords and attack the application.

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
								What kinds of responses could the system return for an authenticated user?
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
								Username Enumeration is present in FindMeAJob on the login and registration pages. Initially, if the user attempts to login with either an invalid email or password (or both), it simply states "Invalid login or unverified account". However, after the third attempt, if their username is a valid one but their password is incorrect, it will inform the user that their account has been locked and requires unlocking ("Your account has been locked. Please reset your password from your email"). This message can be utilized in order to determine if an account exists simply by pinging the form 3 times for each username.<br><br>

								A less challenging username enumeration is also present on the registration page. After each registration attempt, the page informs the user if their email is already in use, indicating which ones are already present in the system.
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
								Username Enumeration can sometimes be a challenging bug to address, simply because it can involve a trade-off with user experience in the application. In the above instances, the messages could simply be changed to a generic "Invalid login or locked account", or "Could not register account". However, this will also make the actions of the site less clear. Ultimately, it is difficult to prevent username enumeration without hurting parts of the user flow and experience, so some applications simply opt for security in other forms instead.
							</div> <!-- / .panel-body -->
						</div> <!-- / .collapse -->
					</div> <!-- / .panel -->

			</div> <!-- / .panel-group -->
</body>
</html>