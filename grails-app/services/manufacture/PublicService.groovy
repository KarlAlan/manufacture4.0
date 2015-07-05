package manufacture

import com.rcstc.manufacture.Batch
import com.rcstc.manufacture.Demand
import com.rcstc.manufacture.DemandCommand
import com.rcstc.manufacture.DemandStatus
import com.rcstc.manufacture.DemandType
import com.rcstc.manufacture.OperateRecord
import com.rcstc.manufacture.Person
import com.rcstc.manufacture.PersonProject
import com.rcstc.manufacture.Priority
import com.rcstc.manufacture.Project
import com.rcstc.manufacture.ProjectRole
import com.rcstc.manufacture.ProjectStatus

import com.rcstc.manufacture.Task
import com.rcstc.manufacture.TaskStatus
import com.rcstc.manufacture.TaskType
import com.rcstc.manufacture.WeeklyPlan
import com.rcstc.manufacture.WeeklyReport
import com.rcstc.personnel.Attendance
import com.rcstc.personnel.Reward
import grails.events.Listener
import grails.transaction.Transactional
import org.grails.plugin.platform.events.EventMessage
import org.joda.time.DateTime
import org.springframework.scheduling.annotation.Scheduled

import java.sql.Timestamp

@Transactional
class PublicService {

    def plist(Person person) {
        def sql = """select distinct new Project(p.id,p.name) from Project p where p.id in (select pr.id from PersonProject pp join pp.person pe join pp.project pr where pe.id = :uid)"""
        def result = Project.executeQuery(sql, [uid:person.id])

        return result
    }

    synchronized def getMaxSerial(long pid, String type){
        int serial = 0
        String out

        def sql1 = "select p.perfix, p."+type+" from Project p where p.id = " + pid

        def result = Project.executeQuery(sql1)
        serial = result[0][1] + 1

        def p = Project.get(pid)
        if(type=="requirmentSerial")
        {
            p.requirmentSerial = serial
            out =  result[0][0]+"-R"+serial
        }

        if(type=="jobSerial")
        {
            p.jobSerial = serial
            out =  result[0][0]+"-J"+serial
        }
        if(type=="batchSerial")
        {
            p.batchSerial = serial
            out =  result[0][0]+"-B"+serial
        }

        p.save(flush: true)

        return out
    }

    def peoplesByProject(long pid, String... roles){
        def sql = "select pp.person from PersonProject pp where pp.project.id = :pid"
        if(roles.size()>0){
            sql = sql + " and (pp.projectRole=1 "
            for(String role in roles){
                sql = sql + "or pp.projectRole = " + role
            }
            sql = sql + ")"
        }
        def result = PersonProject.executeQuery(sql, [pid:pid])
        return result
    }

    def person4Project(long pid){
        def sql = "select pp.id, p.name, pp.projectRole, p.email, p.phone from PersonProject pp join Person p where pp.project.id = :pid"

        def result = PersonProject.executeQuery(sql, [pid:pid])
        return result
    }

    def humanCostsDetail(long pid, int max, int offset){
        def s1 = "select pr.id, pr.name, pe.id, pe.name, pe.dayPrice, b.startDate, b.finishDate, b.planFinishDate "
        def s2 = "from Batch b join b.project pr join b.developer pe with pr.id = :pid"
        def s3 = "select count(b.id) "

        def r1 = Batch.executeQuery(s1+s2,[pid: pid,max: max, offset:offset])
        def r2 = Batch.executeQuery(s3+s2,[pid: pid])

        return [detail:r1, totalCount: r2[0]]
    }

    def pendingTask(Person person){
        // BA and SA task
        def s1 = "select p.id, p.name, d.status, count(d.id) from Demand d join d.project p where d.status = :status and p in (select pp.project from PersonProject pp where pp.person.id = :person and pp.projectRole = :pr) group by p.id,p.name, d.status"
        def r1 = Demand.executeQuery(s1,[status:DemandStatus.ANALYSE,person:person.id,pr:ProjectRole.需求分析师])
        def r2 = Demand.executeQuery(s1,[status:DemandStatus.DESIGN,person:person.id,pr:ProjectRole.系统设计师])
        def r6 = Demand.executeQuery(s1,[status:DemandStatus.AUDIT,person:person.id,pr:ProjectRole.项目经理])
        //def r5 = Demand.executeQuery(s1,[status: DemandStatus.SIT, person: person.id, pr: ProjectRole.测试人员])

        def r = []
        r.addAll(handlePendingResult(r1,"demand_page item-blue"))
        r.addAll(handlePendingResult(r2,"demand_page item-grey"))
        r.addAll(handlePendingResult(r6,"demand_page item-green"))

        // UAT test task
        def s2 = "select p.id, p.name, d.status, count(d.id) from Demand d join d.project p where d.status = :status and d.submitPeople = :personName group by p.id,p.name, d.status"
        def r3 = Demand.executeQuery(s2,[status:DemandStatus.UAT,personName:person.name])

        r.addAll(handlePendingResult(r3,"demand_page item-red"))

        // developer task
        //def s3 = "select p.id, p.name, t.status, count(t.id) from Task t join t.project p join t.batch b where t.status = :status and b.developer.id = :person group by p.id,p.name,t.status"
        //def r4 = Task.executeQuery(s3,[status:TaskStatus.DEVELOP,person:person.id])

        //r.addAll(handlePendingResult(r4,"develop_task_page item-orange"))

        // sit task
        //def s4 = "select p.id, p.name, t.status, count(t.id) from Task t join t.project p join t.batch b where t.status = :status and b.sitPeople.id = :person group by p.id,p.name,t.status"
        //def r5 = Task.executeQuery(s4,[status:TaskStatus.SIT,person:person.id])

        //r.addAll(handlePendingResult(r5,"sit_task_page item-pink"))

        return [pending:r]
    }

    private handlePendingResult(def r, String type){
        def pr = []
        for(def d : r){
            def prd = []
            prd.add(d[0])
            prd.add(d[1])
            prd.add(d[2].id)
            prd.add(d[2].toString())
            prd.add(d[3])
            prd.add(type)

            pr.add(prd)
        }
        return pr
    }

    def projectSituation(Long pid){
        def r = Demand.executeQuery("select d.category1, d.category2, d.type, d.priority, count(d.id) from Demand d where d.project.id = :pid and d.status != :status1 and d.status != :status2 group by d.category1, d.category2, d.type, d.priority",[pid:pid, status1: DemandStatus.DRAFT, status2: DemandStatus.CANCELED])
        def dr = []
        for (def rd : r){
            ProjectStat ps;
            for(def ps1 : dr){
               if(ps1.category1.equals(rd[0])&&ps1.category2.equals(rd[1])){
                   ps = ps1
                   break
               }
            }

            if(!ps){
                ps = new ProjectStat()
                ps.category1 = rd[0]
                ps.category2 = rd[1]

                dr.add(ps)
            }

            if(rd[2]==DemandType.NEW_FUNCTION){
                if(rd[3]== Priority.EMERGENCY){
                    ps.new_emergency_amount = ps.new_emergency_amount + rd[4]
                }else{
                    ps.new_amount = ps.new_amount + rd[4]
                }
            }else if (rd[2]==DemandType.CHANGE_FUNCTION){
                if(rd[3]== Priority.EMERGENCY){
                    ps.mod_emergency_amount = ps.mod_emergency_amount + rd[4]
                }else{
                    ps.mod_amount = ps.mod_amount + rd[4]
                }
            }else {
                if(rd[3]== Priority.EMERGENCY){
                    ps.bug_emergency_amount = ps.bug_emergency_amount + rd[4]
                }else{
                    ps.bug_amount = ps.bug_amount + rd[4]
                }
            }



        }

        def r2 = Demand.executeQuery("select d.category1, d.category2, count(d.id) from Demand d where d.project.id = :pid and d.status != :status1 and d.status != :status2 and d.status != :status3 group by d.category1, d.category2",[pid:pid, status1: DemandStatus.DRAFT, status2: DemandStatus.CANCELED, status3: DemandStatus.ACCOMPLISHED])

        def r3 = Demand.executeQuery("select d.category1, d.category2, count(d.id) from Demand d where d.project.id = :pid and d.status = :status1 group by d.category1, d.category2",[pid:pid, status1: DemandStatus.ACCOMPLISHED])

        for (def ps : dr){
            for (def rd : r2){
                if(ps.category1.equals(rd[0])&&ps.category2.equals(rd[1])){
                    ps.total_amount = rd[2]
                    break
                }
            }

            for (def rd : r3){
                if(ps.category1.equals(rd[0])&&ps.category2.equals(rd[1])){
                    ps.finish_amount = rd[2]
                    break
                }
            }
        }

        return dr
    }

    class ProjectStat {
        String category1
        String category2
        int new_emergency_amount = 0
        int new_amount = 0
        int mod_emergency_amount = 0
        int mod_amount = 0
        int bug_emergency_amount = 0
        int bug_amount = 0
        int finish_amount = 0
        int total_amount = 0

    }

    @Listener(topic = "REPORT-WEEKLY")
    def weeklyReportEventHandle(EventMessage msg){
        WeeklyReport weeklyReportInstance = msg

        def p = Person.findByName(weeklyReportInstance.buildPerson)
        Reward.rewardPoint(p.username, new BigDecimal(100))
    }

    // 考勤监听器
    @Listener(topic = "Attendance")
    def attendanceEventHandle(EventMessage msg){
        Attendance attendance = msg.data
        Reward.rewardPoint(attendance.person.username, new BigDecimal(10))
    }

    @Listener(topic = "BATCH-*")
    def batchEventHandle(EventMessage msg){
        Batch batch = msg.data[0]
        Person p1 = msg.data[1]

        OperateRecord opr = new OperateRecord()
        opr.username = p1.username
        opr.person = p1.name
        opr.operation = msg.event
        opr.operateDate = new Date()
        opr.recordClass = "Batch"
        opr.recordId = batch.id
        opr.description = batch.serial + " " + opr.operation
        opr.project = ""

        opr.save flush: true, insert: true

        if(msg.event == "BATCH-FINISH"){
            // reward point
            Reward.rewardPoint(batch.developer.username, new BigDecimal(100))
            Reward.rewardPoint(batch.sitPeople.username, new BigDecimal(50))
        }

    }

    @Listener(topic = "TASK-*")
    def taskEventHandle(EventMessage msg){
        Task task = msg.data[0]
        Person p1 = msg.data[1]

        OperateRecord opr = new OperateRecord()
        opr.username = p1.username
        opr.person = p1.name
        opr.operation = msg.event
        opr.operateDate = new Date()
        opr.recordClass = "Task"
        opr.recordId = task.id
        opr.description = task.serial + " " + opr.operation + " to " + task.status
        opr.project = ""

        opr.save flush: true, insert: true

        if(msg.event == "TASK-FINISH"){
            // reward point
            //Reward.rewardPoint(batch.developer.username, new BigDecimal(100))
        }

    }

    def publicService

    // 需求从草稿到BA事件
    @Listener(topic = "DEMAND-FORWARD-BA")
    def demandfbaEvent(EventMessage msg){
        Demand demand = msg.data[0]
        Person p1 = msg.data[1]

        Demand d = Demand.get(demand.id)
        Task t = new Task()
        t.demand = d
        t.createDate = new Date()
        t.project = d.project
        t.description = "BA分析任务"
        t.title = "BA分析"+d.category1+">>"+d.category2+">>"+d.serial
        t.priority = d.priority
        t.type = TaskType.ANALYSE_TASK
        t.status = TaskStatus.DRAFT
        t.creater = p1
        t.serial = publicService.getMaxSerial(d.project.id, "jobSerial")

        t.save(flush: true)
    }

    // 需求从审核回退到BA事件
    @Listener(topic = "DEMAND-BACKWARD-BA")
    def demandbbaEvent(EventMessage msg){
        Demand demand = msg.data[0]
        Person p1 = msg.data[1]

        Task t = Task.findByDemandAndType(demand,TaskType.ANALYSE_TASK)
        t.finisher = p1
        t.finishDate = null
        t.status = TaskStatus.DRAFT

        t.save(flush: true)
    }

    // 需求从BA到SA事件
    @Listener(topic = "DEMAND-FORWARD-SA")
    def demandfauEvent(EventMessage msg){
        Demand d = msg.data[0]
        Person p1 = msg.data[1]
        DemandCommand demandCommand = msg.data[2]


        Demand demand = Demand.get(d.id)
        Task te = Task.findByDemandAndTypeAndStatus(demand,TaskType.ANALYSE_TASK,TaskStatus.DRAFT)
        te.finisher = p1
        te.finishDate = new Date()
        te.planHour = demandCommand.work_hour
        te.status = TaskStatus.ACCOMPLISHED

        te.save(flush: true)

        Task t = new Task()
        t.demand = demand
        t.createDate = new Date()
        t.project = demand.project
        t.description = "系统设计任务"
        t.title = "设计"+demand.category1+">>"+demand.category2+">>"+demand.serial
        t.priority = demand.priority
        t.type = TaskType.DESIGN_TASK
        t.status = TaskStatus.DRAFT
        t.creater = p1
        t.serial = publicService.getMaxSerial(demand.project.id, "jobSerial")

        t.save(flush: true)
    }

    // 需求从SA到确认事件
    @Listener(topic = "DEMAND-FORWARD-AU")
    def demandfsaEvent(EventMessage msg){
        Demand demand = msg.data[0]
        Person p1 = msg.data[1]
        DemandCommand demandCommand = msg.data[2]

        Task te = Task.findByDemandAndTypeAndStatus(demand,TaskType.DESIGN_TASK,TaskStatus.DRAFT)
        te.finisher = p1
        te.finishDate = new Date()
        te.planHour = demandCommand.work_hour
        te.status = TaskStatus.ACCOMPLISHED

    }

    // 需求从确认回退到SA事件
    @Listener(topic = "DEMAND-BACKWARD-SA")
    def demandbsaEvent(EventMessage msg){
        Demand demand = msg.data[0]
        Person p1 = msg.data[1]
        DemandCommand demandCommand = msg.data[2]

        Task t = Task.findByDemandAndType(demand,TaskType.DESIGN_TASK)
        t.finisher = p1
        t.finishDate = null
        t.status = TaskStatus.DRAFT

        t.save(flush: true)
    }

    // 需求从确认到开发事件
    @Listener(topic = "DEMAND-FORWARD-DE")
    def demandfdeEvent(EventMessage msg){
        Demand demand = msg.data[0]
        Person p1 = msg.data[1]

    }

    // 需求从开发到SIT事件
    @Listener(topic = "DEMAND-FORWARD-SI")
    def demandfsiEvent(EventMessage msg){
        Demand demand = msg.data[0]
        Person p1 = msg.data[1]
        DemandCommand demandCommand = msg.data[2]

        Demand d = Demand.get(demand.id)
        Task t = new Task()
        t.demand = d
        t.createDate = new Date()
        t.project = d.project
        t.description = "SIT任务"
        t.title = "SIT"+d.category1+">>"+d.category2+">>"+d.serial
        t.priority = d.priority
        t.type = TaskType.SIT_TASK
        t.status = TaskStatus.DRAFT
        t.creater = p1
        t.serial = publicService.getMaxSerial(d.project.id, "jobSerial")

        t.save(flush: true)
    }

    // 需求从SIT到UAT事件
    @Listener(topic = "DEMAND-FORWARD-UA")
    def demandfuaEvent(EventMessage msg){
        Demand demand = msg.data[0]
        Person p1 = msg.data[1]
        DemandCommand demandCommand = msg.data[2]

        Task t1 = Task.findByDemandAndTypeAndStatus(demand,TaskType.SIT_TASK,TaskStatus.DRAFT)
        t1.finisher = p1
        t1.finishDate = new Date()
        t1.planHour = demandCommand.work_hour
        t1.status = TaskStatus.ACCOMPLISHED

        t1.save(flush: true)

        Demand d = Demand.get(demand.id)
        Task t = new Task()
        t.demand = d
        t.createDate = new Date()
        t.project = d.project
        t.description = "UAT任务"
        t.title = "UAT"+d.category1+">>"+d.category2+">>"+d.serial
        t.priority = d.priority
        t.type = TaskType.UAT_TASK
        t.status = TaskStatus.DRAFT
        t.creater = p1
        t.serial = publicService.getMaxSerial(d.project.id, "jobSerial")

        t.save(flush: true)
    }

    @Listener(topic = "DEMAND-FINISH")
    def demandffiEvent(EventMessage msg){
        Demand demand = msg.data[0]
        Person p1 = msg.data[1]

        Task t = Task.findByDemandAndType(demand,TaskType.UAT_TASK)
        t.finisher = p1
        t.finishDate = new Date()
        t.status = TaskStatus.ACCOMPLISHED

    }

    @Listener(topic = "DEMAND-*")
    def demandEventHandle(EventMessage msg){
        Demand demand = msg.data[0]
        Person p1 = msg.data[1]
        DemandCommand demandCommand = msg.data[2]

        OperateRecord opr = new OperateRecord()
        opr.username = p1.username
        opr.person = p1.name
        opr.operation = msg.event
        opr.operateDate = new Date()
        opr.recordClass = "Demand"
        opr.recordId = demand.id
        if(demandCommand&&demandCommand.operation_reason){
            opr.description = demandCommand.operation_reason
        } else {
            opr.description = demand.serial + " " + opr.operation + " to " + demand.status
        }

        opr.project = ""

        opr.save flush: true, insert: true

        if(msg.event == "DEMAND-FINISH"){
            def et = msg.data[3]
            def ed = msg.data[4]
            def ba = msg.data[5]
            def au = msg.data[6]
            def sa = msg.data[7]
            def de = msg.data[8]
            def si = msg.data[9]

            demand.approver = p1
            demand.approveDate = new Date()
            demand.evaluate = et
            demand.evalDesc = ed

            demand.save(flush: true)

            // 获取Demand处理过程中的所有任务
            def tasks = Task.findAllByDemand(demand)

            // 分别插入评价数据
            if(et=='bad'){
                for (def task : tasks){
                    if(ba&&ba=='on'){
                       if(task.type==TaskType.ANALYSE_TASK){
                           Task.evalTask(task, et, ed, p1)

                           Reward.rewardPoint(task.finisher?.name,new BigDecimal(-30))
                       }
                    }
                    if(sa&&sa=='on'){
                        if(task.type==TaskType.DESIGN_TASK){
                            Task.evalTask(task, et, ed, p1)

                            Reward.rewardPoint(task.finisher?.name,new BigDecimal(-30))
                        }
                    }
                    if(de&&de=='on'){
                        if(task.type==TaskType.DEVELOP_TASK){
                            Task.evalTask(task, et, ed, p1)

                            Reward.rewardPoint(task.finisher?.name,new BigDecimal(-30))
                        }
                    }
                    if(si&&si=='on'){
                        if(task.type==TaskType.SIT_TASK){
                            Task.evalTask(task, et, ed, p1)

                            Reward.rewardPoint(task.finisher?.name,new BigDecimal(-30))
                        }
                    }
                }

            } else {
                for (def task : tasks){
                    Task.evalTask(task, et, "", p1)

                    if(et=="good"){
                        Reward.rewardPoint(task.finisher?.name,new BigDecimal(30))
                    }
                }
            }
        }

    }

    /*
    def grailsApplication
    def groovyPageRenderer

    @Listener(topic = "USER-CREATE")
    def userCreateEventHandle(EventMessage msg){
        Person p1 = msg.data

        // send notice email
        sendMail {
            async true
            from grailsApplication.config.sys_email.address
            to p1.email
            subject "中外运需求管理系统账户开通"
            html groovyPageRenderer.render(template:"/person/userCreateMail", model: [person: p1])
        }

    }
    */

    def dataSource;
    def personMonthRanking(){
        DateTime now = new DateTime()
        DateTime lastDayOfPreviousMonth = now.minusMonths(1).dayOfMonth().withMaximumValue()

        /*
        def st = "select mu.name, sum(re.reward_point) from reward re, muser mu where re.username=mu.username and re.reward_type=20 and re.REWARD_DATE>to_date(?,'yyyy-MM-dd') group by mu.name order by sum(re.reward_point) desc"

        def r = []

        Sql sql = new Sql(dataSource)
        sql.eachRow(st,[lastDayOfPreviousMonth.toString('yyyy-MM-dd')]) { it ->
            r << it.toRowResult()
        }
        */

        Timestamp ts = new Timestamp(lastDayOfPreviousMonth.toDate().getTime())
        def st = "select mu.name, sum(re.rewardPoint) from Reward re, User mu where re.username=mu.username and re.rewardType=20 and re.rewardDate>:rdate group by mu.name order by sum(re.rewardPoint) desc"
        def r = Reward.executeQuery(st,[rdate:ts])

        [result: r]
    }

    def grailsApplication
    def groovyPageRenderer

    def handledContent(project, lowerDate, upperDate){
        def countNe = Demand.countByProjectAndPlanStartDateBetween(project, lowerDate, upperDate)
        def countBa = Demand.countByProjectAndBaFinishDateBetween(project, lowerDate, upperDate)
        def countSa = Demand.countByProjectAndSaFinishDateBetween(project, lowerDate, upperDate)
        def countAu = Demand.countByProjectAndConfirmDateBetween(project, lowerDate, upperDate)
        def countDe = Demand.countByProjectAndDeFinishDateBetween(project, lowerDate, upperDate)
        def countSi = Demand.countByProjectAndSiFinishDateBetween(project, lowerDate, upperDate)
        def countUa = Demand.countByProjectAndUaFinishDateBetween(project, lowerDate, upperDate)
        def countDp = Demand.countByProjectAndDeployDateBetween(project, lowerDate, upperDate)
        def sumFi = Demand.countByProjectAndStatus(project, DemandStatus.ACCOMPLISHED)
        def sumAll = Demand.countByProjectAndStatusNotEqual(project, DemandStatus.CANCELED)
        def rateFi = 0
        if(sumAll!=0){
            rateFi = sumFi/sumAll
        }

        groovyPageRenderer.render(template:"/weeklyReport/siContent",model:[countBa: countBa, countSa: countSa, countAu: countAu, countDe: countDe, countSi: countSi, countUa: countUa, countDp: countDp
                , sumFi: sumFi, rateFi: rateFi, countNe: countNe])
    }

    def finishContent(project, lowerDate, upperDate){
        def finished = Demand.findAllByProjectAndSiFinishDateBetween(project, lowerDate, upperDate)
        groovyPageRenderer.render(template:"/weeklyReport/fiContent",model:[finished: finished])
    }

    def planContent(project, year, week){
        def plan = WeeklyPlan.executeQuery("select t.demand.serial, t.demand.title from WeeklyPlan wp left join wp.tasks t where wp.year = :year and wp.week = :week and t.project.id = :pid",[year: year, week: week+1, pid: project.id])
        groovyPageRenderer.render(template:"/weeklyReport/plContent",model:[plan: plan])
    }

    @Scheduled(cron="0 0 22 ? * THU")
    void generateWeeklyReport(){
        Project.withNewSession {
            //获取项目
            def projects = Project.findAllByStatusNotEqualAndAutoBuildWeeklyReport(ProjectStatus.关闭,true)
            //生产项目周报
            projects.each { project ->

                def today = DateTime.now()
                def lowerDate = today.dayOfWeek().withMinimumValue().toDate()
                def upperDate = today.dayOfWeek().withMaximumValue().toDate()
                def year = today.getYear()
                def week = today.getWeekOfWeekyear()

                WeeklyReport wp = new WeeklyReport()
                wp.project = project
                wp.startDate = lowerDate
                wp.stopDate = upperDate
                wp.finishedTask = finishContent(project, lowerDate, upperDate)
                wp.planingTask = planContent(project, year, week)
                wp.handled = handledContent(project, lowerDate, upperDate)
                wp.situation = "normal"
                wp.title = project?.name + year + "年第" + week + "周（" + lowerDate.format("M/d") + "-" + upperDate.format("M/d") + "）"
                wp.buildDate = today.toDate()
                wp.buildPerson = "系统"
                wp.status = "draft"

                wp.save(flush: true)
            }

        }
    }

    @Scheduled(cron="0 0 23 ? * THU")
    void sentWarningWeeklyEmail(){
        WeeklyReport.withNewSession {
            def wps = WeeklyReport.findAllByStatus("draft")

            wps.each { weeklyReport ->
                def mailboxs = []
                //获取项目组经理邮箱
                mailboxs = PersonProject.executeQuery("select pp.person.email from PersonProject pp where pp.projectRole=:pp1 and pp.project.id = :pid",[pp1:ProjectRole.项目经理,pid:weeklyReport.project.id])

                //发邮件
                sendMail {
                    async true
                    from grailsApplication.config.sys_email.address
                    to mailboxs.toArray()
                    subject "编写"+weeklyReport.project?.name+"项目周报提醒"
                    html groovyPageRenderer.render(template:"/weeklyReport/weeklyRemindEmail")
                }
            }
        }
    }

    @Scheduled(cron="0 0 21 ? * SUN")
    void sentWeeklyReportEmail(){
        WeeklyReport.withNewSession {
            def wps = WeeklyReport.findAllByStatus("draft")

            wps.each { weeklyReport ->

                def lowerDate = weeklyReport.startDate
                def upperDate = weeklyReport.stopDate
                def year = new DateTime(weeklyReport.buildDate).getYear()
                def week = new DateTime(weeklyReport.buildDate).getWeekOfWeekyear()

                weeklyReport.handled = publicService.handledContent(weeklyReport.project, lowerDate, upperDate)
                weeklyReport.finishedTask = publicService.finishContent(weeklyReport.project, lowerDate, upperDate)
                weeklyReport.planingTask = publicService.planContent(weeklyReport.project, year, week)

                weeklyReport.status = "formal"
                weeklyReport.save(flush: true)

                def mailboxs = []
                //获取项目组成员邮箱
                mailboxs = PersonProject.executeQuery("select pp.person.email from PersonProject pp where pp.project.id = :pid",[pid:weeklyReport.project.id])

                //获取所有领导邮箱


                //发邮件
                sendMail {
                    async true
                    from grailsApplication.config.sys_email.address
                    to mailboxs.toArray()
                    //to "karl0385@163.com"
                    subject weeklyReport.title
                    html groovyPageRenderer.render(template:"/weeklyReport/weeklyReportEmail",model: [weeklyReportInstance: weeklyReport])
                }

            }

        }
    }
}
