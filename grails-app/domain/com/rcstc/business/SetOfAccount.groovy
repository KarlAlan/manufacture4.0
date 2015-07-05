package com.rcstc.business

class SetOfAccount {

    static constraints = {
        company nullable: false
        name nullable: false
        description nullable: true
    }

    String company
    String name
    String description

    @Override
    String toString() {
        return name
    }
}
