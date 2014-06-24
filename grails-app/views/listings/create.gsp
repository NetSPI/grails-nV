<html>
	<head>
		<title>New Job Listing - Find Me A Job</title>
		<meta name="layout" content="loggedin" />
	</head>
<body>
		<div class="page-header">
			<h1><span class="text-light-gray">Listings / </span>New</h1>
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
									maxLength: 300
								},
								'description': {
									required: true,
									maxLength: 3000
								},
								'requirements': {
									required: true
									maxLength: 3000
								},
								'howtoapply': {
									required: true
									maxLength: 3000
								},
								'location': {
									required: true
									maxLength: 300
								},
								'startdate': {
									required: true
								},
								'fulltime': {
									required: true
								},
								'company': {
									required: true
								}
							},
							messages: {
								'name': 'Your company name must be under 300 characters',
								'description': 'Your description must be under 3000 characters',
								'requirements': 'Your description must be under 3000 characters',
								'howtoapply': 'Your description must be under 3000 characters',
								'location': 'Your description must be under 3000 characters',
								'website': 'Your website URL must be under 3000 characters',
							}
						});
					});
				</script>
				<!-- / Javascript -->

				<div class="panel">
					<div class="panel-heading">
						<span class="panel-title">New Job Listing</span>
					</div>
					<div class="panel-body">
						<g:if test="${flash.error}"><div class="note note-error">${flash.error}</div></g:if><g:if test="${flash.success}"><div class="note note-success">${flash.success}</div></g:if>
						<form class="form-horizontal" id="jq-validation-form" action="${request.contextPath}/listings/create" method="post">

							<div class="form-group">
								<label for="name" class="col-sm-3 control-label">Company</label>
								<div class="col-sm-9">
									<p>${company.name}</p>
								</div>
							</div>

							<div class="form-group">
								<label for="name" class="col-sm-3 control-label">Name</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="name" name="name" placeholder="Name" value="">
								</div>
							</div>

							<div class="form-group">
								<label for="descriptionvalid" class="col-sm-3 control-label">Description</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="description" name="description" placeholder="Description" value="">
								</div>
							</div>

							<div class="form-group">
								<label for="descriptionvalid" class="col-sm-3 control-label">Requirements</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="requirements" name="requirements" placeholder="Requirements" value="">
								</div>
							</div>

							<div class="form-group">
								<label for="descriptionvalid" class="col-sm-3 control-label">How to Apply</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="howtoapply" name="howtoapply" placeholder="How to Apply" value="">
								</div>
							</div>

							<div class="form-group">
								<label for="descriptionvalid" class="col-sm-3 control-label">Location</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="location" name="location" placeholder="Location" value="">
								</div>
							</div>

							<div class="form-group">
								<label for="descriptionvalid" class="col-sm-3 control-label">Start Date</label>
								<div class="col-sm-9">
									<input type="datetime-local" class="form-control" id="startdate" name="startdate" value="">
								</div>
							</div>

							<div class="form-group">
								<label for="descriptionvalid" class="col-sm-3 control-label">Hours</label>
								<div class="col-sm-9">
									<input type="radio" class="form-control" name="fulltime" value="1">Full time<br/>
									<input type="radio" class="form-control" name="fulltime" value="0">Part time
								</div>
							</div>

							<div class="form-group">
								<div class="col-sm-offset-3 col-sm-9">
									<button type="submit" class="btn btn-primary">Submit</button>
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