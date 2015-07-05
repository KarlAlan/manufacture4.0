package com.rcstc.personnel



import grails.test.mixin.*
import spock.lang.*

@TestFor(AttendanceController)
@Mock(Attendance)
class AttendanceControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when: "The index action is executed"
        controller.index()

        then: "The model is correct"
        !model.attendanceInstanceList
        model.attendanceInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when: "The create action is executed"
        controller.create()

        then: "The model is correctly created"
        model.attendanceInstance != null
    }

    void "Test the save action correctly persists an instance"() {

        when: "The save action is executed with an invalid instance"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'POST'
        def attendance = new Attendance()
        attendance.validate()
        controller.save(attendance)

        then: "The create view is rendered again with the correct model"
        model.attendanceInstance != null
        view == 'create'

        when: "The save action is executed with a valid instance"
        response.reset()
        populateValidParams(params)
        attendance = new Attendance(params)

        controller.save(attendance)

        then: "A redirect is issued to the show action"
        response.redirectedUrl == '/attendance/show/1'
        controller.flash.message != null
        Attendance.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when: "The show action is executed with a null domain"
        controller.show(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the show action"
        populateValidParams(params)
        def attendance = new Attendance(params)
        controller.show(attendance)

        then: "A model is populated containing the domain instance"
        model.attendanceInstance == attendance
    }

    void "Test that the edit action returns the correct model"() {
        when: "The edit action is executed with a null domain"
        controller.edit(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the edit action"
        populateValidParams(params)
        def attendance = new Attendance(params)
        controller.edit(attendance)

        then: "A model is populated containing the domain instance"
        model.attendanceInstance == attendance
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when: "Update is called for a domain instance that doesn't exist"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'PUT'
        controller.update(null)

        then: "A 404 error is returned"
        response.redirectedUrl == '/attendance/index'
        flash.message != null


        when: "An invalid domain instance is passed to the update action"
        response.reset()
        def attendance = new Attendance()
        attendance.validate()
        controller.update(attendance)

        then: "The edit view is rendered again with the invalid instance"
        view == 'edit'
        model.attendanceInstance == attendance

        when: "A valid domain instance is passed to the update action"
        response.reset()
        populateValidParams(params)
        attendance = new Attendance(params).save(flush: true)
        controller.update(attendance)

        then: "A redirect is issues to the show action"
        response.redirectedUrl == "/attendance/show/$attendance.id"
        flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when: "The delete action is called for a null instance"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'DELETE'
        controller.delete(null)

        then: "A 404 is returned"
        response.redirectedUrl == '/attendance/index'
        flash.message != null

        when: "A domain instance is created"
        response.reset()
        populateValidParams(params)
        def attendance = new Attendance(params).save(flush: true)

        then: "It exists"
        Attendance.count() == 1

        when: "The domain instance is passed to the delete action"
        controller.delete(attendance)

        then: "The instance is deleted"
        Attendance.count() == 0
        response.redirectedUrl == '/attendance/index'
        flash.message != null
    }
}
