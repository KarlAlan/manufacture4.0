package com.rcstc.manufacture

import com.rcstc.acl.Role
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["hasRole('USER')"])
@Transactional(readOnly = true)
class InformationSystemController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond InformationSystem.list(params), model: [informationSystemInstanceCount: InformationSystem.count()]
    }

    def show(InformationSystem informationSystemInstance) {
        respond informationSystemInstance
    }

    def create() {
        respond new InformationSystem(params)
    }

    @Transactional
    def save(InformationSystem informationSystemInstance) {
        if (informationSystemInstance == null) {
            notFound()
            return
        }

        if (informationSystemInstance.hasErrors()) {
            respond informationSystemInstance.errors, view: 'create'
            return
        }

        informationSystemInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'informationSystem.label', default: 'InformationSystem'), informationSystemInstance.id])
                redirect informationSystemInstance
            }
            '*' { respond informationSystemInstance, [status: CREATED] }
        }
    }

    def edit(InformationSystem informationSystemInstance) {
        respond informationSystemInstance
    }

    @Transactional
    def update(InformationSystem informationSystemInstance) {
        if (informationSystemInstance == null) {
            notFound()
            return
        }

        if (informationSystemInstance.hasErrors()) {
            respond informationSystemInstance.errors, view: 'edit'
            return
        }

        informationSystemInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'InformationSystem.label', default: 'InformationSystem'), informationSystemInstance.id])
                redirect informationSystemInstance
            }
            '*' { respond informationSystemInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(InformationSystem informationSystemInstance) {

        if (informationSystemInstance == null) {
            notFound()
            return
        }

        informationSystemInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'InformationSystem.label', default: 'InformationSystem'), informationSystemInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'informationSystem.label', default: 'InformationSystem'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    def structure() {
        def iss
        def authed = false
        for(def ga : springSecurityService.authentication.authorities){
            if(ga.authority.equals("SUPER_ADMIN")){
                authed = true;
                break;
            }
        }
        if (authed){
            iss = InformationSystem.list()
        } else {
            iss = InformationSystem.findAllByOrg(springSecurityService.currentUser.company)
        }
        [systems:iss, company:springSecurityService.currentUser.company]
    }

    @Transactional
    def ajaxSaveSystem() {
        def is
        if(params.isid&&params.isid!=""){
            is = InformationSystem.get(params.long("isid"))
            is.org = params.org
            is.name = params.name
            is.description = params.description

            is.save flush: true
            render is as JSON
        } else {
            is = new InformationSystem()
            is.org = params.org
            is.name = params.name
            is.description = params.description

            is.save flush: true
            render is as JSON
        }

    }

    @Transactional
    def ajaxDeleteSystem() {
        if(params.isid&&params.isid!=""){
            def is = InformationSystem.get(params.long("isid"))

            is.delete flush: true
            render true
        } else {
            render false
        }

    }

    @Transactional
    def ajaxSaveCategory1() {
        def m
        if(params.mid&&params.mid!=""){
            m = Module.get(params.long("mid"))
            m.name = params.name
            m.description = params.description
            //m.important = params.boolean("important")
            m.important = params.important.equals("checked")?true:false

            m.save flush: true
        } else {
            def iid = params.long("iid")
            def is = InformationSystem.get(iid)

            m = new Module()
            m.name = params.name
            m.description = params.description
            m.important = params.important.equals("checked")?true:false
            m.system = is

            m.save flush: true
        }

        render m as JSON
    }

    @Transactional
    def ajaxSaveCategory2() {
        def m
        if(params.mid&&params.mid!=""){
            m = Module.get(params.long("mid"))
            m.name = params.name
            m.description = params.description
            m.important = params.important.equals("checked")?true:false

            m.save flush: true
        } else {
            def pid = params.long("pid")
            def pm = Module.get(pid)

            m = new Module()
            m.name = params.name
            m.description = params.description
            m.important = params.important.equals("checked")?true:false
            m.parent = pm

            m.save flush: true
        }

        render m as JSON
    }

    @Transactional
    def ajaxDeleteModule() {
        if(params.mid&&params.mid!=""){
            def m = Module.get(params.long("mid"))

            m.delete flush: true
            render true
        } else {
            render false
        }

    }

    @Secured(["hasRole('USER')"])
    def ajaxGetCategory1() {
        def sid = params.long("sid")
        def mods = InformationSystem.executeQuery("select m.id, m.name, m.description, m.important from Module m join m.system s where s.id = :sid ",[sid:sid])

        render mods as JSON
    }

    @Secured(["hasRole('USER')"])
    def ajaxGetCategory2() {
        def mid = params.long("mid")
        def mods = Module.executeQuery("select m.id, m.name, m.description, m.important from Module m where m.parent.id = :mid",[mid:mid])

        render mods as JSON
    }

    @Secured(["hasRole('USER')"])
    def ajaxGetCategory1ByProject() {
        def pid = params.long("pid")
        def mods = InformationSystem.executeQuery("select m.id, m.name, m.description, m.important from Module m, Project p join m.system s where p.informationSystem.id = s.id and p.id = :pid ",[pid:pid])

        render mods as JSON
    }
}
