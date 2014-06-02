<html>
	<head>
		<title>My Profile - Find Me A Job</title>
		<meta name="layout" content="loggedin" />
	</head>
<body>
		<div class="page-header">
			<h1><span class="text-light-gray"><g:if test="${session.user.id == user.id}">My </g:if>Profile / </span>View</h1>
		</div> <!-- / .page-header -->

		<div class="profile-full-name">
			<span class="text-semibold">${user.firstname} ${user.lastname}</span>'s profile
		</div>
	 	<div class="profile-row">
			<div class="">
				<div class="profile-block">
					<div class="panel profile-photo">
						<asset:image src="demo/avatars/5.jpg" alt=""/>
					</div>
					<a href="${request.contextPath}/messages/sendto/${user.id}" class="btn"><i class="fa fa-comment"> Message This User</i></a>
				</div>
				
				<div class="panel panel-transparent">
					<div class="panel-heading">
						<span class="panel-title">About Me</span>
					</div>
					<div class="panel-body">
						<g:if test="${user.description}">${user.description}</g:if><g:else>[User has no description]</g:else><br><br>
						<g:if test="${user.resume}"><p><a href="${request.contextPath}/uploads/${user.resume}">Download My Resume</a></p></g:if>
					</div>
				</div>

				<div class="panel panel-transparent">
					<div class="panel-heading">
						<span class="panel-title">Statistics</span>
					</div>
					<div class="list-group">
						<a href="#" class="list-group-item"><strong>126</strong> Likes</a>
						<a href="#" class="list-group-item"><strong>579</strong> Followers</a>
						<a href="#" class="list-group-item"><strong>100</strong> Following</a>
					</div>
				</div>

				<div class="panel panel-transparent profile-skills">
					<div class="panel-heading">
						<span class="panel-title">Skills</span>
					</div>
					<div class="panel-body">
						<span class="label label-primary">UI/UX</span>
						<span class="label label-primary">Web design</span>
						<span class="label label-primary">Photoshop</span>
						<span class="label label-primary">HTML</span>
						<span class="label label-primary">CSS</span>
					</div>
				</div>

				<div class="panel panel-transparent">
					<div class="panel-heading">
						<span class="panel-title">Social</span>
					</div>
					<div class="list-group">
						<a href="#" class="list-group-item"><i class="profile-list-icon fa fa-twitter" style="color: #4ab6d5"></i> @dsteiner</a>
						<a href="#" class="list-group-item"><i class="profile-list-icon fa fa-facebook-square" style="color: #1a7ab9"></i> Denise Steiner</a>
						<a href="#" class="list-group-item"><i class="profile-list-icon fa fa-envelope" style="color: #888"></i> dsteiner@example.com</a>
					</div>
				</div>

			</div>
		</div>
</body>
</html>