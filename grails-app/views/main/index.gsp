<html>
    <head>
        <title>Main Page - FindMeAJob</title>
        <meta name="layout" content="loggedin" />
    </head>
    <body>
		<div class="page-header">
			<h1><span class="text-light-gray">Job Listings / </span>View</h1>
		</div> <!-- / .page-header -->
		<g:if test="${flash.error}"><div class="note note-error">${flash.error}</div></g:if><g:if test="${flash.success}"><div class="note note-success">${flash.success}</div></g:if>
		<div class="row"><div class="col-sm-4">
			<a href="${request.contextPath}/listings/create"><button class="btn btn-labeled btn-primary"><span class="btn-label icon fa fa-plus"></span>New Listing</button></a><br /><br />
			<!-- Check application.js, we need to encrypt the user's search to protect them -->
			<form id="search-form" class="form-inline" action="${request.contextPath}/listings/search">
				<div class="form-group"><input type="text" class="form-control" id="q" name="q" placeholder="Search for Listing"></div>
				<button type="submit" class="btn btn-primary">Go</button>
			</form
		></div></div><br />
		<p>This page lists all the current job offerings in the system. Only job offerings still available will be listed</p>
		<div class="row">
			<div class="col-sm-12">
				<!-- Javascript -->
				<script>
					init.push(function () {
						var lookup_data = $.parseJSON('${listings_lookup.encodeAsRaw()}');
						console.log(lookup_data);
						$('#jq-datatables-example').dataTable( { "searching": false } );
						$('#jq-datatables-example_wrapper .dataTables_filter input').attr('placeholder', 'Search...');
						$('#jq-datatables-example tbody').on('click', 'tr', function () { 
							var key = $('td', this).eq(0).text() + $('td', this).eq(1).text();
							document.location = "${request.contextPath}/listings/" + lookup_data[key];
						} );
					});
				</script>
				<!-- / Javascript -->
				<div class="table-primary">
					<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered" id="jq-datatables-example">
						<thead>
							<tr>
								<th>Name</th>
								<th>Description</th>
								<th>Location</th>
								<th>Full-time</th>
								<th>Company</th>
							</tr>
						</thead>
						<tbody>
							<g:each in="${listings}" var="listing" >
								<tr class="odd gradeX">
									<td>${listing.name}</td>
									<!-- Formatting in the description --><td>${raw(listing.description)}</td>
									<td>${listing.location}</td>
									<td><g:if test="${listing.fulltime}">Full-time</g:if><g:else>Part-time</g:else></td>
									<td>${listing.company.name}</td>
							</g:each>
						</tbody>
					</table>
				</div>
			</div>
		</div>
</body>
</html>