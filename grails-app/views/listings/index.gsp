<html>
	<head>
		<title>${listing.name} - Find Me A Job</title>
		<meta name="layout" content="loggedin" />
	</head>
<body>
		<div class="page-header">
			<h1><span class="text-light-gray">Listings / </span>${listing.name}</h1>
		</div> <!-- / .page-header -->

		<g:if test="${can_edit}">
			<div class="row"><div class="col-sm-4"><a href="${request.contextPath}/listings/${listing.id}/edit"><button class="btn btn-labeled btn-primary"><span class="btn-label icon fa fa-plus"></span>Edit Listing</button></a></div></div><br />
		</g:if>
	 	<div class="profile-row">
			<div class="">
				
				<g:if test="${listing.description}">
				<div class="panel panel-transparent">
					<div class="panel-heading">
						<span class="panel-title">Listing Description</span>
					</div>
					<div class="panel-body">
						${listing.description}<br><br>
					</div>
				</div>
				</g:if>

				<g:if test="${listing.requirements}">
				<div class="panel panel-transparent">
					<div class="panel-heading">
						<span class="panel-title">Requirements</span>
					</div>
					<div class="panel-body">
						${listing.requirements}<br><br>
					</div>
				</div>
				</g:if>

				<g:if test="${listing.howtoapply}">
				<div class="panel panel-transparent">
					<div class="panel-heading">
						<span class="panel-title">How to Apply</span>
					</div>
					<div class="panel-body">
						${listing.howtoapply}<br><br>
					</div>
				</div>
				</g:if>

				<div class="panel panel-transparent">
					<div class="panel-heading">
						<span class="panel-title">Other Information</span>
					</div>
					<div class="list-group">
						<a href="#" class="list-group-item"><i class="profile-list-icon fa fa-map-marker" style="color: #4ab6d5"></i> Location: <g:if test="${listing.location}">${listing.location}</g:if><g:else>(unknown)</g:else></a>
						<a href="#" class="list-group-item"><i class="profile-list-icon fa fa-check-square" style="color: #1a7ab9"></i> Type: <g:if test="${listing.fulltime}">full time</g:if><g:else>part time</g:else></a>
						<a href="#" class="list-group-item"><i class="profile-list-icon fa fa-calendar" style="color: #888"></i> Starts: <g:if test="${listing.startdate}">${listing.startdate.format("MMMM dd, yyyy")}</g:if><g:else>(unknown)</g:else></a>
					</div>
				</div>

			</div>
		</div>
</body>
</html>