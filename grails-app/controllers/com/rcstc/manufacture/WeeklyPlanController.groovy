package com.rcstc.manufacture

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import org.hibernate.FetchMode
import org.joda.time.DateTime

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["hasRole('USER')"])
@Transactional(readOnly = true)
class WeeklyPlanController {

    def springSecurityService
    def publicService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond WeeklyPlan.list(params), model: [weeklyPlanInstanceCount: WeeklyPlan.count()]
    }

    @Transactional
    def weeklyPlan4Person(){
        def offset = params.int("offset")
        if(!offset){
            offset = 0
            params.offset = 0
        }


        def dt = new DateTime()
        def dt1 = dt.plusDays(offset*7)
        int year = dt1.getWeekyear()
        int week = dt1.getWeekOfWeekyear()

        def fd = dt1.dayOfWeek().withMinimumValue().toString("MM/dd")
        def ld = dt1.dayOfWeek().withMaximumValue().toString("MM/dd")

        def p = springSecurityService.currentUser

        //def wps = WeeklyPlan.executeQuery("select wp from WeeklyPlan wp, Person p where wp.year = :year and wp.week = :week and wp.person = p and p.company = :org",[year: year,week: week,org: p.company])
        def wps = WeeklyPlan.findAllByYearAndWeek(year,week)

        for(WeeklyPlan wp : wps){
            def ts = wp.tasks
            BigDecimal pta = ts.size()
            BigDecimal pwl = 0
            BigDecimal ata = 0
            BigDecimal awl = 0
            for (Task t : ts){
                pwl = pwl + t.planHour
                if (t.status == TaskStatus.ACCOMPLISHED){
                    ata = ata + 1
                    awl = awl + t.planHour
                }
            }

            wp.planTasksAmount = pta
            wp.planWorkload = pwl
            wp.actualTasksAmount = ata
            wp.actualWorkload = awl

            wp.save(flush: true)
        }

        [wps: wps, year: year, week: week, fd: fd, ld: ld]
    }

    def weeklyPlan4Project(){
        def pid = params.long("pid")
        def offset = params.int("offset")
        if(!offset)
            offset = 0

        def dt = new DateTime()
        def dt1 = dt.plusDays(offset*7)
        int year = dt1.getWeekyear()
        int week = dt1.getWeekOfWeekyear()

        def fd = dt1.dayOfWeek().withMinimumValue().toString("MM/dd")
        def ld = dt1.dayOfWeek().withMaximumValue().toString("MM/dd")

        def p = springSecurityService.currentUser

        def wps = WeeklyPlan.executeQuery("select wp from WeeklyPlan wp, Person p, PersonProject pp where wp.year = :year and wp.week = :week and wp.person = p and pp.person = p and pp.project.id = :pid",[year: year,week: week,pid: pid])

        [wps: wps, year: year, week: week, fd: fd, ld: ld]
    }

    def show(WeeklyPlan weeklyPlanInstance) {
        respond weeklyPlanInstance
    }

    def create() {
        respond new WeeklyPlan(params)
    }

    @Transactional
    def save(WeeklyPlan weeklyPlanInstance) {
        if (weeklyPlanInstance == null) {
            notFound()
            return
        }

        if (weeklyPlanInstance.hasErrors()) {
            respond weeklyPlanInstance.errors, view: 'create'
            return
        }

        weeklyPlanInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'weeklyPlan.label', default: 'WeeklyPlan'), weeklyPlanInstance.id])
                redirect weeklyPlanInstance
            }
            '*' { respond weeklyPlanInstance, [status: CREATED] }
        }
    }

    def edit(WeeklyPlan weeklyPlanInstance) {
        respond weeklyPlanInstance
    }

    @Transactional
    def update(WeeklyPlan weeklyPlanInstance) {
        if (weeklyPlanInstance == null) {
            notFound()
            return
        }

        if (weeklyPlanInstance.hasErrors()) {
            respond weeklyPlanInstance.errors, view: 'edit'
            return
        }

        weeklyPlanInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'WeeklyPlan.label', default: 'WeeklyPlan'), weeklyPlanInstance.id])
                redirect weeklyPlanInstance
            }
            '*' { respond weeklyPlanInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(WeeklyPlan weeklyPlanInstance) {

        if (weeklyPlanInstance == null) {
            notFound()
            return
        }

        weeklyPlanInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'WeeklyPlan.label', default: 'WeeklyPlan'), weeklyPlanInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'weeklyPlan.label', default: 'WeeklyPlan'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    def schedue(){
        def user = springSecurityService.currentUser
        def pl = publicService.plist(user)

        def pid
        def developers
        def tasks

        if (params.project?.id && !params.project?.id?.equals("-1")){
            pid =  params.long("project.id")
        }

        if(pid){
            if(params.task_type==TaskType.ANALYSE_TASK.id){
                tasks = Task.executeQuery("from Task t where t.project.id = :pid and t.status= :tst and t.type = :ty",[pid:pid,tst:TaskStatus.DRAFT,ty:TaskType.ANALYSE_TASK])
                developers = Person.executeQuery("select p from Person p , PersonProject pp where pp.person = p and pp.projectRole = ? and pp.project.id = ?",[ProjectRole.需求分析师, pid])
            } else if (params.task_type==TaskType.DESIGN_TASK.id){
                tasks = Task.executeQuery("from Task t where t.project.id = :pid and t.status= :tst and t.type = :ty",[pid:pid,tst:TaskStatus.DRAFT,ty:TaskType.DESIGN_TASK])
                developers = Person.executeQuery("select p from Person p , PersonProject pp where pp.person = p and pp.projectRole = ? and pp.project.id = ?",[ProjectRole.系统设计师, pid])
            } else if (params.task_type==TaskType.DEVELOP_TASK.id){
                tasks = Task.executeQuery("from Task t where t.project.id = :pid and t.status= :tst and t.type = :ty",[pid:pid,tst:TaskStatus.ARRANGE,ty:TaskType.DEVELOP_TASK])
                developers = Person.executeQuery("select p from Person p , PersonProject pp where pp.person = p and pp.projectRole = ? and pp.project.id = ?",[ProjectRole.开发人员, pid])
            } else {
                tasks = Task.executeQuery("from Task t where t.project.id = :pid and t.status= :tst and t.type = :ty",[pid:pid,tst:TaskStatus.DRAFT,ty:params.task_type])
                developers = Person.executeQuery("select p from Person p , PersonProject pp where pp.person = p and pp.project.id = ?",[pid])
            }
        }

        def dt = new DateTime()
        int year = dt.getWeekyear()
        int week = dt.getWeekOfWeekyear()

        def fd = dt.dayOfWeek().withMinimumValue().toString("MM/dd")
        def ld = dt.dayOfWeek().withMaximumValue().toString("MM/dd")

        //def wps = WeeklyPlan.findAllByYearAndWeekAndPersonInList(year, week, developers)

        [pl:pl, tasks: tasks, developers: developers, year: year, week: week, fd:fd, ld:ld]
    }

    def ajaxGetOffsetWeek(){
        def offset = params.int("offset")

        def dt = new DateTime()
        def dt1 = dt.plusDays(offset*7)
        int year = dt1.getWeekyear()
        int week = dt1.getWeekOfWeekyear()

        def fd = dt1.dayOfWeek().withMinimumValue().toString("MM/dd")
        def ld = dt1.dayOfWeek().withMaximumValue().toString("MM/dd")

        render (contentType: "application/json") {
            OffsetWeek(year: year, week:week, fd:fd, ld:ld)
        }
    }

    @Secured(["hasRole('ADMIN')"])
    @Transactional
    def ajaxAddTask4Plan(){
        def pid = params.long("pid")
        def tid = params.long("tid")
        def year = params.int("year")
        def week = params.int("week")

        Task task = Task.get(tid)

        def wp = WeeklyPlan.addTask(Person.get(pid), year, week, task)


        Demand demand = task.demand
        def re = Demand.executeQuery("select count(*) from Demand d join d.tasks t where d.id = :did and t.type = :tt and t.status = :ts",[did:demand.id, tt:TaskType.DEVELOP_TASK, ts: TaskStatus.ARRANGE])
        if(re[0] == 0){
            def wpre = WeeklyPlan.executeQuery("select wp.year, wp.week from WeeklyPlan wp join wp.tasks t where t.demand.id = :did order by wp.year , wp.week desc",[did: demand.id])
            def wpre0 = wpre[0]
            if(wpre0){
                def y = wpre0[0]
                def w = wpre0[1]

                DateTime dt = new DateTime(y,1,1,0,0)
                Date planDeliveryDate = dt.plusWeeks(w-1).dayOfWeek().withMaximumValue().plusDays(2).toDate()

                demand.planDeliveryDate = planDeliveryDate

                demand.save(flush: true)
            }

        }
        for(Task t : demand.tasks){
            if(t.type == TaskType.DEVELOP_TASK){
                if(t.status != TaskStatus.ARRANGE){
                    DateTime dt = new DateTime()
                }
            }

        }

        JSON.use("deep")
        def json = new JSON(wp)
        json.setExcludes(WeeklyPlan.class,["class","tasks","person"])
        render json
    }

    @Secured(["hasRole('ADMIN')"])
    @Transactional
    def ajaxRemoveTask4Plan(){
        def wpid = params.long("wpid")
        def tid = params.long("tid")

        Task task = Task.get(tid)

        WeeklyPlan.removeTask(wpid, task)

        Demand demand = task.demand
        if(demand.planDeliveryDate){
            demand.planDeliveryDate = null
            demand.save(flush: true)
        }

        def wp = WeeklyPlan.get(wpid)

        JSON.use("deep")
        def json = new JSON(wp)
        json.setExcludes(WeeklyPlan.class,["class","tasks","person"])
        render json
    }

    def ajaxGetPlan4Person(){
        def pid = params.long("pid")
        def year = params.int("year")
        def week = params.int("week")

        def wps = WeeklyPlan.findAllByYearAndWeekAndPerson(year, week, Person.get(pid))
        /*
        def wps = WeeklyPlan.withCriteria {
            eq "person.id", pid
            eq "year", year
            eq "week", week
            fetchMode "tasks",FetchMode.JOIN
        }
        */

        JSON.use("deep")
        def json = new JSON(wps)
        json.setExcludes(WeeklyPlan.class,["class"])
        json.setIncludes(Task.class,["serial","title","planHour","proposal","scenario","priority","id","project","status"])
        json.setIncludes(Person.class,["id","name"])
        json.setIncludes(Project.class,["id","name"])
        render json
    }

    def ajaxTasks4WeeklyPlan(){
        def wpid = params.long("wpid")
        def wp = WeeklyPlan.get(wpid)
        def tasks = wp.tasks

        def ts = []
        tasks.each {
            ts.add([serial :it.serial,tid:it.id,proposal:it.proposal,ph:it.planHour,sc:it.scenario,dev:wp.person?.name,fd:it.finishDate?.format("yyyy-MM-dd"),status:it.status.name])
        }

        render ts as JSON
    }

    def ajaxWeeklyTasks4Person(){
        def person = springSecurityService.currentUser

        def re = WeeklyPlan.executeQuery("select wp.year, wp.week, t.id, t.serial, t.proposal, t.scenario, t.priority, t.project.name, t.status, t.title from WeeklyPlan wp join wp.tasks t where wp.person.id = :pid and t.type=:tt and (t.status = :ts or t.status = :ts2)", [pid: person.id, ts: TaskStatus.DEVELOP, ts2: TaskStatus.SIT, tt: TaskType.DEVELOP_TASK])

        render re as JSON
    }

    def ajaxWeeklyDesignTasks4Person(){
        def person = springSecurityService.currentUser

        def re = WeeklyPlan.executeQuery("select wp.year, wp.week, d.id, d.serial, d.title, t.priority, t.project.name, t.status from WeeklyPlan wp join wp.tasks t join t.demand d where wp.person.id = :pid and (t.type=:tt1 or t.type=:tt2) and t.status = :ts", [pid: person.id, ts: TaskStatus.DRAFT, tt1: TaskType.ANALYSE_TASK, tt2: TaskType.DESIGN_TASK])

        render re as JSON
    }

    def ajaxSitTasks4Person(){
        def person = springSecurityService.currentUser

        def re = Demand.executeQuery("select d.id, d.serial, d.title, d.priority, d.project.name from Demand d, PersonProject pp where pp.person.id = :pid and pp.projectRole = :role and d.project.id = pp.project.id and d.status = :ts ", [pid: person.id, ts: DemandStatus.SIT, role: ProjectRole.测试人员])

        render re as JSON
    }
}
