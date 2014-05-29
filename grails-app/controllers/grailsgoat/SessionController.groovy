package grailsgoat

class SessionController {

    def index() { 
    	render  "Hello testing"
    }

    def logout() {
    	session.invalidate()
    	redirect(controller: "user", action: "login")
    }
}
