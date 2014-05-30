<html>
	<head>
		<title>Upload Resume - Find Me A Job</title>
		<meta name="layout" content="loggedin" />
	</head>
<body>
		<div class="page-header">
			<h1><span class="text-light-gray">My Profile / </span>Upload Resume</h1>
		</div> <!-- / .page-header -->

		<div class="row">
			<div class="col-sm-12">

<!-- 14. $DROPZONEJS_FILE_UPLOADS ==================================================================

				Dropzone.js file uploads
-->
				<!-- Javascript -->
				<script>
					init.push(function () {
						$("#dropzonejs-example").dropzone({
							url: "${request.contextPath}/profile/resume",
							paramName: "file", // The name that will be used to transfer the file
							maxFilesize: 5.0, // MB

							addRemoveLinks : false,
							dictResponseError: "Can't upload file!",
							autoProcessQueue: true,
							thumbnailWidth: 138,
							thumbnailHeight: 120,
							uploadMultiple: false,

							previewTemplate: '<div class="dz-preview dz-file-preview"><div class="dz-details"><div class="dz-filename"><span data-dz-name></span></div><div class="dz-size">File size: <span data-dz-size></span></div><div class="dz-thumbnail-wrapper"><div class="dz-thumbnail"><img data-dz-thumbnail><span class="dz-nopreview">No preview</span><div class="dz-success-mark"><i class="fa fa-check-circle-o"></i></div><div class="dz-error-mark"><i class="fa fa-times-circle-o"></i></div><div class="dz-error-message"><span data-dz-errormessage></span></div></div></div></div><div class="progress progress-striped active"><div class="progress-bar progress-bar-success" data-dz-uploadprogress></div></div></div>',
						});
					});
				</script>
				<!-- / Javascript -->

				<div class="panel">
					<div class="panel-heading">
						<span class="panel-title">Upload your resume</span>
					</div>
					<div class="panel-body">
						<div class="note note-info">You can upload your resume using the form below. It will automatically be uploaded and attached to your account</div>

						<div id="dropzonejs-example" class="dropzone-box">
							<div class="dz-default dz-message">
								<i class="fa fa-cloud-upload"></i>
								Drop files in here<br><span class="dz-text-small">or click to pick manually</span>
							</div>
							<form action="${request.contextPath}/profile/resume">
								<div class="fallback">
									<input name="file" type="file" multiple="" />
								</div>
							</form>
						</div>
					</div>
				</div>
<!-- /14. $DROPZONEJS_FILE_UPLOADS -->

			</div>
		</div>
</body>
</html>