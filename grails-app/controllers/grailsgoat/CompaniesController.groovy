package grailsgoat

class CompaniesController {

    def index() {
    	def companies = [companies: Company.getAll()]

    	render(view: "index", model: companies)
    }
}