
class SecurityFilters {

    def springSecurityService

    def filters = {
        /*
        loginCheck(controller:'*', action:'*') {
            before = {
                if(!springSecurityService.isLoggedIn() && !controllerName.equals('login')){
                    redirect(controller: 'login', action: 'auth')
                    return false
                }
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
        */
    }
}
