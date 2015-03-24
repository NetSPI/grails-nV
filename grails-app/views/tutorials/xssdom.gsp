<html>
    <head>
        <title>Cross-site Scripting (DOM) - grails_nV</title>
        <meta name="layout" content="tutorials" />
    </head>
    <body>
		<div class="page-header">
			<h1><span class="text-light-gray">Tutorials / </span>Cross-site Scripting (DOM)</h1>
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
								DOM-based cross-site scripting (XSS) is a form of attack where an attacker is able to insert malicious markup into the HTML of the page, resulting in the takeover of a client browser.
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
								The XSS is present on almost every page!
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
								FindMeAJob wants to be the premier job listing website in the entire world. Recently, they began implementing a language feature, but haven't finished fully rolling it out. Unfortunately, this language feature pulls directly from the URL and inserts markup into the page!
								<pre class="line-numbers"><code class="language-groovy">&lt;script type=&quot;text/javascript&quot;&gt;
init.push(function () {
	// Javascript code here
	var hashParam = location.hash.split(&quot;#&quot;)[1];

	$(&quot;#lang&quot;).click();

	$( &quot;#lang&quot; ).click(function() {
		hashParam = location.hash.split(&quot;#&quot;)[1];
		// Unfortunately, we don&#39;t have spanish support yet :(
		if (hashParam.length &gt; 0) {
			$(this).html(&quot;Switch to &quot; + hashParam);
			if (hashParam === &quot;English&quot;) {
				location.hash = &quot;Spanish&quot;
			} else {
				location.hash = &quot;English&quot;
			}
		}
		});
})
...
&lt;/script&gt;</code></pre>
								This code pulls the location hash from the URL, and loads it into the page so the language switcher button updates. Unfortunately, inserting a hash of <code>&lt;/button&gt;&lt;script&gt;alert(1);&lt;/script&gt;&lt;button&gt;</code> shows this is vulnerable to DOM-based XSS.
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
								Rather than pulling from the URL, simply toggle the string between the choices (in this case, 'English' and 'Spanish'). Whenever possible, it is best to avoid using user input. If you must load user inputted data into the DOM, it is important to properly escape it (ex: use <code>$(this).text()</code> rather than <code>$(this).html()</code> with jQuery).
							</div> <!-- / .panel-body -->
						</div> <!-- / .collapse -->
					</div> <!-- / .panel -->

			</div> <!-- / .panel-group -->
</body>
</html>