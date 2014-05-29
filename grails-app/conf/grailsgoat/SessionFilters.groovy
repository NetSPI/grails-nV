package grailsgoat

class SessionFilters {

    def filters = {
       shouldBeLoggedIn(controller: 'user', action: '*', invert: true) {
           before = {
              if (!session.user) {
                  redirect(action: 'signin')
                  return false
               }
           }
       }
       shouldNotBeLoggedIn(controller: 'user', action: '*') {
           before = {
              if (session.user) {
                  redirect(action: 'mainpage')
                  return false
               }
           }
       }
    }
}
