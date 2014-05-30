class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"
        {
            controller = "main"
        }
        "/logout"
        {
            controller = "session"
            action = "logout"
        }
        "/profile/edit/$id?"
        {
            controller = "profile"
            action = "edit"
        }
        "/profile/($id)?"
        {
            controller = "profile"
            action = "index"
        }
        "/profile/resume"
        {
            controller = "profile"
            action = "resume"
        }
        "500"(view:'/error')
	}
}
