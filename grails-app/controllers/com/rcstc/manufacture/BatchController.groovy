package com.rcstc.manufacture

import com.rcstc.acl.User
import com.rcstc.personnel.Reward
import com.rcstc.personnel.RewardType
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import org.joda.time.DateTime

import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["hasRole('ADMIN')"])
@Transactional(readOnly = true)
class BatchController {

    def springSecurityService
    def publicService
    def taskService
    def demandService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        int offset = params.offset ? params.int('offset') : 0

        def person = springSecurityService.currentUser
        def pl = publicService.plist(person)

        long pid
        Person dev
        boolean all = false

        if (params.pid && !params.pid.equals("-1")){
            pid =  params.long("pid")
        }

        if (params.batch_developer){
            dev = Person.findByName(params.batch_developer)
        }

        println("===="+params.batch_isDone)
        if (params.batch_isDone){

            all = true
        }

        def r = taskService.searchBatchs(person,pid,all,params.batch_serial,dev,params.max,offset)

        [batchInstanceList:r["batchs"],batchInstanceCount:r["totalCount"],params:params,pl:pl]
    }

    def show(Batch batchInstance) {
        respond batchInstance
    }

    def create() {
        respond new Batch(params)
    }

    @Transactional
    def save(Batch batchInstance) {
        if (batchInstance == null) {
            notFound()
            return
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")
        if(params.start_end_date){
            def sp = params.start_end_date.split(" - ")
            assert sp.size() == 2
            batchInstance.startDate = sdf.parse(sp[0])
            batchInstance.planFinishDate = sdf.parse(sp[1])
        }

        if (params.serial == null || params.serial == ""){
            long pid
            pid = params.long("project.id")
            batchInstance.serial = publicService.getMaxSerial(pid, "batchSerial")
        }

        if (batchInstance.hasErrors()) {
            respond batchInstance.errors, view: 'scheduling'
            return
        }

        batchInstance.save flush: true

        for(Task t in batchInstance.task){
            t.status = TaskStatus.DEVELOP
            t.batch = batchInstance
            for(Demand d in t.demand){
                d.status = DemandStatus.DEVELOP
                d.save(flush: true)

                event("DEMAND-FORWARD",[d,springSecurityService.currentUser])
            }
            t.save(flush: true)

            event("TASK-FORWARD",[t,springSecurityService.currentUser])
        }

        event("BATCH-START",[batchInstance,springSecurityService.currentUser])

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'batch.label', default: 'Batch'), batchInstance.id])
                redirect batchInstance
            }
            '*' { respond batchInstance, [status: CREATED] }
        }
    }

    def edit(Batch batchInstance) {
        respond batchInstance
    }

    @Transactional
    def update(Batch batchInstance) {
        if (batchInstance == null) {
            notFound()
            return
        }

        if (batchInstance.hasErrors()) {
            respond batchInstance.errors, view: 'edit'
            return
        }

        batchInstance.save flush: true

        event("BATCH-UPDATE",[batchInstance,springSecurityService.currentUser])

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Batch.label', default: 'Batch'), batchInstance.id])
                redirect batchInstance
            }
            '*' { respond batchInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Batch batchInstance) {

        if (batchInstance == null) {
            notFound()
            return
        }

        batchInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Batch.label', default: 'Batch'), batchInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'batch.label', default: 'Batch'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    def scheduling(Long id){
        def user = springSecurityService.currentUser
        def pl = publicService.plist(user)

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")

        if(id){
            def batchInstance = Batch.get(id)
            if (!batchInstance) {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'batch.label', default: 'Batch'), id])
                redirect(action: "list")
                return
            }

            def developers = publicService.peoplesByProject(batchInstance.project.id)
            def sits = publicService.peoplesByProject(batchInstance.project.id, ProjectRole.测试人员.id)
            params.start_end_date = sdf.format(batchInstance.startDate)+" - "+sdf.format(batchInstance.planFinishDate)
            [batchInstance: batchInstance,pl: pl,tasks:batchInstance.task,developers:developers,sits:sits,params: params]
        } else {
            Date start = new Date()
            Date end = new Date() + 7
            params.start_end_date = sdf.format(start)+" - "+sdf.format(end)

            def result = taskService.searchTasks(user,pl[0].id,'5',null,null,50,0)
            def developers = publicService.peoplesByProject(pl[0].id, ProjectRole.开发人员.id)
            def sits = publicService.peoplesByProject(pl[0].id, ProjectRole.测试人员.id)
            [batchInstance: new Batch(params),pl:pl,tasks: result["tasks"],developers:developers,sits:sits,params: params]
        }
    }

    @Secured(["hasRole('USER')"])
    def personalJobs(){
        int max = Math.min(params.max ? params.int('max') : 10, 100)
        int offset = params.offset ? params.int('offset') : 0

        long pid

        if (params.pid && !params.pid.equals("-1")){
            pid =  params.long("pid")
        }

        def user = springSecurityService.currentUser
        def result = taskService.personalTasks(user,pid,params.job_serial,max,offset)
        def pl = publicService.plist(user)

        [bjs:result["tasks"],bjTotal:result["totalCount"],params:params,pl:pl]
    }

    def ajaxGetTasksList(){
        def pid = params.long("pid")
        def user = springSecurityService.currentUser
        def jl = taskService.searchTasks(user,pid,'5',null,null,50,0)
        def developers = publicService.peoplesByProject(pid, ProjectRole.开发人员.id)
        def sits = publicService.peoplesByProject(pid, ProjectRole.测试人员.id)
        def op = [jl["tasks"],developers,sits]
        render op as JSON
    }

    @Secured(["hasRole('USER')"])
    @Transactional
    def nextStep(){
        def user = springSecurityService.currentUser
        def jid = params.long("jid")
        Task t = Task.get(jid)
        if(t.status==TaskStatus.DEVELOP){
            t.status = TaskStatus.SIT
            for(Demand d in t.demand){
                d.status = DemandStatus.SIT
                d.save(flush: true)

                event("DEMAND-FORWARD",[d,springSecurityService.currentUser])
            }

            event("TASK-FORWARD",[t,springSecurityService.currentUser])
        }else{
            if(params.pass == 'Y'){
                t.status = TaskStatus.ACCOMPLISHED
                for(Demand d in t.demand){
                    d.status = DemandStatus.UAT
                    d.save(flush: true)

                    event("DEMAND-FORWARD",[d,springSecurityService.currentUser])
                }
                Batch.finishBatch(t.id)

                event("TASK-FINISH",[t,springSecurityService.currentUser])
            }else{
                t.status = TaskStatus.DEVELOP
                for(Demand d in t.demand){
                    d.status = DemandStatus.DEVELOP
                    d.save(flush: true)

                    event("DEMAND-BACKWARD",[d,springSecurityService.currentUser])
                }

                event("TASK-BACKWARD",[t,springSecurityService.currentUser])
            }
        }

        t.save(flush: true)
        //jr.save(flush: true)
        redirect(action: "personalJobs", params: params)
    }

    def humanCostsDetail4Project(){
        def pid = params.long("pid")
        int max = params.max ? params.int('max') : 0
        int offset = params.offset ? params.int('offset') : 0
        def user = springSecurityService.currentUser
        def pl = publicService.plist(user)
        if(!pid){
            pid = pl[0].id
        }
        def result = publicService.humanCostsDetail(pid,max,offset)

        [pl: pl,detail:result['detail'],totalCount:result['totalCount']]
    }

    def batch4People(){
        def pid = params.long("pid")
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")
        Date start = new Date() - 15
        Date end = new Date() + 15

        if(params.sumbit_start_end_date){
            def sp = params.sumbit_start_end_date.split(" - ")
            assert sp.size() == 2
            start = sdf.parse(sp[0])
            end = sdf.parse(sp[1])

        } else {
            params.sumbit_start_end_date = sdf.format(start)+" - "+sdf.format(end)
        }

        def user = springSecurityService.currentUser
        def pl = publicService.plist(user)
        if(!pid){
            pid = pl[0].id
        }

        def result = Batch.executeQuery("select a.name, b.serial, b.startDate, b.planFinishDate, b.finishDate from Person a left outer join a.develops b with b.project.id=:pid and ( b.startDate>:start or b.planFinishDate<:end ) join a.pps p with p.project.id=:pid",[pid:pid,start:start,end:end])
        [result:result, params: params, pl: pl]

    }

    @Secured(["hasRole('USER')"])
    def desktop(){
        def person = springSecurityService.currentUser

        //def mps = Reward.executeQuery("select r.username as un, sum(r.rewardPoint) as rp from Reward r where r.rewardType=:type and r.rewardDate>:date group by r.username",[type:RewardType.积分,date:lastDayOfPreviousMonth.toDate()])
        def mps = publicService.personMonthRanking()

        //工作统计  sit,完成
        DateTime dt = DateTime.now()
        Date start = dt.dayOfWeek().withMinimumValue().plusDays(-1).toDate()
        Date end = dt.dayOfWeek().withMaximumValue().toDate()
        def dayWork = Task.executeQuery("select u.name, day(t.finishDate), sum(case when t.status = :sitst then t.planHour end) as sit, sum(case when t.status = :uatst then t.planHour end) as fin from Task t join t.finisher u " +
                "where t.finishDate >= :stday and t.finishDate < :enday and t.finisher.id = :u group by day(t.finishDate), u.name",
                [sitst: TaskStatus.SIT, uatst: TaskStatus.ACCOMPLISHED, stday: start, enday: end, u: person.id])

        Date ms = dt.dayOfMonth().withMinimumValue().toDate()
        Date me = dt.dayOfMonth().withMaximumValue().toDate()

        def monthWork = Task.executeQuery("select sum(t.planHour) from Task t where t.finishDate between :ms and :me and t.status = :ts and t.finisher.id = :tid group by t.finisher.id",
                [ms:ms,me:me,ts:TaskStatus.ACCOMPLISHED,tid:person.id])

        def ut = Task.executeQuery("select sum(case when t.evaluate ='good' then 1 else 0 end),sum(case when t.evaluate ='normal' then 1 else 0 end),sum(case when t.evaluate ='bad' then 1 else 0 end) from Task t where t.status = :ts and t.finishDate between :f1 and :f2 and t.finisher.id = :uid group by t.finisher.id",
                [ts: TaskStatus.ACCOMPLISHED,f1:ms,f2:me, uid:person.id])

        [person: person, mps: mps['result'], dayWork: dayWork, mw: monthWork[0], ut: ut[0]]
    }

    @Secured(["hasRole('USER')"])
    def ajaxPendingTasks(){
        def person = springSecurityService.currentUser
        def result = publicService.pendingTask(person)
        render result as JSON
    }

    def board(Integer max){
        params.max = Math.min(max ?: 10, 100)
        int offset = params.offset ? params.int('offset') : 0

        Date start = new Date() - 30
        Date end = new Date()

        def person = springSecurityService.currentUser
        def stats = demandService.demandStat2(person)

        def records = OperateRecord.list([max:10,sort: "operateDate", order:"desc"])

        //def ptasks = demandService.demandPersonStat()

        def dt = new DateTime()
        int year = dt.getWeekyear()
        int week = dt.getWeekOfWeekyear()

        def pts = WeeklyPlan.executeQuery("from WeeklyPlan wp where wp.year = :year and wp.week = :week",[year: year, week: week, max: params.max, offset: offset])
        def c = WeeklyPlan.executeQuery("select count(*) from WeeklyPlan wp where wp.year = :year and wp.week = :week",[year: year, week: week])

        def pt = taskService.taskStat(person)
        [tg:stats['stat'],records:records,pts:pts, ptsTotal: c[0], projectTask: pt['stat']]
    }

    def ajaxBatch4PersonInProject(){
        def pid = params.long("pid")
        def br = Batch.executeQuery("from Batch b where b.project.id = :pid and b.isDone = false ",[pid: pid])
        def pr = PersonProject.executeQuery("select pp.person.id, pp.person.name from PersonProject pp where pp.project.id = :pid and pp.projectRole = :role",[pid:pid, role: ProjectRole.开发人员])
        def r = []
        for (def p : pr){
            Batch4Person bp = new Batch4Person()
            bp.personId = p[0]
            bp.personName = p[1]
            bp.personRole = "开发人员"
            for (def b : br){
                if(b.developer.id == bp.personId){
                    bp.batchIds = bp.batchIds + "," + b.id
                    bp.batchSerials = b.serial + "," + bp.batchSerials
                    bp.totalPlanHours = bp.totalPlanHours + b.planHour
                    if(bp.lastPlanFinishDate){
                        if(b.planFinishDate>bp.lastPlanFinishDate){
                            bp.lastPlanFinishDate = b.planFinishDate
                        }
                    }else {
                        bp.lastPlanFinishDate = b.planFinishDate
                    }
                    bp.lastPlanFinishDateS = bp.lastPlanFinishDate?bp.lastPlanFinishDate.format("yy-MM-dd"):''
                }
            }

            r.add(bp)
        }
        render r as JSON
    }

    def schedue(){
        def user = springSecurityService.currentUser
        def pl = publicService.plist(user)

        def pid
        def tt

        if(params.task_type && !params.task_type.equals("-1")){
            tt = params.task_type
        }

        if (params.project?.id && !params.project?.id?.equals("-1")){
            pid =  params.long("project.id")
        }

        def developers
        def tasks
        if(pid&&tt){
            tasks = Task.executeQuery("from Task t where t.project.id = :pid and t.type = " + tt,[pid:pid])
            developers = PersonProject.findAllByProjectAndProjectRole(Project.get(pid),ProjectRole.开发人员)
        }

        [pl:pl, tasks: tasks, developers: developers]
    }

    def plan4week(){
        def user = springSecurityService.currentUser
        def b = Batch.executeQuery("from Batch b where b.developer.company = :org",[org:user.company])
    }
}

class Batch4Person
{
    Long personId
    String personName
    String personRole
    String batchIds = ""
    String batchSerials = ""
    int totalPlanHours = 0
    Date lastPlanFinishDate
    String lastPlanFinishDateS = ""
}
