package grails_nV

class Message {

	String subject
	String body

	static belongsTo = [recipient: User]

	int author_id

    static constraints = {
    	subject maxSize: 300
    	body maxSize: 3000
    }
}