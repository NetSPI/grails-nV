package grails_nV

class CompaniesController {

    def index() {
    	render(view: "index", model: [companies: Company.getAll(), can_create: (User.get(session.user.id).accesslevel > 0), user_employer_id: User.get(session.user.id).employer?.id])
    }

    def create() {
    	if (request.post) {
    		if (params.name && params.description && params.website) {
    			// There are no real requirements for any of these
    			def company = new Company(name: params.name, description: params.description, website: params.website)

                // User has to be admin to add a company to the system
                if (User.get(session.user.id).accesslevel == 0) {
                    flash.error = "Unable to add company"
                    redirect(view: "index")
                    return
                }

    			if (!company.save(flush: true)) {
    				flash.error = "Unable to create company"
    				render(view: "create")
    				return
    			}
    			flash.success = company.name + " was added to the database"
    			redirect(view: "index")
    			return
    		}
	    	flash.error = "Unable to create company"

			render(view: "create")
			return
    	} else {

            // User has to be admin to add a company to the system
            if (User.get(session.user.id).accesslevel == 0) {
                flash.error = "Unable to add company"
                redirect(view: "index")
                return
            }

    		render(view: "create")
    		return
    	}
    }

    def edit() {
    	if (request.post) {
    		if (params.id?.isInteger() && params.name && params.description && params.website) {
    			// There are no real requirements for any of these
    			def company = Company.get(params.id)

                // User has to be part of the company, or an admin, to edit it
                if (User.get(session.user.id)?.employer?.id != company.id && User.get(session.user.id).accesslevel == 0) {
                    flash.error = "Unable to update company"
                    redirect(view: "index")
                    return
                }

    			if (company) {
    				company.name = params.name
    				company.description = params.description
    				company.website = params.website

    				company.save(flush: true)
    				flash.success = company.name + " was updated in the database"
    				redirect(view: "index")
    				return
    			}
    		}
	    	flash.error = "Unable to update company"
			redirect(view: "update")
			return
    	} else {
    		if (params.id?.isInteger()) {
				def company = Company.get(params.id)

                // User has to be part of the company to edit it
                if (User.get(session.user.id)?.employer?.id != company.id && User.get(session.user.id).accesslevel == 0) {
                    flash.error = "Unable to update company"
                    redirect(view: "index")
                    return
                }

				render(view: "update", model: [company: company])
				return
			} else {
				redirect(view: "index")
				return
			}
    	}
    }
}