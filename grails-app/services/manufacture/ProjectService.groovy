package manufacture

import com.rcstc.manufacture.OperateRecord
import com.rcstc.manufacture.PersonProject
import grails.events.Listener
import grails.transaction.Transactional
import org.grails.plugin.platform.events.EventMessage

@Transactional
class ProjectService {

    @Listener(topic = "TEAM-*")
    def teamEventHandle(EventMessage msg) {
        PersonProject pp = msg.data

        OperateRecord opr = new OperateRecord()
        opr.username = pp.person.username
        opr.person = pp.person.name
        opr.operation = msg.event
        opr.operateDate = new Date()
        opr.recordClass = "Project"
        opr.recordId = pp.project.id
        opr.description = new Date().format("yy-MM-dd") + opr.person + " " + opr.operation + " " + pp.project.name
        opr.project = pp.project.name

        opr.save flush: true, insert: true
    }
}
