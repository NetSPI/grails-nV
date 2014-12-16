<html>
    <head>
        <title>Search Listings - FindMeAJob</title>
        <meta name="layout" content="loggedin" />
    </head>
    <body>
		<div class="page-header">
			<h1><span class="text-light-gray">Job Listings / </span>Search</h1>
		</div> <!-- / .page-header -->
		<g:if test="${flash.error}"><div class="note note-error">${flash.error}</div></g:if><g:if test="${flash.success}"><div class="note note-success">${flash.success}</div></g:if>
		<p>This page lists all listings matching the search "${raw(query)}"</p>
		<div class="row">
			<div class="col-sm-12">
				<!-- Javascript -->
				<script>
					init.push(function () {
						var lookup_data = $.parseJSON('${listings_lookup.encodeAsRaw()}');
						console.log(lookup_data);
						$('#jq-datatables-example').dataTable( { "searching": false } );
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
