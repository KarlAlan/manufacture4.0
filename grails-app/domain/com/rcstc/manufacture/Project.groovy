package com.rcstc.manufacture

class Project {

    static constraints = {
        fristParty(nullable: false)
        secondParty(nullable: false)
        thirdParty(nullable:true)
        fourthParty(nullable: true)
        name(blank: false)
        serial(blank: false)
        type(blank:false)
        status(blank: false)
        sales(nullable: true)
        picPeople(nullable: true)
        subjectMatter()
        startDate(nullable: true)
        launchedDate(nullable: true)
        planDate(nullable: true)
        signDate(nullable: true)
        closeDate(nullable: true)
        perfix(blank: false)
        requirmentSerial()
        jobSerial()
        batchSerial()
        informationSystem(nullable: true)

        usingDepartment(nullable: true)
        budget(nullable: true)
        approvalDate(nullable: true)
        remark(nullable: true,maxSize: 2000)

        autoBuildWeeklyReport nullable: true
    }

    Project(Long id, String name){
        this.id = id
        this.name = name
    }

    String name              // 项目名称
    String serial            //编号(合同编号)
    ProjectType type         //类型
    ProjectStatus status     //状态
    String fristParty            // 甲方
    String secondParty           // 乙方
    String thirdParty            // 第三方
    String fourthParty           // 第四方

    String picPeople         // 负责人
    String sales             // 销售

    int subjectMatter       // 标的

    Date startDate          //启动日期
    Date launchedDate       // 实际上线日期
    Date planDate           // 计划上线日期
    Date signDate           // 签约日期
    Date closeDate          // 关闭日期

    String usingDepartment  //业务单位（使用部门）
    //String headOfIT         //IT部负责人
    //String headOfOD         //运营部负责人
    //String headOfBusiness   //业务部门负责人

    BigDecimal budget       //预算
    Date approvalDate       //立项日期

    String remark           //备注

    String perfix //前缀
    int  requirmentSerial    //需求序列号
    int  jobSerial           //工作序列号
    int  batchSerial         //批次序列号

    InformationSystem informationSystem

    Boolean autoBuildWeeklyReport   //自动生成周报

    String toString(){
        return name
    }
}

public enum ProjectType {
    项目('10'),
    产品('20'),
    运维('80'),
    其他('90')

    String id

    ProjectType(String id) { this.id = id }
}

public enum ProjectStatus {
    备案('10'),
    立项('20'),
    验收('30'),
    运维('40'),
    关闭('99')

    String id

    ProjectStatus(String id) { this.id = id }
}