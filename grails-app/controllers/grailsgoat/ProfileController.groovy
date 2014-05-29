package grailsgoat

class ProfileController {

    def index() { 
    	render(view: "profile")
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
