package grailsgoat

import org.apache.commons.lang.RandomStringUtils

class UserController {

	def index() {
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

    			if (user != null && user_password_md5.equals(user.password) && !user.verify_token) {
    				// User was validated, so create a session
    				session["user"] = user
    				redirect(controller: "main", action: "index")
    				return
    			}
    		}

    		// Catch-all error
    	    flash.error = "Invalid login or unverified account"
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

    			if (user == null) {
                    if(passwords_match) {    				
        				def user_verify_token = RandomStringUtils.randomAlphanumeric(30)
        				def new_user = new User(email: user_email, firstname: user_firstname, lastname: user_lastname, fullname: user_firstname + " " + user_lastname, password: user_password_md5, verify_token: user_verify_token)
        				if (new_user.save(flush: true)) {
    						sendMail {
    							async true
      							to user_email    
      							subject "Verify your FindMeAJob account"     
      							body 'Someone signed you up for FindMeAJob. We\'re the premier site for helping some people find jobs occasionally. If you were the one who signed up, click on the link below. If you weren\'t, don\'t click on the link! http://localhost:8080' + request.contextPath + "/user/verifyhook?token=" + user_verify_token
    						}

        					flash.success = "Your account has been registered! Please verify your email and then log in"
                            redirect(view: "signin")
        					return
    					}

                        new_user.errors.each {
                            println it
                        }
                    }
    			} else {
                    flash.error = "That email is already taken"
                    render(view: "signup")
                    return
                }
    		}

    		flash.error = "Invalid registration"
    		render(view: "signup")
            return

    	} else {
    		render(view: "signup")
    	}
    }

    def forgot() {
    	if (request.post) {
    		if (params.password_reset_email) {
				def user_email = params.password_reset_email

				def user = User.findWhere(email: user_email)

				if (user != null) {

					user.forgot_token = RandomStringUtils.randomAlphanumeric(30)
					user.save(flush: true) 

					// This is secure, right :)?
					sendMail {
						async true
  						to user_email    
  						subject "Reset your FindMeAJob account"     
  						body 'Someone requested their password on FindMeAJob be reset. If it was you, click on the link below. If it wasn\'t, don\'t click on the link! http://localhost:8080' + request.contextPath + "/user/forgothook?token=" + user.forgot_token
					}

					println "Reset account"

					flash.info = "If an account with that email exists, it has been sent a reset token"
					render(view: "signin")
					return
				}
    		}

    		redirect(action: "signin")
    	} else {
    		redirect(action: "signin")
    	}
    }

	// TODO: Password recovery dialog here
    def forgothook() {
    	if (request.post) {
    		// If someone is posting, they're sending their new password up
    		if (params.password && params.confirm && params.forgot_token) {
    			def user_password = params.password
    			def user_confirm = params.confirm
    			def user_forgot_token = params.forgot_token

    			def user_password_md5 = user_password.encodeAsMD5()

    			def user = User.findWhere(forgot_token: user_forgot_token)

    			if (user != null && user_password.equals(user_confirm)) {
    				// Reset the user's password
    				user.password = user_password_md5
    				user.forgot_token = null
    				user.save(flush: true)

    				flash.success = "Your password has successfully been reset!"
    				redirect(view: "signin")
    				return
    			}
    		}

    		redirect(view: "signin")
    	} else {
    		if (params.token) {
    			// _Very_ securely check the entire database for the token
    			def user_token = params.token

    			def user = User.findWhere(forgot_token: user_token)

    			if (user != null) {
    				flash.info = "You can now reset your password"
    				flash.forgot_token = user_token
    				render(view: "resetpassword")
    				return
    			}
    		}

    		redirect(action: "signin")
    	}
    }

    def verifyhook() {
    	if (request.post) {
    		// Why is someone POSTing this address?
    		redirect(action: "signin")
    	} else {
    		if (params.token) {
    			// _Very_ securely check the entire database for the token
    			def user_token = params.token

    			def user = User.findWhere(verify_token: user_token)

    			if (user != null) {
    				user.verify_token = null
    				user.save(flush: true)

    				flash.info = "Your email has been verified successfully!"
    				redirect(action: "signin")
    				return
    			}
    		}

    		flash.error = "This email has been verified or is not valid"
    		redirect(action: "signin")
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
