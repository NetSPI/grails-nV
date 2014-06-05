<html>
    <head>
        <title>Messages - FindMeAJob</title>
        <meta name="layout" content="loggedin" />
    </head>
    <body>
		<div class="page-header">
			<h1><span class="text-light-gray">My Messages / </span>View</h1>
		</div> <!-- / .page-header -->
		<g:if test="${flash.error}"><div class="note note-error">${flash.error}</div></g:if><g:if test="${flash.success}"><div class="note note-success">${flash.success}</div></g:if>
		<p>This is the inbox of all messages you've received on our website. You can use this system to send and receive messages from recruiters, employers, and fellow job seekers.</p>
		<a href="${request.contextPath}/messages/send/"><button class="btn btn-labeled btn-primary"><span class="btn-label icon fa fa-plus"></span>New Message</button></a><br><br>
		<div class="row">
			<div class="col-sm-12">
				<!-- Javascript -->
				<script>
					init.push(function () {
						$('#jq-datatables-example').dataTable();
						$('#jq-datatables-example_wrapper .dataTables_filter input').attr('placeholder', 'Search...');
					});
				</script>
				<!-- / Javascript -->
				<div class="table-primary">
					<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered" id="jq-datatables-example">
						<thead>
							<tr>
								<th>From</th>
								<th>Subject</th>
								<th>Body</th>
								<th>Reply</th>
							</tr>
						</thead>
						<tbody>
							<g:each in="${messages}" var="message" >
								<tr class="odd gradeC">
									<td>${senders[String.valueOf(message.author_id)]}</td>
									<td>${message.subject}</td>
									<td>${message.body}</td>
									<td><a href="${request.contextPath}/messages/send/${message.id}">Send a Reply</a></td>
							</g:each>
						</tbody>
					</table>
				</div>
			</div>
		</div>
</body>
</html>