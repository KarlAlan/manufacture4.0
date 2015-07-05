import com.rcstc.acl.Role

class BootStrap {

    def init = { servletContext ->

        def userRole = new Role(authority: Role.USER).save(flush: true)
        def adminRole = new Role(authority: Role.ADMIN).save(flush: true)
        def superAdminRole = new Role(authority: Role.SUPER_ADMIN).save(flush: true)
        def supervisorRole = new Role(authority: Role.SUPERVISOR).save(flush: true)
        def salesmanRole = new Role(authority: Role.SALESMAN).save(flush: true)
        def financeRole = new Role(authority: Role.FINANCE).save(flush: true)
        def businessRole = new Role(authority: Role.BUSINESS).save(flush: true)

        assert Role.count() == 7

    }
    def destroy = {
    }
}
