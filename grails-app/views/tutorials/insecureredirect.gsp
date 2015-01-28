<html>
    <head>
        <title>Insecure Redirect - grails_nV</title>
        <meta name="layout" content="tutorials" />
    </head>
    <body>
		<div class="page-header">
			<h1><span class="text-light-gray">Tutorials / </span>Insecure Redirect</h1>
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
								An Insecure Redirect is a HTTP redirect that allows an arbitrary URL to be passed. Insecure Redirect vulnerabilities are often not recognized as problem, since they do not directly impact the website they are found in. However, they can be used by attackers to redirect users to malicious hosts, while still appearing to be on a trustworthy domain. Phishing attacks can also make use of insecure redirects to give the appearance of legitimacy.
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
								Where in FindMeAJob do we redirect the user's web browser?
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
								In order to make life easier, the developers of FindMeAJob have included a GET parameter on the signin method that redirects back to the url provided after a successful login.
								<pre class="line-numbers"><code class="language-groovy">if (params.lastpage) {
    redirect(url: params.lastpage)
} else {
    redirect(controller: "main", action: "index")
}
return</code></pre>
								Internally to the site, this is used with relative URLs and unauthenticated users. When a user who has not logged in attempts to access the site, this is used to redirect them back to the page they were browsing once they've logged in. In other words, I can send the user a link to 
								<code>https://<findmeajob.com>/grails_nV/user/signin?redirect_to=http%3A%2F%2Fmalware.evil</code>
								and while they believe they are on a secured domain, they will be redirected to my malicious host after login.

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
								One option is to use a whitelist to ensure that all passed URLs are on the same host as the backend. However, Grails provides an easier and more secure method for us! By passing both a <code>redirect_controller</code> and <code>redirect_action</code>, we can ensure that the only possible redirection paths are back to paths we have defined on our own site.
								<pre class="line-numbers"><code class="language-groovy">if (params.redirect_controller && params.redirect_action) {
    redirect(controller: params.controller, action: params.action)
} else {
    redirect(controller: "main", action: "index")
}
return</code></pre>
							</div> <!-- / .panel-body -->
						</div> <!-- / .collapse -->
					</div> <!-- / .panel -->

			</div> <!-- / .panel-group -->
</body>
</html>