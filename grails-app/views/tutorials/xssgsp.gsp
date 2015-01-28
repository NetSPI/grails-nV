<html>
    <head>
        <title>Cross-site Scripting (GSP) - grails_nV</title>
        <meta name="layout" content="tutorials" />
    </head>
    <body>
		<div class="page-header">
			<h1><span class="text-light-gray">Tutorials / </span>Cross-site Scripting (GSP)</h1>
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
								GSP-based cross-site scripting (XSS) is a form of XSS attack specific to Grails. By default in the latest version, Grails uses HTML encoding on all outputted GSP template elements in order to prevent templating attacks (such as GSP XSS). However, it is possible to bypass this protection on an element by calling the raw() method individually on a value you output in the template.
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
								FindMeAJob wanted to use markdown on fields to let companies be more descriptive, but they never got around to actually adding the Markdown part...
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
								FindMeAJob apparently wished to allow companies to be more descriptive when they posted information about job listings. On the job listing template, they've altered the template markup to allow the HTML that would be output by a Markdown parser.
								<pre class="line-numbers"><code class="language-javascript">&lt;g:each in=&quot;${'${listings}'}&quot; var=&quot;listing&quot; &gt;
	&lt;tr class=&quot;odd gradeX&quot;&gt;
		&lt;td&gt;${'${listing.name}'}&lt;/td&gt;
		&lt;!-- Formatting in the description --&gt;&lt;td&gt;${'${raw(listing.description)}'}&lt;/td&gt;
		&lt;td&gt;${'${listing.location}'}&lt;/td&gt;
		&lt;td&gt;&lt;g:if test=&quot;${'${listing.fulltime}'}&quot;&gt;Full-time&lt;/g:if&gt;&lt;g:else&gt;Part-time&lt;/g:else&gt;&lt;/td&gt;
		&lt;td&gt;${'${listing.company.name}'}&lt;/td&gt;
&lt;/g:each&gt;</code></pre>
								The company description has been purposely left unescaped.
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
								In this case, the main problem was the lack of an actual Markdown parser being linked to the description generated, so any rogue HTML markup was allowed within the description. To address this vulnerability, all portions of a Grails template must be properly escaped, with special exceptions and care being taken if the need arises for formatting (such as Markdown)
							</div> <!-- / .panel-body -->
						</div> <!-- / .collapse -->
					</div> <!-- / .panel -->

			</div> <!-- / .panel-group -->
</body>
</html>