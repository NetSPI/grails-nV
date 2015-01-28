<html>
    <head>
        <title>Weak Password Complexity - grails_nV</title>
        <meta name="layout" content="tutorials" />
    </head>
    <body>
		<div class="page-header">
			<h1><span class="text-light-gray">Tutorials / </span>Weak Password Complexity</h1>
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
								Enforcing Password Complexity is an important part of any registration flow. Weak password are significantly less secure and easier to crack than strong ones, so it's always important to ensure that a user password meets a minimum level of security.
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
								Where does password complexity come into play?
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
								FindMeAJob does not properly check the complexity of a user password when it is entered. In fact, it appears to only check the length of the password against a given minimum and maximum
                    			<pre class="line-numbers"><code class="language-groovy">if (user_password.length() < 6) {
    flash.error = "Your password is too short"
    render(view: "signup")
    return
}
if (user_password.length() > 40) {
    flash.error = "Your password is too long"
    render(view: "signup")
    return
}</code></pre>
							These complexity requirements are not sufficient to ensure a good user password. Furthermore, password length should not be limited.
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
								In order to ensure the password is of sufficient complexity, we should use a more advanced regular expression to ensure the password matches. In addition, we should not arbitrarily limit user password length. Since passwords are stored using a constnat length has algorithm, the length of the user's chosen password will not be a problem in the general case. It may still be important to check for DoS attacks against a CPU intensive hashing algorithm (such as bcrypt) but most users will not enter a password anywhere near as long.
								<pre class="line-numbers"><code class="language-groovy">def passwordmatcher = user_password =~ /\A.*(?=.{10,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[\@\#\$\%\^\&\+\=]).*\z/

if (user_password.length() &lt; 6) {
    flash.error = "Your password is too short"
    render(view: "signup")
    return
}

if (user_password.length() &gt; d10000) {
    flash.error = "Your password is too long"
    render(view: "signup")
    return
}

if (!passwordmatcher.matches()) {
    flash.error = "Your password is not sufficiently complex"
    render(view: "signup")
    return
}</code></pre>
								
							</div> <!-- / .panel-body -->
						</div> <!-- / .collapse -->
					</div> <!-- / .panel -->

			</div> <!-- / .panel-group -->
</body>
</html>