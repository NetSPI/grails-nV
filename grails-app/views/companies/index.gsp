<html>
    <head>
        <title>Companies - FindMeAJob</title>
        <meta name="layout" content="loggedin" />
    </head>
    <body>
		<div class="page-header">
			<h1><span class="text-light-gray">Companies / </span>View</h1>
		</div> <!-- / .page-header -->
		<g:if test="${flash.error}"><div class="note note-error">${flash.error}</div></g:if><g:if test="${flash.success}"><div class="note note-success">${flash.success}</div></g:if>
		<g:if test="${can_create}">
			<div class="row"><div class="col-sm-4"><a href="${request.contextPath}/companies/create"><button class="btn btn-labeled btn-primary"><span class="btn-label icon fa fa-plus"></span>Add Company</button></a></div></div><br />
		</g:if>
		<p>This page lists all the companies and employers in the system. The job listings from these companies can be seen on the main job listing page</p>
		<div class="row">
			<div class="col-sm-12">
				<!-- Javascript -->
				<script>
					init.push(function () {
						$('#jq-datatables-example').dataTable();
						$('#jq-datatables-example_wrapper .table-caption').text('Companies');
						$('#jq-datatables-example_wrapper .dataTables_filter input').attr('placeholder', 'Search...');
					});
				</script>
				<!-- / Javascript -->
				<div class="table-primary">
					<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered" id="jq-datatables-example">
						<thead>
							<tr>
								<th>Edit</th>
								<th>Name</th>
								<th>Description</th>
								<th>Website</th>
								<th>Employees</th>
							</tr>
						</thead>
						<tbody>
							<g:each in="${companies}" var="company" >
								<tr class="odd gradeC">
									<td><g:if test="${can_create || (user_employer_id == company.id)}"><a href="${request.contextPath}/companies/edit/${company.id}"><button class="btn btn-sm"><span class="btn-label icon fa fa"></span>Edit Listing</button></a></g:if>
									<g:else> </g:else></td>
									<td>${company.name}</td>
									<td>${company.description}</td>
									<td><a href="${company.website}">${company.website}</a></td>
									<td><g:each in="${company.employees}" var="employee"><a href="${request.contextPath}/profile/${employee.id}">${employee.fullname}</a> </g:each></td>
							</g:each>
						</tbody>
					</table>
				</div>
			</div>
		</div>
</body>
</html>