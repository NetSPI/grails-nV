package grails.nV

class ListingsController {

    def index() { 
    	if (request.post) {
    		// why are they posting this address?
    		redirect(controller: "main", view: "index")
    	} else {
    		if (params.listing?.isInteger()) {

    			def listing = JobListing.get(params.listing)

    			render(view: "index", model: [listing: listing])
                return
    		}
    	}
        redirect(controller: "main", view: "index")
    }

    def create() {
        if (request.post) {
            if (params.companyid?.isInteger() && params.name && params.description && params.requirements && params.howtoapply && params.location && params.startdate && params.fulltime) {
                def newdate = new Date().parse("yyyy-M-d'T'H:m", params.startdate)

                def listing = new JobListing(name: params.name, description: params.description, requirements: params.requirements, howtoapply: params.howtoapply, location: params.location, startdate: newdate, fulltime: params.fulltime == 1 ? true : false)

                Company.get(params.companyid).addToJoblistings(listing).save()
                if (!listing.save(flush: true)) {
                    listing.errors.each {
                        println it
                    }
                    flash.error = "Unable to create job listing"
                    render(view: "create", model: [companies: Company.getAll()])
                    return
                }
                flash.success = listing.name + " was added to the database"
                redirect(view: "index")
                return
            }
            flash.error = "Unable to create job listing"

            render(view: "create", model: [companies: Company.getAll()])
            return
        } else {
            render(view: "create", model: [companies: Company.getAll()])
            return
        }
    }

    def edit() {
        if (request.post) {
            if (params.id?.isInteger() && params.name && params.description && params.website) {
                // There are no real requirements for any of these
                def listing = JobListing.get(params.id)

                if (listing) {
                    listing.name = params.name
                    listing.description = params.description
                    listing.requirements = params.requirements
                    listing.howtoapply = params.howtoapply
                    listing.startdate = params.startdate
                    listing.fulltime = params.fulltime == 1 ? true : false

                    listing.save(flush: true)
                    flash.success = listing.name + " was updated in the database"
                    redirect(view: "index")
                    return
                }
            }
            flash.error = "Unable to update job listing"
            redirect(view: "update")
            return
        } else {
            if (params.id?.isInteger()) {
                def listing = JobListing.get(params.id)
                render(view: "update", model: [listing: listing])
                return
            } else {
                redirect(view: "index")
                return
            }
        }
    }
}
