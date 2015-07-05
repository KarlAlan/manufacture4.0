package com.rcstc.manufacture

import com.rcstc.acl.User

class Person extends User {
    static mapping = {
        type defaultValue: PersonType.一般用户
    }

    static hasMany = [develops: Batch, sits: Batch, pps: PersonProject]
    static mappedBy = [develops: "developer", sits: "sitPeople"]

    static constraints = {
        name blank: false
        email email:true, blank: false
        phone blank: false
        company blank: true, nullable: true
        department blank: true, nullable: true
        jobTitle blank: true, nullable: true
        type nullable: true
        startWork nullable: true
        education nullable: true
        emtryTime nullable: true
    }

    String name
    String email
    String phone
    String company
    String department
    String jobTitle

    PersonType type

    Date startWork
    Date emtryTime
    String education            // 学历

    int administrativeLevel    //行政级别
    int skillLevel             //技能级别

    int dayPrice               // 人日单价

    @Override
    String toString() {
        return name
    }
}

public enum PersonType {
    一般用户('10'),
    雇员('20')

    String id

    PersonType(String id) { this.id = id }
}