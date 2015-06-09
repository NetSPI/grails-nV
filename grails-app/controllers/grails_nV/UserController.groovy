package grails_nV

import org.apache.commons.lang.RandomStringUtils
import org.codehaus.groovy.grails.web.servlet.mvc.GrailsHttpSession

class UserController {

	def index() {
		redirect(action: "signin")
	}

    def signin() {
    	if (request.post) {
            withForm {
        		if (params.signin_email && params.signin_password) {

        			def user_email = params.signin_email
                    def user_password = params.signin_password

                    // Let's hash their password first to prevent timing attacks
                    def user_password_hash = user_password.encodeAsMD5();
                    /* 
                    def bcryptService
                    def user_password_hash = bcryptService.hashPassword(user_password)
                    */

        			// Check to see if a user with that email exists in our database (save time and check both fields)
        			def user = User.find("from User where password = '${user_password_hash}' and email = '${user_email}'")
      
                    /*if (user && user.original_attempt) {
                        if (user.latest_attempt + 1800 < System.currentTimeMillis() / 1000L) {
                            user.attempts = 0
                            user.latest_attempt = 0
                            user.original_attempt = 0
                            user.save(flush: true)
                        }
                    }*/

                    // Reset their account lockout if it needs it
                    if (session["original_attempt"]) {
                        if (session["last_attempt"] + 1800 < System.currentTimeMillis() / 1000L) {
                            session.invalidate()
                        }
                    }

                    /* if (user != null && !user.verify_token && user.attempts < 3) { */
        			if (user != null && !user.verify_token && session["attempts"] < 3) {
        				// User was validated, so create a session
                        /*
                            user.attempts = 0
                            user.latest_attempt = 0
                            user.original_attempt = 0
                            user.reset_token = null
                            user.save(flush: true)
                        */
                        
                        session["attempts"] = 0

        				session["user"] = user
                        //session.invalidate()
                        //flash.userid = user.id

                        // Redirect to the last page
                        if (params.lastpage) {
                            redirect(url: params.lastpage)
                        } else {
        				    redirect(controller: "main", action: "index")
                        }

        				return
        			}

                    // Should we lock someone out?
                    user = user ? user : User.findWhere(email: user_email)
                    
                    /*if (user) {
                        user.latest_attempt = (long) (System.currentTimeMillis() / 1000L)

                        if (user.original_attempt) {
                            // They've tried before
                            user.attempts = user.attempts + 1

                            if (user.attempts > 2) {
                                // Tell them they need to reset their account
                                flash.error = "Your account has been locked. Please reset your password from your email"

                                if (user.attempts == 3) {
                                    user.reset_token = RandomStringUtils.randomAlphanumeric(30)

                                    sendMail {
                                        async true
                                        to user_email    
                                        subject "Reset your FindMeAJob account"
                                        html 'Reset your account here: <a href="' + createLink(absolute: true, controller: 'user', action: 'resethook', params: ['token': user.reset_token]) + '">link</a>'
                                    }
                                }
                                user.save(flush: true)
                                render(view: "signin")
                                return

                            }

                        } else {
                            // First time trying
                            user.original_attempt = (long) (System.currentTimeMillis() / 1000L)
                            user.latest_attempt = user.original_attempt
                            user.attempts = 1
                        }
                        user.save(flush: true)
                    }*/
                    

                    if (user) {

                        session["last_attempt"] = (long) (System.currentTimeMillis() / 1000L)

                        if (session["original_attempt"]) {
                            // They've tried before
                            session["attempts"] = session["attempts"] + 1

                            if (session["attempts"] > 2) {
                                // Tell them they need to reset their account
                                flash.error = "Your account has been locked. Please reset your password from your email"

                                if (session["attempts"] == 3) {
                                    session["reset_token"] = RandomStringUtils.randomAlphanumeric(30)
                                    session["reset_id"] = user.id
                                    sendMail {
                                        async true
                                        to user_email    
                                        subject "Reset your FindMeAJob account"
                                        html 'Reset your account here: <a href="' + createLink(absolute: true, controller: 'user', action: 'resethook', params: ['token': session["reset_token"]]) + '">link</a>'
                                    }
                                }

                                render(view: "signin")
                                return

                            }

                        } else {
                            // First time trying
                            session["original_attempt"] = (long) (System.currentTimeMillis() / 1000L)
                            session["last_attempt"] = session["original_attempt"];
                            session["attempts"] = 1
                        }
                    }

        		}

        		// Catch-all error
        	    flash.error = "Invalid login or unverified account"
        		render(view: "signin")
            }
    	} else {
            if (params.redirect_to) {
                render(view: "signin", model: [lastpage: params.redirect_to])
            } else {
                render(view: "signin")
            }
    	}
    }

    def signup() {
        if (request.post) {
            withForm {
        		
        		// Make sure their request had all the required fields
        		if (params.signup_firstname && params.signup_lastname && params.signup_email && params.signup_password && params.signup_confirm) {

        			def user_firstname = params.signup_firstname
        			def user_lastname = params.signup_lastname
        			def user_email = params.signup_email
        			def user_password = params.signup_password
        			def user_confirm = params.signup_confirm

        			// Check to see if a user with that email already exists
        			def user = User.findWhere(email: user_email)

                    // Let's validate the user email address
                    def email_valid = (user_email =~ /(.*)@(.*).(.*)/)

        			// Check to see if their passwords match
        			def passwords_match = user_password.equals(user_confirm)

        			// Calculate hash of password
        			def user_password_hash = user_password.encodeAsMD5()
                    /*
                    def bcryptService
                    def user_password_hash = bcryptService.hashPassword(user_password)
                    */

                    // Check the password complexity
                    def passwordmatcher = user_password =~ /\A.*(?=.{10,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[\@\#\$\%\^\&\+\=]).*\z/

                    if (user_password.length() < 6) {
                        flash.error = "Your password is too short"
                        render(view: "signup")
                        return
                    }
                    if (user_password.length() > 40) {
                        flash.error = "Your password is too long"
                        render(view: "signup")
                        return
                    }

                    // If they're one of our employees, automatically make them admin
                    def set_admin = false
                    if (user_email.contains("findmeajob.com")) {
                        set_admin = true
                    }

                    /*if (!passwordmatcher.matches()) {
                        flash.error = "Your password is not sufficiently complex"
                        render(view: "signup")
                        return
                    }*/

        			if (user == null) {
                        if(passwords_match && email_valid) {    				
            				def user_verify_token = RandomStringUtils.randomAlphanumeric(30)

            				def new_user = new User(email: user_email, firstname: user_firstname, lastname: user_lastname, fullname: user_firstname + " " + user_lastname, password: user_password_hash, verify_token: user_verify_token)
            				if (set_admin) {
                                new_user.accesslevel = 1
                            }
                            if (new_user.save(flush: true)) {
        						sendMail {
        							async true
          							to user_email    
          							subject "Verify your FindMeAJob account"      
          							html 'Someone signed you up for FindMeAJob. We\'re the premier site for helping some people find jobs occasionally. If you were the one who signed up, click on the link below. If you weren\'t, don\'t click on the link! <a href="' + createLink(absolute: true, controller: 'user', action: 'verifyhook', params: ['token': user_verify_token]) + '">link</a>'
        						}

                                flash.success = "Your account has been registered! Please verify your email to log in"
                                render(view: "signin")
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
            }
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
  						body 'Someone requested their password on FindMeAJob be reset. If it was you, click on the link below. If it wasn\'t, don\'t click on the link! <a href="' + createLink(absolute: true, controller: 'user', action: 'forgothook', params: ['token': user.forgot_token]) + '">link</a>'
					}

					flash.info = "If an account with that email exists, it has been sent a reset token"
					render(view: "signin")
					return
				} else {
                    flash.error = "No account with that email is registered"
                    render(view: "signin")
                    return
                }
    		}

    		redirect(action: "signin")
    	} else {
    		redirect(action: "signin")
    	}
    }

   def resethook() {
            /*if (request.post) {
                // If someone is posting, they're sending their new password up
                if (params.password && params.confirm && params.reset_token) {
                    def user_password = params.password
                    def user_confirm = params.confirm
                    def user_reset_token = params.reset_token

                    def user_password_hash = user_password.encodeAsMD5()

                    //def bcryptService
                    //def user_password_hash = bcryptService.hashPassword(user_password)

                    def user = User.findWhere(reset_token: user_reset_token)

                    if (user != null && user_password.equals(user_confirm)) {
                        // Reset the user's password
                        user.password = user_password_hash
                        user.attempts = 0
                        user.original_attempt = 0
                        user.latest_attempt = 0
                        user.reset_token = null
                        flash.info = null
                        user.save(flush: true)

                        render(view: "signin", model: [success: "Your account has been reset"])
                        return
                    }
                }

                redirect(view: "signin")
            } else {
                if (params.token) {

                    def user = User.findWhere(reset_token: params.token)

                    if (user != null) {
                        flash.info = "You can now reset your password"
                        flash.reset_token = params.token
                        render(view: "resetaccount")
                        return
                    }
                }

                redirect(action: "signin")
            }*/
        

        
        if (request.post) {
            // If someone is posting, they're sending their new password up
            if (params.password && params.confirm && params.reset_token) {
                def user_password = params.password
                def user_confirm = params.confirm
                def user_reset_token = params.reset_token

                def user_password_hash = user_password.encodeAsMD5()
                /*
                def bcryptService
                def user_password_hash = bcryptService.hashPassword(user_password)
                */

                def user = User.findWhere(id: session["reset_id"])

                if (user != null && user_password.equals(user_confirm)) {
                    // Reset the user's password
                    user.password = user_password_hash
                    session["attempts"] = 0
                    flash.info = null
                    user.save(flush: true)

                    render(view: "signin", model: [success: "Your account has been reset"])
                    return
                }
            }

            redirect(view: "signin")
        } else {
            if (params.token && params.token.equals(session["reset_token"])) {
                // _Very_ securely check the entire database for the token

                def user = User.findWhere(id: session["reset_id"])

                if (user != null) {
                    flash.info = "You can now reset your password"
                    flash.reset_token = session["reset_token"]
                    render(view: "resetaccount")
                    return
                }
            }

            redirect(action: "signin")
        }
        
    }

    def forgothook() {
    	if (request.post) {
    		// If someone is posting, they're sending their new password up
    		if (params.password && params.confirm && params.forgot_token) {
    			def user_password = params.password
    			def user_confirm = params.confirm
    			def user_forgot_token = params.forgot_token

    			def user_password_hash = user_password.encodeAsMD5()
                /*
                def bcryptService
                def user_password_hash = bcryptService.hashPassword(user_password)
                */

    			def user = User.findWhere(forgot_token: user_forgot_token)

    			if (user != null && user_password.equals(user_confirm)) {
    				// Reset the user's password
    				user.password = user_password_hash
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
