<!DOCTYPE html>
<!--[if IE 8]>         <html class="ie8"> <![endif]-->
<!--[if IE 9]>         <html class="ie9 gt-ie8"> <![endif]-->
<!--[if gt IE 9]><!--> <html class="gt-ie8 gt-ie9 not-ie"> <!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title><g:layoutTitle/></title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">

	<!-- Open Sans font from Google CDN -->
	<link href="http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,400,600,700,300%26subset=latin" rel="stylesheet" type="text/css">

	<!-- Pixel Admin's stylesheets -->
	<asset:stylesheet href="application.css"/>

	<!--[if lt IE 9]>
		<script src="assets/javascripts/ie.min.js"></script>
	<![endif]-->
	<g:layoutHead />
</head>


<!-- 1. $BODY ======================================================================================
	
	Body

	Classes:
	* 'theme-{THEME NAME}'
	* 'right-to-left'      - Sets text direction to right-to-left
	* 'main-menu-right'    - Places the main menu on the right side
	* 'no-main-menu'       - Hides the main menu
	* 'main-navbar-fixed'  - Fixes the main navigation
	* 'main-menu-fixed'    - Fixes the main menu
	* 'main-menu-animated' - Animate main menu
-->
<body class="theme-default main-menu-animated">

<script>var init = [];</script>

<div id="main-wrapper">


<!-- 2. $MAIN_NAVIGATION ===========================================================================

	Main navigation
-->
	<div id="main-navbar" class="navbar navbar-inverse" role="navigation">
		<!-- Main menu toggle -->
		<button type="button" id="main-menu-toggle"><i class="navbar-icon fa fa-bars icon"></i><span class="hide-menu-text">HIDE MENU</span></button>
		
		<div class="navbar-inner">
			<!-- Main navbar header -->
			<div class="navbar-header">

				<!-- Logo -->
				<a href="${request.contextPath}/tutorials/" class="navbar-brand">
					<div><asset:image alt="Pixel Admin" src="pixel-admin/main-navbar-logo.png"/></div>
					grails_nV Tutorials
				</a>

				<!-- Main navbar toggle -->
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#main-navbar-collapse"><i class="navbar-icon fa fa-bars"></i></button>

			</div> <!-- / .navbar-header -->

			<div id="main-navbar-collapse" class="collapse navbar-collapse main-navbar-collapse">
				<div>
				</div>
			</div> <!-- / #main-navbar-collapse -->
		</div> <!-- / .navbar-inner -->
	</div> <!-- / #main-navbar -->
<!-- /2. $END_MAIN_NAVIGATION -->


<!-- 4. $MAIN_MENU =================================================================================

		Main menu
		
		Notes:
		* to make the menu item active, add a class 'active' to the <li>
		  example: <li class="active">...</li>
		* multilevel submenu example:
			<li class="mm-dropdown">
			  <a href="#"><span class="mm-text">Submenu item text 1</span></a>
			  <ul>
				<li>...</li>
				<li class="mm-dropdown">
				  <a href="#"><span class="mm-text">Submenu item text 2</span></a>
				  <ul>
					<li>...</li>
					...
				  </ul>
				</li>
				...
			  </ul>
			</li>
-->
	<div id="main-menu" role="navigation">
		<div id="main-menu-inner">
			<div class="menu-content top" id="menu-content-demo">
				<div class="text-bg"><span class="text-semibold">Tutorials</div>
			</div>
			<ul class="navigation">
				<li>
					<a href="${request.contextPath}/tutorials/adminconsole"><i class="menu-icon fa fa-list"></i><span class="mm-text">Admin Console</span></a>
				</li>
				<li>
					<a href="${request.contextPath}/tutorials/authfiltering"><i class="menu-icon fa fa-list"></i><span class="mm-text">Auth Filtering Blacklist</span></a>
				</li>
				<li>
					<a href="${request.contextPath}/tutorials/csrf"><i class="menu-icon fa fa-list"></i><span class="mm-text">CSRF</span></a>
				</li>
				<li>
					<a href="${request.contextPath}/tutorials/infodisclosure"><i class="menu-icon fa fa-list"></i><span class="mm-text">Information Disclosure</span></a>
				</li>
				<li>
					<a href="${request.contextPath}/tutorials/insecuredoa"><i class="menu-icon fa fa-list"></i><span class="mm-text">Insecure Direct Object Access</span></a>
				</li>
				<li>
					<a href="${request.contextPath}/tutorials/insecureredirect"><i class="menu-icon fa fa-list"></i><span class="mm-text">Insecure Redirect</span></a>
				</li>
				<li>
					<a href="${request.contextPath}/tutorials/acclockout"><i class="menu-icon fa fa-list"></i><span class="mm-text">Lack of Account Lockout</span></a>
				</li>
				<li>
					<a href="${request.contextPath}/tutorials/logicflaws"><i class="menu-icon fa fa-list"></i><span class="mm-text">Logic Flaws</span></a>
				</li>
				<li>
					<a href="${request.contextPath}/tutorials/massassign"><i class="menu-icon fa fa-list"></i><span class="mm-text">Mass Assignment</span></a>
				</li>
				<li>
					<a href="${request.contextPath}/tutorials/sessionfixation"><i class="menu-icon fa fa-list"></i><span class="mm-text">Session Fixation</span></a>
				</li>
				<li>
					<a href="${request.contextPath}/tutorials/sessiontimeout"><i class="menu-icon fa fa-list"></i><span class="mm-text">Session Timeout</span></a>
				</li>
				<li>
					<a href="${request.contextPath}/tutorials/sqlinjection"><i class="menu-icon fa fa-list"></i><span class="mm-text">SQL/HQL injection</span></a>
				</li>
				<li>
					<a href="${request.contextPath}/tutorials/usernameenumeration"><i class="menu-icon fa fa-list"></i><span class="mm-text">Username Enumeration</span></a>
				</li>
				<li>
					<a href="${request.contextPath}/tutorials/validators"><i class="menu-icon fa fa-list"></i><span class="mm-text">Validators</span></a>
				</li>
				<li>
					<a href="${request.contextPath}/tutorials/weakcomplexity"><i class="menu-icon fa fa-list"></i><span class="mm-text">Weak Complexity</span></a>
				</li>
				<li>
					<a href="${request.contextPath}/tutorials/xssdom"><i class="menu-icon fa fa-list"></i><span class="mm-text">XSS - DOM Based</span></a>
				</li>
				<li>
					<a href="${request.contextPath}/tutorials/xssgsp"><i class="menu-icon fa fa-list"></i><span class="mm-text">XSS - GSP Template</span></a>
				</li>
				<li>
					<a href="${request.contextPath}/tutorials/xssjs"><i class="menu-icon fa fa-list"></i><span class="mm-text">XSS - JS Context</span></a>
				</li>
			</ul>
			<div class="menu-content">
				<a href="${request.contextPath}/" class="btn btn-primary btn-block btn-outline dark">Back to Main Site</a>
			</div>
		</div> <!-- / #main-menu-inner -->
	</div> <!-- / #main-menu -->
<!-- /4. $MAIN_MENU -->


	<div id="content-wrapper">
	<g:layoutBody/>

	</div> <!-- / #content-wrapper -->
	<div id="main-menu-bg"></div>
</div> <!-- / #main-wrapper -->

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
	init.push(function () {
	})
	window.PixelAdmin.start(init);
</script>

</body>
</html>