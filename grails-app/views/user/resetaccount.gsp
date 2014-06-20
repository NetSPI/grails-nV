<!DOCTYPE html>
<!--[if IE 8]>         <html class="ie8"> <![endif]-->
<!--[if IE 9]>         <html class="ie9 gt-ie8"> <![endif]-->
<!--[if gt IE 9]><!--> <html class="gt-ie8 gt-ie9 not-ie"> <!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>Reset your Account - FindMeAJob</title>
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
				<asset:image alt="background" src="demo/logo-big.png" style="margin-top: -5px;"/>&nbsp;
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
			<g:if test="${flash.error}"><div class="alert alert-danger">${flash.error}</div></g:if><g:if test="${flash.info}"><div class="alert alert-info">${flash.info}</div></g:if>
			<!-- Form -->
			<form action="${request.contextPath}/user/resethook" id="signin-form_id" method="post">
				<input type="hidden" name="reset_token" id="reset_token" value="${flash.reset_token}">
				<div class="signin-text">
					<span>Reset your account</span>
				</div> <!-- / .signin-text -->

				<div class="form-group w-icon">
					<input type="password" name="password" id="password_id" class="form-control input-lg" placeholder="New Password" required>
					<span class="fa fa-lock signin-form-icon"></span>
				</div> <!-- / Password -->

				<div class="form-group w-icon">
					<input type="password" name="confirm" id="confirm_id" class="form-control input-lg" placeholder="Confirm New Password" required>
					<span class="fa fa-lock signin-form-icon"></span>
				</div> <!-- / Password -->

				<div class="form-actions">
					<input type="submit" value="SIGN IN" class="signin-btn bg-primary">
				</div> <!-- / .form-actions -->
			</form>
			<!-- / Form -->
		</div>
		<!-- Right side -->
	</div>
	<!-- / Container -->

	<div class="not-a-member">
		Not a member? <a href="${request.contextPath}/user/register">Sign up now</a>
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

	// Setup Sign In form validation
	init.push(function () {
		$("#signin-form_id").validate({ focusInvalid: true, errorPlacement: function () {} });

		// Validate password
		$("#password_id").rules("add", {
			required: true,
			minlength: 6
		});

		// Validate confirm password
		$("#confirm_id").rules("add", {
			required: true,
			minlength: 6
		});
	});
	window.PixelAdmin.start(init);
</script>

</body>
</html>