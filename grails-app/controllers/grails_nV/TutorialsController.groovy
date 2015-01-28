package grails_nV

class TutorialsController {

    def index() { 
    	render(view: "index.gsp")
    }

    def tutorial() {
    	def tutorial_list = [
    	"adminconsole",
		"authfiltering",
		"csrf",
		"infodisclosure",
		"insecuredoa",
		"insecureredirect",
		"acclockout",
		"logicflaws",
		"massassign",
		"sessionfixation",
		"sessiontimeout",
		"sqlinjection",
		"usernameenumeration",
		"validators",
		"weakcomplexity",
		"xssdom",
		"xssgsp",
		"xssjs"
    	]

    	if (params.which) {
    		if (tutorial_list.contains(params.which)) {
    			render(view: params.which + ".gsp")
    		}
    	} else {
    		render(view: "index.gsp")
    	}
    }
}
