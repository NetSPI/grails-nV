package grails_nV

class LoggingFilters {

    def filters = {
        all(controller:'assets', action:'*', invert: true) {
            before = {
              def req_useragent = request.getHeader("User-Agent")
              if (req_useragent) {
                req_useragent = req_useragent.substring(0, Math.min(req_useragent.length(), 2000))
              }

              def req_ip = request.getRemoteAddr()
              req_ip = req_ip.substring(0, Math.min(req_ip.length(), 30))

              def req_referer = request.getHeader('referer')
              if (req_referer) {
                req_referer = req_referer.substring(0, Math.min(req_referer.length(), 2000))
              }

              def req_page = request.forwardURI
              req_page = req_page.substring(0, Math.min(req_page.length(), 2000))

              def req_parameters = (params ? params.toString() : 'none')
              if (req_parameters) {
                req_parameters = req_parameters.substring(0, Math.min(req_parameters.length(), 2000))
              }

              def log = new Log(useragent: req_useragent, ip: req_ip, referer: req_referer, page: req_page, parameters: req_parameters)
              log.save(flush: true)
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
    }
}
