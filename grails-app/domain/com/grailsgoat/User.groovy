package com.grailsgoat

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
    }
}
