package grails_nV

import grails.converters.JSON

class MainController {

    def index() { 

    	// At this point the user is logged in. Let's pull all the job listings

    	def listings = JobListing.getAll()

    	def listings_lookup = listings.collectEntries { [it.name + it.description, it.id] }

    	render(view: "index", model: [listings: listings, listings_lookup: (listings_lookup as JSON).toString()])
    }
}