<html>
	<head>
		<title>My Profile - Find Me A Job</title>
		<meta name="layout" content="loggedin" />
	</head>
<body>
		<div class="page-header">
			<h1><span class="text-light-gray"><g:if test="${session.user.id == user.id}">My </g:if>Profile / </span>View <span class="text-light-gray">(#<g:if test="${params.id}">${params.id}</g:if><g:else>${session.user.id}</g:else>)</span></h1>
		</div> <!-- / .page-header -->

		<g:if test="${can_edit}">
			<div class="row"><div class="col-sm-4"><a href="${request.contextPath}/<g:if test="${params.id}">user-management</g:if><g:else>profile</g:else>/edit/${user.id}"><button class="btn btn-labeled btn-primary"><span class="btn-label icon fa fa-plus"></span>Edit User</button></a></div></div><br />
		</g:if>

		<div class="profile-full-name" style="margin-bottom:10px">
			<span class="text-semibold">${user.firstname} ${user.lastname}</span>'s profile
		</div>
	 	<div class="profile-row">
			<div class="">
				<div class="profile-block" style="width:152px">
					<div class="panel profile-photo">
						<asset:image src="pixel-admin/default.jpg" alt=""/>
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

<g:if test="${params.id}">user-management</g:if><g:else>profile</g:else>