<html>
    <head>
        <title>Information Disclosure - grails_nV</title>
        <meta name="layout" content="tutorials" />
    </head>
    <body>
		<div class="page-header">
			<h1><span class="text-light-gray">Tutorials / </span>Information Disclosure</h1>
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
								Information Disclosure is a general class of vulnerability where the application accidentally exposes information or data to unauthenticated or insufficiently authenticated users that it was not meant to show. This information could be anything from username and password information, to sensitive user data such as credit card or social security numbers.
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
								FindMeAJob is pretty good at securing user information, right? I mean, we only show sensitive things on the user profile page. You also need to be logged in to see anything super secret like your Social Security number.
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
								Information Disclosure can often be difficult to fully protect against, because of the number of different attack vectors to defend against. In this case, the server does not set correct caching headers on the profile page. On the messaging page, we use the following headers
								<pre class="line-numbers"><code class="language-groovy">// Let's set some headers so the messages don't get insecurely cached!!
header 'Cache-Control', 'no-cache, no-store, must-revalidate'
header 'Pragma', 'no-cache'
header 'Expires', '0'</code></pre>
								However, we leave this out on the user profile page. Since we show sensitive user information, such as the user's SSN on their personal profile page, an attacker could pull the page from a client browser cache and view the page later.
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
								To defend against this caching attack, we need set proper caching headers on any page that contains sensitive user information. In this case, simply setting the below headers on the user profile page will prevent this attack
								<pre class="line-numbers"><code class="language-http">Cache-Control: "no-cache, no-store, must-revalidate"
Pragma: "no-cache"
Expires: 0</code></pre>
								It is important to keep in mind that this is only one type of information disclosure. When dealing with such a broad class of vulnerability, you must be aware of other methods by which data could be leaked. User access controls must always be tighly integrated to defend against such attacks.
							</div> <!-- / .panel-body -->
						</div> <!-- / .collapse -->
					</div> <!-- / .panel -->

			</div> <!-- / .panel-group -->
</body>
</html>