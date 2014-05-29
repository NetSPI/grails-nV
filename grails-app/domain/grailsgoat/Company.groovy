package grailsgoat

class Company {

	String name
	String description
	String website

	static hasMany = [joblistings: JobListing]

    static constraints = {
    }
}
