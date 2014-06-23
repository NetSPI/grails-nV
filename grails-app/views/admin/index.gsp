<html>
    <head>
        <title>Admin Panel - User Management</title>
        <meta name="layout" content="loggedin" />
    </head>
    <body>
		<div class="page-header">
			<h1><span class="text-light-gray">User Management / </span>View</h1>
		</div> <!-- / .page-header -->
		<p>This page lists all the current users within the system</p>
		<div class="row">
			<div class="col-sm-12">
				<script>
					init.push(function () {
						$('#jq-datatables-example').dataTable();
						$('#jq-datatables-example_wrapper .dataTables_filter input').attr('placeholder', 'Search...');
						$('#jq-datatables-example tbody').on('click', 'tr', function () { 
							var key = $(this).eq(0).data("id");
							document.location = "${request.contextPath}/user-management/edit/" + key;
						} );
					});
				</script>
				<div class="table-primary">
					<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered" id="jq-datatables-example">
						<thead>
							<tr>
								<th>Name</th>
								<th>Social-Security Number</th>
								<th>Password</th>
							</tr>
						</thead>
						<tbody>
							<g:each in="${users}" var="user" >
									<tr class="odd gradeX" data-id="${user.id}">
										<td>${user.fullname}</td>
										<td>${user.ssn}</td>
										<td>${user.password}</td>
									</tr>
							</g:each>
						</tbody>
					</table>
				</div>
			</div>
		</div>
</body>
</html>