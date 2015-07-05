package com.rcstc.manufacture

class InformationSystem {

    static constraints = {
        org blank: false, nullable: false
        name blank: false, nullable: false
        description blank: true, nullable: true, maxSize: 2000
    }

    static hasMany = [modules:Module]

    String org
    String name
    String description

    @Override
    String toString() {
        return this.name
    }
}
