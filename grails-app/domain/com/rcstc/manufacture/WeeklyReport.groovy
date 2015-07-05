package com.rcstc.manufacture

class WeeklyReport {

    static mapping = {
        resource column: 'project_resource'
    }

    static constraints = {
        project nullable: false
        title nullable: true
        startDate nullable: true, blank:true
        stopDate nullable: true, blank:true
        buildDate nullable: true, blank:true
        buildPerson nullable: false
        situation nullable: true
        handled nullable: true, maxSize: 2000
        description nullable: true, maxSize: 2000
        question nullable: true, maxSize: 2000
        resource nullable: true, maxSize: 2000
        remark nullable: true, maxSize: 2000

        planingTask nullable: true, maxSize: 2000
        finishedTask nullable: true, maxSize: 2000
        status nullable: true, inList: ['draft','formal']

    }

    Project project     //项目
    String title        //标题
    Date startDate      //汇报周期
    Date stopDate       //汇报周期

    Date buildDate      //制作日期
    String buildPerson  //制作人

    String situation    //项目状况
    String handled      //本周处理总结
    String description  //进展说明
    String question     //问题
    String resource     //资源
    String remark       //备注

    String planingTask  //下周计划
    String finishedTask //本周实际工作

    String status       //状态
}
