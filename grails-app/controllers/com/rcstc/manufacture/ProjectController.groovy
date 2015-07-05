package com.rcstc.manufacture

import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured
import org.joda.time.DateTime

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["hasAnyRole('ADMIN','BUSINESS')"])
@Transactional(readOnly = true)
class ProjectController {

    def springSecurityService
    def publicService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def org = springSecurityService.currentUser.company
        //def ps = Project.findAllByFristPartyOrSecondParty(org,org,[max:params.max ,offset:params.offset?:0])
        //def psc = Project.countByFristPartyOrSecondParty(org,org)

        def r
        def c = []
        if(SpringSecurityUtils.ifAnyGranted("SUPER_ADMIN,BUSINESS")){
            //r = Project.executeQuery("from Project p where p.id in (select pr.id from PersonProject pp join pp.person pe join pp.project pr where pe.id = :uid) or p.fristParty = :org or p.secondParty = :org or p.thirdParty = :org or p.fourthParty = :org",[uid:springSecurityService.currentUser.id,org:org,max:params.max ,offset:params.offset?:0])
            //c = Project.executeQuery("select count(*) from Project p where p.id in (select pr.id from PersonProject pp join pp.person pe join pp.project pr where pe.id = :uid) or p.fristParty = :org or p.secondParty = :org or p.thirdParty = :org or p.fourthParty = :org",[uid:springSecurityService.currentUser.id,org:org])
            r = Project.list(params)
            c[0] = Project.count()
        }else if(SpringSecurityUtils.ifAnyGranted("SUPERVISOR")) {
            r = Project.executeQuery("from Project p where p.id in (select pr.id from PersonProject pp join pp.person pe join pp.project pr where pe.id = :uid) or p.fristParty = :org or p.secondParty = :org or p.thirdParty = :org or p.fourthParty = :org",[uid:springSecurityService.currentUser.id,org:org,max:params.max ,offset:params.offset?:0])
            c = Project.executeQuery("select count(*) from Project p where p.id in (select pr.id from PersonProject pp join pp.person pe join pp.project pr where pe.id = :uid) or p.fristParty = :org or p.secondParty = :org or p.thirdParty = :org or p.fourthParty = :org",[uid:springSecurityService.currentUser.id,org:org])
        }else {
            r = Project.executeQuery("from Project p where p.id in (select pr.id from PersonProject pp join pp.person pe join pp.project pr where pe.id = :uid)",[uid:springSecurityService.currentUser.id,max:params.max ,offset:params.offset?:0])
            c = Project.executeQuery("select count(*) from Project p where p.id in (select pr.id from PersonProject pp join pp.person pe join pp.project pr where pe.id = :uid)",[uid:springSecurityService.currentUser.id])
        }

        respond r, model: [projectInstanceCount: c[0]]
    }

    def show(Project projectInstance) {
        respond projectInstance
    }

    @Secured(["hasAnyRole('ADMIN')"])
    def create() {
        def org = springSecurityService.currentUser.company
        def iss = InformationSystem.findAll()
        respond new Project(params), model: [iss:iss]
    }

    @Transactional
    def save(Project projectInstance) {
        if (projectInstance == null) {
            notFound()
            return
        }

        if (projectInstance.hasErrors()) {
            respond projectInstance.errors, view: 'create'
            return
        }

        projectInstance.save flush: true

        def person = springSecurityService.currentUser
        PersonProject.create(person,projectInstance,ProjectRole.项目领导小组成员,true)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'project.label', default: 'Project'), projectInstance.id])
                redirect projectInstance
            }
            '*' { respond projectInstance, [status: CREATED] }
        }
    }

    def edit(Project projectInstance) {
        def org = springSecurityService.currentUser.company
        //def iss = InformationSystem.findAllByOrg(org)
        def iss = InformationSystem.findAll()
        def ops = OperateRecord.findAllByRecordClassAndRecordId("Project",projectInstance.id,[sort: "operateDate", order: "desc"])
        respond projectInstance, model: [iss:iss, ops:ops]
    }

    @Transactional
    def update(Project projectInstance) {
        if (projectInstance == null) {
            notFound()
            return
        }

        if (projectInstance.hasErrors()) {
            respond projectInstance.errors, view: 'edit'
            return
        }

        projectInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Project.label', default: 'Project'), projectInstance.id])
                redirect projectInstance
            }
            '*' { respond projectInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Project projectInstance) {

        if (projectInstance == null) {
            notFound()
            return
        }

        projectInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Project.label', default: 'Project'), projectInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'project.label', default: 'Project'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    def people4Project() {
        def person = springSecurityService.currentUser
        Set projects = []
        if(SpringSecurityUtils.ifAnyGranted("SUPER_ADMIN,BUSINESS")){
            //projects = Project.findAllByFristPartyOrSecondParty(person.company,person.company)
            projects = Project.findAllByStatusNotEqual(ProjectStatus.关闭)
        } else if(SpringSecurityUtils.ifAnyGranted("SUPERVISOR")) {
            projects = Project.findAllByFristPartyOrSecondParty(person.company,person.company)
        } else {
            def personProjects = PersonProject.findAllByPerson(person)

            if(personProjects)
            {
                for (def personProject : personProjects) {
                    projects << personProject.project
                }
            }
        }

        [projects:projects]
    }

    def ajaxPeople4Project(){
        def pid = params.long("pid")
        def pps = PersonProject.findAllByProject(Project.get(pid))
        def persons = []
        if(pps)
        {
            for (def personProject : pps) {
                persons << [personProject.id,personProject.person.name, personProject.projectRole, personProject.person.email, personProject.person.phone, personProject.person.company, personProject.person.id, personProject.projectRole.id, personProject.person.username]
            }
        }
        render persons as JSON
    }

    def ajaxPeopleInProject(){
        def pid = params.long("project")
        def p = Project.get(pid)
        def pl = [p.fristParty,p.secondParty]
        if(p.thirdParty)
            pl.add(p.thirdParty)
        if(p.fourthParty)
            pl.add(p.fourthParty)
        def persons = Person.findAllByCompanyInList(pl)

        render persons as JSON
    }

    @Transactional
    def ajaxDeletePeopleInProject(){
        def project = Project.get(params.long("project"))
        def person = Person.get(params.long("person"))
        def pp = ProjectRole.valueOf(params.pp)

        PersonProject.remove(person,project,pp,true)

        event topic:"TEAM-LEAVE", data:new PersonProject(project:project,person:person,projectRole:pp)

        render true
    }

    @Transactional
    def ajaxAddPeopleInProject(){
        def project = Project.get(params.long("project"))
        def person = Person.findByEmail(params.person_email)
        if(!person){
            render false
        }
        def pp = ProjectRole.valueOf(params.pp)

        PersonProject.create(person,project,pp,true)

        //def cl = countListeners("JOIN_TEAM")
        //println(cl)

        event topic:"TEAM-JOIN", data:new PersonProject(project:project,person:person,projectRole:pp), fork:false
        //def reply = event("JOIN_TEAM",new PersonProject(project:project,person:person,projectRole:pp), [fork:false])

        //println(reply)

        render true
    }

    def projectSituation(){
        def pid = params.long("pid")
        def person = springSecurityService.currentUser
        def pl = publicService.plist(person)
        if(pid){
            def ps = publicService.projectSituation(pid)

            [ps:ps,pl:pl]
        } else {
            [pl:pl]
        }

    }

    @Secured(["hasAnyRole('USER','BUSINESS','SALESMAN')"])
    def ajaxCompanyName(){
        def org = params.query
        def r = Person.executeQuery("select distinct p.company from Person p where p.company like :org",[org:'%'+org+'%'])
        render r as JSON
    }

    def ajaxGetProject(){
        def pid = params.long("pid")
        render Project.get(pid) as JSON
    }

    @Transactional
    def addProjectEvent(Project projectInstance){
        def operation = new OperateRecord()
        operation.operation = params.operation
        operation.project = projectInstance.name
        operation.recordClass = "Project"
        operation.person = springSecurityService.currentUser
        operation.username = springSecurityService.currentUser.username
        operation.recordId = projectInstance.id
        operation.description = params.opdescription
        operation.operateDate = new Date()
        if (!operation.save(flush: true)) {
            operation.errors.each {
                println it
            }
            redirect action: "edit", id: projectInstance.id
        }
        redirect action: "edit", id: projectInstance.id
    }

    def tracking(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def org = springSecurityService.currentUser.company

        def r
        def c = []
        if(SpringSecurityUtils.ifAnyGranted("SUPER_ADMIN,BUSINESS")){
            r = Project.list(params)
            c[0] = Project.count()
        } else if(SpringSecurityUtils.ifAnyGranted("SUPERVISOR")){
            r = Project.executeQuery("from Project p where p.id in (select pr.id from PersonProject pp join pp.person pe join pp.project pr where pe.id = :uid) or p.fristParty = :org or p.secondParty = :org or p.thirdParty = :org or p.fourthParty = :org",[uid:springSecurityService.currentUser.id,org:org,max:params.max ,offset:params.offset?:0])
            c = Project.executeQuery("select count(*) from Project p where p.id in (select pr.id from PersonProject pp join pp.person pe join pp.project pr where pe.id = :uid) or p.fristParty = :org or p.secondParty = :org or p.thirdParty = :org or p.fourthParty = :org",[uid:springSecurityService.currentUser.id,org:org])
        }else {
            r = Project.executeQuery("from Project p where p.id in (select pr.id from PersonProject pp join pp.person pe join pp.project pr where pe.id = :uid)",[uid:springSecurityService.currentUser.id,max:params.max ,offset:params.offset?:0])
            c = Project.executeQuery("select count(*) from Project p where p.id in (select pr.id from PersonProject pp join pp.person pe join pp.project pr where pe.id = :uid)",[uid:springSecurityService.currentUser.id])
        }

        def pws = []
        r.each {
            def pr = it
            def wr = WeeklyReport.findByProject(pr,[sort: "buildDate", order: "desc"])
            def itp = PersonProject.findAllByProjectAndProjectRole(pr,ProjectRole.IT部负责人)
            def yup = PersonProject.findAllByProjectAndProjectRole(pr,ProjectRole.运营部负责人)
            def yep = PersonProject.findAllByProjectAndProjectRole(pr,ProjectRole.业务负责人)
            def pw = [project: pr, weekly: wr, itp: itp, yup: yup, yep: yep]
            pws.add(pw)
        }


        [pws:pws,projectInstanceCount: c[0]]
    }

    def demandDoc4Project(){
        def pid = params.long("pid")
        //def docType = params.docType

        def demands
        def project
        def mfile

        if(pid){
            project = Project.get(pid)
            demands = Demand.executeQuery("select d.id, d.category1, d.category2, d.serial, d.description from Demand d join d.project p where p.id = :pid and d.status != :ds1 and d.status != :ds2 and d.type != :dt1 order by d.category1, d.category2",[pid:pid,ds1:DemandStatus.CANCELED,ds2:DemandStatus.DRAFT,dt1:DemandType.BUG])

            mfile = ManufactureFile.executeQuery("select d.id, mf.id, mf.originalFilename, mf.fileType from ManufactureFile mf, Demand d where mf.objectType = 'Demand' and mf.objectId = d.id and d.project.id = :pid",[pid:pid])

        }

        [demands: demands, project: project, mfile:mfile]
    }

    def designDoc4Project(){
        def pid = params.long("pid")

        def project = Project.get(pid)
        def designs = Demand.executeQuery("select d.id, d.category1, d.category2, d.serial, t.proposal from Demand d join d.project p join d.tasks t where p.id = :pid and d.status != :ds1 and d.status != :ds2 and d.status != :ds3 and d.status != :ds4 and d.status != :ds5 and d.type != :dt1 and t.type = :tt order by d.category1, d.category2, d.serial",[pid:pid,ds1:DemandStatus.CANCELED,ds2:DemandStatus.DRAFT,ds3:DemandStatus.ANALYSE,ds4:DemandStatus.AUDIT,ds5:DemandStatus.DESIGN,dt1:DemandType.BUG,tt:TaskType.DEVELOP_TASK])

        [designs: designs, project: project]
    }

    def testReport4Project(){
        def pid = params.long("pid")

        def project = Project.get(pid)
        def testReports = Demand.executeQuery("select d.id, d.category1, d.category2, d.serial, t.scenario from Demand d join d.project p join d.tasks t where p.id = :pid and d.status != :ds1 and d.status != :ds2 and d.status != :ds3 and d.status != :ds4 and d.status != :ds5 and d.type != :dt1 and t.type = :tt order by d.category1, d.category2, d.serial",[pid:pid,ds1:DemandStatus.CANCELED,ds2:DemandStatus.DRAFT,ds3:DemandStatus.ANALYSE,ds4:DemandStatus.AUDIT,ds5:DemandStatus.DESIGN,dt1:DemandType.BUG,tt:TaskType.DEVELOP_TASK])

        [testReports: testReports, project: project]
    }

    def serviceIndicator(){
        def pid = params.long("pid")
        if(!pid){
            pid = 0L
        }
        DateTime now = new DateTime()
        def mo = params.month?params.int("month"):now.getMonthOfYear()
        def ye = params.year?params.int("year"):now.getYear()

        if(!params.month)
            params.month = mo
        if(!params.year)
            params.year = ye

        DateTime dt = new DateTime(ye,mo,1,2,0)
        def m1 = dt.dayOfMonth().withMinimumValue().toDate()
        def m2 = dt.dayOfMonth().withMaximumValue().toDate()

        def person = springSecurityService.currentUser
        def pl = publicService.plist(person)

        def hours = Task.executeQuery("select t.type, sum(t.planHour) from Task t join t.project p where p.id = :pid and t.status = :ts and t.finishDate between :m1 and :m2 group by t.type ",[pid: pid, ts:TaskStatus.ACCOMPLISHED, m1: m1, m2: m2])
        def total = 0, des = 0, dev = 0
        hours.each {
            total = total + it[1]
            if((it[0]==TaskType.ANALYSE_TASK)||(it[0]==TaskType.DESIGN_TASK)){
                des = des + it[1]
            }
            if((it[0]==TaskType.DEVELOP_TASK)||(it[0]==TaskType.SIT_TASK)){
                dev = dev + it[1]
            }
        }

        def amount = Demand.executeQuery("select count(d.id), sum(case when d.siFinishDate <= d.planDeliveryDate then 1 else 0 end) from Demand d join d.project p where p.id = :pid and d.planDeliveryDate between :m1 and :m2",[pid: pid, m1: m1, m2: m2])

        [pl: pl, hours: hours, total: total, des: des, dev: dev, amount: amount[0]]
    }
}
