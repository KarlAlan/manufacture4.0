package manufacture

import com.rcstc.business.Contract
import com.rcstc.business.ContractStatus
import com.rcstc.manufacture.Person
import grails.gorm.DetachedCriteria
import grails.transaction.Transactional
import org.hibernate.FetchMode
import org.hibernate.criterion.Criterion
import org.hibernate.criterion.Restrictions

@Transactional
class BusinessService {

    def searchContract(Long pid, String serial, String name, String fp, String sp, ArrayList status, int max, int offset) {

        def criteria = new DetachedCriteria(Contract).build {
            or {
                spPersons {
                    eq("id",pid)
                }

            }

        }

        if(serial)
            criteria.like("serial","%"+serial+"%")

        if(name)
            criteria.like("name","%"+name+"%")

        if(fp){
            criteria.eq("firstParty",fp)
        }

        if(sp){
            criteria.eq("secondParty",sp)
        }

        criteria.or {
            status.each {
                eq("status",it)
            }
        }

        def co = criteria.count()
        def result = criteria.list(max: max,offset: offset)

        return  [contracts:result,totalCount:co]
    }

    def receivable(Long pid, String serial, String name, String fp, int max, int offset) {
        def criteria = new DetachedCriteria(Contract).build {
            spPersons {
                eq("id",pid)
            }
            or {
                eq("status",ContractStatus.DRAFT)
                eq("status",ContractStatus.ACTIVE)
            }
        }

        if(serial)
            criteria.like("serial","%"+serial+"%")

        if(name)
            criteria.like("name","%"+name+"%")

        if(fp){
            criteria.eq("firstParty",fp)
        }

        def co = criteria.count()
        def result = criteria.list(max: max,offset: offset)

        return  [contracts:result,totalCount:co]
    }

    def payable(Long pid, String serial, String name, String sp, int max, int offset) {
        def criteria = new DetachedCriteria(Contract).build {
            fpPersons {
                eq("id",pid)
            }
            or {
                eq("status",ContractStatus.DRAFT)
                eq("status",ContractStatus.ACTIVE)
            }
        }

        if(serial)
            criteria.like("serial","%"+serial+"%")

        if(name)
            criteria.like("name","%"+name+"%")

        if(sp){
            criteria.eq("secondParty",sp)
        }

        def co = criteria.count()
        def result = criteria.list(max: max,offset: offset)

        return  [contracts:result,totalCount:co]
    }
}
