<!DOCTYPE html>
<!--[if IE 8]>         <html class="ie8"> <![endif]-->
<!--[if IE 9]>         <html class="ie9 gt-ie8"> <![endif]-->
<!--[if gt IE 9]><!--> <html class="gt-ie8 gt-ie9 not-ie"> <!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>Sign Up - FindMeAJob</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">

	<!-- Open Sans font from Google CDN -->
	<link href="http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,400,600,700,300&subset=latin" rel="stylesheet" type="text/css">

	<!-- Pixel Admin's stylesheets -->
	<link href="${request.contextPath}/pixeladmin/html/assets/stylesheets/bootstrap.min.css" rel="stylesheet" type="text/css">
	<link href="${request.contextPath}/pixeladmin/html/assets/stylesheets/pixel-admin.min.css" rel="stylesheet" type="text/css">
	<link href="${request.contextPath}/pixeladmin/html/assets/stylesheets/pages.min.css" rel="stylesheet" type="text/css">
	<link href="${request.contextPath}/pixeladmin/html/assets/stylesheets/rtl.min.css" rel="stylesheet" type="text/css">
	<link href="${request.contextPath}/pixeladmin/html/assets/stylesheets/themes.min.css" rel="stylesheet" type="text/css">

	<!--[if lt IE 9]>
		<script src="${request.contextPath}/pixeladmin/html/assets/javascripts/ie.min.js"></script>
	<![endif]-->
</head>

<!-- 1. $BODY ======================================================================================
	
	Body

	Classes:
	* 'theme-{THEME NAME}'
	* 'right-to-left'     - Sets text direction to right-to-left
-->
<body class="theme-default page-signup">

<script>
	var init = [];
</script>
	<!-- Page background -->
	<div id="page-signup-bg">
		<!-- Background overlay -->
		<div class="overlay"></div>
		<!-- Replace this with your bg image -->
		<img src="${request.contextPath}/pixeladmin/html/assets/demo/signin-bg-1.jpg" alt="">
	</div>
	<!-- / Page background -->

	<!-- Container -->
	<div class="signup-container">
		<g:if test="${flash.invalidToken}"><div class="alert alert-danger">Please submit the login only once</div></g:if><g:if test="${flash.error}"><div class="alert alert-danger">${flash.error}</div></g:if><g:if test="${flash.info}"><div class="alert alert-info">${flash.info}</div></g:if><g:if test="${flash.success}"><div class="alert alert-success">${flash.success}</div></g:if><g:if test="${success}"><div class="alert alert-success">${success}</div></g:if>
		<!-- Header -->
		<div class="signup-header">
			<a href="index.html" class="logo">
				<img src="${request.contextPath}/pixeladmin/html/assets/demo/logo-big.png" alt="" style="margin-top: -5px;">&nbsp;
				FindMeAJob
			</a> <!-- / .logo -->
			<div class="slogan">
				Fast. Easy. Mostly Effective.
			</div> <!-- / .slogan -->
		</div>
		<!-- / Header -->

		<!-- Form -->
		<div class="signup-form">
			<g:form action="signup" name="signup-form_id" method="post" useToken="true">
				
				<div class="signup-text">
					<span>Create an account</span>
				</div>

				<div class="form-group w-icon">
					<input type="text" name="signup_firstname" id="firstname_id" class="form-control input-lg" placeholder="First name">
					<span class="fa fa-info signup-form-icon"></span>
				</div>

				<div class="form-group w-icon">
					<input type="text" name="signup_lastname" id="lastname_id" class="form-control input-lg" placeholder="Last name">
					<span class="fa fa-info signup-form-icon"></span>
				</div>

				<div class="form-group w-icon">
					<input type="text" name="signup_email" id="email_id" class="form-control input-lg" placeholder="E-mail">
					<span class="fa fa-envelope signup-form-icon"></span>
				</div>

				<div class="form-group w-icon">
					<input type="password" name="signup_password" id="password_id" class="form-control input-lg" placeholder="Password" autocomplete="off">
					<span class="fa fa-lock signup-form-icon"></span>
				</div>

				<div class="form-group w-icon">
					<input type="password" name="signup_confirm" id="confirm_id" class="form-control input-lg" placeholder="Confirm Password" autocomplete="off">
					<span class="fa fa-lock signup-form-icon"></span>
				</div>

				<div class="form-group" style="margin-top: 20px;margin-bottom: 20px;">
					<label class="checkbox-inline">
						<input type="checkbox" name="signup_agree" class="px" id="agree_id">
						<span class="lbl">I agree with the <a href="#" target="_blank">Terms and Conditions</a></span>
					</label>
				</div>

				<div class="form-actions">
					<input type="submit" value="SIGN UP" class="signup-btn bg-primary">
				</div>
			</g:form>
			<!-- / Form -->
		</div>
		<!-- Right side -->
	</div>

		<div class="have-account">
		Already have an account? <a href="${request.contextPath}/user/login">Sign In</a><br />
		Looking for the Grailsgoat tutorials? <a href="${request.contextPath}/tutorials">Click here</a>
	</div>


<!-- Get jQuery from Google CDN -->
<!--[if !IE]> -->
	<script type="text/javascript"> window.jQuery || document.write('<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js">'+"<"+"/script>"); </script>
<!-- <![endif]-->
<!--[if lte IE 9]>
	<script type="text/javascript"> window.jQuery || document.write('<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js">'+"<"+"/script>"); </script>
<![endif]-->


<!-- Pixel Admin's javascripts -->
<script src="${request.contextPath}/pixeladmin/html/assets/javascripts/bootstrap.min.js"></script>
<script src="${request.contextPath}/pixeladmin/html/assets/javascripts/pixel-admin.min.js"></script>

<script type="text/javascript">
	// Resize BG
	init.push(function () {
		var $ph  = $('#page-signup-bg'),
		    $img = $ph.find('> img');

		$(window).on('resize', function () {
			$img.attr('style', '');
			if ($img.height() < $ph.height()) {
				$img.css({
					height: '100%',
					width: 'auto'
				});
			}
		});

		$("#signup-form_id").validate({ focusInvalid: true, errorPlacement: function () {} });

		// Validate first name
		$("#firstname_id").rules("add", {
			required: true,
			minlength: 1
		});

		// Validate last name
		$("#lastname_id").rules("add", {
			required: true,
			minlength: 1
		});


		// Validate email
		$("#email_id").rules("add", {
			required: true,
			email: true
		});
		

		// Validate password
		$("#password_id").rules("add", {
			required: true,
			minlength: 6
		});

		$("#confirm_id").rules("add", {
			required: true,
			equalTo: "#password_id"
		})

		// Validate confirm checkbox
		$("#agree_id").rules("add", {
			required: true
		});
	});

	window.PixelAdmin.start(init);
</script>

</body>
</html>
