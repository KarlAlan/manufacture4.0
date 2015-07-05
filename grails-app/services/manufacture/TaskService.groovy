package manufacture

import com.rcstc.manufacture.Batch
import com.rcstc.manufacture.OperateRecord
import com.rcstc.manufacture.Person
import com.rcstc.manufacture.Task
import com.rcstc.manufacture.TaskStatus
import com.rcstc.manufacture.WeeklyPlan
import grails.gorm.DetachedCriteria
import grails.plugin.springsecurity.SpringSecurityUtils
import grails.transaction.Transactional

@Transactional
class TaskService {

    def searchTasks(Person person, long pid, String task_serial, String demand_serial, String task_priority, String task_person_type, long task_person,
                    String task_date_type, Date start, Date end, ArrayList task_status, ArrayList task_type,  int max, int offset) {
        def par=[:]
        def sh1 = "select count(t.id)"
        def sh2 = "select new Task(t.id, t.serial, t.description, t.planHour, t.type, t.status, t.priority, t.proposal, t.scenario, t.remark, t.verifyDate, t.verifier, p.name," +
                " d.id, d.serial, tc.name, t.createDate, tf.name, t.finishDate, t.evaluate, t.evalDesc, ta.name, t.approveDate, t.title)"
        def sql = " from Task t join t.project p left join t.demand d left join t.creater tc left join t.finisher tf left join t.approver ta where 1 = 1 "
        //def sql = "from Task t fetch all properties"
        if(pid) {
            sql = sql + " and p.id = " + pid
        } else {
            sql = sql + " and p.id in (select pr.id from PersonProject pp join pp.person pe join pp.project pr where pe.id = "+ person.id + ")"
        }

        if(task_serial)
            sql = sql + " and t.serial like '%" + task_serial + "%'"

        if(demand_serial)
            sql = sql + " and d.serial like '%" + demand_serial + "%'"

        if(task_priority)
            sql = sql + " and t.priority = " + task_priority

        if(task_person)
            sql = sql + " and t." + task_person_type + " = " + task_person

        if(task_status.size() > 0){
            sql = sql + " and ("
            for(int i=0; i<task_status.size(); i++){
                if(i == 0){
                    sql = sql + " t.status = " + task_status[i] + " "
                } else {
                    sql = sql + " or t.status = " + task_status[i] + " "
                }

            }
            sql = sql + ") "
            //println("---------"+task_status)
            //par.put("st",task_status)
        }

        if(task_type.size() > 0){
            //sql = sql + " and t.type in :ty"
            //par.put("ty",task_type)
            sql = sql + " and ("
            for(int i=0; i<task_type.size(); i++){
                if(i == 0){
                    sql = sql + " t.type = " + task_type[i] + " "
                } else {
                    sql = sql + "or t.type = " + task_type[i] + " "
                }

            }
            sql = sql + ") "
        }

        if(start&&end){
            sql = sql + " and t." + task_date_type + " between :start and :end"
            par.put("start",start)
            par.put("end",end)
        }

        def tc = Task.executeQuery(sh1 + sql,par)

        par.put("max",max)
        par.put("offset",offset)
        def result = Task.executeQuery(sh2 + sql + " order by t.createDate desc",par)

        return  [tasks:result,totalCount:tc[0]]
    }

    def personalTasks(Person person, long pid, String serial, int max, int offset){

        def sql1 = "select j.id, j.serial, p.name, j.proposal, j.scenario, j.priority, j.status, b.planFinishDate, b.startDate, b.remark, j.type,  developer.id, sit.id "
        def sql2 = "select count(*) "
        def sql =  "from Batch as b inner join b.developer as developer inner join b.sitPeople as sit inner join b.task as j inner join b.project as p where (developer.id = :pid or sit.id = :pid)"

        if(pid) {
            sql = sql + " and p.id = " + pid
        }

        if(serial)
            sql = sql + " and j.serial like '%" + serial + "'"

        sql = sql + " and j.status != 99 order by j.priority ,b.planFinishDate"

        def tc = Task.executeQuery(sql1 + sql,[pid:person.id,max:max,offset:offset])
        def js = Task.executeQuery(sql2 + sql,[pid:person.id])

        return [tasks:tc, totalCount: js[0]]
    }

    def searchBatchs(Person person, Long pid, Boolean all, String serial, Person dev, int max, int offset) {
        def sh1 = "select count(b.id)"
        def sh2 = "select b.id, b.serial, b.project.name, t.id, t.serial, t.proposal,  b.startDate, b.planFinishDate, b.isDone, b.finishDate, b.planHour, b.bufferHour, b.developer.name, b.sitPeople.name"
        def sql = " from Batch b join b.project p join b.task t where 1 = 1 "
        //def sql = "from Task t fetch all properties"
        if(pid) {
            sql = sql + " and p.id = " + pid
        } else {
            sql = sql + " and p.id in (select pr.id from PersonProject pp join pp.person pe join pp.project pr where pe.id = "+ person.id + ")"
        }

        if(serial)
            sql = sql + " and b.serial like '%" + serial + "'"

        if(!all)
            sql = sql + " and b.isDone = false"

        if(dev)
            sql = sql + " and b.developer.id = " + dev.id

        def tc = Batch.executeQuery(sh1 + sql)
        def result = Batch.executeQuery(sh2 + sql+" order by b.startDate desc",[max:max,offset:offset])

        return  [batchs:result,totalCount:tc[0]]
    }

    def taskStat(Person person){
        def result
        if(SpringSecurityUtils.ifAnyGranted("SUPER_ADMIN,BUSINESS")){
            result = Task.executeQuery("select t.project.id, t.project.name, count(t.id), sum(t.planHour), t.type from Task t where t.status != :ts group by t.project.id, t.project.name, t.type order by t.project.id",[ts: TaskStatus.ACCOMPLISHED])
        } else if(SpringSecurityUtils.ifAnyGranted("SUPERVISOR")){
            result = Task.executeQuery("select t.project.id, t.project.name, count(t.id), sum(t.planHour), t.type from Task t where (t.project.fristParty = :org or t.project.secondParty = :org or t.project.thirdParty = :org or t.project.fourthParty = :org) and t.status != :ts group by t.project.id, t.project.name, t.type order by t.project.id",[ts: TaskStatus.ACCOMPLISHED,org:person.company])
        }else {
            result = Task.executeQuery("select p.id, p.name, count(t.id), sum(t.planHour), t.type from Task t join t.project p where p.id in (select p1.id from PersonProject up join up.project p1 join up.person u1 where u1.id = :uid) and  t.status != :ts group by p.id, p.name, t.type order by p.id",[ts: TaskStatus.ACCOMPLISHED,uid:person.id])
        }


        return [stat:result]
    }

    def planingTasks(String serial, String preson_name, ArrayList task_status, int year, int week, int comparison, int max, int offset){
        def hq = " from WeeklyPlan wp join wp.tasks t where 1=1 "
        def h1 = "select t.id, t.status, t.serial, wp.person.name, wp.year, wp.week, t.finishDate, t.title, wp.id  "

        if(serial)
            hq = hq + " and t.serial like '%" + serial + "%' "

        if(preson_name)
            hq = hq + " and wp.person.name = '" + preson_name + "' "

        if(task_status.size() > 0){
            hq = hq + " and ("
            for(int i=0; i<task_status.size(); i++){
                if(i == 0){
                    hq = hq + " t.status = " + task_status[i] + " "
                } else {
                    hq = hq + " or t.status = " + task_status[i] + " "
                }

            }
            hq = hq + ") "
        }

        hq = hq + " order by wp.year desc, wp.week desc "

        def co = Task.executeQuery("select count(t.id) "+hq)
        def result = Task.executeQuery(h1+hq,[max: max,offset: offset])

        return  [tasks: result,totalCount:co[0]]
    }

    def statBackward(Date d1, Date d2, String name, String times){
        def nameq = " "
        if(name){
            nameq = "and p.name = '" + name + "' "
        }
        def haveq = "having count(ord.id) >3"
        if(times){
            haveq = "having count(ord.id) >"+times
        }
        def hq = "select t.id, t.serial, p.name, count(ord.id) from OperateRecord ord, Task t, Person p " +
                "where ord.recordId = t.id and t.finisher=p.id and ord.operation = 'TASK-BACKWARD' and t.status=:ts " + nameq +
                "and t.finishDate between :td1 and :td2 group by ord.recordId, t.id, t.serial, p.name " +
                haveq
        def result = OperateRecord.executeQuery(hq,[ts:TaskStatus.ACCOMPLISHED,td1:d1,td2:d2])

        return  [tasks: result]
    }
}
