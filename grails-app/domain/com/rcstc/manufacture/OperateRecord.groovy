package com.rcstc.manufacture

class OperateRecord {

    def springSecurityService

    static mapping = {
        version false
    }

    static constraints = {
        operation nullable: false
        description nullable: true
        project nullable: true
        recordClass nullable: false
        recordId nullable: false
        parentOperationId nullable: true
        person nullable: false
        username nullable: true
        operateDate nullable: false
    }

    String operation
    String description
    String project
    String recordClass
    Long recordId
    Long parentOperationId
    String person
    String username
    Date operateDate

    static OperateRecord create(String operation, String description, String project, String recordClass, Long recordId, Long parentOperationId, String person, String username, boolean flush = false){
        OperateRecord instance = new OperateRecord(operateDate: operation, description: description, project: project, recordClass: recordClass, recordId: recordId, parentOperationId: parentOperationId, person: person, username: username)
        instance.operateDate = new Date()
        instance.save(flush: flush, insert: true)
        instance
    }
}
