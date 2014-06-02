<html>
	<head>
		<title>Send Message - Find Me A Job</title>
		<meta name="layout" content="loggedin" />
	</head>
<body>
		<div class="page-header">
			<h1><span class="text-light-gray">Messages / </span>Send Message</h1>
		</div> <!-- / .page-header -->

		<div class="row">
			<div class="col-sm-12">

				<script>
					init.push(function () {
						// Setup validation
						$("#jq-validation-form").validate({
							ignore: '.ignore, .select2-input',
							focusInvalid: false,
							rules: {
								'recipient': {
									required: true
								},
								'subject': {
									required: true
								},
								'body': {
									maxLength: 3000
								},
							},
							messages: {
								'recipient': 'You must choose a valid user to message',
								'subject': 'You must enter a valid subject',
								'body': 'Your message must be under 3000 characters',
							}
						});
					});
				</script>
				<div class="panel">
					<div class="panel-heading">
						<span class="panel-title">Send Message</span>
					</div>
					<div class="panel-body">
						<g:if test="${flash.error}"><div class="note note-error">${flash.error}</div></g:if><g:if test="${flash.success}"><div class="note note-success">${flash.success}</div></g:if>
						<form class="form-horizontal" id="jq-validation-form" action="${request.contextPath}/messages/send" method="post">

							<div class="form-group">
								<label for="firstnamevalid" class="col-sm-3 control-label">To</label>
								<div class="col-sm-9">
									<g:select name="recipient" id="recipient" from="${flash.users}" optionKey="id" optionValue="fullname" value="${flash.recipient_id}"/>
								</div>
							</div>

							<div class="form-group">
								<label for="firstnamevalid" class="col-sm-3 control-label">Subject</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="subject" name="subject" placeholder="Subject" <g:if test="${flash.subject}">value="${flash.subject}" readonly</g:if>>
								</div>
							</div>

							<div class="form-group">
								<label for="firstnamevalid" class="col-sm-3 control-label">Body</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="body" name="body" placeholder="Body">
								</div>
							</div>

							<div class="form-group">
								<div class="col-sm-offset-3 col-sm-9">
									<button type="submit" class="btn btn-primary">Send</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
</body>
</html>