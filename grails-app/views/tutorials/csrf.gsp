<html>
    <head>
        <title>CSRF - grails_nV</title>
        <meta name="layout" content="tutorials" />
    </head>
    <body>
		<div class="page-header">
			<h1><span class="text-light-gray">Tutorials / </span>Cross-site Request Forgery (CSRF)</h1>
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
								A Cross-site Request Forgery (CSRF) attack is one in which the user's browser is hijacking in order to submit a request to another website they are authenticated on. For example, if a form/request on a bank website to add money to their bank account is not protected by CSRF, an attacker could create an unrelated page, and submit a request to that endpoint when the user loads the attacker's page. Since the user's browser has a valid session cookie, the request would occur without the user even being aware anything had happened!
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
								How do we protect from CSRF attacks, especially in a comprehensive framework like Grails?
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
								Grails provides a special <code>&lt;g:form&gt;</code> tag to generate HTML forms. One of the options on this tag is to include a special CSRF form token. Each time the page is generated, a unique token will be inserted as a hidden tag on the form.
								<pre class="line-numbers"><code class="language-javascript">&lt;g:form action="signin" name="signin-form_id" method="post" useToken="True"&gt;
&lt;input type="hidden" name="SYNCHRONIZER_TOKEN" value="40c90bc8-bf62-4cd5-b98c-0241b17f5e48" id="SYNCHRONIZER_TOKEN" /&gt;
&lt;input type="hidden" name="SYNCHRONIZER_URI" value="/grails_nV/user/signin" id="SYNCHRONIZER_URI" /&gt;
...
&lt;/g:form&gt;</code></pre>
								In order to process this on the server, we simply have to wrap our action with a <code>withForm</code> statement. If this token is not correct when the request is submitted to the server endpoint, the request will be automatically rejected
								<pre class="line-numbers"><code class="language-groovy">def signin() {
	if (request.post) {
		withForm {
			...
		}
	} else {
		...
	}
}</code></pre>
							However, Grails does not automatically insert the CSRF token into every <code>&lt;form&gt;</code> in your code. Instead, you must make sure to use <code>&lt;g:form&gt;</code> everywhere you would use a normal HTML form. Unfortunately, FindMeAJob only uses this tag on its login and registration pages, leaving other forms vulnerable to CSRF. Since users who access the other forms will also be authenticated, this present security flaws.
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
								To address this problem, we simply need to update all the HTML forms in the views to use the <code>&lt;g:form&gt;</code> tag, instead of wrap HTML forms. CSRF can often be difficult to address, but thankfully Grails makes it simple.<br><br>

								It is also important to secure any API endpoints. While APIs are not directly vulnerable to CSRF (because they do not rely on user cookies or unwitting direct browser access), they should be secured using other methods to prevent attackers maliciously accessing them with user permissions.
							</div> <!-- / .panel-body -->
						</div> <!-- / .collapse -->
					</div> <!-- / .panel -->

			</div> <!-- / .panel-group -->
</body>
</html>