import grails.nV.Company
import grails.nV.JobListing

class BootStrap {

    def init = { servletContext ->
    		def leetsec = new Company(name: "LeetSec", description: "Experts in Application Security", website: "https://leetsec.com" ).save(failOnError: true)
    		def megacorp = new Company(name: "MegaCorp", description: "The best at what we do", website: "http://megacorp.co.jp").save(failOnError: true)
    		def goatsllc = new Company(name: "GoatS LLC", description: "We provide the best goats, for traditional goat stew", website: "http://goatsforstew.com").save(failOnError: true)

    		def job1 = new JobListing(name: "Security Consultant", description: "Responsible for hacking all the things", requirements: "none", howtoapply: "Contact our HR team: megangoat@leetsec.com", location: "Virginia", startdate: new Date(), fulltime: true, company: leetsec).save(failOnError: true)
    		def job2 = new JobListing(name: "Senior Security Consultant", description: "Manages the rookies", requirements: "3+ years experience in application security. Extensive Grails Experience", howtoapply: "Contact our HR team: megangoat@leetsec.com", location: "Virginia", startdate: new Date(), fulltime: true, company: leetsec).save(failOnError: true)
    		def job3 = new JobListing(name: "Financial Assistant", description: "Responsible for managing financial tasks, such as investments and purchasing", requirements: "Extensive experience with MS Excel + Access", howtoapply: "Please give us a call at (211) 355-3413 x1337. Ask for Cyrus", location: "Virginia", startdate: new Date(), fulltime: true, company: megacorp).save(failOnError: true)

    }
    def destroy = {
    }
}
