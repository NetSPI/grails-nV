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
							url: "//dummy.html",
							paramName: "file", // The name that will be used to transfer the file
							maxFilesize: 0.5, // MB

							addRemoveLinks : true,
							dictResponseError: "Can't upload file!",
							autoProcessQueue: false,
							thumbnailWidth: 138,
							thumbnailHeight: 120,

							previewTemplate: '<div class="dz-preview dz-file-preview"><div class="dz-details"><div class="dz-filename"><span data-dz-name></span></div><div class="dz-size">File size: <span data-dz-size></span></div><div class="dz-thumbnail-wrapper"><div class="dz-thumbnail"><img data-dz-thumbnail><span class="dz-nopreview">No preview</span><div class="dz-success-mark"><i class="fa fa-check-circle-o"></i></div><div class="dz-error-mark"><i class="fa fa-times-circle-o"></i></div><div class="dz-error-message"><span data-dz-errormessage></span></div></div></div></div><div class="progress progress-striped active"><div class="progress-bar progress-bar-success" data-dz-uploadprogress></div></div></div>',

							resize: function(file) {
								var info = { srcX: 0, srcY: 0, srcWidth: file.width, srcHeight: file.height },
									srcRatio = file.width / file.height;
								if (file.height > this.options.thumbnailHeight || file.width > this.options.thumbnailWidth) {
									info.trgHeight = this.options.thumbnailHeight;
									info.trgWidth = info.trgHeight * srcRatio;
									if (info.trgWidth > this.options.thumbnailWidth) {
										info.trgWidth = this.options.thumbnailWidth;
										info.trgHeight = info.trgWidth / srcRatio;
									}
								} else {
									info.trgHeight = file.height;
									info.trgWidth = file.width;
								}
								return info;
							}
						});
					});
				</script>
				<!-- / Javascript -->

				<div class="panel">
					<div class="panel-heading">
						<span class="panel-title">Dropzone.js file uploads</span>
					</div>
					<div class="panel-body">
						<div class="note note-info">More info and examples at <a href="http://www.dropzonejs.com" target="_blank">http://www.dropzonejs.com</a></div>

						<div id="dropzonejs-example" class="dropzone-box">
							<div class="dz-default dz-message">
								<i class="fa fa-cloud-upload"></i>
								Drop files in here<br><span class="dz-text-small">or click to pick manually</span>
							</div>
							<form action="//dummy">
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