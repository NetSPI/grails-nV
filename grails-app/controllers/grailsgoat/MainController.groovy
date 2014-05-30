package grailsgoat

class MainController {

    def index() { 

    	// At this point the user is logged in. Let's pull all the job listings

    	def listings = [listings: JobListing.getAll()]

    	render(view: "index", model: listings)
    }
}
