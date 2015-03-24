<html>
    <head>
        <title>Lack of Session Timeout - grails_nV</title>
        <meta name="layout" content="tutorials" />
    </head>
    <body>
		<div class="page-header">
			<h1><span class="text-light-gray">Tutorials / </span>Lack of Session Timeout</h1>
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
								Session Timeout refers to the maximum lifetime a session has when it is not being used. After the session timeout has expired, the browser will destroy the cookie and the server will remove the session from its memory. These timeouts are useful tools in order to prevent attackers from capturing session identifiers to have unlimited permanent access to the target account.
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
								What handles sessions for us in Grails?
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
								The Grails development server (<code>grails run-app</code>) internally runs on Tomcat, which reads (among other places) the <code>src/templates/war/web.xml</code> file for information on cookie lifetime.
								<pre class="line-numbers"><code class="language-javascript">&lt;session-config&gt;
    &lt;!-- This is annoying --&gt;
    &lt;session-timeout&gt;0&lt;/session-timeout&gt;
&lt;/session-config&gt;</code></pre>
							The session lifespan has been set to 0, indicating it will never expire.
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
								To address this, we set the session timeout to a non-zero value. However, it's important to be careful to set it to a value high enough not to disturbt potential users who are attempting to use the site. In this case, we'll use 30 minutes.
								<pre class="line-numbers"><code class="language-javascript">&lt;session-config&gt;
    &lt;session-timeout&gt;30&lt;/session-timeout&gt;
&lt;/session-config&gt;</code></pre>
							</div> <!-- / .panel-body -->
						</div> <!-- / .collapse -->
					</div> <!-- / .panel -->

			</div> <!-- / .panel-group -->
</body>
</html>