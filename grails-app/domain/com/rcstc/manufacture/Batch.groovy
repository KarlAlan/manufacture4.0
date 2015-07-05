package com.rcstc.manufacture

import com.rcstc.personnel.Reward

class Batch {

    static constraints = {
        serial(bindable: false,nullable: true)
        project(blank:false)
        description(maxSize: 2000,nullable: true)
        startDate(bindable: false,nullable: true)
        planFinishDate(bindable: false,nullable: true)
        planHour()
        bufferHour()
        developer(blank:false)
        sitPeople(blank:false)
        remark(maxSize: 2000,nullable: true)
        isDone()
        finishDate(nullable: true)
    }

    static hasMany = [task:Task]

    static belongsTo = [project:Project]

    String serial
    String description
    Date startDate // 开始日期
    Date planFinishDate	// 计划完成日期

    boolean isDone = false // 是否完成
    Date finishDate	// 实际完成日期

    int planHour       //计划总耗时
    int bufferHour    //缓冲时间

    String remark     //备注

    Person developer // 开发人
    Person sitPeople // SIT测试人

    static def finishBatch(long tid){
        def result = Batch.findAll("from Batch as b inner join b.task as t where t.id = ?", [tid])
        Batch b = result[0][0]

        for (Task a in b.task){
            if (a.status != TaskStatus.ACCOMPLISHED)
                return;
        }
        b.isDone = true
        b.finishDate = new Date()

        b.save(flush: true)

        event("BATCH-FINISH",[b,b.sitPeople])

    }

}
