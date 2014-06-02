package grailsgoat

class ListingsController {

    def index() { 
    	if (request.post) {
    		// why are they posting this address?
    		redirect(controller: "main", view: "index")
    	} else {
    		render "test"
    	}
    }
}
