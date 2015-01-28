package grails_nV

class JobListing {

	String name
	String description
	String requirements
	String howtoapply
	String location
	Date startdate
	boolean fulltime

	static belongsTo = [company: Company]

    static constraints = {
    	requirements nullable: true
    	howtoapply nullable: true

    	name maxSize: 300
    	description maxSize: 3000
    	requirements maxSize: 3000
    	howtoapply maxSize: 3000
    	location maxSize: 300
    }

    static mapping = {
    	fulltime defaultValue: true
    }
}
