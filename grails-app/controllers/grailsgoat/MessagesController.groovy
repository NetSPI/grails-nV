package grailsgoat

class MessagesController {

    def index() { 
    	if (request.post) {
    		// Why are they posting the message index?
    		redirect(action: "index")
    	} else {
    		def user_id = session.user.id

    		def user_messages = User.get(user_id).messages
    		render(view: "index", model: [messages: user_messages])
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
    		// Display the message sending form
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
