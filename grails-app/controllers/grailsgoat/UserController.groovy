package grailsgoat

class UserController {

	def index() {
		// TODO: Check if the user is already signed in
		redirect(action: "signin")
	}

    def signin() { 
    	render(view: "signin")
    }

    def login() {
    	redirect(actoin: "signin")
    }

    def register() {
    	render(view: "signup")
    }

    def signup() {
    	redirect(action: "register")
    }
}
