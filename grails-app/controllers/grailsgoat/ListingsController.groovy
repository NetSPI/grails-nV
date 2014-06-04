package grailsgoat

class ListingsController {

    def index() { 
    	if (request.post) {
    		// why are they posting this address?
    		redirect(controller: "main", view: "index")
    	} else {
    		if (params.listing?.isInteger()) {

    			def listing = JobListing.get(params.listing)

    			render(view: "index", model: [listing: listing])
    		}
    	}
    }
}
