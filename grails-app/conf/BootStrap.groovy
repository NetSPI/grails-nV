import grails_nV.Company
import grails_nV.JobListing
import grails_nV.User
import grails_nV.Message

class BootStrap {

    def init = { servletContext ->

    	if(!Company.count()) {
    		def leetsec = new Company(name: "LeetSec", description: "Experts in Application Security", website: "https://leetsec.com" ).save(failOnError: true)
    		def megacorp = new Company(name: "MegaCorp", description: "The best at what we do", website: "http://megacorp.co.jp").save(failOnError: true)
    		def goatsllc = new Company(name: "GoatS LLC", description: "We provide the best goats, for traditional goat stew", website: "http://goatsforstew.com").save(failOnError: true)

    		def job1 = new JobListing(name: "Security Consultant", description: "Responsible for hacking all the things", requirements: "none", howtoapply: "Contact our HR team: megangoat@leetsec.com", location: "Virginia", startdate: new Date(), fulltime: true, company: leetsec).save(failOnError: true)
    		def job2 = new JobListing(name: "Senior Security Consultant", description: "Manages the rookies", requirements: "3+ years experience in application security. Extensive Grails Experience", howtoapply: "Contact our HR team: megangoat@leetsec.com", location: "Virginia", startdate: new Date(), fulltime: true, company: leetsec).save(failOnError: true)
    		def job3 = new JobListing(name: "Financial Assistant", description: "Responsible for managing financial tasks, such as investments and purchasing", requirements: "Extensive experience with MS Excel + Access", howtoapply: "Please give us a call at (211) 355-3413 x1337. Ask for Cyrus", location: "Virginia", startdate: new Date(), fulltime: true, company: megacorp).save(failOnError: true)

    		def admin = new User(email: "admin@grails.com", firstname: "Admin", lastname: "Admin", fullname: "Admin Admin", password: "password".encodeAsMD5(), verify_token: null, accesslevel: 1).save(failOnError: true)

            def john = new User(email: "john@grails.com", firstname: "John", lastname: "Poulin", fullname: "John Poulin", password: "haX0r!".encodeAsMD5(), verify_token: null, accesslevel: 2).save(failOnError: true)
            leetsec.addToEmployees(john).save()

            def jack = new User(email: "jack@l33t.com", firstname: "Jack", lastname: "Edwards", fullname: "Jack Edwards", password: "password".encodeAsMD5(), verify_token: null, accesslevel: 2).save(failOnError: true)
            leetsec.addToEmployees(jack).save()

            def james = new User(email: "james@megacorp.gov", firstname: "James", lastname: "Bradley", fullname: "James Bradley", password: "password".encodeAsMD5(), verify_token: null, accesslevel: 0).save(failOnError: true)
            megacorp.addToEmployees(james).save()

            def joseph = new User(email: "joseph@megacorp.gov", firstname: "Joseph", lastname: "Nelson", fullname: "Joseph Nelson", password: "password".encodeAsMD5(), verify_token: null, accesslevel: 0).save(failOnError: true)
            megacorp.addToEmployees(joseph).save()

            def jeremy = new User(email: "jeremy@goatsllc.org", firstname: "Jeremy", lastname: "Krimper", fullname: "Jeremy Krimper", password: "password".encodeAsMD5(), verify_token: null, accesslevel: 0).save(failOnError: true)
            goatsllc.addToEmployees(jeremy).save()

    		def message = new Message(subject: "Help with job", body: "Hello Admin, I'm currently looking for help finding a job. Please give me a call, (222) 345-9241", author_id: 2, recipient: admin).save(failOnError: true)
  	  }
    }
    def destroy = {
    }
}
