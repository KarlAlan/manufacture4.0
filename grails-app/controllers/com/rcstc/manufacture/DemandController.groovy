package com.rcstc.manufacture

import com.rcstc.personnel.Reward
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import org.apache.poi.ss.usermodel.Workbook
import org.apache.poi.ss.usermodel.WorkbookFactory
import org.joda.time.DateTime
import org.springframework.web.multipart.MultipartHttpServletRequest

import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["hasRole('USER')"])
@Transactional(readOnly = true)
class DemandController {

    private updateDemandStatus(Demand demandInstance){
        if (demandInstance == null) {
            notFound()
            return
        }

        if (demandInstance.hasErrors()) {
            respond demandInstance.errors, view: 'edit'
            return
        }

        demandInstance.save flush: true

        return demandInstance
    }

    def springSecurityService
    def publicService
    def demandService
    def excelImportService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        int offset = params.offset ? params.int('offset') : 0
        def sort = params.sort
        def order = params.order

        long pid                                      // project id

        def dt                                        // demand type
        def dc                                        // demand character
        def dp                                        // demand priority

        def demand_date_type = params.demand_date_type      //需求日期类型
        Date start
        Date end

        if(params.demand_date){
            def sp = params.demand_date.split(" - ")
            assert sp.size() == 2

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")
            start = sdf.parse(sp[0])
            end = sdf.parse(sp[1])
        }

        def demand_status = []                        // demand status
        if(params.demand_status){
            if(params.demand_status instanceof String){
                demand_status.add(params.demand_status)
            } else {
                params.demand_status.each(){
                    demand_status.add(it)
                }
            }
        }

        if(params.demand_type && !params.demand_type.equals("-1")){
            dt = params.demand_type
        }

        if(params.demand_character && !params.demand_character.equals("-1")){
            dc = params.demand_character
        }

        if(params.demand_priority && !params.demand_priority.equals("-1")){
            dp = params.demand_priority
        }

        if (params.pid && !params.pid.equals("-1")){
            pid =  params.long("pid")
        }

        def person = springSecurityService.currentUser
        def result = demandService.searchDemands(person,pid,demand_status,dt,dc,dp,params.demand_category1,params.demand_category2,params.sumb_people,params.demand_serial,start,end,demand_date_type,params.demand_description,params.max,offset,sort,order)

        def pl = publicService.plist(person)

        [demandInstanceList:result["demands"],demandInstanceCount:result["totalCount"],params:params,pl:pl]
    }

    def show(Demand demandInstance) {
        def ops = OperateRecord.findAllByRecordClassAndRecordId("Demand",demandInstance.id,[sort: "operateDate", order: "desc"])
        def tasks = Task.findAllByDemandAndType(demandInstance, TaskType.DEVELOP_TASK)
        respond demandInstance, model:[ops:ops, tasks : tasks]
    }

    def create() {
        respond new Demand(params), model:[pl:publicService.plist(springSecurityService.currentUser),person:springSecurityService.currentUser.name]
    }

    @Transactional
    def save(Demand demandInstance) {
        if (params.serial == null || params.serial == ""){
            long pid
            pid = params.long("project.id")
            demandInstance.serial = publicService.getMaxSerial(pid, "requirmentSerial")
            demandInstance.status = DemandStatus.DRAFT
            demandInstance.backward = false
        }

        if (demandInstance == null) {
            notFound()
            return
        }

        if (demandInstance.hasErrors()) {
            respond demandInstance.errors, view: 'create', model:[pl:publicService.plist(springSecurityService.currentUser)]
            return
        }

        demandInstance.save flush: true

        if(params.file){
            def pf = params.file
            if(pf instanceof String[]){
                pf.each(){ it ->
                    def mf = ManufactureFile.get(it)
                    mf.objectId = demandInstance.id
                    mf.objectType = "Demand"
                }
            } else {
                def mf = ManufactureFile.get(pf)
                mf.objectId = demandInstance.id
                mf.objectType = "Demand"
            }


        }

        //record(demandInstance,"创建")
        event("DEMAND-START",[demandInstance,springSecurityService.currentUser])

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'demand.label', default: 'Demand'), demandInstance.id])
                redirect demandInstance
            }
            '*' { respond demandInstance, [status: CREATED] }
        }
    }

    def edit(Demand demandInstance) {
        def ops = OperateRecord.findAllByRecordClassAndRecordId("Demand",demandInstance.id,[sort: "operateDate", order: "desc"])
        respond demandInstance, model:[pl:publicService.plist(springSecurityService.currentUser),person:springSecurityService.currentUser.name, ops:ops]
    }

    @Transactional
    def update(Demand demandInstance) {
        if (demandInstance == null) {
            notFound()
            return
        }

        if (demandInstance.hasErrors()) {
            respond demandInstance.errors, view: 'edit'
            return
        }

        demandInstance.save flush: true

        //record(demandInstance,"更新")
        event("DEMAND-UPDATE",[demandInstance,springSecurityService.currentUser])

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Demand.label', default: 'Demand'), demandInstance.id])
                redirect demandInstance
            }
            '*' { respond demandInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Demand demandInstance) {

        if (demandInstance == null) {
            notFound()
            return
        }

        demandInstance.delete flush: true

        //record(demandInstance,"删除")
        event("DEMAND-DELETE",[demandInstance,springSecurityService.currentUser])

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Demand.label', default: 'Demand'), demandInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'demand.label', default: 'Demand'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    def demandStat1() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")
        Date start = new Date() - 30
        Date end = new Date()

        if(params.sumbit_start_end_date){
            def sp = params.sumbit_start_end_date.split(" - ")
            assert sp.size() == 2
            start = sdf.parse(sp[0])
            end = sdf.parse(sp[1])

        } else {
            params.sumbit_start_end_date = sdf.format(start)+" - "+sdf.format(end)
        }

        def person = springSecurityService.currentUser
        def projects = demandService.demandStat1(person,start,end)
        [tg:projects['pro'],total:projects['tot'],params: params]
    }

    @Transactional
    def ajaxSuspend(){
        def demandInstance = Demand.get(params.cid)
        demandInstance.status = DemandStatus.CANCELED

        if (!demandInstance.save(flush: true)) {
            demandInstance.errors.each {
                println it
            }
            return
        }

        //record(demandInstance,"作废")
        event("DEMAND-SUSPEND",[demandInstance,springSecurityService.currentUser])

        render true
    }

    @Transactional
    def ajaxUpdateDemandAttr() {
        def attr = params.attr
        def val = params.val
        def tid = params.long("tid")

        if (attr && tid) {
            Demand.executeUpdate("update Demand t set t."+attr+"=:val " + "where t.id=:tid",
                    [val: val, tid: tid])
        } else {
            return
        }

        //record(demandInstance,"更新")
        event("DEMAND-UPDATE",[Demand.get(tid),springSecurityService.currentUser])

        render true
    }





    def demandImport(){

    }

    @Transactional
    def importDemandExcel(){
        def demandsMapList
        if (request instanceof MultipartHttpServletRequest) {
            for (filename in request.getFileNames()){
                def file =request.getFile(filename)
                Workbook book = WorkbookFactory.create(file.inputStream);

                Map CONFIG_DEMAND_COLUMN_MAP = [
                        sheet:'工作表1',
                        startRow: 1,
                        columnMap:  [
                                'A':'系统',
                                'B':'模块',
                                'C':'菜单',
                                'D':'需求内容',
                                'E':'需求分类',
                                'F':'提交者',
                                'G':'提交时间',
                        ]
                ]

                demandsMapList = excelImportService.columns(book, CONFIG_DEMAND_COLUMN_MAP)

                //println demandsMapList

                def projects = Project.list()

                demandsMapList.each { Map demandParams ->
                    def newDemand = new Demand()
                    def p = getProjectByName(projects,demandParams.系统)
                    if(p){
                        newDemand.project = p
                        newDemand.serial = publicService.getMaxSerial(p.id, "requirmentSerial")

                        newDemand.category1 = demandParams.模块
                        newDemand.category2 = demandParams.菜单
                        newDemand.description = demandParams.需求内容
                        newDemand.submitPeople = demandParams.提交者
                        newDemand.planStartDate = demandParams.提交时间.toDate()

                        switch (demandParams.需求分类){
                            case "需求":
                                newDemand.type = DemandType.NEW_FUNCTION
                                newDemand.demandCharacter = DemandCharacter.FUNCTIONAL
                                break
                            case "易用性":
                                newDemand.type = DemandType.NEW_FUNCTION
                                newDemand.demandCharacter = DemandCharacter.USABILITY
                                break
                            case "BUG":
                                newDemand.type = DemandType.BUG
                                newDemand.demandCharacter = DemandCharacter.FUNCTIONAL
                                break
                            case "功能变更":
                                newDemand.type = DemandType.CHANGE_FUNCTION
                                newDemand.demandCharacter = DemandCharacter.FUNCTIONAL
                                break
                            default:
                                newDemand.type = DemandType.NEW_FUNCTION
                                newDemand.demandCharacter = DemandCharacter.CONSTRAINT
                        }


                        newDemand.priority = Priority.NORMAL
                        newDemand.status = DemandStatus.DRAFT
                        newDemand.backward = false

                        if (!newDemand.save()) {
                            println "Demand not saved, errors = ${newDemand.errors}"
                        }

                        event("DEMAND-START",[newDemand,springSecurityService.currentUser])
                    }


                }

            }
            render(contentType: "application/json") {
                Demand(amount: demandsMapList.size())
            }
        } else {
            render false
        }

    }

    private Project getProjectByName(List<Project> projects, name){
        for (def p : projects){
            if(name.equals(p.name)){
                return p
            }
        }
        return null
    }

    @Transactional
    def addDemandEvent(Demand demandInstance){
        def operation = new OperateRecord()
        operation.operation = params.operation
        operation.project = demandInstance.project.name
        operation.recordClass = "Demand"
        operation.person = springSecurityService.currentUser
        operation.username = springSecurityService.currentUser.username
        operation.recordId = demandInstance.id
        operation.description = params.opdescription
        operation.operateDate = new Date()
        if (!operation.save(flush: true)) {
            operation.errors.each {
                println it
            }
            redirect action: "edit", id: demandInstance.id
        }
        redirect action: "edit", id: demandInstance.id
    }

    def ajaxTasks4Demand(){
        def did = params.long("did")
        def tasks = Task.findAllByDemand(Demand.get(did))

        def ts = []
        tasks.each {
            ts.add([serial :it.serial,tid:it.id,proposal:it.proposal,ph:it.planHour,sc:it.scenario,fd:it.finishDate?.format("yy-MM-dd"),
                    status:it.status.name,ty:it.type.name,pe:it.finisher?.name,cp:it.creater?.name,cd:it.createDate?.format("yy-MM-dd"),
                    ap:it.approver?.name,ad:it.approveDate?.format("yy-MM-dd"),ev:it.evaluate,ed:it.evalDesc])
        }

        render ts as JSON
    }

    @Transactional
    def ajaxCreateTask4Demand(){
        def did = params.long("did")
        Demand d = Demand.get(did)

        createTask4Demand(d,params.title, params.proposal, params.scenario, params.int("planHour"))
        render true
    }

    @Secured(["hasRole('USER')"])
    @Transactional
    def buildTask4Demand(Demand demandInstance){
        createTask4Demand(demandInstance,params.task_title, params.task_proposal, params.task_scenario, params.int("planHour"))

        redirect(action: "show", id: demandInstance.id)
    }

    private Demand createTask4Demand(Demand demandInstance,String title, String proposal, String scenario, int planHour){
        Task t = new Task()
        t.project = demandInstance.project
        t.priority = demandInstance.priority
        t.demand = demandInstance
        t.serial = publicService.getMaxSerial(t.project.id, "jobSerial")
        t.status = TaskStatus.ARRANGE
        t.title = title
        t.proposal = proposal
        t.scenario = scenario
        t.planHour = planHour
        t.type = TaskType.DEVELOP_TASK
        t.creater = springSecurityService.currentUser
        t.createDate = new Date()

        t.save(flush: true)

        if(demandInstance.planDeliveryDate){
            demandInstance.planDeliveryDate = null
            demandInstance.save(flush: true)
        }

        event("TASK-START",[t,springSecurityService.currentUser])

        demandInstance
    }

    @Transactional
    def ajaxDeleteTask4Demand(){
        def tid = params.long("tid")
        def t = Task.get(tid)
        if(t.status!=TaskStatus.ACCOMPLISHED&&t.status!=TaskStatus.SIT){
            t.delete(flush: true)
            render true
        } else {
            render false
        }

    }

    @Secured(["hasRole('USER')"])
    @Transactional
    def ajaxForwardUAT(){
        def did = params.long("did")

        // demand to uat
        Demand demand = Demand.get(did)
        forwardNext(demand)

        render true
    }

    @Secured(["hasRole('USER')"])
    @Transactional
    def ajaxBackDevelop(){
        def did = params.long("did")

        Demand demand = Demand.get(did)

        backwardPrev(demand)

        render true
    }

    @Secured(["hasRole('USER')"])
    @Transactional
    def ajaxForwardNext(){
        def did = params.long("did")

        Demand demand = Demand.get(did)

        demand = forwardNext(demand)

        render demand as JSON
    }

    @Transactional
    def forwardNextStep(DemandCommand demandCommand){
        def demandInstance = Demand.get(demandCommand.demand_id)
        demandInstance.properties = params
        demandInstance = forwardNext(demandInstance, demandCommand)

        redirect(action: "show", id: demandInstance.id)

    }

    @Transactional
    def forwardClose(Demand demandInstance){
        demandInstance = forwardNext(demandInstance, null)

        redirect(action: "show", id: demandInstance.id)

    }

    @Transactional
    def backwardPrevStep(DemandCommand demandCommand){
        def demandInstance = Demand.get(demandCommand.demand_id)
        if(demandCommand.operation_type=='suspend'){
            demandInstance.status = DemandStatus.CANCELED
            updateDemandStatus(demandInstance)

            event("DEMAND-SUSPEND",[demandInstance,springSecurityService.currentUser,demandCommand])
        }else if(demandCommand.operation_type=='postpone'){
            demandInstance.status = DemandStatus.DRAFT
            updateDemandStatus(demandInstance)

            event("DEMAND-POSTPONE",[demandInstance,springSecurityService.currentUser,demandCommand])
        }else if(demandCommand.operation_type=='finish'){
            demandInstance.status = DemandStatus.UAT
            updateDemandStatus(demandInstance)

            for (Task task : demandInstance.tasks){
                if(task.status != TaskStatus.ACCOMPLISHED){
                    task.status = TaskStatus.ACCOMPLISHED
                    task.finishDate = new Date()
                    task.finisher = springSecurityService.currentUser

                    task.save(flush: true)
                }
            }

            event("DEMAND-DIRECT-FINISH",[demandInstance,springSecurityService.currentUser,demandCommand])
        }else {
            backwardPrev(demandInstance,demandCommand)
        }

        redirect(action: "show", id: demandInstance.id)
    }

    private Demand forwardNext(Demand demand, DemandCommand demandCommand){
        if(demand.status == DemandStatus.DRAFT){
            if(demand.type == DemandType.BUG){
                demand.status = DemandStatus.DESIGN
                demand.backward = false
                demand.updateDate = new Date()
                updateDemandStatus(demand)

                event("DEMAND-FORWARD-SA",[demand,springSecurityService.currentUser,demandCommand])

            } else {
                demand.status = DemandStatus.ANALYSE
                demand.backward = false
                demand.updateDate = new Date()
                updateDemandStatus(demand)

                event("DEMAND-FORWARD-BA",[demand,springSecurityService.currentUser,demandCommand])

            }
        } else if(demand.status == DemandStatus.ANALYSE){
            demand.status = DemandStatus.DESIGN
            demand.backward = false
            demand.baFinishDate = new Date()
            updateDemandStatus(demand)

            event("DEMAND-FORWARD-SA",[demand,springSecurityService.currentUser,demandCommand])

        } else if(demand.status == DemandStatus.DESIGN){
            if(demand.type == DemandType.BUG){
                demand.status = DemandStatus.DEVELOP
                demand.backward = false
                demand.saFinishDate = new Date()
                updateDemandStatus(demand)

                event("DEMAND-FORWARD-DE",[demand,springSecurityService.currentUser,demandCommand])
            } else {
                demand.status = DemandStatus.AUDIT
                demand.backward = false
                demand.saFinishDate = new Date()
                updateDemandStatus(demand)

                event("DEMAND-FORWARD-AU",[demand,springSecurityService.currentUser,demandCommand])
            }

        } else if(demand.status == DemandStatus.AUDIT){
            demand.status = DemandStatus.DEVELOP
            demand.backward = false
            demand.confirmDate = new Date()
            demand.confirm = springSecurityService.currentUser
            updateDemandStatus(demand)

            event("DEMAND-FORWARD-DE",[demand,springSecurityService.currentUser,demandCommand])

        } else if(demand.status == DemandStatus.SIT){
            demand.status = DemandStatus.UAT
            demand.backward = false
            demand.siFinishDate = new Date()

            for(Task task: demand.tasks){
                if(task.type == TaskType.DEVELOP_TASK && task.status == TaskStatus.SIT){
                    task.status = TaskStatus.ACCOMPLISHED
                    task.save(flush: true)
                }
            }

            updateDemandStatus(demand)

            event("DEMAND-FORWARD-UA",[demand,springSecurityService.currentUser,demandCommand])

        } else if(demand.status == DemandStatus.UAT) {
            demand.uaFinishDate = new Date()
            demand.closeDate = new Date()
            demand.status = DemandStatus.ACCOMPLISHED
            demand.backward = false

            updateDemandStatus(demand)

            // 评价处理结果
            def et = params.evaluate_radio
            def ed = params.evaluate_desc
            def ba = params.evaluate_bad_ba
            def au = params.evaluate_bad_au
            def sa = params.evaluate_bad_sa
            def de = params.evaluate_bad_de
            def si = params.evaluate_bad_si

            //record(demandInstance,"关闭需求")
            event("DEMAND-FINISH",[demand,springSecurityService.currentUser,demandCommand,et,ed,ba,au,sa,de,si])
        } else {

        }

        return demand
    }

    private Demand backwardPrev(Demand demand, DemandCommand demandCommand){
        if(demand.status == DemandStatus.ANALYSE){
            demand.status = DemandStatus.DRAFT
            demand.updateDate = null
            demand.backward = true
            updateDemandStatus(demand)

            event("DEMAND-BACKWARD",[demand,springSecurityService.currentUser,demandCommand])

        } else if(demand.status == DemandStatus.DESIGN){
            demand.status = DemandStatus.ANALYSE
            demand.backward = true
            demand.baFinishDate = null
            updateDemandStatus(demand)

            event("DEMAND-BACKWARD",[demand,springSecurityService.currentUser,demandCommand])

        } else if(demand.status == DemandStatus.AUDIT){
            demand.status = DemandStatus.DESIGN
            demand.backward = true
            demand.saFinishDate = null

            updateDemandStatus(demand)

            event("DEMAND-BACKWARD",[demand,springSecurityService.currentUser,demandCommand])
        } else if(demand.status == DemandStatus.SIT){
            demand.status = DemandStatus.DEVELOP
            demand.backward = true
            demand.deFinishDate = null
            updateDemandStatus(demand)

            for(Task task: demand.tasks){
                if(task.type == TaskType.DEVELOP_TASK&&task.status == TaskStatus.SIT){
                    task.status = TaskStatus.DEVELOP
                    task.save(flush: true)

                    event("TASK-BACKWARD",[task,springSecurityService.currentUser])
                }
            }

            event("DEMAND-BACKWARD",[demand,springSecurityService.currentUser,demandCommand])
        } else if(demand.status == DemandStatus.UAT){
            demand.status = DemandStatus.DESIGN
            demand.backward = true
            demand.saFinishDate = null
            updateDemandStatus(demand)

            event("DEMAND-BACKWARD",[demand,springSecurityService.currentUser,demandCommand])
        } else {

        }

        return demand
    }



    def projectDemandStat(){
        def pid = params.long("pid")

        def person = springSecurityService.currentUser
        def pl = publicService.plist(person)

        if(!pid){
            pid = pl[0]?.id
            params.pid = pid
        }

        def re = Demand.executeQuery("select p.id, p.name, d.category1," +
                " sum(case when d.type = :t1 then 1 else 0 end), " +
                " sum(case when d.type = :t2 then 1 else 0 end), " +
                " sum(case when d.type = :t3 then 1 else 0 end), " +
                " sum(case when d.status = :s1 then 1 else 0 end), " +
                " sum(case when d.status != :s1 then 1 else 0 end) " +
                "from Demand d join d.project p where p.id = :pid and d.status != :s2 and d.status != :s3 group by p.id, p.name, d.category1",
                [pid:pid,t1:DemandType.NEW_FUNCTION,t2:DemandType.CHANGE_FUNCTION,t3:DemandType.BUG,s1:DemandStatus.ACCOMPLISHED,s2:DemandStatus.CANCELED,s3:DemandStatus.DRAFT])

        def r2 = Demand.executeQuery("select p.id, p.name, d.category1," +
                " sum(case when d.status = :s1 then 1 else 0 end)," +
                " sum(case when d.status = :s2 then 1 else 0 end)," +
                " sum(case when d.status = :s3 then 1 else 0 end)," +
                " sum(case when d.status = :s4 then 1 else 0 end)," +
                " sum(case when d.status = :s5 then 1 else 0 end)," +
                " sum(case when d.status = :s6 then 1 else 0 end)," +
                " sum(case when d.status = :s7 then 1 else 0 end)" +
                " from Demand d join d.project p where p.id = :pid and d.status != :s8 and d.status != :s9 group by p.id, p.name, d.category1",
                [pid:pid,s1: DemandStatus.DRAFT,s2: DemandStatus.ANALYSE,s3: DemandStatus.AUDIT,s4:DemandStatus.DESIGN,
                        s5:DemandStatus.DEVELOP,s6:DemandStatus.SIT,s7:DemandStatus.UAT,s8:DemandStatus.ACCOMPLISHED,s9:DemandStatus.CANCELED])

        def nd = [], fd = [], ud = []

        DateTime dt = DateTime.now()
        Date df0 = dt.dayOfWeek().withMinimumValue().toDate()
        Date de0 = dt.dayOfWeek().withMaximumValue().toDate()

        nd[0] = Demand.countByUpdateDateBetweenAndProject(df0,de0,Project.get(pid))
        fd[0] = Demand.countBySiFinishDateBetweenAndProject(df0,de0,Project.get(pid))
        ud[0] = Demand.countByUaFinishDateBetweenAndProject(df0,de0,Project.get(pid))

        DateTime dt1 = dt.plusWeeks(-1)
        Date df1 = dt1.dayOfWeek().withMinimumValue().toDate()
        Date de1 = dt1.dayOfWeek().withMaximumValue().toDate()

        nd[1] = Demand.countByUpdateDateBetweenAndProject(df1,de1,Project.get(pid))
        fd[1] = Demand.countBySiFinishDateBetweenAndProject(df1,de1,Project.get(pid))
        ud[1] = Demand.countByUaFinishDateBetweenAndProject(df1,de1,Project.get(pid))

        DateTime dt2 = dt.plusWeeks(-2)
        Date df2 = dt2.dayOfWeek().withMinimumValue().toDate()
        Date de2 = dt2.dayOfWeek().withMaximumValue().toDate()

        nd[2] = Demand.countByUpdateDateBetweenAndProject(df2,de2,Project.get(pid))
        fd[2] = Demand.countBySiFinishDateBetweenAndProject(df2,de2,Project.get(pid))
        ud[2] = Demand.countByUaFinishDateBetweenAndProject(df2,de2,Project.get(pid))

        DateTime dt3 = dt.plusWeeks(-3)
        Date df3 = dt3.dayOfWeek().withMinimumValue().toDate()
        Date de3 = dt3.dayOfWeek().withMaximumValue().toDate()

        nd[3] = Demand.countByUpdateDateBetweenAndProject(df3,de3,Project.get(pid))
        fd[3] = Demand.countBySiFinishDateBetweenAndProject(df3,de3,Project.get(pid))
        ud[3] = Demand.countByUaFinishDateBetweenAndProject(df3,de3,Project.get(pid))

        [demands: re, params:params, pl: pl, nd:nd, fd: fd, ud: ud, r2:r2]
    }

}


class DemandCommand {

    static constraints = {
        operation_type blank: true
        operation_reason blank: true
        work_hour blank: true, max: 30, min: 0
        demand_id nullable: false
    }

    String operation_type     //操作类型
    String operation_reason     //操作原因
    Integer work_hour          //所需时间（小时）

    Long demand_id
}