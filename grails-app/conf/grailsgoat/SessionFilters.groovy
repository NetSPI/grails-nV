package grailsgoat

class SessionFilters {

    def filters = {
       shouldBeLoggedIn(controller: 'user', action: '*', invert: true) {
           before = {
              if (!session.user) {
                  redirect(controller: 'user', action: 'signin')
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
