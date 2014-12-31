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
								'firstname': {
									required: true
								},
								'lastname': {
									required: true
								},
								'description': {
									maxLength: 3000
								},
								'ssn': {
									maxLength: 11
								},
								'email': {
								  required: true,
								  email: true
								},
								'password': {
									required: true,
									minlength: 6,
								},
								'newpassword': {
									minlength: 6
								},
								'passwordconfirm': {
									equalTo: "#newpassword"
								},
							},
							messages: {
								'firstname': 'You must enter your first name',
								'lastname': 'You must enter your last name',
								'description': 'Your description must be under 3000 characters',
								'email': 'You must enter a valid email',
								'password': 'Your password must be at least 6 characters long',
								'newpassword': 'The new password must be at least 6 characters long',
								'passwordconfirm': 'This field must match the new password'
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
						<g:if test="${user?.firstname}"><button class="btn btn-outline btn-xs btn-labeled btn-danger" onclick="resetForm();"><span class="btn-label icon fa fa-camera-retro"></span>Reset Form</button></g:if>
						<form class="form-horizontal" id="jq-validation-form" action="${request.contextPath}/profile/edit/${user.id}" method="post">
							<div class="form-group">
								<label for="firstnamevalid" class="col-sm-3 control-label">First Name</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="firstname" name="firstname" placeholder="First Name" value="${user.firstname}">
								</div>
							</div>

							<div class="form-group">
								<label for="lastnamevalid" class="col-sm-3 control-label">Last Name</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="lastname" name="lastname" placeholder="Last Name" value="${user.lastname}">
								</div>
							</div>

							<div class="form-group">
								<label for="descriptionvalid" class="col-sm-3 control-label">Description</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="description" name="description" placeholder="Description" value="${user.description}">
								</div>
							</div>

							<div class="form-group">
								<label for="descriptionvalid" class="col-sm-3 control-label">Social Security Number</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="ssn" name="ssn" placeholder="SSN" value="${user.ssn}">
								</div>
							</div>

							<div class="form-group">
								<label for="emailvalid" class="col-sm-3 control-label">Email</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="email" name="email" placeholder="Email" value="${user.email}">
								</div>
							</div>

							<div class="form-group">
								<label for="passwordvalid" class="col-sm-3 control-label">Current Password</label>
								<div class="col-sm-9">
									<input type="password" class="form-control" id="password" name="password" placeholder="Password" autocomplete="off">
									<p class="help-block">Passwords must be at least 6 characters long and contain one number</p>
								</div>
							</div>

							<div class="form-group">
								<label for="newpasswordvalid" class="col-sm-3 control-label">New password</label>
								<div class="col-sm-9">
									<input type="password" class="form-control" id="newpassword" name="newpassword" placeholder="New password" autocomplete="off">
									<p class="help-block">(Optional) Enter a new password for the account</p>
								</div>
							</div>

							<div class="form-group">
								<label for="passwordconfirmationvalid" class="col-sm-3 control-label">Confirm new password</label>
								<div class="col-sm-9">
									<input type="password" class="form-control" id="passwordconfirm" name="passwordconfirm" placeholder="Confirm password" autocomplete="off">
									<p class="help-block">(Optional) Confirm the new password</p>
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