<!DOCTYPE html>
<!--[if IE 8]>         <html class="ie8"> <![endif]-->
<!--[if IE 9]>         <html class="ie9 gt-ie8"> <![endif]-->
<!--[if gt IE 9]><!--> <html class="gt-ie8 gt-ie9 not-ie"> <!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>Sign In - FindMeAJob</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">

	<!-- Open Sans font from Google CDN -->
	<link href="http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,400,600,700,300&subset=latin" rel="stylesheet" type="text/css">

	<!-- Pixel Admin's stylesheets -->
	<asset:stylesheet href="application.css"/>

	<!--[if lt IE 9]>
		<script src="${request.contextPath}/pixeladmin/html/assets/javascripts/ie.min.js"></script>
	<![endif]-->

<!-- 1. $BODY ======================================================================================
	
	Body

	Classes:
	* 'theme-{THEME NAME}'
	* 'right-to-left'     - Sets text direction to right-to-left
-->
<body class="theme-default page-signin">

<script>
	var init = [];
</script>

	<!-- Page background -->
	<div id="page-signin-bg">
		<!-- Background overlay -->
		<div class="overlay"></div>
		<!-- Replace this with your bg image -->
		<asset:image alt="background" src="demo/signin-bg-1.jpg"/>
	</div>
	<!-- / Page background -->

	<!-- Container -->
	<div class="signin-container">

		<!-- Left side -->
		<div class="signin-info">
			<a href="index.html" class="logo">
				<asset:image alt="" src="demo/logo-big.png" style="margin-top: -5px;"/>&nbsp;
				FindMeAJob
			</a> <!-- / .logo -->
			<div class="slogan">
				Fast. Easy. Mostly Effective.
			</div> <!-- / .slogan -->
			<ul>
				<li><i class="fa fa-sitemap signin-icon"></i> Popular with employers</li>
				<li><i class="fa fa-file-text-o signin-icon"></i> Easy-to-browse offers</li>
				<li><i class="fa fa-outdent signin-icon"></i> One-click resume submit</li>
				<li><i class="fa fa-heart signin-icon"></i> Very, very secure</li>
			</ul> <!-- / Info list -->
		</div>
		<!-- / Left side -->

		<!-- Right side -->
		<div class="signin-form">
			<g:if test="${success}"><div class="alert alert-success">${success}</div></g:if><g:if test="${flash.invalidToken}"><div class="alert alert-danger">Please submit the login only once</div></g:if><g:if test="${flash.error}"><div class="alert alert-danger">${flash.error}</div></g:if><g:if test="${flash.info}"><div class="alert alert-info">${flash.info}</div></g:if><g:if test="${flash.success}"><div class="alert alert-success">${flash.success}</div></g:if><g:if test="${success}"><div class="alert alert-success">${success}</div></g:if>
			<!-- Form -->
			<g:form action="signin" name="signin-form_id" method="post" useToken="True">
				<div class="signin-text">
					<span>Sign In to your account</span>
				</div> <!-- / .signin-text -->

				<div class="form-group w-icon">
					<input type="text" name="signin_email" id="username_id" class="form-control input-lg" placeholder="Email">
					<span class="fa fa-user signin-form-icon"></span>
				</div> <!-- / Username -->

				<div class="form-group w-icon">
					<input type="password" name="signin_password" id="password_id" class="form-control input-lg" placeholder="Password" autocomplete="off">
					<span class="fa fa-lock signin-form-icon"></span>
				</div> <!-- / Password -->

				<div class="form-actions">
					<input type="submit" value="SIGN IN" class="signin-btn bg-primary">
					<a href="#" class="forgot-password" id="forgot-password-link">Forgot your password?</a>
				</div> <!-- / .form-actions -->

				<g:if test="${lastpage}"><g:hiddenField name="lastpage" value="${lastpage}" /></g:if>
			</g:form>

			<!-- / Form -->
			<!-- Password reset form -->
			<div class="password-reset-form" id="password-reset-form">
				<div class="header">
					<div class="signin-text">
						<span>Password reset</span>
						<div class="close">&times;</div>
					</div> <!-- / .signin-text -->
				</div> <!-- / .header -->
				
				<!-- Form -->
				<form action="${request.contextPath}/user/forgot" id="password-reset-form_id" method="post">
					<div class="form-group w-icon">
						<input type="text" name="password_reset_email" id="p_email_id" class="form-control input-lg" placeholder="Enter your email">
						<span class="fa fa-envelope signin-form-icon"></span>
					</div> <!-- / Email -->

					<div class="form-actions">
						<input type="submit" value="SEND PASSWORD RESET LINK" class="signin-btn bg-primary">
					</div> <!-- / .form-actions -->
				</form>
				<!-- / Form -->
			</div>
			<!-- / Password reset form -->
		</div>
		<!-- Right side -->
	</div>
	<!-- / Container -->

	<div class="not-a-member">
		Not a member? <a href="${request.contextPath}/user/register">Sign up now</a><br />
		Looking for the grails_nV tutorials? <a href="${request.contextPath}/tutorials">Click here</a>
	</div>

<!-- Get jQuery from Google CDN -->
<!--[if !IE]> -->
	<script type="text/javascript"> window.jQuery || document.write('<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js">'+"<"+"/script>"); </script>
<!-- <![endif]-->
<!--[if lte IE 9]>
	<script type="text/javascript"> window.jQuery || document.write('<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js">'+"<"+"/script>"); </script>
<![endif]-->


<!-- Pixel Admin's javascripts -->
<asset:javascript src="application.js"/>

<script type="text/javascript">
	// Resize BG
	init.push(function () {
		var $ph  = $('#page-signin-bg'),
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
	});

	// Show/Hide password reset form on click
	init.push(function () {
		$('#forgot-password-link').click(function () {
			$('#password-reset-form').fadeIn(400);
			return false;
		});
		$('#password-reset-form .close').click(function () {
			$('#password-reset-form').fadeOut(400);
			return false;
		});
	});

	// Setup Sign In form validation
	init.push(function () {
		$("#signin-form_id").validate({ focusInvalid: true, errorPlacement: function () {} });
		
		// Validate username
		$("#username_id").rules("add", {
			required: true,
			minlength: 3
		});

		// Validate password
		$("#password_id").rules("add", {
			required: true,
			minlength: 6
		});
	});

	// Setup Password Reset form validation
	init.push(function () {
		$("#password-reset-form_id").validate({ focusInvalid: true, errorPlacement: function () {} });
		
		// Validate email
		$("#p_email_id").rules("add", {
			required: true,
			email: true
		});
	});

	window.PixelAdmin.start(init);
</script>

</body>
</html>
