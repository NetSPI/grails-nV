<html>
    <head>
        <title>SQL Injection - grails_nV</title>
        <meta name="layout" content="tutorials" />
    </head>
    <body>
		<div class="page-header">
			<h1><span class="text-light-gray">Tutorials / </span>SQL Injection</h1>
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
								SQL Injection is a class of vulnerability where queries given to a SQL database are modified by an attacker in order to perform unintended operations or retrieve sensitive information. For example, let's assume we use the following query to check if a user exists and is has an <code>access_level</code> of 1.
								<pre class="line-numbers"><code class="language-javascript">SELECT 1 FROM USER WHERE user_id = " + user_id + " AND access_level = 1</code></pre>
								However, if the user_id is not properly sanitized, the attacker can inject SQL code (where data should be) and bypass an ID check. If the attacker could pass <code>1 OR 1=1</code> as the <code>user_id</code>, they would transform the query into the following:
								<pre class="line-numbers"><code class="language-javascript">SELECT 1 FROM USER WHERE user_id = 1 OR 1=1 AND access_level = 1</code></pre>
								This transforms the query entirely. While it originally checked if the given user had an <code>access_level</code> of 1, it now checks if <i>any</i> user has an <code>access_level</code> of 1. Unfortunately, SQL injections can be far more malicious than simply bypassing a permissions check, which is already bad enough. Consider the following, where the user_id is passed as <code>1; DROP TABLE user; --</code>. Our simply query then becomes:
								<pre class="line-numbers"><code class="language-javascript">SELECT 1 FROM USER WHERE user_id = 1; DROP TABLE user; -- AND access_level = 1</code></pre>
								The attacker has now successfully dropped our entire users table!
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
								Logging in takes a long time, what with hashing the password and all. What would it be like if we tried to speed it up?
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
								One of the benefits of Grails is its ORM (dubbed 'GORM'), which removes the need for raw SQL queries in most instances. However, it also provides the ability to use a raw query using the Hibernate Query Language (HQL). While not exactly SQL, HQL has much of the same syntax and many of the same potential issues with injection.<br><br>

								When we take a look at the login and authentication code, we find the following code to validate the user's account.
								<pre class="line-numbers"><code class="language-groovy">def user = User.find("from User where password = '${user_password_hash}' and email = '${user_email}'")</code></pre>
								This leaves us open to injection, since the parameters are directly inserted into the query without any sort of escaping done on the inputs. In the <code>ProfileController</code>, we find another piece of risky code.
								<pre class="line-numbers"><code class="language-groovy">if (params.id?.isInteger()) {
    // Show the specific user ID
    def userdata = User.find("from User where id = ${'${params.id}'}")

    if (userdata != null) {
        ...
    }
}</code></pre>
								With this, we're again able to insert arbitrary HQL into the query due to the lack of validation
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
								In Grails, the most straightforward way to address this is to avoid using raw HQL/SQL whenever possible. Thanks to the power of the GORM functionality, we almost never need to drop directly into the raw queries. Using GORM features, we can replace the login and authentication code with the following as a drop-in replacement.
								<pre class="line-numbers"><code class="language-groovy">def user = User.findWhere(email: user_email, password: user_password_hash)</code></pre>
								For the profile, we can again simply replace the code with the following to immediately prevent this entire class of attack.
								<pre class="line-numbers"><code class="language-groovy">if (params.id?.isInteger()) {
    // Show the specific user ID
    def userdata = User.get(params.id)

    if (userdata != null) {
        ...
    }
}</code></pre>
								In all cases, developers should opt to use the GORM rather than a raw query. While in other languages without an ORM, prepared statements are recommended, the power and performance of the GORM in this instance makes it preferable in all cases.
							</div> <!-- / .panel-body -->
						</div> <!-- / .collapse -->
					</div> <!-- / .panel -->

			</div> <!-- / .panel-group -->
</body>
</html>