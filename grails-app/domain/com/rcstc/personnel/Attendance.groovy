package com.rcstc.personnel

import com.rcstc.manufacture.Person

class Attendance {

    static constraints = {
        person nullable: false
        operation inList: ["Check In", "Check Out"]
        attendanceDate nullable: false

        isNormal nullable: true
        description nullable: true, maxSize: 2000
        status nullable: true , inList: ["Apply", "Reject", "Pass"]

        applyDate nullable: true
        handleDate nullable: true
        handler nullable: true

        location nullable: true
        address nullable: true
    }

    Person person       //考勤人
    String operation    //考勤类型
    Date attendanceDate //考勤日期

    boolean isNormal    //状态：正常，不正常， 默认正常
    String description  //迟到、不签到等原因说明
    String status       //申请、驳回、通过，由用户就不正常的考勤说明理由，上级处理（通过、驳回）

    Date applyDate      //申请日期
    Date handleDate     //处理日期
    String handler      //处理人


    String location
    String address
}
