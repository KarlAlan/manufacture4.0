package com.rcstc.manufacture

class Task {

    static belongsTo = [project:Project,demand:Demand]

    static constraints = {
        serial nullable: true
        project(blank:false)
        type()
        title nullable: true
        description(maxSize: 2000,nullable: true)
        proposal(maxSize: 2000,nullable: true)
        scenario(maxSize: 2000,nullable: true)
        priority()
        planHour()
        verifyDate(blank:true,nullable: true)
        verifier(blank: true,nullable: true)
        status(nullable: true)
        remark(maxSize: 2000,nullable: true)
        finisher(nullable: true)
        finishDate(nullable: true)
        demand nullable: true

        creater(nullable: true)
        createDate(nullable: true)

        evaluate nullable: true, inList: ["good","normal","bad"]
        evalDesc nullable: true
        //evaluater nullable: true

        approver nullable: true
        approveDate nullable: true
    }

    String serial       //序号
    String title        //任务标题
    String description  //任务描述

    int planHour        //计划时间

    TaskType type       //工作类型
    TaskStatus status
    Priority priority   //优先级
    String proposal     //解决方案
    String scenario     //测试方案
    String remark       //备注

    Date verifyDate
    String verifier

    Person approver     //验收人
    Date approveDate    //验收日期

    Person creater      //任务创建人
    Date createDate     //任务创建日期

    Person finisher     //完成人
    Date finishDate     //完成日期

    String evaluate     //评价
    String evalDesc     //评价说明（差评说明）
    //String evaluater    //评价人

    Task(id, String serial, String description, int planHour, TaskType type, TaskStatus status, Priority priority, String proposal, String scenario, String remark, Date verifyDate, String verifier, String projectName,
         Long did, String dserial, String creater, Date createDate, String finisher, Date finishDate, String evaluate, String evalDesc, String approver, Date approveDate, String title) {
        this.id = id
        this.serial = serial
        this.description = description
        this.planHour = planHour
        this.type = type
        this.status = status
        this.priority = priority
        this.proposal = proposal
        this.scenario = scenario
        this.remark = remark
        this.verifyDate = verifyDate
        this.verifier = verifier
        this.project = new Project()
        this.project.name = projectName
        this.demand = new Demand()
        this.demand.id = did
        this.demand.serial = dserial
        this.creater = new Person()
        this.creater.name = creater
        this.createDate = createDate
        this.finisher = new Person()
        this.finisher.name = finisher
        this.finishDate = finishDate
        this.evaluate = evaluate
        this.evalDesc = evalDesc
        this.approver = new Person()
        this.approver.name = approver
        this.approveDate = approveDate
        this.title = title
    }

    static evalTask(Task task, String evaluate, String evaluateDesc, Person approver){
        task.evaluate = evaluate
        task.evalDesc = evaluateDesc
        task.approver = approver
        task.approveDate = new Date()

        task.save(flush: true)
    }

}



