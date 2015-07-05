package manufacture

class CookieFilters {

    // using service
    //def cookieService // define field for DI

    def filters = {

        all(controller:'*', action:'*') {
            before = {
                if(request.method=="GET"){
                    def po = session.getAttribute(request.getServletPath())
                    po.each {
                        if(!params.containsKey(it.key))
                            params[it.key] = it.value
                    }
                }
            }
            after = { Map model ->
                if (request.method == "POST") {
                    //def cos = request.getCookies()
                    session.removeAttribute(request.getServletPath())
                    session.setAttribute(request.getServletPath(),params)

                }
            }
            afterView = { Exception e ->

            }

        }

    }
}
