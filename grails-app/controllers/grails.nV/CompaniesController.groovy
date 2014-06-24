package grails.nV

class CompaniesController {

    def index() {
    	def companies = [companies: Company.getAll()]

    	render(view: "index", model: companies)
    }

    def create() {
    	if (request.post) {
    		if (params.name && params.description && params.website) {
    			// There are no real requirements for any of these
    			def company = new Company(name: params.name, description: params.description, website: params.website)
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
    		render(view: "create")
    		return
    	}
    }

    def edit() {
    	if (request.post) {
    		if (params.id?.isInteger() && params.name && params.description && params.website) {
    			// There are no real requirements for any of these
    			def company = Company.get(params.id)

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
				render(view: "update", model: [company: company])
				return
			} else {
				redirect(view: "index")
				return
			}
    	}
    }
}