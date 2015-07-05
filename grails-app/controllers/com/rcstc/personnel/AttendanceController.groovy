package com.rcstc.personnel

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import org.joda.time.DateTime
import org.joda.time.LocalDate
import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["hasRole('USER')"])
@Transactional(readOnly = true)
class AttendanceController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Attendance.list(params), model:[attendanceInstanceCount: Attendance.count()]
    }

    def show(Attendance attendanceInstance) {
        respond attendanceInstance
    }

    def create() {
        respond new Attendance(params)
    }

    @Transactional
    def save(Attendance attendanceInstance) {
        if (attendanceInstance == null) {
            notFound()
            return
        }

        if (attendanceInstance.hasErrors()) {
            respond attendanceInstance.errors, view:'create'
            return
        }

        attendanceInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'attendance.label', default: 'Attendance'), attendanceInstance.id])
                redirect attendanceInstance
            }
            '*' { respond attendanceInstance, [status: CREATED] }
        }
    }

    def edit(Attendance attendanceInstance) {
        respond attendanceInstance
    }

    @Transactional
    def update(Attendance attendanceInstance) {
        if (attendanceInstance == null) {
            notFound()
            return
        }

        if (attendanceInstance.hasErrors()) {
            respond attendanceInstance.errors, view:'edit'
            return
        }

        attendanceInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Attendance.label', default: 'Attendance'), attendanceInstance.id])
                redirect attendanceInstance
            }
            '*'{ respond attendanceInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Attendance attendanceInstance) {

        if (attendanceInstance == null) {
            notFound()
            return
        }

        attendanceInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'attendance.label', default: 'Attendance'), attendanceInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'attendance.label', default: 'Attendance'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def ajaxGetAttendanceStatus(){
        def currentUser = springSecurityService.currentUser

        def status = "None"
        //def r = Attendance.executeQuery("from Attendance a where a.person.id = :pid and to_char(a.attendanceDate,'yyyy-MM-dd') = :date order by a.attendanceDate",[pid:currentUser.id,date:today])
        //判断当前是否存在当天的考勤记录
        DateTime dt1 = DateTime.now().withTimeAtStartOfDay()
        DateTime dt2 = DateTime.now().millisOfDay().withMaximumValue()
        def r = Attendance.withCriteria {
            eq('person', currentUser)
            ge('attendanceDate', dt1.toDate())
            lt('attendanceDate', dt2.toDate())
        }
        for(Attendance a : r){
            if(a.operation.equals("Check In")){
                status = "Reached"
            }
            if(a.operation.equals("Check Out")){
                status = "Gone"
            }
        }
        render(contentType: "application/json") {
            AttendanceStatus(status: status)
        }
    }

    @Transactional
    def ajaxWorkAttendance(){
        def op = params.op

        //判断当前是否存在当天的考勤记录
        DateTime dt1 = DateTime.now().withTimeAtStartOfDay()
        DateTime dt2 = DateTime.now().millisOfDay().withMaximumValue()
        def p = springSecurityService.currentUser

        def at = Attendance.findByOperationAndPersonAndAttendanceDateGreaterThan(op,p,dt1.toDate())
        if(at){
            render false
        } else {
            //记录
            Attendance a = new Attendance()
            a.operation = op
            a.attendanceDate = new Date()
            a.person = springSecurityService.currentUser

            DateTime dt
            if(op=="Check In"){
                dt = DateTime.now().withTime(grailsApplication.config.attendance.checkIn.hour,grailsApplication.config.attendance.checkIn.minute,0,0)
                if(dt.isAfter(new DateTime(a.attendanceDate))){
                    a.isNormal = false
                } else {
                    a.isNormal = true
                }
            }

            if(op=="Check Out"){
                dt = DateTime.now().withTime(grailsApplication.config.attendance.checkOut.hour,grailsApplication.config.attendance.checkOut.minute,0,0)
                if(dt.isBefore(new DateTime(a.attendanceDate))){
                    a.isNormal = false
                } else {
                    a.isNormal = true
                }
            }

            a.save flush: true

            //Reward.rewardPoint(a.person.username, null, new BigDecimal(10))
            if(!a.isNormal)
                event("Attendance", a)

            render true
        }


    }

    @Secured(["hasAnyRole('USER','BUSINESS','SALESMAN','SUPERVISOR')"])
    def ajaxAttendanceCount(){
        def person = springSecurityService.currentUser
        DateTime now = new DateTime()
        DateTime lastDayOfPreviousMonth = now.minusMonths(1).dayOfMonth().withMaximumValue()

        def cin = Attendance.countByPersonAndAttendanceDateGreaterThanAndOperation(person, lastDayOfPreviousMonth.toDate(),"Check In")
        def cout = Attendance.countByPersonAndAttendanceDateGreaterThanAndOperation(person, lastDayOfPreviousMonth.toDate(),"Check Out")

        render (contentType: "application/json") {
            AttendanceStat(cin: cin,cout:cout)
        }
    }

    //申请考勤记录修改
    @Transactional
    @Secured(["hasAnyRole('USER','BUSINESS','SALESMAN','SUPERVISOR')"])
    def ajaxApplyAttendanceResult(){
        def op

        def desc = params.desc

        if(params.op.equals("签到")){
            op = "Check In"
        }
        if(params.op.equals("签出")){
            op = "Check Out"
        }

        DateTimeFormatter fmt = DateTimeFormat.forPattern("yyyy-MM-dd");
        def opd = fmt.parseDateTime(params.opd)

        DateTime dt1 = opd.withTimeAtStartOfDay()
        DateTime dt2 = opd.millisOfDay().withMaximumValue()

        def person = springSecurityService.currentUser

        def at = Attendance.findByPersonAndOperationAndAttendanceDateBetween(person,op,dt1.toDate(),dt2.toDate())
        if(at){
            if(at.status){
                // 申请已存在，不能再申请
                render false
                return
            }
            at.applyDate = new Date()
            at.description = desc
            at.status = "Apply"

            at.save(flush: true)

        } else {
            Attendance na = new Attendance()
            na.person = springSecurityService.currentUser
            na.attendanceDate = opd.toDate()
            na.applyDate = new Date()
            na.operation = op
            na.description = desc
            na.isNormal = false
            na.status = "Apply"

            na.save(flush: true)
        }

        render true
    }

    //处理考勤记录申请
    @Transactional
    @Secured(["hasAnyRole('ADMIN','BUSINESS')"])
    def ajaxHandleAttendanceApply(){
        def aid = params.long("aid")
        Attendance a = Attendance.get(aid)
        if(params.result=="Pass"){
            a.status = "Pass"
            a.isNormal = false
        } else {
            a.status = "Reject"
            a.isNormal = true
        }

        a.save(flush: true)

        render true
    }

    //获取考勤记录申请列表
    @Secured(["hasAnyRole('ADMIN','BUSINESS')"])
    def ajaxAttendanceApplys(){
        def company = springSecurityService.currentUser.company
        def ats = Attendance.executeQuery("from Attendance a where a.person.company = :company and a.status= 'Apply'",[company: company, max: 10])
        render ats as JSON
    }

    //获取指定月份当前人员的考勤记录
    @Secured(["hasAnyRole('USER','BUSINESS','SALESMAN','SUPERVISOR')"])
    def ajaxAttendancePersonRecord(){
        int monthOffset = 0
        if(params.monthOffset)
            monthOffset = params.int("monthOffset")

        //def person = springSecurityService.currentUser
        DateTime now = new DateTime()
        def ye = now.minusMonths(monthOffset).year().asString.toInteger()
        def mo = now.minusMonths(monthOffset).monthOfYear().asString.toInteger()

        def weekdays = now.minusMonths(monthOffset).dayOfMonth().withMinimumValue().dayOfWeek().asString

        def attendaces = Attendance.executeQuery("from Attendance a where a.person.id = :pid and year(a.attendanceDate)=:year and month(a.attendanceDate) = :month order by a.person.name, a.attendanceDate",[pid:params.long("pid"),year:ye,month:mo])

        DateTime dt1 = new DateTime(ye,mo,1,2,0)
        int maxday = dt1.dayOfMonth().getMaximumValue()

        def morn = new Object[maxday][4]
        def aftr = new Object[maxday][4]

        attendaces.each {
            def time = it.attendanceDate
            DateTime ad = new DateTime(it.attendanceDate)
            int ind = ad.getDayOfMonth()-1

            if(it.operation=="Check In"){
                morn[ind][0] = time.format("HH:mm")
                morn[ind][1] = it.isNormal
                morn[ind][2] = it.description
                morn[ind][3] = it.status
            }
            if(it.operation=="Check Out"){
                aftr[ind][0] = time.format("HH:mm")
                aftr[ind][1] = it.isNormal
                aftr[ind][2] = it.description
                aftr[ind][3] = it.status
            }


        }

        render (contentType: "application/json") {
            AttendancePersonPecord(weekdays: weekdays,  morn:morn, aftr:aftr, month: now.minusMonths(monthOffset).toDate().format("yyyy年M月"))
        }
    }
}
