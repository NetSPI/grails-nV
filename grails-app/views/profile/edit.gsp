<html>
	<head>
		<title>Edit Profile - Find Me A Job</title>
		<meta name="layout" content="loggedin" />
	</head>
<body>
		<div class="page-header">
			<h1><span class="text-light-gray">My Profile / </span>Edit</h1>
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
								'firstnamevalid': {
									required: true
								},
								'lastnamevalid': {
									required: true
								},
								'descriptionvalid': {
									maxLength: 3000
								},
								'emailvalid': {
								  required: true,
								  email: true
								},
								'passwordvalid': {
									required: true,
									minlength: 6,
								},
								'passwordconfirmationvalid': {
									required: true,
									minlength: 6,
									equalTo: "#passwordvalid"
								},
							},
							messages: {
								'firstnamevalid': 'You must enter your first name',
								'lastnamevalid': 'You must enter your last name',
								'descriptionvalid': 'Your description must be under 3000 characters',
								'emailvalid': 'You must enter a valid email',
								'passwordvalid': 'Your password must be at least 6 characters long',
								'passwordconfirmationvalid': 'Confirm password must match the original password'
							}
						});
					});
				</script>
				<!-- / Javascript -->

				<div class="panel">
					<div class="panel-heading">
						<span class="panel-title">Edit Profile</span>
					</div>
					<div class="panel-body">
						<g:if test="${flash.error}"><div class="note note-error">${flash.error}</div></g:if><g:if test="${flash.success}"><div class="note note-success">${flash.success}</div></g:if>
						<form class="form-horizontal" id="jq-validation-form" action="${request.contextPath}/profile/edit/${user.id}" method="post">
							<div class="form-group">
								<label for="firstnamevalid" class="col-sm-3 control-label">First Name</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="firstnamevalid" name="firstnamevalid" placeholder="First Name" value="${user.firstname}">
								</div>
							</div>

							<div class="form-group">
								<label for="lastnamevalid" class="col-sm-3 control-label">Last Name</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="lastnamevalid" name="lastnamevalid" placeholder="Last Name" value="${user.lastname}">
								</div>
							</div>

							<div class="form-group">
								<label for="descriptionvalid" class="col-sm-3 control-label">Description</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="descriptionvalid" name="descriptionvalid" placeholder="Description" value="${user.description}">
								</div>
							</div>

							<div class="form-group">
								<label for="emailvalid" class="col-sm-3 control-label">Email</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="emailvalid" name="emailvalid" placeholder="Email" value="${user.email}">
								</div>
							</div>

							<div class="form-group">
								<label for="passwordvalid" class="col-sm-3 control-label">Password</label>
								<div class="col-sm-9">
									<input type="password" class="form-control" id="passwordvalid" name="passwordvalid" placeholder="Password">
									<p class="help-block">Passwords must be at least 6 characters long and contain one number</p>
								</div>
							</div>

							<div class="form-group">
								<label for="passwordconfirmationvalid" class="col-sm-3 control-label">Confirm password</label>
								<div class="col-sm-9">
									<input type="password" class="form-control" id="passwordconfirmationvalid" name="passwordconfirmationvalid" placeholder="Confirm password">
									<p class="help-block">This must match the original password</p>
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-offset-3 col-sm-9">
									<button type="submit" class="btn btn-primary">Update Information</button>
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