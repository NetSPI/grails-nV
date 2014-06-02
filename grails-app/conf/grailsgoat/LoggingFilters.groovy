package grailsgoat

class LoggingFilters {

    def filters = {
        all(controller:'assets', action:'*', invert: true) {
            before = {
                def log = new Log(useragent: request.getHeader("User-Agent"), 
                              ip: request.getRemoteAddr(),
                              referer: request.getHeader('referer'),
                              page: request.forwardURI,
                              parameters: params ? params.toString() : 'none')
                log.save(flush: true)
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
    }
}
