<html>
    <head>
        <title>Insecure Direct Object Access - grails_nV</title>
        <meta name="layout" content="tutorials" />
    </head>
    <body>
		<div class="page-header">
			<h1><span class="text-light-gray">Tutorials / </span>Insecure Direct Object Access</h1>
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
								Insecure Direct Object Access is a class of vulnerability where attackers are able to access pages they are not meant to have access to simply by changing parameter values. This attack results from a combination of insufficient access controls, and overly excessive client trust (excess/unneccesary request parameters).
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
								Some pages do have IDs in their URL, but since we have the user object in the session, we always pull from that, right?
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
								There is an instance of Insecure DOA on the user "my profile" page. While the user object is stored in the session, <code>params.id</code> from the URL is used instead.
								<pre class="line-numbers"><code class="language-groovy">if (params.id) {
	if (params.id?.isInteger()) {
    	// Show the specific user ID
    	def userdata = User.find("from User where id = ${'${params.id}'}")
    	...
	...</code></pre>
							If this is done unintentionally, it could lead to information disclosure of sensitive user information.
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
								To prevent this, never trust any information provided from the client. We should look up the user from the session, which has been stored only on the server and is more trustworthy.
								<pre class="line-numbers"><code class="language-groovy">def userdata = session.user
...
...</code></pre>
								Insecure Direct Object Access is also a common class of vulnerability with metaprogramming, especially in frameworks like Grails. Such frameworks often provide generation of controller methods to access database models (ex: HTTP verbs tied to models for REST APIs). Calling an improperly secured REST method is another form of Insecure DOA, and one which can be much harder to detect.
							</div> <!-- / .panel-body -->
						</div> <!-- / .collapse -->
					</div> <!-- / .panel -->

			</div> <!-- / .panel-group -->
</body>
</html>