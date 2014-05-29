package grailsgoat

class JobListing {

	String name
	String description
	String location
	Date startdate
	boolean fulltime

	static belongsTo = [company: Company]

    static constraints = {
    }
}
