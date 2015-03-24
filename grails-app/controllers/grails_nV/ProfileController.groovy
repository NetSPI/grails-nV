package grails_nV

import javax.servlet.http.Cookie
import grails.converters.JSON

class ProfileController {

    def index() { 
        if (params.id) {
            if (params.id?.isInteger()) {
                // Show the specific user ID
                def userdata = User.find("from User where id = ${params.id}")

                //FIX: def userdata = User.get(params.id)
                //FIX insecure DOA too: def userdata = User.get(session.user.id)

                if (userdata != null) {
                    render(view: "profile", model: [user: userdata, can_edit: (User.get(session.user.id).accesslevel == 1)])
                    return
                }
            }
        } else {
            def userdata = User.get(session.user.id)

            if (userdata != null) {
                render(view: "profile", model: [user: userdata, can_edit: true])
                return
            }
        }

        // The user didn't exist
        redirect(controller: "main", view: "index")
    }

    def resume() {
        if (request.post) {
            // They want to upload a resume
            
            def uploadedfile = request.getFile('file')
            if (!uploadedfile?.empty) {
                uploadedfile.transferTo(new File("web-app/uploads/" + uploadedfile.getOriginalFilename()))
                def user = User.get(session.user.id)

                user.resume = uploadedfile.getOriginalFilename()
                user.save(flush: true)

                response.sendError(200, 'Done')
                render "Uploaded."
                return
            }
            render "Failed."
            return
        } else {
            render(view: "uploadresume")
        }
    }

    def edit() {
    	if (request.post) {

            if (params.firstname && params.lastname && params.description && params.ssn && params.email && params.password && params.id?.isInteger()) {
                def new_data = params

                new_data.password = new_data.password.encodeAsMD5()
                /*
                def bcryptService
                new_data.password = bcryptService.hashPassword(new_data.password)
                */

                def user = User.get(params.id)

                if (user && user.password == new_data.password && (new_data.email =~ /(.*)@(.*).(.*)/)) {

                    // Should we update password?
                    if (new_data.newpassword) {
                        if (new_data.newpassword.equals(new_data.passwordconfirm) && new_data.password.length() >= 6) {
                            new_data.password = new_data.newpassword.encodeAsMD5()
                            /* new_data.password = bcryptService.hashPassword(new_data.newpassword) */
                        } else {
                            flash.error = "New password was not valid"
                            render(view: "edit", model: [user: session.user])
                            return                            
                        }
                    }

                    user.properties = new_data
                    user.save(flush: true)

                    session.user = user

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
                    
                    // Store the user data so we can reset the form
                    JSON.use("deep")

                    // Encrypt the cookie so it can't be read by attackers
                    Cookie cookie = new Cookie("user", (userdata as JSON).toString().bytes.encodeBase64().toString())
                    cookie.maxAge = 100
                    response.addCookie(cookie)
                    render(view: "edit", model: [user: userdata])
                    return
                }
            }
            redirect(controller: "main", view: "index")
    	}
    }
}
