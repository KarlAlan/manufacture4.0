package com.rcstc.manufacture

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["hasRole('ADMIN')"])
@Transactional(readOnly = true)
class PersonProjectController {

    def springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PersonProject.list(params), model: [personProjectInstanceCount: PersonProject.count()]
    }

    def show(PersonProject personProjectInstance) {
        respond personProjectInstance
    }

    def create() {
        respond new PersonProject(params)
    }

    @Transactional
    def save(PersonProject personProjectInstance) {
        if (personProjectInstance == null) {
            notFound()
            return
        }

        if (personProjectInstance.hasErrors()) {
            respond personProjectInstance.errors, view: 'create'
            return
        }

        personProjectInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'personProject.label', default: 'PersonProject'), personProjectInstance.id])
                redirect personProjectInstance
            }
            '*' { respond personProjectInstance, [status: CREATED] }
        }
    }

    def edit(PersonProject personProjectInstance) {
        respond personProjectInstance
    }

    @Transactional
    def update(PersonProject personProjectInstance) {
        if (personProjectInstance == null) {
            notFound()
            return
        }

        if (personProjectInstance.hasErrors()) {
            respond personProjectInstance.errors, view: 'edit'
            return
        }

        personProjectInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PersonProject.label', default: 'PersonProject'), personProjectInstance.id])
                redirect personProjectInstance
            }
            '*' { respond personProjectInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(PersonProject personProjectInstance) {

        if (personProjectInstance == null) {
            notFound()
            return
        }

        personProjectInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PersonProject.label', default: 'PersonProject'), personProjectInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'personProject.label', default: 'PersonProject'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    @Secured(["hasRole('USER')"])
    def ajaxMyProjectList(){
        def person = springSecurityService.currentUser
        def personProjects = PersonProject.findAllByPerson(person)
        Set projects = []
        if(personProjects)
        {
            for (def personProject : personProjects) {
                projects << personProject.project
            }
        }

        render projects as JSON
    }

    @Secured(["hasRole('USER')"])
    def ajaxMyAddressList(){
        def person = springSecurityService.currentUser
        def personProjects = PersonProject.findAllByPerson(person)
        Set projects = []
        if(personProjects)
        {
            for (def personProject : personProjects) {
                projects << personProject.project
            }
        }

        render projects as JSON
    }
}
