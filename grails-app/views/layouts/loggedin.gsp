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
				<a href="${request.contextPath}/" class="navbar-brand">
					<div><asset:image alt="Pixel Admin" src="pixel-admin/main-navbar-logo.png"/></div>
					FindMeAJob
				</a>

				<!-- Main navbar toggle -->
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#main-navbar-collapse"><i class="navbar-icon fa fa-bars"></i></button>

			</div> <!-- / .navbar-header -->

			<div id="main-navbar-collapse" class="collapse navbar-collapse main-navbar-collapse">
				<div>
					<div class="right clearfix">
						<ul class="nav navbar-nav pull-right right-navbar-nav">
							<li class="dropdown">
								<a href="#" class="dropdown-toggle user-menu" data-toggle="dropdown">
									<asset:image src="pixel-admin/default.jpg"/>
									<span>${session.user?.firstname} ${session.user?.lastname}</span>
								</a>
								<ul class="dropdown-menu">
									<li><a href="${request.contextPath}/profile/${session.user?.id}">My Profile</a></li>
									<li><a href="${request.contextPath}/tutorials"><i class="dropdown-icon fa fa-cog"></i>&nbsp;&nbsp;Tutorial</a></li>
									<g:if test="${session.user?.accesslevel > 0}"><li><a href="${request.contextPath}/admin"><i class="dropdown-icon fa fa-user"></i>&nbsp;&nbsp;Admin Panel</a></li></g:if>
									<li class="divider"></li>
									<li><a href="${request.contextPath}/logout"><i class="dropdown-icon fa fa-power-off"></i>&nbsp;&nbsp;Log Out</a></li>
								</ul>
							</li>
						</ul> <!-- / .navbar-nav -->
					</div> <!-- / .right -->
				</div>
			</div> <!-- / #main-navbar-collapse -->
		</div> <!-- / .navbar-inner -->
	</div> <!-- / #main-navbar -->
<!-- /2. $END_MAIN_NAVIGATION -->


<!-- 4. $MAIN_MENU ================================================================================= -->
	<div id="main-menu" role="navigation">
		<div id="main-menu-inner">
			<div class="menu-content top" id="menu-content-demo">
				<div>
					<div class="text-bg"><span class="text-slim">Welcome,</span> <span class="text-semibold">${session.user?.firstname}<br></span><g:if test="${session.user?.accesslevel > 0}"><span class="text-slim">(site admin)</span></g:if></div>

					<asset:image src="pixel-admin/default.jpg" alt="" class=""/>
					<div class="btn-group">
						<a href="#" class="btn btn-xs btn-primary btn-outline dark"><i class="fa fa-envelope"></i></a>
						<a href="#" class="btn btn-xs btn-primary btn-outline dark"><i class="fa fa-user"></i></a>
						<a href="#" class="btn btn-xs btn-primary btn-outline dark"><i class="fa fa-cog"></i></a>
						<a href="#" class="btn btn-xs btn-danger btn-outline dark"><i class="fa fa-power-off"></i></a>
					</div>
					<a href="#" class="close">&times;</a>
				</div>
			</div>
			<ul class="navigation">
				<li>
					<a href="${request.contextPath}/"><i class="menu-icon fa fa-list"></i><span class="mm-text">Listings</span></a>
				</li>
				<li class="mm-dropdown mm-dropdown-root active">
					<a href="${request.contextPath}/profile/"><i class="menu-icon fa fa-user"></i><span class="mm-text">Profile</span></a>
					<ul>
						<li>
							<a tabindex="-1" href="${request.contextPath}/profile/"><span class="mm-text">My Profile</span></a>
						</li>
						<li>
							<a tabindex="-1" href="${request.contextPath}/profile/edit/${session.user?.id}"><span class="mm-text">Edit Profile</span></a>
						</li>
						<li>
							<a tabindex="-1" href="${request.contextPath}/profile/resume/"><span class="mm-text">Upload Resume</span></a>
						</li>
					</ul>
				</li>
				<li>
					<a href="${request.contextPath}/companies/"><i class="menu-icon fa fa-list"></i><span class="mm-text">Companies</span></a>
				</li>
				<li class="mm-dropdown mm-dropdown-root active">
					<a href="${request.contextPath}/messages/"><i class="menu-icon fa fa-envelope"></i><span class="mm-text">Messages</span></a>
					<ul>
						<li>
						<a tabindex="-1" href="${request.contextPath}/messages/"><span class="mm-text">My Messages</span></a>
						</li>
						<li>
							<a tabindex="-1" href="${request.contextPath}/messages/send/"><span class="mm-text">New Message</span></a>
						</li>
					</ul>
				</li>
				<g:if test="${session.user.accesslevel.equals(1)}">
				<li>
					<a href="${request.contextPath}/user-management/"><i class="menu-icon fa fa-user"></i><span class="mm-text">User Management</span></a>
				</li>
			</g:if>
			<div class="menu-content">
				<a href="${request.contextPath}/tutorials" class="btn btn-primary btn-block btn-outline dark">Tutorial</a>
			</div>
			<div class="menu-content">
				<button id="lang" class="btn btn-primary btn-block btn-outline dark btn-xs btn-danger">Switch to Spanish</button>
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
		// Javascript code here
		var hashParam = location.hash.split("#")[1];

		$("#lang").click();

		$( "#lang" ).click(function() {
			if (location.hash.length > 0) {
			hashParam = location.hash.split("#")[1];
				// Unfortunately, we don't have spanish support yet :(
				if (hashParam.length > 0) {
					$(this).html("Switch to " + hashParam);
					if (hashParam === "English") {
						location.hash = "Spanish";
					} else {
						location.hash = "English";
					}
				}
			} else {
				location.hash = "Spanish";
				$(this).html("Switch to English");
			}
  		});
	})
	window.PixelAdmin.start(init);
</script>

</body>
</html>