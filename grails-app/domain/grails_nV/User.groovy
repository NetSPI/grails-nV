package grails_nV

import java.util.Date;

class User {

	String email
	String firstname
	String lastname
    String fullname
    String description
    String resume
    String ssn
	String password
	Date created_at
	Date updated_at
    String verify_token
    String forgot_token
    int accesslevel

    long original_attempt
    long latest_attempt
    int attempts
    String reset_token

    static hasMany = [messages: Message]
    static belongsTo = [employer: Company]

    static constraints = {
    	updated_at nullable: true
        forgot_token nullable: true
        verify_token nullable: true
        created_at nullable: true
        description nullable: true
        ssn nullable: true
        resume nullable: true
        reset_token nullable: true
        employer nullable: true

    	email maxSize: 255

    	firstname maxSize: 255

    	lastname maxSize: 255

        fullname maxSize: 600

        description maxSize: 3000
        ssn maxSize: 11

    	password maxSize: 36

    	verify_token maxSize: 30
        forgot_token maxSize: 30
        reset_token maxSize: 30
    }

    static mapping = {
    	updated_at defaultValue: null
    	created_at defaultValue: new Date()
        forgot_token defaultValue: null
        resume defaultValue: null
        description defaultValue: null
        ssn defaultValue: null
        accesslevel defaultValue: 0
        original_attempt defaultValue: 0
        latest_attempt defaultValue: 0
        reset_token defaultValue: null
        attempts defaultValue: 0
    }
}
