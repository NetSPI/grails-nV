package grailsgoat

class Company {

	String name
	String description
	String website

	static hasMany = [joblistings: JobListing]

    static constraints = {
    	name maxSize: 300
    	description maxSize: 3000
    	website maxSize: 2000
    }
}
