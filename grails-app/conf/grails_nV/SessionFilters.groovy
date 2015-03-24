package grails_nV

import org.codehaus.groovy.grails.web.mapping.LinkGenerator

class SessionFilters {

    LinkGenerator grailsLinkGenerator

    def filters = {

       /* Use a whitelist instead - shouldBeLoggedIn(controller: 'user', action: '*', invert: true) { */
       shouldBeLoggedIn(controller: 'profile|main|messages|session', action: '*') {
           before = {
              /*if (flash.userid) {
                session.user = User.get(flash.userid)
              }*/

              if (!session.user) {
                  // Take the user back to the original page
                  def generated_link = grailsLinkGenerator.link(controller: params.controller, action: params.action, absolute: true)
                  def uri = java.net.URLEncoder.encode(generated_link)

                  redirect(url: grailsLinkGenerator.serverBaseURL + "/user/signin?redirect_to=" + uri)
                  return false
              }
           }
       }
       shouldNotBeLoggedIn(controller: 'user', action: '*') {
           before = {
              if (session.user) {
                  redirect(controller: 'main', action: 'index')
                  return false
               }
           }
       }
    }
}
