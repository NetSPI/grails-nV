package grailsgoat

import org.apache.commons.lang.RandomStringUtils

class UserController {

	def index() {
		// TODO: Check if the user is already signed in
		redirect(action: "signin")
	}

    def signin() { 
    	if (request.post) {
    		if (params.signin_email && params.signin_password) {

    			def user_email = params.signin_email
    			def user_password = params.signin_password

    			// Check to see if a user with that email exists in our database
    			def user = User.findWhere(email: user_email)

    			// Let's hash their password first to prevent timing attacks
    			def user_password_md5 = user_password.encodeAsMD5();

    			if (user != null && user_password_md5.equals(user.password)) {
    				// User was validated, so create a session
    				render "Successfully logged in"
    				return
    			}
    		}

    		// Catch-all error
    	    flash.error = "Invalid email or password"
    		render(view: "signin")
    	} else {
    		render(view: "signin")
    	}
    }

    def signup() {
    	if (request.post) {
    		
    		// Make sure their request had all the required fields
    		if (params.signup_firstname && params.signup_lastname && params.signup_email && params.signup_password && params.signup_confirm) {

    			def user_firstname = params.signup_firstname
    			def user_lastname = params.signup_lastname
    			def user_email = params.signup_email
    			def user_password = params.signup_password
    			def user_confirm = params.signup_confirm

    			// Check to see if a user with that email already exists
    			def user = User.findWhere(email: user_email)

    			// Check to see if their passwords match
    			def passwords_match = user_password.equals(user_confirm)

    			// Calculate MD5 of password
    			def user_password_md5 = user_password.encodeAsMD5()

    			if (user == null && passwords_match) {
    				def new_user = new User(email: user_email, firstname: user_firstname, lastname: user_lastname, password: user_password_md5, auth_token: RandomStringUtils.randomAlphanumeric(30))
    				if (!new_user.save(flush: true)) {
    					new_user.errors.each {
        					println it
    					}
					}
    				render "Successfully registered a new account!"
    				return
    			}
    		}

    		flash.error = "Invalid registration"
    		render(view:"signup")

    	} else {
    		render(view: "signup")
    	}
    }

    // Redirect
    def login() {
    	redirect(action: "signin")
    }

    // Redirect
    def register() {
    	redirect(action: "signup")
    }
}
