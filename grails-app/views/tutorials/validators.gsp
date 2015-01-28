<html>
    <head>
        <title>Validators - grails_nV</title>
        <meta name="layout" content="tutorials" />
    </head>
    <body>
		<div class="page-header">
			<h1><span class="text-light-gray">Tutorials / </span>Validators</h1>
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
								A validator is a piece of code used to verify the format of data to be entered into our model. Validators can be used to ensure a password is of sufficient complexity, an email address is of valid format, or a credit card passes basic fraud checking. Validator code is often used on both the client-side and server-side of an application. On the client, they can improve user experience and interaction by providing error messages immediately, without having to wait for a network request/response and a page refresh. However, user input should again be validated on the server, which should ensure the input really does pass any validation.
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
								What better time to check user information that at login?
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
								The regular expressions validator to check an email address can be seen in the registration and profile update sections of the code.
								<pre class="line-numbers"><code class="language-groovy">def email_valid = (user_email =~ /(.*)@(.*).(.*)/)</code></pre>
								Unfortunately, this regular expression allows users to sign up with duplicate emails. Most mail servers ignore strings in an email address after a '+' character (ex: <code>dave@test.com</code> and <code>dave+evil@test.com</code> are treated the same), but our validator does not check for this. This same validator is also used in the profile updating code.
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
								We should update our validator so that we attempt to avoid duplicate emails in the system. Unfortunately, the full regular expression for an email address <a href="http://ex-parrot.com/~pdw/Mail-RFC822-Address.html">is a bit complicated</a>. For a simpler solution that will cover most users, we should simply remove the portion that is ignored by mail servers before validating our address.
								<pre class="line-numbers"><code class="language-groovy">def user_email_sanitized = user_email.replace(/(\+.*)(?:@)/, "")
def email_valid = (user_email_sanitized =~ /(.*)@(.*).(.*)/)</code></pre>
								This will fix the problem with the validator, but could potentially shut out some legitimate users. While it will work for the majority (likely >95% of users) in a given application, some users may find themselves unable to register due to the removal of a portion of their email.
							</div> <!-- / .panel-body -->
						</div> <!-- / .collapse -->
					</div> <!-- / .panel -->

			</div> <!-- / .panel-group -->
</body>
</html>