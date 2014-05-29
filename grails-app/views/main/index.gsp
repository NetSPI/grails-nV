<html>
    <head>
        <title>Main Page - FindMeAJob</title>
        <meta name="layout" content="loggedin" />
    </head>
    <body>
		<div class="page-header">
			<h1>Job Listings</h1>
		</div> <!-- / .page-header -->
		<p>This page lists all the current job offerings in the system. Only job offerings still available will be listed</p>
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
								<th>Location</th>
								<th>Full-time</th>
								<th>Company</th>
							</tr>
						</thead>
						<tbody>
							<tr class="odd gradeX">
								<td>Trident</td>
								<td>Internet
									 Explorer 4.0</td>
								<td>Win 95+</td>
								<td class="center"> 4</td>
								<td class="center">X</td>
							</tr>
							<tr class="even gradeC">
								<td>Trident</td>
								<td>Internet
									 Explorer 5.0</td>
								<td>Win 95+</td>
								<td class="center">5</td>
								<td class="center">C</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
</body>
</html>