<html>
	<head>
		<title>Edit Company - Find Me A Job</title>
		<meta name="layout" content="loggedin" />
	</head>
<body>
		<div class="page-header">
			<h1><span class="text-light-gray">Companies / </span>Edit</h1>
		</div> <!-- / .page-header -->

		<div class="row">
			<div class="col-sm-12">

<!-- 5. $JQUERY_VALIDATION =========================================================================

				jQuery Validation
-->
				<!-- Javascript -->
				<script>
					init.push(function () {
						// Setup validation
						$("#jq-validation-form").validate({
							ignore: '.ignore, .select2-input',
							focusInvalid: false,
							rules: {
								'name': {
									required: true,
									maxLength: 200
								},
								'description': {
									required: true,
									maxLength: 3000
								},
								'website': {
									maxLength: 11,
									maxLength: 2000,
									url: true
								},
							},
							messages: {
								'name': 'Your company name must be under 200 characters',
								'description': 'Your description must be under 3000 characters',
								'website': 'Your website URL must be under 2000 characters',
							}
						});
					});
				</script>
				<!-- / Javascript -->

				<div class="panel">
					<div class="panel-heading">
						<span class="panel-title">Edit Company</span>
					</div>
					<div class="panel-body">
						<g:if test="${flash.error}"><div class="note note-error">${flash.error}</div></g:if><g:if test="${flash.success}"><div class="note note-success">${flash.success}</div></g:if>
						<form class="form-horizontal" id="jq-validation-form" action="${request.contextPath}/companies/edit/${company.id}" method="post">
							<div class="form-group">
								<label for="name" class="col-sm-3 control-label">Name</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="name" name="name" placeholder="Name" value="${company.name}">
								</div>
							</div>

							<div class="form-group">
								<label for="descriptionvalid" class="col-sm-3 control-label">Description</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="description" name="description" placeholder="Description" value="${company.description}">
								</div>
							</div>

							<div class="form-group">
								<label for="websitevalid" class="col-sm-3 control-label">Social Security Number</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="website" name="website" placeholder="URL" value="${company.website}">
								</div>
							</div>

							<div class="form-group">
								<div class="col-sm-offset-3 col-sm-9">
									<button type="submit" class="btn btn-primary">Update</button>
								</div>
							</div>
						</form>
					</div>
				</div>
<!-- /5. $JQUERY_VALIDATION -->

			</div>
		</div>
</body>
</html>