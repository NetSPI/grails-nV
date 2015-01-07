class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/tutorials/($which)?"
        {
            controller = "tutorials"
            action = "tutorial"
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

        "/listings/create"
        {
            controller = "listings"
            action = "create"
        }

        "/listings/search"
        {
            controller = "listings"
            action = "search"
        }

        "/listings/($listing)?"
        {
            controller = "listings"
            action = "index"
        }
        
        "/listings/($listing)?/edit"
        {
            controller = "listings"
            action = "edit"
        }

        "/profile/edit/$id?"
        {
            controller = "profile"
            action = "edit"
        }

        "/profile/"
        {
            controller = "profile"
            action = "index"
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

        "/messages/send/($messageid)?"
        {
            controller = "messages"
            action = "send"
        }

        "/messages/sendto/($userid)?"
        {
            controller = "messages"
            action = "sendto"
        }

        "/companies/edit/$id?"
        {
            controller = "company"
            action = "edit"
        }

        "/user-management"
        {
            controller = "admin"
            action = "index"
        }

        "/user-management/edit/$id?"
        {
            controller = "admin"
            action = "edit"
        }

        "500"(view:'/error')
	}
}
