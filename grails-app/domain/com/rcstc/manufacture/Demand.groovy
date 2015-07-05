package com.rcstc.manufacture

class Demand {

    static belongsTo = [project:Project]
    static hasMany = [tasks:Task]

    static constraints = {
        serial(bindable: false,nullable: true)
        project(blank:false)
        category1(nullable: false)
        category2(nullable:true)
        category3(nullable:true)
        title nullable: true
        description(blank:false,maxSize:2000)
        planStartDate()
        planStopDate(nullable:true)

        baFinishDate nullable: true
        saFinishDate nullable: true
        deFinishDate nullable: true
        siFinishDate nullable: true
        uaFinishDate nullable: true

        //finishDate(nullable:true)
        closeDate(nullable:true)
        type(nullable:true)
        status(nullable:true)
        demandCharacter(nullable: true)
        priority()
        proposal(maxSize:2000,nullable: true)
        //sitResult(maxSize: 2000,nullable: true)
        submitPeople(nullable: false)
        remark(nullable: true, maxSize:2000)
        updateDate(nullable:true)
        picPeople(nullable:true)
        //sitPeople(nullable: true)

        planDeliveryDate nullable: true
        deployDate nullable: true
        approver nullable: true
        approveDate nullable: true
        evaluate nullable: true
        evalDesc nullable: true

        confirm nullable: true
        confirmDate nullable: true
        batchNo nullable: true
        scenario(maxSize:2000,nullable: true)
        instructions(maxSize:2000,nullable: true)
    }

    boolean backward = false        // 后退标志

    String category1                // 大类（模块名称）
    String category2                // 中类（功能点名称）
    String category3                //
    String title                    //标题
    String serial                   // 序号
    String description              // 需求描述
    Date planStartDate              // 提出日期
    Date planStopDate	            // 要求提交UAT测试日期
    //Date sxFinishDate               // 生效日期
    Date baFinishDate               // 运营分析完成日期
    Date saFinishDate	            // 设计完成日期，提交开发，相当开发开始日期
    Date deFinishDate	            // 开发完成日期 ，提交sit测试
    Date siFinishDate               // sit测试完成日期，提交UAT测试  13.5.15 新增
    Date uaFinishDate               // uat测试完成日期  135.3.29 新增
    //Date finishDate	// UAT完成日期，上线部署日期
    Date closeDate	                // 关闭日期，发布完成、需求取消、暂时关闭等

    DemandType type                    //需求类型
    DemandCharacter demandCharacter    //需求特性
    DemandStatus status                //需求状态
    Priority priority                  //优先级
    //Progress progress
    String proposal                    //解决方案
    String remark                      //备注
    //String sitResult // 测试结果  13.5.15 新增
    //String sitPeople // 测试人   13.5.15 新增
    String submitPeople                // 提交人
    /* 10.16 日新加*/
    Date updateDate                     // 生效日期
    String picPeople                    // 负责人

    Date planDeliveryDate               //计划交付日期
    Date deployDate                     //发布生产环境日期

    String evaluate         //评价
    String evalDesc         //评价说明（差评说明）

    Person approver         //验收人
    Date approveDate        //验收日期

    //2015.5.13 新增确认环节
    Person confirm          //确认人
    Date   confirmDate      //确认日期

    String batchNo          //批次号，和合同关联

    boolean urgent = false          //加急处理标记

    String scenario         //测试方案及测试报告
    String instructions     //操作说明

    Demand(Long id, String category1, String category2, String category3, String serial, String description, Date planStartDate,
           Date planStopDate, Date closeDate, DemandType type, DemandStatus status, Priority priority, String proposal, String remark,
           String submitPeople, Date updateDate, String picPeople, String projectName, DemandCharacter demandCharacter,
           boolean backward, Date baFinishDate, Date saFinishDate, Date deFinishDate, Date siFinishDate, Date uaFinishDate,
           Date planDeliveryDate, Date deployDate, String evaluate, String evalDesc, String approver, Date approveDate, String title) {
        this.category1 = category1
        this.category2 = category2
        this.category3 = category3
        this.serial = serial
        this.description = description
        this.planStartDate = planStartDate
        this.planStopDate = planStopDate
        this.closeDate = closeDate
        this.type = type
        this.status = status
        this.priority = priority
        this.proposal = proposal
        this.remark = remark
        this.submitPeople = submitPeople
        this.updateDate = updateDate
        this.picPeople = picPeople
        this.id = id
        this.project = new Project()
        this.project.name = projectName
        this.demandCharacter = demandCharacter
        this.backward = backward
        this.baFinishDate = baFinishDate
        this.saFinishDate = saFinishDate
        this.deFinishDate = deFinishDate
        this.siFinishDate = siFinishDate
        this.uaFinishDate = uaFinishDate
        this.planDeliveryDate = planDeliveryDate
        this.deployDate = deployDate
        this.evaluate = evaluate
        this.evalDesc = evalDesc
        this.approver = new Person()
        this.approver.name = approver
        this.approveDate = approveDate
        this.title = title
    }
}


public enum DemandType {
    CHANGE_FUNCTION('30','功能变更'),
    BUG('20','BUG'),
    NEW_FUNCTION('10','新功能')

    String id
    String name

    DemandType(String id, String name) {
        this.id = id
        this.name = name
    }
}

public enum DemandCharacter {
    CONSTRAINT('40','约束'),
    USABILITY('30','易用性'),
    PERFORMANCE('20','性能'),
    FUNCTIONAL('10','功能性')

    String id
    String name

    DemandCharacter(String id, String name) {
        this.id = id
        this.name = name
    }
}

public enum DemandStatus {
    DRAFT('1','草稿'),
    ANALYSE('10','分析'),
    DESIGN('20','设计'),
    AUDIT('12','确认'),
    DEVELOP('30','开发'),
    SIT('31','SIT'),
    UAT('32','UAT'),
    CANCELED('40','作废'),
    ACCOMPLISHED('99','关闭')

    String id
    String name

    DemandStatus(String id, String name) {
        this.id = id
        this.name = name
    }
}

public enum Priority {
    EMERGENCY('10','重要'),
    NORMAL('30','一般')

    String id
    String name

    Priority(String id, String name) {
        this.id = id
        this.name = name
    }
}