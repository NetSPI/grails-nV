<html>
    <head>
        <title>Logic Flaws - grails_nV</title>
        <meta name="layout" content="tutorials" />
    </head>
    <body>
		<div class="page-header">
			<h1><span class="text-light-gray">Tutorials / </span>Logic Flaws</h1>
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
								A logic flaw is simply a mistake made by the developer that allows users to bypass the normal flow of actions within the app. Usually, a logic flaw is a result of not considering all possible scenarios for a given series of actions. For example, if <code>A -> B</code> and <code>B -> C</code>, then <code>A -> B -> C</code>. However, if a logic flaw could be exploited to directly go from <code>A -> C</code>, without the intermediate <code>B</code> step, authentication or security could be bypassed.<br/r><br/>
								
								Logic flaws can potentially be more dangerous than other flaws, because they are often more difficult to detect. They cannot be picked up by static analysis tools, and can require thinking from a different mindset than the one used when developing the application to identify.
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
								What's the process FindMeAJob uses for determining which users should be admins and which shouldn't be?
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
								In UserController, we find this particular snippet of code to determine if a new user should be made an admin.
								<pre class="line-numbers"><code class="language-groovy">// If they're one of our employees, automatically make them admin
def set_admin = false
if (user_email.contains("findmeajob.com")) {
    set_admin = true
}</code></pre>
								Any user who has the string <code>findmeajob.com</code> in their email address is automatically promoted to admin access when they sign up. Coupled with a poor email regular expression(<code>/(.*)@(.*).(.*)/</code>), an attacker could sign up with the email <code>drdoom+findmeajob.com@evil.edu</code> and be granted admin access. Since all popular SMTP servers ignore any string after the '+' character and before the '@' in an e-mail, the attacker would even be able to use their regular email address with no problems!
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
								The code as presented above has the logical flaw of assuming any user with a certain characteristic is an employee of FindMeAJob. If someone bypasses the middle step, they are able to go directly from signing up to being given admin level privileges on the website.<br/><br/>

								The most secure way to solve the problem in this instance is to either manually assign users administrator privileges, or use a more secure way of authenticating them, such as requiring an employee pin or an email. However, we can also update the check to include the '@' symbol, which cannot be included as part of an extra string in the email.
								<pre class="line-numbers"><code class="language-groovy">// If they're one of our employees, automatically make them admin
def set_admin = false
if (user_email.contains("@findmeajob.com")) {
    set_admin = true
}</code></pre>
							</div> <!-- / .panel-body -->
						</div> <!-- / .collapse -->
					</div> <!-- / .panel -->

			</div> <!-- / .panel-group -->
</body>
</html>