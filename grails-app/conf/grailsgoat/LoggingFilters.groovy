package grailsgoat

class LoggingFilters {

    def filters = {
        all(controller:'*', action:'*') {
            before = {
                def log = new Log(useragent: request.getHeader("User-Agent"), 
                              ip: request.getRemoteAddr(),
                              referer: request.getHeader('referer'),
                              page: request.forwardURI,
                              parameters: request.queryString)
                log.save(flush: true)
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
    }
}
