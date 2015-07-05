package com.rcstc.manufacture

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured
import org.joda.time.DateTime

import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["hasAnyRole('ADMIN','BUSINESS')"])
@Transactional(readOnly = true)
class WeeklyReportController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService
    def publicService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        long pid
        if (params.pid && !params.pid.equals("-1")){
            pid =  params.long("pid")
        }

        def org = springSecurityService.currentUser.company

        def r
        def c = []

        if(pid){
            def p = Project.get(pid)
            r = WeeklyReport.findAllByProject(p,[sort: "buildDate", order: "desc"])
            c[0] = WeeklyReport.countByProject(p)
        } else {
            if(SpringSecurityUtils.ifAnyGranted("SUPER_ADMIN,BUSINESS")){
                r = WeeklyReport.list(params)
                c[0] = WeeklyReport.count()
            } else if(SpringSecurityUtils.ifAnyGranted("SUPERVISOR")){
                r = WeeklyReport.executeQuery("from WeeklyReport wr where wr.project.id in (select pr.id from PersonProject pp join pp.person pe join pp.project pr where pe.id = :uid) or wr.project.fristParty = :org or wr.project.secondParty = :org or wr.project.thirdParty = :org or wr.project.fourthParty = :org",[uid:springSecurityService.currentUser.id,org:org,max:params.max ,offset:params.offset?:0])
                c = WeeklyReport.executeQuery("select count(*) from WeeklyReport wr where wr.project.id in (select pr.id from PersonProject pp join pp.person pe join pp.project pr where pe.id = :uid) or wr.project.fristParty = :org or wr.project.secondParty = :org or wr.project.thirdParty = :org or wr.project.fourthParty = :org",[uid:springSecurityService.currentUser.id,org:org])
            }else {
                r = WeeklyReport.executeQuery("from WeeklyReport wr where wr.project.id in (select pr.id from PersonProject pp join pp.person pe join pp.project pr where pe.id = :uid)",[uid:springSecurityService.currentUser.id,max:params.max ,offset:params.offset?:0])
                c = WeeklyReport.executeQuery("select count(*) from WeeklyReport wr where wr.project.id in (select pr.id from PersonProject pp join pp.person pe join pp.project pr where pe.id = :uid)",[uid:springSecurityService.currentUser.id])
            }
        }

        def pl = publicService.plist(springSecurityService.currentUser)

        respond r, model: [weeklyReportInstanceCount: c[0], pl: pl]
    }

    def show(WeeklyReport weeklyReportInstance) {
        def today = DateTime.now()
        def lowerDate = today.dayOfWeek().withMinimumValue().toDate()
        def upperDate = today.dayOfWeek().withMaximumValue().toDate()
        def year = today.getYear()
        def week = today.getWeekOfWeekyear()
        def finished = Demand.findAllByProjectAndSiFinishDateBetween(weeklyReportInstance.project, lowerDate, upperDate)

        def plan = WeeklyPlan.executeQuery("select t.demand.serial, t.demand.title from WeeklyPlan wp left join wp.tasks t where wp.year = :year and wp.week = :week and t.project.id = :pid",[year: year, week: week+1, pid: weeklyReportInstance.project.id])

        def countNe = Demand.countByProjectAndPlanStartDateBetween(weeklyReportInstance.project, lowerDate, upperDate)
        def countBa = Demand.countByProjectAndBaFinishDateBetween(weeklyReportInstance.project, lowerDate, upperDate)
        def countSa = Demand.countByProjectAndSaFinishDateBetween(weeklyReportInstance.project, lowerDate, upperDate)
        def countAu = Demand.countByProjectAndConfirmDateBetween(weeklyReportInstance.project, lowerDate, upperDate)
        def countDe = Demand.countByProjectAndDeFinishDateBetween(weeklyReportInstance.project, lowerDate, upperDate)
        def countSi = Demand.countByProjectAndSiFinishDateBetween(weeklyReportInstance.project, lowerDate, upperDate)
        def countUa = Demand.countByProjectAndUaFinishDateBetween(weeklyReportInstance.project, lowerDate, upperDate)
        def countDp = Demand.countByProjectAndDeployDateBetween(weeklyReportInstance.project, lowerDate, upperDate)
        def sumFi = Demand.countByProjectAndStatus(weeklyReportInstance.project, DemandStatus.ACCOMPLISHED)
        def sumAll = Demand.countByProjectAndStatusNotEqual(weeklyReportInstance.project, DemandStatus.CANCELED)
        def rateFi = 0
        if(sumAll!=0){
            rateFi = sumFi/sumAll
        }
        //def plan = WeeklyPlan.f
        respond weeklyReportInstance, model: [lowerDate: lowerDate, upperDate: upperDate, year: year, week: week, finished: finished, plan: plan
        , countBa: countBa, countSa: countSa, countAu: countAu, countDe: countDe, countSi: countSi, countUa: countUa, countDp: countDp
        , sumFi: sumFi, rateFi: rateFi, countNe: countNe]
    }

    def create() {
        def wr = new WeeklyReport(params)
        wr.buildPerson = springSecurityService.currentUser.name

        DateTime dt = DateTime.now()
        wr.startDate = dt.dayOfWeek().setCopy("星期一").toDate()
        wr.stopDate = dt.dayOfWeek().setCopy("星期五").toDate()

        params.start_end_date = wr.startDate.format("yyyy-MM-dd") + " - " + wr.stopDate.format("yyyy-MM-dd")

        def pl = publicService.plist(springSecurityService.currentUser)
        respond wr, model: [params: params, pl: pl]
    }

    @Transactional
    def save(WeeklyReport weeklyReportInstance) {
        if (weeklyReportInstance == null) {
            notFound()
            return
        }

        if (weeklyReportInstance.hasErrors()) {
            respond weeklyReportInstance.errors, view: 'create'
            return
        }

        if(params.start_end_date){
            def sp = params.start_end_date.split(" - ")
            assert sp.size() == 2
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")
            weeklyReportInstance.startDate = sdf.parse(sp[0])
            weeklyReportInstance.stopDate = sdf.parse(sp[1])
        }
        weeklyReportInstance.buildDate = new Date()

        weeklyReportInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'weeklyReport.label', default: 'WeeklyReport'), weeklyReportInstance.id])
                redirect weeklyReportInstance
            }
            '*' { respond weeklyReportInstance, [status: CREATED] }
        }
    }

    @Transactional
    def edit(WeeklyReport weeklyReportInstance) {

        def lowerDate = weeklyReportInstance.startDate
        def upperDate = weeklyReportInstance.stopDate
        def year = new DateTime(weeklyReportInstance.buildDate).getYear()
        def week = new DateTime(weeklyReportInstance.buildDate).getWeekOfWeekyear()

        weeklyReportInstance.handled = publicService.handledContent(weeklyReportInstance.project, lowerDate, upperDate)
        weeklyReportInstance.finishedTask = publicService.finishContent(weeklyReportInstance.project, lowerDate, upperDate)
        weeklyReportInstance.planingTask = publicService.planContent(weeklyReportInstance.project, year, week)

        weeklyReportInstance.buildPerson = springSecurityService.currentUser.name
        weeklyReportInstance.buildDate = new Date()
        weeklyReportInstance.save(flush: true)

        respond weeklyReportInstance, model: [params: params]
    }

    @Transactional
    def update(WeeklyReport weeklyReportInstance) {
        if (weeklyReportInstance == null) {
            notFound()
            return
        }

        if (weeklyReportInstance.hasErrors()) {
            respond weeklyReportInstance.errors, view: 'edit'
            return
        }

        weeklyReportInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'WeeklyReport.label', default: 'WeeklyReport'), weeklyReportInstance.id])
                redirect weeklyReportInstance
            }
            '*' { respond weeklyReportInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(WeeklyReport weeklyReportInstance) {

        if (weeklyReportInstance == null) {
            notFound()
            return
        }

        weeklyReportInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'WeeklyReport.label', default: 'WeeklyReport'), weeklyReportInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'weeklyReport.label', default: 'WeeklyReport'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    @Transactional
    def formal(WeeklyReport weeklyReportInstance) {
        if (weeklyReportInstance == null) {
            notFound()
            return
        }

        if (weeklyReportInstance.hasErrors()) {
            respond weeklyReportInstance.errors, view: 'show'
            return
        }

        weeklyReportInstance.status = 'formal'
        weeklyReportInstance.save flush: true

        def mailboxs = []
        //获取项目组领导邮箱
        mailboxs = PersonProject.executeQuery("select pp.person.email from PersonProject pp where pp.project.id = :pid and (pp.projectRole=:pp1 or pp.projectRole=:pp2 or pp.projectRole = :pp3 or pp.projectRole = :pp4 or pp.projectRole = :pp5)",[pid:weeklyReportInstance.project.id,pp1:ProjectRole.IT部负责人,pp2:ProjectRole.业务部负责人,pp3:ProjectRole.运营部负责人,pp4:ProjectRole.项目领导小组成员,pp5:ProjectRole.项目经理])


        //发邮件
        sendMail {
            async true
            from grailsApplication.config.sys_email.address
            to mailboxs.toArray()
            subject weeklyReportInstance.project.name + weeklyReportInstance.startDate.format("yyyy/M/d") + "-" +weeklyReportInstance.stopDate.format("yyyy/M/d") + "周报"
            html g.render(template:"weeklyReportEmail", model: [weeklyReportInstance:weeklyReportInstance])
        }

        event topic:"REPORT-WEEKLY", data:weeklyReportInstance

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'WeeklyReport.label', default: 'WeeklyReport'), weeklyReportInstance.id])
                redirect weeklyReportInstance
            }
            '*' { respond weeklyReportInstance, [status: OK] }
        }
    }
}
