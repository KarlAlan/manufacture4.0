package manufacture

import com.rcstc.manufacture.Batch
import com.rcstc.manufacture.Demand
import com.rcstc.manufacture.DemandStatus
import com.rcstc.manufacture.Person
import com.rcstc.manufacture.Priority
import com.rcstc.manufacture.Project
import grails.plugin.springsecurity.SpringSecurityUtils
import grails.transaction.Transactional
import org.joda.time.DateTime

@Transactional
class DemandService {

    def searchDemands(Person person, long pid, ArrayList demand_status, String dt, String dc, String dp, String demand_category1,
                      String demand_category2, String submit_people, String serial, Date start, Date end, String demand_date_type, String demand_desc, int max, int offset, String sort, String order) {

        def sh1 = "select count(t.id)"
        def sh2 = "select new Demand(t.id, t.category1, t.category2, t.category3, t.serial, t.description, t.planStartDate, t.planStopDate, " +
                "t.closeDate, t.type, t.status, t.priority, t.proposal, t.remark, t.submitPeople, t.updateDate, t.picPeople, t.project.name, " +
                "t.demandCharacter, t.backward, t.baFinishDate, t.saFinishDate, t.deFinishDate, t.siFinishDate, t.uaFinishDate, t.planDeliveryDate, " +
                "t.deployDate, t.evaluate, t.evalDesc, ta.name, t.approveDate, t.title)"
        def sql = " from Demand t join t.project p left join t.approver ta where 1 = 1 "
        //def sql = "from Task t fetch all properties"
        if(pid) {
            sql = sql + " and p.id = " + pid
        } else {
            sql = sql + " and p.id in (select pr.id from PersonProject pp join pp.person pe join pp.project pr where pe.id = "+ person.id + ")"
        }

        if(demand_category1)
            sql = sql + " and t.category1 like '%" + demand_category1 + "%'"

        if(demand_category2)
            sql = sql + " and t.category2 like '%" + demand_category2 + "%'"

        if(submit_people)
            sql = sql + " and t.submitPeople = '" + submit_people + "'"

        if(serial)
            sql = sql + " and t.serial like '%" + serial + "%'"

        if(demand_status.size() > 0){
            sql = sql + " and ("
            for(int i=0; i<demand_status.size(); i++){
                if(i == 0){
                    sql = sql + " t.status = " + demand_status[i] + " "
                } else {
                    sql = sql + " or t.status = " + demand_status[i] + " "
                }

            }
            sql = sql + ") "
            //par.put("st",task_status)
        }

        if(dt)
            sql = sql + " and t.type = " + dt

        if(dc)
            sql = sql + " and t.demandCharacter = " + dc

        if(dp)
            sql = sql + " and t.priority = " + dp

        if(start&&end)
            sql = sql + " and t." + demand_date_type + " between :start and :end"

        if(demand_desc)
            sql = sql + " and t.description like '%" + demand_desc + "%'"

        def ob = " order by t.id desc"
        if(sort&&order){
            ob = " order by t." + sort + ", t.id " + order
        }

        def tc
        def result
        if(start&&end){
            tc = Demand.executeQuery(sh1 + sql,[start:start,end:end])
            result = Demand.executeQuery(sh2 + sql+ ob,[start:start,end:end,max:max,offset:offset])
        } else {
            tc = Demand.executeQuery(sh1 + sql)
            result = Demand.executeQuery(sh2 + sql+ ob,[max:max,offset:offset])
        }


        return  [demands:result,totalCount:tc[0]]
    }

    def demandStat1(Person person, Date plan_start_date, Date plan_stop_date) {
        def projects = Project.executeQuery("""select p.id, p.name, '', '', '', '', '', '', '', '', '' from Project p where p.id in (select p1.id from PersonProject up join up.project p1 join up.person u1 where u1.id = :uid)""",[uid:person.id])
        def result = Demand.executeQuery("""select p.id,p.name,t.status ,count(t.id) from Demand t join t.project p where t.planStartDate >= :plan_start_date and t.planStartDate < :plan_stop_date group by t.project,t.status""",[plan_start_date:plan_start_date,plan_stop_date:plan_stop_date])

        def total = new int[7]

        for (def r : result){
            for (def p : projects) {
                if (r[0] == p[0]){
                    if(r[2].equals(DemandStatus.ANALYSE)){
                        p[2] = r[3]
                        total[0]=total[0]+r[3]
                    }
                    if(r[2].equals(DemandStatus.DESIGN)){
                        p[3] = r[3]
                        total[1]=total[1]+r[3]
                    }
                    if(r[2].equals(DemandStatus.DEVELOP)){
                        p[4] = r[3]
                        total[2]=total[2]+r[3]
                    }
                    if(r[2].equals(DemandStatus.SIT)){
                        p[5] = r[3]
                        total[3]=total[3]+r[3]
                    }
                    if(r[2].equals(DemandStatus.UAT)){
                        p[6] = r[3]
                        total[4]=total[4]+r[3]
                    }
                    if(r[2].equals(DemandStatus.ACCOMPLISHED)){
                        p[7] = r[3]
                        total[5]=total[5]+r[3]
                    }
                    if(r[2].equals(DemandStatus.CANCELED)){
                        p[8] = r[3]
                        total[6]=total[6]+r[3]
                    }
                }
            }
        }

        return [pro:projects,tot:total]
    }

    // 统计各环节未完成需求当前状态，在任意环节超过15天（相当于两周），没能往下走的需求
    def demandStat2(Person person){
        DateTime dt = DateTime.now()
        def bd = dt.plusDays(-15).toDate()

        def hql = "select p.id, p.name, " +
                "sum(case when d.status = 10 and d.priority = 10 then 1 else 0 end) as ba_emergency_amount, " +
                "sum(case when d.status = 10 and d.priority = 30 then 1 else 0 end) as ba_amount," +
                "sum(case when d.status = 12 and d.priority = 10 then 1 else 0 end) as au_emergency_amount," +
                "sum(case when d.status = 12 and d.priority = 30 then 1 else 0 end) as au_amount," +
                "sum(case when d.status = 20 and d.priority = 10 then 1 else 0 end) as sa_emergency_amount," +
                "sum(case when d.status = 20 and d.priority = 30 then 1 else 0 end) as sa_amount," +
                "sum(case when d.status = 30 and d.priority = 10 then 1 else 0 end) as de_emergency_amount," +
                "sum(case when d.status = 30 and d.priority = 30 then 1 else 0 end) as de_amount," +
                "sum(case when d.status = 31 and d.priority = 10 then 1 else 0 end) as si_emergency_amount," +
                "sum(case when d.status = 31 and d.priority = 30 then 1 else 0 end) as si_amount," +
                "sum(case when d.status = 32 and d.priority = 10 then 1 else 0 end) as ua_emergency_amount," +
                "sum(case when d.status = 32 and d.priority = 30 then 1 else 0 end) as ua_amount, " +
                "sum(case when d.status = 10 and d.updateDate < :bd and d.type != 20 then 1 else 0 end) as ba_overdue," +
                "sum(case when d.status = 12 and d.baFinishDate < :bd then 1 else 0 end) as au_overdue," +
                "sum(case when d.status = 20 and ((d.updateDate < :bd and d.type = 20) or (d.baFinishDate < :bd and d.type != 20)) then 1 else 0 end) as sa_overdue," +
                "sum(case when d.status = 30 and d.planDeliveryDate < :bd then 1 else 0 end) as de_overdue," +
                "sum(case when d.status = 31 and d.deFinishDate < :bd then 1 else 0 end) as si_overdue," +
                "sum(case when d.status = 32 and d.siFinishDate < :bd then 1 else 0 end) as ua_overdue"
        def result
        if(SpringSecurityUtils.ifAnyGranted("SUPER_ADMIN,BUSINESS")){
            result = Demand.executeQuery(hql +
                    " from Demand d join d.project p group by p.id,p.name",[bd:bd])
        } else if(SpringSecurityUtils.ifAnyGranted("SUPERVISOR")){
            result = Demand.executeQuery(hql + """ from Demand d join d.project p where (p.fristParty = :org or p.secondParty = :org or p.thirdParty = :org or p.fourthParty = :org) and d.status != 1 and d.status != 40 and d.status != 99 group by p.id,p.name""",[bd:bd,org:person.company])
        }else {
            result = Demand.executeQuery(hql + """ from Demand d join d.project p where p.id in (select p1.id from PersonProject up join up.project p1 join up.person u1 where u1.id = :uid) and d.status != 1 and d.status != 40 and d.status != 99 group by p.id,p.name""",[bd:bd,uid:person.id])
        }

        return [stat:result]
    }

    def demandPersonStat() {
        def r = Batch.executeQuery("select b.developer.name, count(d.description), max(b.planFinishDate) from Batch b join b.task t join t.demand d where b.isDone = false group by b.developer.name")
        return [stat: r]
    }

    // 在任意环节超过15天（相当于两周），没能往下走的需求
    def overdue() {
        DateTime dt = DateTime.now()
        def bd = dt.plusDays(-15).toDate()
        def r = Demand.executeQuery("select d.project.name, d.status, count(d.id) from Demand d where (d.status = :ds1 and d.updateDate < :du)" +
                " or (d.status = :ds2 and d.baFinishDate < :du)" +
                " or (d.status = :ds3 and d.planDeliveryDate < :du)" +
                " or (d.status = :ds4 and d.deFinishDate < :du)" +
                " or (d.status = :ds5 and d.siFinishDate < :du) group by d.project.name, d.status",
                [ds1:DemandStatus.ANALYSE,ds2:DemandStatus.DESIGN,ds3:DemandStatus.DEVELOP,ds4:DemandStatus.SIT,ds5:DemandStatus.UAT,du:bd])

        return [demands: r]
    }
}

