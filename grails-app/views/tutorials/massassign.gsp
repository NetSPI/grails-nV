<html>
    <head>
        <title>Mass Assignment - grails_nV</title>
        <meta name="layout" content="tutorials" />
    </head>
    <body>
		<div class="page-header">
			<h1><span class="text-light-gray">Tutorials / </span>Mass Assignment</h1>
		</div> <!-- / .page-header -->
			<div class="col-sm-12">
				<div class="panel-group panel-group-success" id="vuln-accordion">
					<div class="panel">
						<div class="panel-heading">
							<a class="accordion-toggle" data-toggle="collapse" data-parent="#vuln-accordion" href="#collapseDescription">
								Description
							</a>
						</div> <!-- / .panel-heading -->
						<div id="collapseDescription" class="panel-collapse in">
							<div class="panel-body">
								Mass Assignment is a vulnerability where the ORM or database access layer is manipulated into updating different fields in a database table. Often times, this vulnerability is used to access fields not normally meant to be accessed - changing user permissions or access level, for exmaple. In recent years, Mass Assignment attacks have been executed against many popular frameworks and web languages, such as Ruby on Rails. In Grails, this usually involves updating fields in a database domain that were not intended to be accessed by the programmer by directly accessing the <code>properties</code> member on the object.
							</div> <!-- / .panel-body -->
						</div> <!-- / .collapse -->
					</div> <!-- / .panel -->

					<div class="panel">
						<div class="panel-heading">
							<a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#vuln-accordion" href="#collapseHint">
								Hint
							</a>
						</div> <!-- / .panel-heading -->
						<div id="collapseHint" class="panel-collapse collapse">
							<div class="panel-body">
								Where can we update a bunch of User fields at the same time?
							</div> <!-- / .panel-body -->
						</div> <!-- / .collapse -->
					</div> <!-- / .panel -->

					<div class="panel">
						<div class="panel-heading">
							<a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#vuln-accordion" href="#collapseBug">
								Problem
							</a>
						</div> <!-- / .panel-heading -->
						<div id="collapseBug" class="panel-collapse collapse">
							<div class="panel-body">
								By default, the developer who created the edit profile page decided to take the easy way out. Rather than updating
								all the fields of the class at once, he or she chose to to simply update them all by overwriting the fields of the
								user class! To prevent anyone from setting whatever fields they wanted, though, the fields being updated are checked.
								<pre class="line-numbers"><code class="language-groovy">if (params.firstname && params.lastname && params.description && params.ssn && params.email && params.password && params.passwordconfirm && params.id?.isInteger()) {
    def new_data = params

    /* ... */

    def user = User.get(params.id)

    if (user && ...) {
        user.properties = new_data
        user.save(flush: true)

        session.user = user

        flash.success = "Your profile has been updated successfully"
        render(view: "edit", model: [user: user])
        return
    }
}
</code></pre>
							</div> <!-- / .panel-body -->
						</div> <!-- / .collapse -->
					</div> <!-- / .panel -->

					<div class="panel">
						<div class="panel-heading">
							<a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#vuln-accordion" href="#collapseSolution">
								Solution
							</a>
						</div> <!-- / .panel-heading -->
						<div id="collapseSolution" class="panel-collapse collapse">
							<div class="panel-body">
								In order to prevent mass assignment, it is not sufficient only to ensure that the fields you want to update ARE present.
								The code must also ensure that the ONLY values are the ones you wish to update. In Grails, the easiest way to ensure
								mass assignment calls are secure is to use the <code>bindData()</code> function. <code>bindData()</code> ensures only the desired values are either included or excluded, so you can be sure of exactly which fields will be changed.
								<pre class="line-numbers"><code class="language-groovy">def new_data = params

/* ... */

def user = User.get(params.id)

if (user && ...) {
	bindData(user, new_data, [include: ['firstname', 'lastname', 'description', 'ssn', 'email', 'password'], exclude: ['accesslevel', ...]])
    user.properties = new_data
    user.save(flush: true)

    session.user = user

    flash.success = "Your profile has been updated successfully"
    render(view: "edit", model: [user: user])
    return
}</code></pre>
							</div> <!-- / .panel-body -->
						</div> <!-- / .collapse -->
					</div> <!-- / .panel -->

			</div> <!-- / .panel-group -->
</body>
</html>