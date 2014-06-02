<html>
    <head>
        <title>Companies - FindMeAJob</title>
        <meta name="layout" content="loggedin" />
    </head>
    <body>
		<div class="page-header">
			<h1><span class="text-light-gray">Companies / </span>View</h1>
		</div> <!-- / .page-header -->
		<p>This page lists all the companies and employers in the system. The job listings from these companeis can be seen on the main job listing page</p>
		<div class="row">
			<div class="col-sm-12">
				<!-- Javascript -->
				<script>
					init.push(function () {
						$('#jq-datatables-example').dataTable();
						$('#jq-datatables-example_wrapper .table-caption').text('Some header text');
						$('#jq-datatables-example_wrapper .dataTables_filter input').attr('placeholder', 'Search...');
					});
				</script>
				<!-- / Javascript -->
				<div class="table-primary">
					<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered" id="jq-datatables-example">
						<thead>
							<tr>
								<th>Name</th>
								<th>Description</th>
								<th>Website</th>
							</tr>
						</thead>
						<tbody>
							<g:each in="${companies}" var="company" >
								<tr class="odd gradeC">
									<td>${company.name}</td>
									<td>${company.description}</td>
									<td><a href="${company.website}">${company.website}</a></td>
							</g:each>
						</tbody>
					</table>
				</div>
			</div>
		</div>
</body>
</html>