package com.rcstc.business

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["hasRole('USER')"])
@Transactional(readOnly = true)
class ContractController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService
    def publicService
    def businessService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        int offset = params.offset ? params.int('offset') : 0

        def status = []                        // contract status
        if(params.contract_status){
            if(params.contract_status instanceof String){
                status.add(params.contract_status)
            } else {
                params.contract_status.each(){
                    status.add(it)
                }
            }
        }

        def result = businessService.searchContract(springSecurityService.currentUser.id,params.contract_serial,params.contract_name,params.frist_party,params.second_party,status,params.max,offset)
        respond result["contracts"], model: [contractInstanceCount: result["totalCount"],params:params]
    }

    def show(Contract contractInstance) {
        respond contractInstance
    }

    def create() {
        Contract contract = new Contract(params)
        contract.spPersons = []
        contract.spPersons.add(springSecurityService.currentUser)
        respond contract, model:[pl:publicService.plist(springSecurityService.currentUser),currentPerson:springSecurityService.currentUser]
    }

    @Transactional
    def save(Contract contractInstance) {
        if (contractInstance == null) {
            notFound()
            return
        }

        if (contractInstance.hasErrors()) {
            respond contractInstance.errors, view: 'create'
            return
        }

        contractInstance.creater = springSecurityService.currentUser
        contractInstance.createDate = new Date()

        contractInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'contract.label', default: 'Contract'), contractInstance.id])
                redirect contractInstance
            }
            '*' { respond contractInstance, [status: CREATED] }
        }
    }

    def edit(Contract contractInstance) {
        respond contractInstance, model:[pl:publicService.plist(springSecurityService.currentUser)]
    }

    @Transactional
    def update(Contract contractInstance) {
        if (contractInstance == null) {
            notFound()
            return
        }

        if (contractInstance.hasErrors()) {
            respond contractInstance.errors, view: 'edit'
            return
        }

        contractInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Contract.label', default: 'Contract'), contractInstance.id])
                redirect contractInstance
            }
            '*' { respond contractInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Contract contractInstance) {

        if (contractInstance == null) {
            notFound()
            return
        }

        contractInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Contract.label', default: 'Contract'), contractInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'contract.label', default: 'Contract'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    @Transactional
    def active(Contract contractInstance) {
        contractInstance.status = ContractStatus.ACTIVE
        update(contractInstance)
        redirect action: "show", id: contractInstance.id
    }

    @Transactional
    def accomplish(Contract contractInstance) {
        contractInstance.status = ContractStatus.ACCOMPLISHED
        update(contractInstance)
        redirect action: "show", id: contractInstance.id
    }

    @Transactional
    def cancel(Contract contractInstance) {
        contractInstance.status = ContractStatus.CANCELED
        update(contractInstance)
        redirect action: "show", id: contractInstance.id
    }

    def receivable(Integer max){
        params.max = Math.min(max ?: 10, 100)
        int offset = params.offset ? params.int('offset') : 0

        def result = businessService.receivable(springSecurityService.currentUser.id,params.contract_serial,params.contract_name,params.frist_party,params.max,offset)
        respond result["contracts"], model: [contractInstanceCount: result["totalCount"],params:params]
    }

    def payable(Integer max){
        params.max = Math.min(max ?: 10, 100)
        int offset = params.offset ? params.int('offset') : 0

        def result = businessService.payable(springSecurityService.currentUser.id,params.contract_serial,params.contract_name,params.second_party,params.max,offset)
        respond result["contracts"], model: [contractInstanceCount: result["totalCount"],params:params]
    }
}
