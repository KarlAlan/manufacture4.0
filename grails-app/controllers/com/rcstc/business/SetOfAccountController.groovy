package com.rcstc.business

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["hasRole('SUPERVISOR')"])
@Transactional(readOnly = true)
class SetOfAccountController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        def soal
        def soac
        if(SpringSecurityUtils.ifAnyGranted("SUPER_ADMIN")){
            soal = SetOfAccount.list(params)
            soac = SetOfAccount.count()
        } else {
            def company = springSecurityService.currentUser.company
            soal = SetOfAccount.findAllByCompany(company)
            soac = SetOfAccount.countByCompany(company)
        }
        respond soal, model: [setOfAccountInstanceCount: soac]
    }

    def show(SetOfAccount setOfAccountInstance) {
        respond setOfAccountInstance
    }

    def create() {
        respond new SetOfAccount(params) , model: [company:springSecurityService.currentUser.company]
    }

    @Transactional
    def save(SetOfAccount setOfAccountInstance) {
        if (setOfAccountInstance == null) {
            notFound()
            return
        }

        if (setOfAccountInstance.hasErrors()) {
            respond setOfAccountInstance.errors, view: 'create'
            return
        }

        setOfAccountInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'setOfAccount.label', default: 'SetOfAccount'), setOfAccountInstance.id])
                redirect setOfAccountInstance
            }
            '*' { respond setOfAccountInstance, [status: CREATED] }
        }
    }

    def edit(SetOfAccount setOfAccountInstance) {
        respond setOfAccountInstance
    }

    @Transactional
    def update(SetOfAccount setOfAccountInstance) {
        if (setOfAccountInstance == null) {
            notFound()
            return
        }

        if (setOfAccountInstance.hasErrors()) {
            respond setOfAccountInstance.errors, view: 'edit'
            return
        }

        setOfAccountInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'SetOfAccount.label', default: 'SetOfAccount'), setOfAccountInstance.id])
                redirect setOfAccountInstance
            }
            '*' { respond setOfAccountInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(SetOfAccount setOfAccountInstance) {

        if (setOfAccountInstance == null) {
            notFound()
            return
        }

        setOfAccountInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'SetOfAccount.label', default: 'SetOfAccount'), setOfAccountInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'setOfAccount.label', default: 'SetOfAccount'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
