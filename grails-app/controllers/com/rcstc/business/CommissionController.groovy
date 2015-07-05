package com.rcstc.business

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["hasRole('BUSINESS')"])
@Transactional(readOnly = true)
class CommissionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService

    @Secured(["hasAnyRole('SALESMAN','BUSINESS','ADMIN')"])
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        def org = springSecurityService.currentUser.company

        def r
        def c
        if(SpringSecurityUtils.ifAnyGranted("SUPERVISOR,SUPER_ADMIN,BUSINESS")){
            r = Commission.executeQuery("from Commission co where co.company = :org",[org:org,max:params.max ,offset:params.offset?:0])
            c = Commission.executeQuery("select count(*) from Commission co where co.company = :org",[org:org])
        }else if(SpringSecurityUtils.ifAnyGranted("SALESMAN")){
            r = Commission.executeQuery("from Commission co where co.saleman = :name or co.schemer = :name",[name:springSecurityService.currentUser.name,max:params.max ,offset:params.offset?:0])
            c = Commission.executeQuery("select count(*) from Commission co where co.saleman = :name or co.schemer = :name",[name:springSecurityService.currentUser.name])
        } else if(SpringSecurityUtils.ifAnyGranted("ADMIN")){
            r = Commission.executeQuery("from Commission co where co.manager = :name",[name:springSecurityService.currentUser.name,max:params.max ,offset:params.offset?:0])
            c = Commission.executeQuery("select count(*) from Commission co where co.manager = :name ",[name:springSecurityService.currentUser.name])
        }

        respond r, model: [commissionInstanceCount: c[0]]
    }

    def show(Commission commissionInstance) {
        respond commissionInstance
    }

    def create() {
        respond new Commission(params)
    }

    @Transactional
    def save(Commission commissionInstance) {
        if (commissionInstance == null) {
            notFound()
            return
        }

        if (commissionInstance.hasErrors()) {
            respond commissionInstance.errors, view: 'create'
            return
        }

        commissionInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'commission.label', default: 'Commission'), commissionInstance.id])
                redirect commissionInstance
            }
            '*' { respond commissionInstance, [status: CREATED] }
        }
    }

    def edit(Commission commissionInstance) {
        respond commissionInstance
    }

    @Transactional
    def update(Commission commissionInstance) {
        if (commissionInstance == null) {
            notFound()
            return
        }

        if (commissionInstance.hasErrors()) {
            respond commissionInstance.errors, view: 'edit'
            return
        }

        commissionInstance.calculateSaleCommission()
        commissionInstance.calculateSchemeBonus()
        if(commissionInstance.actualCost&&commissionInstance.actualDate){
            commissionInstance.calculateActualTeamBonus()
        } else {
            commissionInstance.calculatePlanTeamBonus()
        }
        commissionInstance.calculateManagerBonus()
        commissionInstance.calculateGrossProfit()
        commissionInstance.calculateGrossProfitRate()

        commissionInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Commission.label', default: 'Commission'), commissionInstance.id])
                redirect commissionInstance
            }
            '*' { respond commissionInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Commission commissionInstance) {

        if (commissionInstance == null) {
            notFound()
            return
        }

        commissionInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Commission.label', default: 'Commission'), commissionInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'commission.label', default: 'Commission'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    @Transactional
    def buildCommission() {
        def ba = BusinessAccount.get(params.long("baId"))
        Commission commission = new Commission(params)

        commission.company = ba.company
        commission.project = ba.project.name
        commission.contractAmount = ba.contractAmount

        commission.calculateSaleCommission()
        commission.calculateSchemeBonus()
        if(commission.actualCost&&commission.actualDate){
            commission.calculateActualTeamBonus()
        } else {
            commission.calculatePlanTeamBonus()
        }

        commission.calculateManagerBonus()
        commission.calculateGrossProfit()
        commission.calculateGrossProfitRate()

        if (commission.hasErrors()) {
            respond commission.errors, view: 'index'
            return
        }

        commission.save flush: true

        redirect controller: commission, action: index()
    }
}
