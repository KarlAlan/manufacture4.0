package com.rcstc.manufacture

class Module {

    static constraints = {
        name blank: false, nullable: false
        description blank: true, nullable: true, maxSize: 2000
        system nullable: true
        parent nullable: true
    }

    static hasMany = [children:Module]
    static belongsTo = [system:InformationSystem, parent:Module]

    String name
    String description
    boolean important
}
