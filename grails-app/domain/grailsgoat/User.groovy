package grailsgoat

import java.util.Date;

class User {

	String email
	String firstname
	String lastname
	String password
	Boolean verified
	Date created_at
	Date updated_at
	String auth_token

    static constraints = {
    	verified nullable: true
    	updated_at nullable: true

    	email maxSize: 255

    	firstname maxSize: 255

    	lastname maxSize: 255

    	password maxSize: 36

    	auth_token maxSize: 30
    }

    static mapping = {
    	updated_at defaultValue: null
    	verified defaultValue: null
    	created_at defaultValue: new Date()
    }
}
