package grails_nV

class ListingsController {

    def index() { 
    	if (request.post) {
    		// why are they posting this address?
    		redirect(controller: "main", view: "index")
    	} else {
    		if (params.listing?.isInteger()) {

    			def listing = JobListing.get(params.listing)

    			render(view: "index", model: [listing: listing, can_edit: (User.get(session.user.id).employer?.id == listing.company.id || User.get(session.user.id).accesslevel > 0)])
                return
    		}
    	}

        // Let's just propogate these because this isn't a real page...
        flash.error = flash.error
        flash.success = flash.success
        flash.employer_set = User.get(session.user.id).employer
        redirect(controller: "main", view: "index")
    }

    def create() {

        def user_employer = User.get(session.user.id).employer

        // User has to be part of the company to edit it
        if (!user_employer) {
            flash.error = "Unable to create job listing"
            redirect(view: "index")
            return
        }

        if (request.post) {
            if (params.name && params.description && params.requirements && params.howtoapply && params.location && params.startdate && params.fulltime) {

                def newdate = new Date().parse("yyyy-M-d'T'H:m", params.startdate)

                def listing = new JobListing(name: params.name, description: params.description, requirements: params.requirements, howtoapply: params.howtoapply, location: params.location, startdate: newdate, fulltime: params.fulltime == 1 ? true : false)

                user_employer.addToJoblistings(listing).save()
                if (!listing.save(flush: true)) {

                    flash.error = "Unable to create job listing"
                    render(view: "create", model: [company: user_employer])
                    return
                }
                flash.success = listing.name + " was added to the database"
                redirect(view: "index")
                return
            }
            flash.error = "Unable to create job listing"

            render(view: "create", model: [company: user_employer])
            return
        } else {
            render(view: "create", model: [company: user_employer])
            return
        }
    }

    def edit() {
        if (request.post) {
            if (params.listing?.isInteger() && params.name && params.description && params.requirements && params.howtoapply && params.location && params.startdate && params.fulltime) {

                def listing = JobListing.get(params.listing)

                // User has to be part of the company to edit it
                if (User.get(session.user.id)?.employer?.id != listing.company.id && User.get(session.user.id)?.accesslevel == 0) {
                    flash.error = "Unable to update job listing"
                    redirect(view: "index")
                    return
                }

                if (listing) {
                    listing.name = params.name
                    listing.description = params.description
                    listing.requirements = params.requirements
                    listing.howtoapply = params.howtoapply
                    listing.location = params.location
                    listing.startdate = new Date().parse("yyyy-M-d'T'H:m", params.startdate)
                    listing.fulltime = params.fulltime.equals("1") ? true : false

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
            if (params.listing?.isInteger()) {

                def listing = JobListing.get(params.listing)

                // User has to be part of the company to edit it
                if (User.get(session.user.id)?.employer?.id != listing.company.id && User.get(session.user.id)?.accesslevel == 0) {
                    flash.error = "Unable to update job listing"
                    redirect(view: "index")
                    return
                }

                // We need to specially format the date
                def dateformatted = listing.startdate.format("yyyy-MM-dd'T'HH:mm")

                render(view: "update", model: [listing: listing, dateformatted: dateformatted])
                return
            } else {
                redirect(view: "index")
                return
            }
        }
    }

    def search() {
        if (params.q) {
            def searched = new String(params.q.decodeBase64())
            def listings = JobListing.withCriteria {
                ilike('name', "%${searched}%")
            }
            render(view: "search", model: [query: searched, listings: listings])
            return
        }
        flash.error = "Unable to search listings"
        redirect(view: "index")
        return
    }
}
