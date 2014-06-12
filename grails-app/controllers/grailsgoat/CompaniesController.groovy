package grails.nV

class CompaniesController {

    def index() {
    	def companies = [companies: Company.getAll()]

    	render(view: "index", model: companies)
    }
}