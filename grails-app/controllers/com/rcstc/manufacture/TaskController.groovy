package com.rcstc.manufacture

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import org.joda.time.DateTime

import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["hasRole('ADMIN')"])
@Transactional(readOnly = true)
class TaskController {

    def springSecurityService
    def publicService
    def taskService
    def demandService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    @Secured(["hasAnyRole('USER','ADMIN')"])
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        int offset = params.offset ? params.int('offset') : 0

        long pid                        //project id
        if (params.pid && !params.pid.equals("-1")){
            pid =  params.long("pid")
        }

        def task_serial = params.task_serial        //任务序号
        def demand_serial = params.demand_serial    //需求序号


        if(params.exculde_status){
            params.task_status = []
            for(TaskStatus ts  :EnumSet.allOf(TaskStatus)) {
                if(!((ts.id).equals(params.exculde_status))){
                    params.task_status.add(ts.id)
                }
            }
        }

        def task_status = []                        // task status
        if(params.task_status){
            if(params.task_status instanceof String){
                task_status.add(params.task_status)
            } else {
                params.task_status.each(){
                    task_status.add(it)
                }
            }
        }

        def task_type = []                         // task type
        if(params.task_type){
            if(params.task_type instanceof String){
                task_type.add(params.task_type)
            } else {
                params.task_type.each(){
                    task_type.add(it)
                }
            }
        }

        def task_priority                           // Priority
        if(params.task_priority && !params.task_priority.equals("-1")){
            task_priority = params.task_priority
        }

        def task_person_type = params.task_person_type  //任务人类型：创建人、完成人、评价人
        long task_person                                 //任务人
        if(params.task_person){
            def p = Person.findByName(params.task_person)
            if(p){
                task_person = p.id
            }
        }

        def task_date_type = params.task_date_type      //任务日期：创建日期、完成日期、评价日期
        def start, end                                  //日期

        if(params.task_date){
            def sp = params.task_date.split(" - ")
            assert sp.size() == 2

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")
            start = sdf.parse(sp[0])
            end = sdf.parse(sp[1])
        }

        def person = springSecurityService.currentUser
        def result = taskService.searchTasks(person,pid,task_serial,demand_serial,task_priority,task_person_type,task_person,task_date_type,start,end,task_status,task_type,params.max,offset)

        def pl = publicService.plist(person)

        [taskInstanceList:result["tasks"],taskInstanceTotal:result["totalCount"],params:params,pl:pl]
    }

    def show(Task taskInstance) {
        respond taskInstance
    }

    @Secured(["hasRole('USER')"])
    def create() {
        Task t = new Task(params)

        def person = springSecurityService.currentUser
        def pl = publicService.plist(person)

        //def tl = demandService.searchDemands(person,pl[0].id,"10",null,null,null,50,0)
        def tt = []
        tt.add(TaskType.ONLINE_TASK)
        tt.add(TaskType.OTHER_TASK)
        tt.add(TaskType.TRAIN_TASK)
        tt.add(TaskType.DOCUMENT_TASK)
        tt.add(TaskType.MAINTENANCE_TASK)
        tt.add(TaskType.SALE_TASK)
        [taskInstance: t,pl:pl,tt:tt]
    }

    @Secured(["hasRole('USER')"])
    @Transactional
    def saveCommonTask(Task taskInstance) {
        if (taskInstance == null) {
            notFound()
            return
        }

        if (taskInstance.hasErrors()) {
            respond taskInstance.errors, view: 'create'
            return
        }

        taskInstance.serial = publicService.getMaxSerial(taskInstance.project.id, "jobSerial")


        taskInstance.creater = springSecurityService.currentUser
        taskInstance.createDate = new Date()

        if(!taskInstance.finisher)
            taskInstance.finisher = springSecurityService.currentUser
        if(!taskInstance.finishDate)
            taskInstance.finishDate = new Date()
        taskInstance.status = TaskStatus.ACCOMPLISHED

        taskInstance.save flush: true

        event("TASK-FINISH",[taskInstance,springSecurityService.currentUser])


        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'task.label', default: 'Task'), taskInstance.id])
                redirect taskInstance
            }
            '*' { respond taskInstance, [status: CREATED] }
        }
    }

    @Transactional
    def save(Task taskInstance) {
        if (taskInstance == null) {
            notFound()
            return
        }

        if (taskInstance.hasErrors()) {
            respond taskInstance.errors, view: 'create'
            return
        }

        taskInstance.serial = publicService.getMaxSerial(taskInstance.project.id, "jobSerial")
        taskInstance.status = TaskStatus.ARRANGE

        taskInstance.save flush: true

        if(taskInstance.demand){
            Demand d = taskInstance.demand
            d.status = DemandStatus.DEVELOP
            d.saFinishDate = new Date()
            d.save(flush: true)

            //record(taskInstance,"创建")
            event("DEMAND-FORWARD-DE", [d, springSecurityService.currentUser])
            event("TASK-START",[taskInstance,springSecurityService.currentUser])
        }


        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'task.label', default: 'Task'), taskInstance.id])
                redirect taskInstance
            }
            '*' { respond taskInstance, [status: CREATED] }
        }
    }

    def edit(Task taskInstance) {
        def person = springSecurityService.currentUser
        def pl = publicService.plist(person)
        respond taskInstance , model:[pl: pl]
    }

    @Transactional
    def update(Task taskInstance) {
        if (taskInstance == null) {
            notFound()
            return
        }

        if (taskInstance.hasErrors()) {
            respond taskInstance.errors, view: 'edit'
            return
        }

        taskInstance.save flush: true

        event("TASK-UPDATE",[taskInstance,springSecurityService.currentUser])

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'task.label', default: 'Task'), taskInstance.id])
                redirect taskInstance
            }
            '*' { respond taskInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Task taskInstance) {

        if (taskInstance == null) {
            notFound()
            return
        }

        taskInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'task.label', default: 'Task'), taskInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'task.label', default: 'Task'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    def ajaxGetDemandsList(){
        def pid = params.long("pid")
        def person = springSecurityService.currentUser
        def tl = demandService.searchDemands(person,pid,"10",null,null,null,50,0)
        render tl["demands"] as JSON
    }

    @Transactional
    def ajaxDeleteTask(){
        def jid = params.long("jid")

        def task = Task.get(jid)
        Demand d = task.demand
        d.status = DemandStatus.DESIGN
        d.save(flush: true)

        task.delete(flush: true)

        event("DEMAND-BACKWARD",[d,springSecurityService.currentUser])
        render true
    }

    @Transactional
    def ajaxVerifyTask(){
        def tid = params.long("tid")
        def task = Task.get(tid)
        def person = springSecurityService.currentUser

        task.proposal = params.proposal
        task.scenario = params.scenario
        task.remark = params.remark
        task.planHour = params.int("planHour")
        task.verifier = person.name
        task.verifyDate = new Date()
        task.status = TaskStatus.ARRANGE

        task.save(flush: true)
        render true
    }

    @Transactional
    def ajaxAnalyzDemand(){
        def did = params.long("did")
        def d = Demand.get(did)
        d.proposal=params.proposal
        d.status=DemandStatus.ANALYSE

        Task t = new Task()
        t.serial = publicService.getMaxSerial(d.project.id, "jobSerial")
        t.status = TaskStatus.AUDIT
        t.project = d.project
        t.demand=[]
        t.demand.add(d)
        t.priority=d.priority
        t.proposal=d.proposal
        t.planHour=params.int("devTime")
        t.type=TaskType.DEVELOP_TASK

        t.save flush: true
        d.save flush: true

        render true
    }

    @Transactional
    def ajaxUpdateTask(){
        def tid = params.long("tid")
        def t = Task.get(tid)

        t.proposal = params.proposal
        t.scenario = params.scenario
        t.remark = params.remark
        t.planHour = params.int("planHour")

        t.save flush: true

        render true
    }

    def createDevelopTask()  {
        def did = params.long("did")
        Task t = new Task(params)
        if(did){
            Demand d = Demand.get(did)
            t.demand = d
            t.description = d.description
            t.priority = d.priority
            t.project = d.project
            t.type = TaskType.DEVELOP_TASK
        }
        def person = springSecurityService.currentUser
        def pl = publicService.plist(person)

        [taskInstance: t,pl:pl]
    }


    @Secured(["hasRole('USER')"])
    @Transactional
    def ajaxForwardSIT(){
        def tid = params.long("tid")
        def t = Task.get(tid)

        t.status = TaskStatus.SIT
        t.finishDate = new Date()
        t.finisher = springSecurityService.currentUser
        //t.verifier = springSecurityService.currentUser.name

        Demand d = t.demand
        boolean uatTag = true
        for (Task ta : d.tasks){
            if(ta.status != TaskStatus.SIT && ta.status != TaskStatus.ACCOMPLISHED && ta.type == TaskType.DEVELOP_TASK){
                uatTag = false
                break
            }
        }
        if(uatTag){
            d.status = DemandStatus.SIT
            d.deFinishDate = new Date()

            event("DEMAND-FORWARD-SI",[d,springSecurityService.currentUser])
        }


        t.save(flush: true)

        //record(t,"提交SIT")
        event("TASK-FORWARD",[t,springSecurityService.currentUser])

        render true
    }

    @Secured(["hasRole('USER')"])
    @Transactional
    def ajaxForwardUAT(){
        def tid = params.long("tid")
        def t = Task.get(tid)

        t.status = TaskStatus.ACCOMPLISHED

        // demand to uat
        Demand d = t.demand
        boolean uatTag = true
        for (Task ta : d.tasks){
            if(ta.status != TaskStatus.ACCOMPLISHED){
                uatTag = false
                break
            }
        }
        if(uatTag){
            t.demand.status = DemandStatus.UAT
            t.demand.siFinishDate = new Date()

            event("DEMAND-FORWARD-SI",[t.demand,springSecurityService.currentUser])
        }

        t.save(flush: true)

        //record(t,"提交UAT")
        event("TASK-FINISH",[t,springSecurityService.currentUser])
        render true
    }

    @Secured(["hasRole('USER')"])
    @Transactional
    def ajaxBackDevelop(){
        def tid = params.long("tid")
        def t = Task.get(tid)

        t.status = TaskStatus.DEVELOP
        t.demand.status = DemandStatus.DEVELOP

        t.save(flush: true)

        //record(t,"SIT不通过")
        event("DEMAND-BACKWARD",[t.demand,springSecurityService.currentUser])
        event("TASK-BACKWARD",[t,springSecurityService.currentUser])
        render true
    }

    @Secured(["hasRole('USER')"])
    def myWeeklyTasks(){
        def pid = params.long("pid")
        if(!pid){
            pid = springSecurityService.currentUser.id
        }

        def re = WeeklyPlan.executeQuery("select wp.year, wp.week, t.id, t.serial, t.proposal, t.scenario, t.priority, t.project.name, t.status, t.demand.description, t.demand.category1, t.demand.category2, t.demand.serial, t.demand.id from WeeklyPlan wp join wp.tasks t where wp.person.id = :pid and (t.status = :ts or t.status = :ts2) order by wp.year, wp.week, t.priority", [pid: pid, ts: TaskStatus.DEVELOP, ts2: TaskStatus.SIT])
        [tasks: re]
    }

    @Secured(["hasRole('USER')"])
    def tasksStat(){
        DateTime now = new DateTime()

        def f1 = now.dayOfMonth().withMinimumValue().toDate()
        def f2 = now.dayOfMonth().withMaximumValue().toDate()

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")

        if(params.start_end_date){
            def sp = params.start_end_date.split(" - ")
            assert sp.size() == 2

            f1 = sdf.parse(sp[0])
            f2 = sdf.parse(sp[1])
        } else {
            params.start_end_date = f1.format("yyyy-MM-dd") + " - " + f2.format("yyyy-MM-dd")
        }

        def pt = Task.executeQuery("select t.project.name, count(t.id), sum(t.planHour), sum(case when t.evaluate ='good' then 1 else 0 end),sum(case when t.evaluate ='normal' then 1 else 0 end),sum(case when t.evaluate ='bad' then 1 else 0 end), t.project.id from Task t where t.status = :ts and t.finishDate between :f1 and :f2 group by t.project.name, t.project.id",[ts: TaskStatus.ACCOMPLISHED, f1:f1,f2:f2])

        def ut = Task.executeQuery("select t.finisher.name, count(t.id), sum(t.planHour), sum(case when t.evaluate ='good' then 1 else 0 end),sum(case when t.evaluate ='normal' then 1 else 0 end),sum(case when t.evaluate ='bad' then 1 else 0 end) from Task t where t.status = :ts and t.finishDate between :f1 and :f2 group by t.finisher.name",[ts: TaskStatus.ACCOMPLISHED,f1:f1,f2:f2])

        [projectTask: pt, userTask: ut, params: params]
    }



    @Secured(["hasRole('USER')"])
    def yearlyPersonStat(){
        DateTime now = new DateTime()

        def ye = params.year?params.int("year"):now.getYear()
        def pid = params.long("pid")

        if(!params.year)
            params.year = ye

        def ut = Task.executeQuery("select MONTH(t.finishDate), count(t.id), sum(t.planHour), sum(case when t.evaluate ='good' then 1 else 0 end),sum(case when t.evaluate ='normal' then 1 else 0 end),sum(case when t.evaluate ='bad' then 1 else 0 end) from Task t join t.finisher u with u.id = :pid where t.status = :ts and year(t.finishDate) = :ye group by MONTH(t.finishDate)",[ts: TaskStatus.ACCOMPLISHED,ye:ye,pid:pid])

        [userTask: ut, params: params]
    }

    def taskDetailStat(Integer max){
        params.max = Math.min(max ?: 10, 100)
        int offset = params.offset ? params.int('offset') : 0

        def person = springSecurityService.currentUser
        def pl = publicService.plist(person)

        def pid = params.long("pid")
        if(!pid){
            pid = pl[0]?.id
            params.pid = pid
        }

        DateTime now = new DateTime()
        def f1 = now.dayOfMonth().withMinimumValue().toDate()
        def f2 = now.dayOfMonth().withMaximumValue().toDate()

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")

        if(params.start_end_date){
            def sp = params.start_end_date.split(" - ")
            assert sp.size() == 2

            f1 = sdf.parse(sp[0])
            f2 = sdf.parse(sp[1])
        } else {
            params.start_end_date = f1.format("yyyy-MM-dd") + " - " + f2.format("yyyy-MM-dd")
        }

        def re = Task.executeQuery("select u.name, t.type, count(t.id), sum(t.planHour), sum(case when t.evaluate ='good' then 1 else 0 end),sum(case when t.evaluate ='normal' then 1 else 0 end),sum(case when t.evaluate ='bad' then 1 else 0 end) from Task t join t.project p join t.finisher u  where p.id = :pid and t.status = :ts and t.finishDate between :fs and :fe group by u.name, t.type order by u.name",
                [pid:pid,ts:TaskStatus.ACCOMPLISHED,fs:f1,fe:f2])

        [tasks: re, pl:pl, params: params]
    }

    @Secured(["hasRole('USER')"])
    def createDeployTask() {
        Task t = new Task(params)

        def person = springSecurityService.currentUser

        def pid = params.long("pid")
        def p = Project.get(pid)
        def demands = Demand.findAllByStatusAndProjectAndDeployDateIsNull(DemandStatus.ACCOMPLISHED,p)

        [taskInstance: t, demands: demands, project: p]
    }

    @Secured(["hasRole('USER')"])
    def indexDeployTask(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        int offset = params.offset ? params.int('offset') : 0

        def person = springSecurityService.currentUser
        def pl = publicService.plist(person)

        def p
        if(params.pid){
            p = Project.get(params.long("pid"))
        } else {
            p = Project.get(pl[0].id)
        }

        def tasks
        def total = [0]

        if(p){
            tasks = Task.findAllByTypeAndProject(TaskType.DEPLOYMENT_TASK,p,[max: max, offset: offset, sort: "createDate", order: "desc"])
            total = Task.countByTypeAndProject(TaskType.DEPLOYMENT_TASK,p)
        }

        [taskInstanceList: tasks,pl:pl, taskInstanceTotal: total, params: params]
    }

    @Secured(["hasRole('USER')"])
    @Transactional
    def saveDeployTask(Task taskInstance) {
        if (taskInstance == null) {
            notFound()
            return
        }

        if (taskInstance.hasErrors()) {
            respond taskInstance.errors, view: 'createDeployTask'
            return
        }

        def deploy_name = []                         // demands
        if(params.deploy_name){
            if(params.deploy_name instanceof String){
                deploy_name.add(params.deploy_name)
            } else {
                params.deploy_name.each(){
                    deploy_name.add(it)
                }
            }

            taskInstance.proposal = "以下需求在" +  (new Date()).format("yy-MM-dd") + "发布到生产环境:"
        }



        for(String did : deploy_name){
            Demand demand = Demand.get(did.toLong())
            demand.deployDate = new Date()

            demand.save(flush: true)

            taskInstance.proposal = taskInstance.proposal + " " + demand.serial +","
        }


        taskInstance.serial = publicService.getMaxSerial(taskInstance.project.id, "jobSerial")
        taskInstance.status = TaskStatus.ACCOMPLISHED
        taskInstance.creater =  springSecurityService.currentUser
        taskInstance.createDate = new Date()
        taskInstance.finisher = springSecurityService.currentUser
        taskInstance.finishDate = new Date()

        taskInstance.save flush: true

        event("DEPLOY-TASK-FINISHED",[taskInstance,springSecurityService.currentUser])

        redirect action: "indexDeployTask",params:[pid: taskInstance.project.id]
    }

    @Secured(["hasRole('USER')"])
    def ajaxDemands4Deploy(){
        def pid = params.long("pid")
        def demands = Demand.findAllByStatusInListAndProjectAndDeployDateIsEmpty([DemandStatus.UAT,DemandStatus.ACCOMPLISHED],Project.get(pid))

        render demands as JSON
    }

    def planTasksStat(){
        def person = springSecurityService.currentUser

        DateTime dt = DateTime.now()
        def year = dt.getWeekyear()
        def week = dt.getWeekOfWeekyear()

        def re = Task.executeQuery("select u.name," +
                " sum(case when (wp.year<:year or (wp.year=:year and wp.week < :week)) and ts.status != 99 then 1 else 0 end)," +
                " sum(case when (wp.year<:year or (wp.year=:year and wp.week < :week)) and ts.status != 99 then ts.planHour else 0 end)," +
                " sum(case when wp.year=:year and wp.week = :week then 1 else 0 end)," +
                " sum(case when wp.year=:year and wp.week = :week then ts.planHour else 0 end)," +
                " sum(case when (wp.year=:year and wp.week = :week) and ts.status = 99 then 1 else 0 end)," +
                " sum(case when (wp.year=:year and wp.week = :week) and ts.status = 99 then ts.planHour else 0 end)," +
                " sum(case when wp.year>:year or (wp.year=:year and wp.week > :week) then 1 else 0 end)," +
                " sum(case when wp.year>:year or (wp.year=:year and wp.week > :week) then ts.planHour else 0 end)," +
                " sum(case when (wp.year>:year or (wp.year=:year and wp.week > :week)) and ts.status = 99 then 1 else 0 end)," +
                " sum(case when (wp.year>:year or (wp.year=:year and wp.week > :week)) and ts.status = 99 then ts.planHour else 0 end)" +
                " from WeeklyPlan wp join wp.person u right join wp.tasks ts where u.enabled = true and u.company = :org group by u.name",
                [org:person.company, year: year, week: week])

        [weekplan: re]
    }

    def planingTasks(Integer max){
        params.max = Math.min(max ?: 10, 100)
        int offset = params.offset ? params.int('offset') : 0

        def task_status = []                        // task status
        if(params.task_status){
            if(params.task_status instanceof String){
                task_status.add(params.task_status)
            } else {
                params.task_status.each(){
                    task_status.add(it)
                }
            }
        }

        def result = taskService.planingTasks(params.task_serial,params.task_person_name,task_status,0,0,0,params.max,offset)
        [tasks: result["tasks"], taskInstanceCount: result["totalCount"],params:params]
    }

    @Secured(["hasRole('USER')"])
    def indexTroubleTask(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        int offset = params.offset ? params.int('offset') : 0

        def person = springSecurityService.currentUser
        def pl = publicService.plist(person)

        def p
        if(params.pid){
            p = Project.get(params.long("pid"))
        } else {
            p = Project.get(pl[0].id)
        }

        def tasks
        def total = [0]

        if(p){
            tasks = Task.findAllByTypeAndProject(TaskType.TROUBLE_SHOOTING_TASK,p,[max: max, offset: offset, sort: "createDate", order: "desc"])
            total = Task.countByTypeAndProject(TaskType.TROUBLE_SHOOTING_TASK,p)
        }

        [taskInstanceList: tasks,pl:pl, taskInstanceTotal: total, params: params]
    }

    @Secured(["hasRole('USER')"])
    @Transactional
    def saveTroubleTask(Task taskInstance) {
        if (taskInstance == null) {
            notFound()
            return
        }

        if (taskInstance.hasErrors()) {
            respond taskInstance.errors, view: 'createDeployTask'
            return
        }

        def deploy_name = []                         // demands
        if(params.deploy_name){
            if(params.deploy_name instanceof String){
                deploy_name.add(params.deploy_name)
            } else {
                params.deploy_name.each(){
                    deploy_name.add(it)
                }
            }

            taskInstance.proposal = "以下需求在" +  (new Date()).format("yy-MM-dd") + "发布到生产环境:"
        }



        for(String did : deploy_name){
            Demand demand = Demand.get(did.toLong())
            demand.deployDate = new Date()

            demand.save(flush: true)

            taskInstance.proposal = taskInstance.proposal + " " + demand.serial +","
        }


        taskInstance.serial = publicService.getMaxSerial(taskInstance.project.id, "jobSerial")
        taskInstance.status = TaskStatus.ACCOMPLISHED
        taskInstance.creater =  springSecurityService.currentUser
        taskInstance.createDate = new Date()
        taskInstance.finisher = springSecurityService.currentUser
        taskInstance.finishDate = new Date()

        taskInstance.save flush: true

        event("TROUBLE-SHOOTING-TASK-FINISHED",[taskInstance,springSecurityService.currentUser])

        redirect action: "indexTroubleTask",params:[pid: taskInstance.project.id]
    }

    @Secured(["hasRole('USER')"])
    def createTroubleTask() {
        Task t = new Task(params)

        def person = springSecurityService.currentUser

        def pid = params.long("pid")
        def p = Project.get(pid)

        [taskInstance: t, project: p]
    }

    def statBackwardTask(Integer max){
        params.max = Math.min(max ?: 10, 100)
        int offset = params.offset ? params.int('offset') : 0

        DateTime now = new DateTime()

        def f1 = now.dayOfMonth().withMinimumValue().toDate()
        def f2 = now.dayOfMonth().withMaximumValue().toDate()

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")

        if(params.start_end_date){
            def sp = params.start_end_date.split(" - ")
            assert sp.size() == 2

            f1 = sdf.parse(sp[0])
            f2 = sdf.parse(sp[1])
        } else {
            params.start_end_date = f1.format("yyyy-MM-dd") + " - " + f2.format("yyyy-MM-dd")
        }

        def result = taskService.statBackward(f1, f2, params.task_person_name, params.back_times)
        [tasks: result["tasks"], params:params]
    }

    /*
    周计划统计报表
    1、周：指安排开发计划日期，转为周；
    2、需求序号：指录入需求时产生的号；
    3、简单描述：需求描述；
    4、是否完成：SIT完成为“是”，否则为“否”；

    5、是否通过：UAT测试通过为“是”，不通过为“否”，为测试为空；
    6、是否发布：发布登记为“是”，否则为“否”；
     */
    def weekplanReport1(){
        def person = springSecurityService.currentUser

        int max = params.max ? params.int('max') : 10
        int offset = params.offset ? params.int('offset') : 0

        DateTime dt = DateTime.now()
        int year = dt.getWeekyear()
        int week = dt.getWeekOfWeekyear()

        if(params.demand_week){
            year = params.demand_year ? params.int("demand_year") : year
            week = params.demand_week ? params.int("demand_week") : week
        } else {
            params.demand_year = year
            params.demand_week = week
        }

        DateTime dt1 = new DateTime(year,1,1,0,0)
        Date stop_date = dt1.plusWeeks(week-1).dayOfWeek().withMaximumValue().toDate()
        Date start_date = dt1.plusWeeks(week-1).dayOfWeek().withMinimumValue().toDate()

        def pl = publicService.plist(person)
        def plids = new Long[pl.size()]
        pl.eachWithIndex {it,index ->
            plids[index] = it.id
        }

        // 通过Task和WeeklyPlan的关系获取
        //def r1 = Demand.executeQuery("select d.priority, d.serial, d.title, d.project.name, case when d.status = 31 or d.status = 32 or d.status = 99 then 1 else 0 end, case when d.status = 32 or d.status = 99 then 1 else 0 end, case when d.deployDate != null then 1 else 0 end from Demand d, WeeklyPlan wp join wp.tasks t where t.demand = d and wp.year = :year and wp.week = :week",[year: year, week: week, max: max,offset: offset])

        // 直接根据Demnand的计划日期进行过滤
        def r1 = Demand.executeQuery("select d.priority, d.serial, d.title, d.project.name, case when d.status = 31 or d.status = 32 or d.status = 99 then 1 else 0 end, case when d.status = 32 or d.status = 99 then 1 else 0 end, case when d.deployDate != null then 1 else 0 end, d.status from Demand d where d.planDeliveryDate between :pd and :ps and d.project.id in (:pids)",[pids: plids, pd: start_date, ps: stop_date, max: max,offset: offset])
        def rcount = Demand.executeQuery("select count(*) from Demand d where d.planDeliveryDate between :pd and :ps and d.project.id in (:pids)",[pids: plids, pd: start_date, ps: stop_date])
        [demands: r1, demandsCount: rcount[0], params: params, pl: pl]

    }
}
