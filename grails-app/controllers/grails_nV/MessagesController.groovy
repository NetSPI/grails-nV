package grails_nV

class MessagesController {

    def index() { 
    	if (request.post) {
    		// Why are they posting the message index?
    		redirect(action: "index")
    	} else {

    		def user_id = session.user.id

    		def user_messages = User.get(user_id).messages

            def userid_list = user_messages.collect { it.author_id }.join(',')

            // Since author_id isn't a foreign key, we need to get a list of all users
            def message_senders = User.findAll("from User where id in (${userid_list})")

            def senders = [:]

            message_senders.each {
                senders[String.valueOf(it.id)] = it.fullname
            }

            // Let's set some headers so the messages don't get insecurely cached!!
            header 'Cache-Control', 'no-cache, no-store, must-revalidate'
            header 'Pragma', 'no-cache'
            header 'Expires', '0'

    		render(view: "index", model: [messages: user_messages, senders: senders])
    	}
    }

    def sendto() {
        if (request.post) {
            redirect(view: "index")
        } else {
            if (params.userid?.isInteger()) {

                def sendto_user = User.get(params.userid)

                if (sendto_user) {
                    // Let's fill in a few useful fields
                    flash.recipient_id = params.userid
                }
            }

            flash.users = User.getAll()
            render(view: "send")
        }
    }

    def send() { 
    	if (request.post) {
    		// Send the message here
    		if (params.body && params.subject && params.recipient) {
                def message_recipient = params.recipient
                def message_subject = params.subject
                def message_body = params.body

                def recipient = User.get(message_recipient)

                if (recipient) {
                    def message = new Message(subject: message_subject, body: message_body, author_id: session.user.id)
                    recipient.addToMessages(message)
                    recipient.save(flush: true)

                    flash.success = "Your message was sent!"
                    redirect(view: "index")
                    return
                }
            }

            flash.error = "Your message could not be sent"
            return
    	} else {
    		if (params.messageid?.isInteger()) {

                def reply_message = Message.get(params.messageid)

                if (reply_message) {
                    // Let's fill in a few useful fields
                    flash.recipient_id = reply_message.author_id
                    flash.subject = "RE: " + reply_message.subject
                }
    		}

            flash.users = User.getAll()
    		render(view: "send")
    	}
    }
}