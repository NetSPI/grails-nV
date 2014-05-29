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
        "500"(view:'/error')
	}
}
