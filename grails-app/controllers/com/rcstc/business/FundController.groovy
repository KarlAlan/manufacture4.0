package com.rcstc.business

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["hasAnyRole('FINANCE','BUSINESS')"])
@Transactional(readOnly = true)
class FundController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Fund.list(params), model: [fundInstanceCount: Fund.count()]
    }

    def show(Fund fundInstance) {
        respond fundInstance
    }

    def create() {
        respond new Fund(params)
    }

    @Transactional
    def save(Fund fundInstance) {
        if (fundInstance == null) {
            notFound()
            return
        }

        if (fundInstance.hasErrors()) {
            respond fundInstance.errors, view: 'create'
            return
        }

        fundInstance.creater = springSecurityService.currentUser
        fundInstance.createDate = new Date()
        fundInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'fund.label', default: 'Fund'), fundInstance.id])
                //redirect fundInstance
                redirect controller: "contract", action: "show", id: fundInstance.bill.contract.id
            }
            '*' { respond fundInstance, [status: CREATED] }
        }
    }

    def edit(Fund fundInstance) {
        respond fundInstance
    }

    @Transactional
    def update(Fund fundInstance) {
        if (fundInstance == null) {
            notFound()
            return
        }

        if (fundInstance.hasErrors()) {
            respond fundInstance.errors, view: 'edit'
            return
        }

        fundInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Fund.label', default: 'Fund'), fundInstance.id])
                redirect fundInstance
            }
            '*' { respond fundInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Fund fundInstance) {

        if (fundInstance == null) {
            notFound()
            return
        }

        fundInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Fund.label', default: 'Fund'), fundInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'fund.label', default: 'Fund'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
