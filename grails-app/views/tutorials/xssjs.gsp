<html>
    <head>
        <title>Cross-site Scripting (JS) - grails_nV</title>
        <meta name="layout" content="tutorials" />
    </head>
    <body>
		<div class="page-header">
			<h1><span class="text-light-gray">Tutorials / </span>Cross-site Scripting (JS)</h1>
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
								JavaScript-based cross-site scripting is a class of vulnerability where the attacker is able to directly insert malicious code into the executed JavaScript of a page. Often times, this is either a result of improperly escaped templating to generate JavaScript, or use of the <code>eval()</code> function for metaprogramming (which should almost always be avoided).
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
								Job listings draw information from all over the database, so how do we pull data from many different tables?
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
								The main job listings page attempts to create links to each individual job listing page in order to provide more information about each opportunity. To do so, it requires the server to assemble a JSON output of the information in the database to be easily accesible by JavaScript.
								<pre class="line-numbers"><code class="language-groovy">def listings_lookup = listings.collectEntries { [it.name + it.description, it.id] }

render(view: "index", model: [listings: listings, listings_lookup: (listings_lookup as JSON).toString()])</code></pre>
								On the listings page, it parses the array as it receives it
								<pre class="line-numbers"><code class="language-javascript">init.push(function () {
	var lookup_data = $.parseJSON('${listings_lookup.encodeAsRaw()}');
	console.log(lookup_data);
	$('#jq-datatables-example').dataTable();
	$('#jq-datatables-example_wrapper .dataTables_filter input').attr('placeholder', 'Search...');
	$('#jq-datatables-example tbody').on('click', 'tr', function () { 
		var key = $('td', this).eq(0).text() + $('td', this).eq(1).text();
		document.location = "${request.contextPath}/listings/" + lookup_data[key];
	} );
});</code></pre>
								Unfortunately, our controller doesn't validate that the information from the database is escaped before outputting the JSON string. Since we must call encodeAsRaw() on the JSON string to avoid it becoming escaped and being invalid, we cannot perform this check on the client either.
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
								This problem can be mitigated by avoiding the use of uneccesary JavaScript on the client-side view. The calculations required to generate links simply involve matching the information in the table to an ID that matches the listing. This could simply be implenented in the GSP template by using the objects already passed to the view.
							</div> <!-- / .panel-body -->
						</div> <!-- / .collapse -->
					</div> <!-- / .panel -->

			</div> <!-- / .panel-group -->
</body>
</html>