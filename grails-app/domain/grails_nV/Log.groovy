package grails_nV

class Log {

	String ip
	String referer
	String useragent
	String page
	String parameters
	
    static constraints = {
        referer nullable: true
        useragent nullable: true
        parameters nullable: true

    	ip maxSize: 30
    	referer maxSize: 2000
    	useragent maxSize: 2000
    	page maxSize: 2000
    	parameters maxSize: 2000
    }
}
