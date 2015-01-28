<html>
    <head>
        <title>Lack of Account Lockout - grails_nV</title>
        <meta name="layout" content="tutorials" />
    </head>
    <body>
		<div class="page-header">
			<h1><span class="text-light-gray">Tutorials / </span>Lack of Account Lockout</h1>
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
								Account Lockout is a commonly implemented feature on websites where user are only allowed to log into any given account a certain number of times, after which they must verify the e-mail address on that account in order to proceed. Account Lockout is an invaluable feature that prevents attackers from brute-forcing passwords on your login form, or performing a denial of service attack on the password hashing function. However, it must be carefully implemented in order to prevent attackers from bypassing its protections.
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
								FindMeAJob implements account lockout, so that's good. But does it give attackers a little too much control over how the lockout is enforced?
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
								FindMeAJob's implemention of account lockout works under normal circumstances, but since it stores the lockout state in the session, all an attacker has to do to bypass the lockout or prevent one from occuring is to clear session cookies.

								<pre class="line-numbers"><code class="language-groovy">if (user) {

    session["last_attempt"] = (long) (System.currentTimeMillis() / 1000L)

    if (session["original_attempt"]) {
        // They've tried before
        session["attempts"] = session["attempts"] + 1

        if (session["attempts"] > 2) {
            /* Tell them they need to reset their account */

            /* Send an email once they hit 3 tries */
            if (session["attempts"] == 3) {
                session["reset_token"] = RandomStringUtils.randomAlphanumeric(30)
                session["reset_id"] = user.id

                sendMail { /* Reset Email */ }
            }

            render(view: "signin")
            return

        }

    } else {
        // First time trying
        session["original_attempt"] = (long) (System.currentTimeMillis() / 1000L)
        session["last_attempt"] = session["original_attempt"];
        session["attempts"] = 1
    }
}</code></pre>
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
								In order to avoid the attacker compromising the state of the account lockout, we simply need to store it on the server. In this case, we've chosen to store the lockout information on the database. This has the additional benefit of working across user devices, so simply switching browsers or clearing cookies won't affect it.
								<pre class="line-numbers"><code class="language-groovy">if (user) {
    user.latest_attempt = (long) (System.currentTimeMillis() / 1000L)

    if (user.original_attempt) {
        // They've tried before
        user.attempts = user.attempts + 1

        if (user.attempts > 2) {
            /* Tell them they need to reset their account */

            if (user.attempts == 3) {
                user.reset_token = RandomStringUtils.randomAlphanumeric(30)

                sendMail { /* Reset Email */ }
            }
            user.save(flush: true)
            render(view: "signin")
            return

        }

    } else {
        // First time trying
        user.original_attempt = (long) (System.currentTimeMillis() / 1000L)
        user.latest_attempt = user.original_attempt
        user.attempts = 1
    }
    user.save(flush: true)
}</code></pre>
							</div> <!-- / .panel-body -->
						</div> <!-- / .collapse -->
					</div> <!-- / .panel -->

			</div> <!-- / .panel-group -->
</body>
</html>