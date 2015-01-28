<html>
    <head>
        <title>Authentication Filtering Blacklist - grails_nV</title>
        <meta name="layout" content="tutorials" />
    </head>
    <body>
		<div class="page-header">
			<h1><span class="text-light-gray">Tutorials / </span>Authentication Filtering Blacklist</h1>
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
								It's important to deny users access to pages they aren't authorized to access, or sensitive data they need to authenticate to view. In order to extend this protection to all application pages, FindMeAJob uses <code>SessionFilters</code>, a Grails filter class created to ensure users cannot access certain pages without being logged in.
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
								Which pages does the <code>shouldBeLoggedIn</code> filter check?
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
								The <code>shouldBeLoggedIn</code> filter uses a blacklist of pages that require auth. However, it appears we've forgotten to update this blacklist as the rest of the site was updated with new features.
								<pre class="line-numbers"><code class="language-groovy">shouldBeLoggedIn(controller: 'profile|main|messages|session', action: '*') {</code>
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
								We should update the filter to operate on a whitelist, not a blacklist. For our purposes, we will require authentication to access any page but the login/registration/password recovery/etc pages. Setting the <code>invert</code> flag on the filter makes it apply to all controllers/actions <i>except</i> the ones we have specified.
								<pre class="line-numbers"><code class="language-groovy">shouldBeLoggedIn(controller: 'user', action: '*', invert: true) {</code>
							</div> <!-- / .panel-body -->
						</div> <!-- / .collapse -->
					</div> <!-- / .panel -->

			</div> <!-- / .panel-group -->
</body>
</html>