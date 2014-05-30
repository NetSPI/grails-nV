package grailsgoat

class ProfileController {

    def index() { 
        if (params.id) {
            if (params.id?.isInteger()) {
                // Show the specific user ID
                def userdata = User.get(params.id)

                if (userdata != null) {
                    render(view: "profile", model: [user: userdata])
                    return
                }
            }
        } else {
            def userdata = User.get(session.user.id)

            if (userdata != null) {
                render(view: "profile", model: [user: userdata])
                return
            }
        }

        // The user didn't exist
        redirect(controller: "main", view: "index")
    }

    def resume() {
        if (request.post) {
            // They want to upload a resume
            render "okay"
            return
        } else {
            render(view: "uploadresume")
        }
    }

    def edit() {
    	if (request.post) {
            if (params.firstnamevalid && params.lastnamevalid && params.descriptionvalid && params.emailvalid && params.passwordvalid && params.passwordconfirmationvalid && params.id?.isInteger()) {
                def user_firstname = params.firstnamevalid
                def user_lastname = params.lastnamevalid
                def user_description = params.descriptionvalid
                def user_email = params.emailvalid
                def user_password = params.passwordvalid
                def user_password_confirmation = params.passwordconfirmationvalid

                def user_password_md5 = user_password.encodeAsMD5()

                def user = User.get(params.id)

                if (user && user_password.equals(user_password_confirmation) && user_password.length() > 5) {
                    user.firstname = user_firstname
                    user.lastname = user_lastname
                    user.description = user_description
                    user.email = user_email
                    user.password = user_password_md5
                    user.save(flush: true)
                    flash.success = "Your profile has been updated successfully"
                    render(view: "edit", model: [user: user])
                    return
                }
            }

            flash.error = "Your profile could not be updated"
            render(view: "edit", model: [user: session.user])
            return
    	} else {
            if (params.id?.isInteger()) {
                def userdata = User.get(params.id)

                if (userdata != null) {
                   render(view: "edit", model: [user: userdata])
                   return
                }
            }
            redirect(controller: "main", view: "index")
    	}
    }
}
