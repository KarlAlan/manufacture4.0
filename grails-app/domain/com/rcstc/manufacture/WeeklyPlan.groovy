package com.rcstc.manufacture

import org.joda.time.DateTime

class WeeklyPlan {

    static constraints = {
        person nullable: false
        planTasksAmount nullable: true
        planWorkload nullable: true
        actualTasksAmount nullable: true
        actualWorkload nullable: true
    }

    static belongsTo = [person:Person]
    static hasMany = [tasks:Task]

    int year
    int week

    BigDecimal planTasksAmount
    BigDecimal planWorkload
    BigDecimal actualTasksAmount
    BigDecimal actualWorkload

    static WeeklyPlan addTask(Person p, int year, int week, Task t, boolean finished){
        def wp = WeeklyPlan.findByPersonAndYearAndWeek(p,year,week)
        if(!wp){
            wp = new WeeklyPlan()
            wp.year = year
            wp.week = week
            wp.person = p
            wp.planTasksAmount = 0
            wp.planWorkload = 0
            wp.actualTasksAmount = 0
            wp.actualWorkload = 0
            wp.tasks = new ArrayList<Task>()

            wp.save(flush: true, insert: true)
        }

        wp.tasks.add(t)
        if(finished){
            wp.actualTasksAmount = wp.actualTasksAmount + 1
            wp.actualWorkload = wp.actualWorkload + t.planHour
        } else {
            wp.planTasksAmount = wp.planTasksAmount + 1
            wp.planWorkload = wp.planWorkload + t.planHour

            t.status = TaskStatus.DEVELOP
            t.save(flush: true)
        }



        wp.save(flush: true)
        wp
    }

    static WeeklyPlan addTask(Person p, int year, int week, Task t){
        addTask(p, year, week, t, false)
    }

    static void removeTask(long weeklyPlanId, Task t){
        if(t.status!=TaskStatus.ACCOMPLISHED){
            def wp = WeeklyPlan.get(weeklyPlanId)
            wp.tasks.remove(t)
            wp.planTasksAmount = wp.planTasksAmount - 1
            wp.planWorkload = wp.planWorkload - t.planHour

            t.status = TaskStatus.ARRANGE
            t.save(flush: true)

            wp.save(flush: true)
        }
    }

    static boolean exists(long personId, int year, int week) {
        WeeklyPlan.where {
            person == Person.load(personId) &&
            year == year &&
            week == week
        }.count() > 0
    }
}
