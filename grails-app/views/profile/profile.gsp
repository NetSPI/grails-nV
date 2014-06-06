<html>
	<head>
		<title>My Profile - Find Me A Job</title>
		<meta name="layout" content="loggedin" />
	</head>
<body>
		<div class="page-header">
			<h1><span class="text-light-gray"><g:if test="${session.user.id == user.id}">My </g:if>Profile / </span>View <span class="text-light-gray">(#<g:if test="${params.id}">${params.id}</g:if><g:else>${session.user.id}</g:else>)</span></h1>
		</div> <!-- / .page-header -->

		<div class="profile-full-name" style="margin-bottom:10px">
			<span class="text-semibold">${user.firstname} ${user.lastname}</span>'s profile
		</div>
	 	<div class="profile-row">
			<div class="">
				<div class="profile-block" style="width:162px">
					<div class="panel profile-photo">
						<asset:image src="demo/avatars/5.jpg" alt=""/>
					</div>
				</div>
				
				<div class="panel panel-transparent">
					<div class="panel-heading">
						<span class="panel-title">About Me</span>
					</div>
					<div class="panel-body">
						<g:if test="${user.description}">${user.description}</g:if><g:else>[User has no description]</g:else><br><br>
						<g:if test="${user.resume}"><p><a href="${request.contextPath}/uploads/${user.resume}">Download My Resume</a></p></g:if>
						<g:if test="${user.id == session.user.id && user.ssn}">My SSN: ${user.ssn}</g:if><br><br>
					</div>
				</div>
			</div>
		</div>
</body>
</html>