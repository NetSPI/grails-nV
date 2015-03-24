package grails_nV

import grails.converters.JSON

class AdminController {

    def beforeInterceptor = [action:this.&requireAdmin, except:["index"]]

      def requireAdmin() {
        if(!session.user || !session.user.accesslevel.equals(1)) {
          flash.error = "You do not have sufficient access to perform this action"

          redirect(controller:"main", action:"index")
          return false
        }
      }


	def index() {
		def users = User.getAll()

		render(view: "index", model: [users: users])
	}

	def edit() {
		if (request.post) {
			if (params.firstname && params.lastname && params.description && params.ssn && params.email && params.password && params.passwordconfirm && params.id?.isInteger()) {
                def new_data = params

                def input_password = new_data.password

                new_data.password = new_data.password.encodeAsMD5()
                /*
                def bcryptService
                new_data.password = bcryptService.hashPassword(new_data.password)
                */

                def user = User.get(params.id)

                if (user && input_password.equals(new_data.passwordconfirm) && (new_data.email =~ /(.*)@(.*).(.*)/)) {
                    user.properties = new_data
                    user.save(flush: true)

                    session.user = user

                    flash.success = "This user has been updated successfully"
                    render(view: "edit", model: [user: user])
                    return
                }
            }

            flash.error = "This user could not be updated"
            render(view: "edit", model: [user: session.user])
            return
		} else {
			if (params.id?.isInteger()) {
	    		def user = User.get(params.id)
	    		render(view: "edit", model: [user: user])
	    	}
    	}
	}

	def delete() {

	}

}