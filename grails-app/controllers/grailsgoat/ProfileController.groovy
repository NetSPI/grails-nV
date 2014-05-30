package grailsgoat

class ProfileController {

    def index() { 
        if (params.id) {
            if (params.id.isInteger()) {
                // Show the specific user ID
                def userdata = User.get(params.id)

                if (userdata != null) {
                    render(view: "profile", model: [user: userdata])
                    return
                }
            }
        } else {
            def userdata = User.get(session.user.id)

            if (userdata != null) {
                render(view: "profile", model: [user: userdata])
                return
            }
        }

        // The user didn't exist
        redirect(controller: "main", view: "index")
    }

    def update() {
    	if (request.post) {
    		// Post request
    	} else {
    		// Why are they GETting this URL?
    		redirect(controller: "main", action: "index")
    	}
    }
}
