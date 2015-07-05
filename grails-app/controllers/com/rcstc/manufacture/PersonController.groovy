package com.rcstc.manufacture

import com.rcstc.acl.Role
import com.rcstc.acl.User
import com.rcstc.acl.UserRole
import com.rcstc.personnel.Attendance
import com.rcstc.personnel.InviteCode
import com.rcstc.personnel.Reward
import com.rcstc.personnel.RewardType
import com.rcstc.util.PasswordCreator
import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured
import org.apache.poi.ss.usermodel.Workbook
import org.apache.poi.ss.usermodel.WorkbookFactory
import org.imgscalr.Scalr
import org.joda.time.DateTime
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest

import javax.imageio.ImageIO
import java.awt.image.BufferedImage

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["hasRole('SUPER_ADMIN')"])
@Transactional(readOnly = true)
class PersonController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService
    def excelImportService

    @Secured(["hasAnyRole('ADMIN','BUSINESS')"])
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        def r
        def c

        if(params.people){
            r = Person.findAllByNameLike(params.people)
            c = Person.countByNameLike(params.people)
        } else if(SpringSecurityUtils.ifAnyGranted("SUPER_ADMIN")){
            r = Person.list(params)
            c = Person.count()
        }else {
            r = Person.executeQuery("from Person p where p.company = :org",[org:springSecurityService.currentUser.company,max:params.max ,offset:params.offset?:0])
            c = Person.executeQuery("select count(*) from Person p where p.company = :org",[org:springSecurityService.currentUser.company])[0]
        }
        respond r, model:[personInstanceCount: c]
    }

    @Secured(["hasRole('USER')"])
    def show(Person personInstance) {
        def ors = OperateRecord.findAllByPerson(personInstance.name,[max: 10, sort: "operateDate", order: "desc"])
        def colleagues = Person.findAllByCompany(personInstance.company)
        def rewardPoint = Reward.executeQuery("select sum (r.rewardPoint) from Reward r where r.username=:name",[name:personInstance.username])
        respond personInstance, model: [ors : ors, coleagues: colleagues, point: rewardPoint.get(0)]
    }

    @Secured(["hasAnyRole('ADMIN','BUSINESS')"])
    def create() {
        respond new Person(params)
    }

    @Secured(["hasRole('USER')"])
    @Transactional
    def save(Person personInstance) {
        if (personInstance == null) {
            notFound()
            return
        }

        if (personInstance.hasErrors()) {
            respond personInstance.errors, view:'create'
            return
        }

        personInstance.save flush:true

        event topic:"USER-CREATE", data:newUser

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'person.label', default: 'Person'), personInstance.id])
                redirect personInstance
            }
            '*' { respond personInstance, [status: CREATED] }
        }
    }

    @Secured(["hasRole('USER')"])
    def edit(Person personInstance) {
        if(personInstance.type==PersonType.雇员){
            respond personInstance, view: 'editEmployee'
            return
        }
        respond personInstance
    }

    @Secured(["hasRole('USER')"])
    @Transactional
    def update(Person personInstance) {
        if (personInstance == null) {
            notFound()
            return
        }

        if (personInstance.hasErrors()) {
            respond personInstance.errors, view:'edit'
            return
        }

        personInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Person.label', default: 'Person'), personInstance.id])
                redirect personInstance
            }
            '*'{ respond personInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Person personInstance) {

        if (personInstance == null) {
            notFound()
            return
        }

        UserRole.removeAll(personInstance,true)
        personInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Person.label', default: 'Person'), personInstance.id])
                redirect action:"authorities", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'person.label', default: 'Person'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def authorities(Integer max){
        params.max = Math.min(max ?: 10, 100)

        def r
        def c

        if(params.people){
            r = Person.findAllByNameLike(params.people)
            c = Person.countByNameLike(params.people)
        } else {
            r = Person.list(params)
            c = Person.count()
        }
        respond r, model:[personInstanceCount: c]
    }


    def employees(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def employees = Person.findAllByType(PersonType.雇员,params)
        [employeesList:employees,employeesCount: Person.countByType(PersonType.雇员)]
    }

    @Transactional
    def ajaxAssignAuthority() {
        def pid = params.long("pid")
        def aut = params.long("authority")
        if(UserRole.exists(pid, aut))
            UserRole.remove(User.get(pid), Role.get(aut), true)
        else
            UserRole.create(User.get(pid), Role.get(aut), true)

        render true
    }

    @Transactional
    def ajaxSetAccount() {
        def pid = params.long("pid")
        def op = params.op
        User u = User.get(pid)
        if(op.equals("enabled")){
            if(u.enabled){
                u.enabled = false
            } else {
                u.enabled = true
            }

        }
        if(op.equals("accountExpired")){
            if(u.accountExpired){
                u.accountExpired = false
            } else {
                u.accountExpired = true
            }

        }
        if(op.equals("accountLocked")){
            if(u.accountLocked){
                u.accountLocked = false
            } else {
                u.accountLocked = true
            }

        }
        if(op.equals("passwordExpired")){
            if(u.passwordExpired){
                u.passwordExpired = false
            } else {
                u.passwordExpired = true
            }

        }

        render true
    }

    @Secured(["hasRole('USER')"])
    def updatePassword(){
        def personInstance = springSecurityService.currentUser
        respond personInstance
    }

    @Secured(["hasRole('USER')"])
    @Transactional
    def passwordUpdated(){
        def pw = params.pw
        def personInstance = springSecurityService.currentUser
        personInstance.password = pw

        personInstance.save flush:true

        redirect controller: "batch", action: "desktop"
    }

    @Secured(["hasRole('USER')"])
    @Transactional
    def uploadAvatar(){
        def personInstance = springSecurityService.currentUser

        def file = request.getFile('avatar_file')
        if (file.empty) {
            flash.message = 'file cannot be empty'
            render(view: 'show', id:personInstance.id)
            return
        }

        String newFilenameBase = personInstance.username
        String originalFileExtension = file.originalFilename.substring(file.originalFilename.lastIndexOf("."))
        String storageDirectory = grailsApplication.config.file.upload.directory?:'/tmp'

        File newFile = new File("$storageDirectory/"+UUID.randomUUID().toString()+originalFileExtension)
        file.transferTo(newFile)

        BufferedImage thumbnail = Scalr.resize(ImageIO.read(newFile),Scalr.Mode.FIT_EXACT, 40, 40, Scalr.OP_ANTIALIAS);
        String thumbnailFilename = newFilenameBase + '-thumbnail.png'
        File thumbnailFile = new File("$storageDirectory/$thumbnailFilename")
        ImageIO.write(thumbnail, 'png', thumbnailFile)

        BufferedImage avatar = Scalr.resize(ImageIO.read(newFile),Scalr.Mode.FIT_TO_HEIGHT, 180, 200, Scalr.OP_ANTIALIAS);
        String avatarFilename = newFilenameBase + '.png'
        File avatarFile = new File("$storageDirectory/$avatarFilename")
        ImageIO.write(avatar, 'png', avatarFile)

        render true
    }

    @Secured(["hasRole('USER')"])
    def avatar(){
        File avatar = null;

        if(!params.thum){
            avatar = new File("${grailsApplication.config.file.upload.directory?:'/tmp'}/${params.username + '-thumbnail.png'}")
            if (!avatar.exists()){
                avatar = new File("${grailsApplication.config.file.upload.directory?:'/tmp'}/avatar4.png")
            }
        } else {
            avatar = new File("${grailsApplication.config.file.upload.directory?:'/tmp'}/${params.username + '.png'}")
            if (!avatar.exists()){
                avatar = new File("${grailsApplication.config.file.upload.directory?:'/tmp'}/profile-pic.jpg")
            }
        }

        response.contentType = 'image/png'
        response.outputStream << new FileInputStream(avatar)
        response.outputStream.flush()
    }

    @Secured(["hasRole('USER')"])
    def avatarByName(){
        def username = Person.findByName(params.name).username

        File avatar = null;

        avatar = new File("${grailsApplication.config.file.upload.directory?:'/tmp'}/${username + '-thumbnail.png'}")
        if (!avatar.exists()){
            avatar = new File("${grailsApplication.config.file.upload.directory?:'/tmp'}/avatar4.png")
        }

        response.contentType = 'image/png'
        response.outputStream << new FileInputStream(avatar)
        response.outputStream.flush()
    }

    @Secured(["hasAnyRole('ADMIN','BUSINESS')"])
    @Transactional
    def importUsersExcel(){
        def usersMapList
        if (request instanceof MultipartHttpServletRequest) {
            for (filename in request.getFileNames()){
                def file =request.getFile(filename)
                Workbook book = WorkbookFactory.create(file.inputStream);

                Map CONFIG_DEMAND_COLUMN_MAP = [
                        sheet:'工作表1',
                        startRow: 1,
                        columnMap:  [
                                'A':'公司',
                                'B':'姓名',
                                'C':'电话',
                                'D':'邮箱',
                                'E':'部门',
                                'F':'职衔',
                                'G':'用户名',
                        ]
                ]

                usersMapList = excelImportService.columns(book, CONFIG_DEMAND_COLUMN_MAP)

                //println usersMapList

                def r = Role.findByAuthority(Role.USER)

                usersMapList.each { Map userParams ->
                    def newUser = new Person()
                    newUser.username = userParams.用户名
                    newUser.name = userParams.姓名
                    newUser.company = userParams.公司
                    newUser.email = userParams.邮箱
                    newUser.department = userParams.部门
                    newUser.jobTitle = userParams.职衔
                    newUser.phone = userParams.电话
                    newUser.type = PersonType.雇员

                    PasswordCreator.GeneratedPassword password = PasswordCreator.generate(8)
                    newUser.password = password.getClearText()
                    if (!newUser.save()) {
                        println "User not saved, errors = ${newUser.errors}"
                    }

                    UserRole.create(newUser, r ,true)

                    // send login email
                    sendMail {
                        async true
                        from grailsApplication.config.sys_email.address
                        to newUser.email
                        subject "中外运需求管理系统账户开通"
                        html g.render(template:"userCreateMail", model: [person : newUser, pw: password.getClearText()])
                    }
                }

            }

            render(contentType: "application/json") {
                Person(amount: usersMapList.size())
            }
        } else {
            redirect controller: "person", action: "index"
        }

    }

    @Secured(["hasAnyRole('ADMIN','BUSINESS')"])
    @Transactional
    def ajaxInviteSystemUser(){
        def peo = params.people_name
        def pem = params.people_email
        def aut = params.auth_radio
        def person = springSecurityService.currentUser

        // Use email to check User exist
        if(Person.countByEmail(pem)>0){
            render false
        }

        //  generate invite code
        def code = InviteCode.generateCode(person.name,peo,pem,aut)

        // send invite email
        sendMail {
            async true
            from grailsApplication.config.sys_email.address
            to pem
            subject "中外运需求管理系统注册邀请函"
            html g.render(template:"mail1", model: [invite:code])
        }

        render true
    }

    @Secured(["hasAnyRole('ADMIN','BUSINESS')"])
    @Transactional
    def ajaxResetPassword(){
        if(!params.pid) {
            render false
            return
        }

        PasswordCreator.GeneratedPassword password = PasswordCreator.generate(8)

        def person = Person.get(params.long("pid"))
        person.password = password.getClearText()

        person.save flush:true

        // send reset password email
        sendMail {
            async true
            from grailsApplication.config.sys_email.address
            to person.email
            subject "需求管理系统的密码重置"
            html g.render(template:"resetPwMail", model: [person:person,pw:password.getClearText()])
        }

        render true
    }

    @Secured(["hasAnyRole('ADMIN','BUSINESS')"])
    def attendanceOfCompany(){
        def person = springSecurityService.currentUser
        DateTime dt = DateTime.now()
        def mo = params.month?params.int("month"):dt.getMonthOfYear()
        def ye = params.year?params.int("year"):dt.getYear()

        if(!params.month)
            params.month = mo
        if(!params.year)
            params.year = ye

        def persons = Person.findAllByCompanyAndEnabled(person.company,true)
        def attendaces = Attendance.executeQuery("from Attendance a where a.person.company = :org and a.person.enabled = true and year(a.attendanceDate)=:year and month(a.attendanceDate) = :month order by a.person.name, a.attendanceDate",[org:person.company,year:ye,month:mo])

        DateTime dt1 = new DateTime(ye,mo,1,2,0)
        int maxday = dt1.dayOfMonth().getMaximumValue()

        def morns = new Object[persons.size()][maxday][3]
        def aftes = new Object[persons.size()][maxday][3]

        attendaces.each {
            def pid = it.person.id
            def time = it.attendanceDate.format("HH:mm")
            DateTime ad = new DateTime(it.attendanceDate)
            int day = ad.dayOfMonth().get() - 1
            int i
            persons.eachWithIndex {p,index ->
                if(p.id == pid){
                   i = index
                }
            }
            if(it.operation=="Check In"){
                morns[i][day][0] = time
                morns[i][day][1] = it.isNormal
                morns[i][day][2] = it.status
            }
            if(it.operation=="Check Out"){
                aftes[i][day][0] = time
                aftes[i][day][1] = it.isNormal
                aftes[i][day][2] = it.status
            }
        }

        def applings = Attendance.executeQuery("from Attendance a where a.person.company = :org and a.status = 'Apply'",[org:person.company])

        [morns : morns, aftes : aftes, presons : persons ,params:params,applings:applings]
    }

    @Secured(["hasAnyRole('USER','BUSINESS','SALESMAN','SUPERVISOR')"])
    def ajaxRewardCount(){
        def username = springSecurityService.currentUser.username
        DateTime now = new DateTime()
        DateTime lastDayOfPreviousMonth = now.minusMonths(1).dayOfMonth().withMaximumValue()

        //def good = Reward.countByRewardTypeAndEvaluateAndUsername(RewardType.评价,"good",username)
        //def normal = Reward.countByRewardTypeAndEvaluateAndUsername(RewardType.评价,"normal",username)
        //def bad = Reward.countByRewardTypeAndEvaluateAndUsername(RewardType.评价,"bad",username)
        def good = 0
        def normal = 0
        def bad = 0

        def tr = Task.executeQuery("select t.evaluate, count(*) from Task t where t.finishDate > :ld group by t.evaluate",[ld:lastDayOfPreviousMonth.toDate()])
        tr.each { it ->
            if(it[0]=="good"){
                good = it[1]
            }
            if(it[0]=="normal"){
                normal = it[1]
            }
            if(it[0]=="bad"){
                bad = it[1]
            }
        }

        def tp = Reward.executeQuery("select sum(r.rewardPoint) from Reward r where r.rewardType=:type and r.username=:um",[type:RewardType.积分,um:username])
        def mp = Reward.executeQuery("select sum(r.rewardPoint) from Reward r where r.rewardType=:type and r.username=:um and r.rewardDate>:date",[type:RewardType.积分,um:username,date:lastDayOfPreviousMonth.toDate()])

        render (contentType: "application/json") {
            RewardStat(good: good,normal:normal,bad:bad,totalPoint:tp,monthPoint:mp)
        }
    }

    @Secured(["hasAnyRole('BUSINESS','SALESMAN','SUPERVISOR')"])
    def ajaxPersonEmail(){
        def em = params.query
        def r = Person.executeQuery("select distinct p.email from Person p where p.email like :em",[em:'%'+em+'%'])
        render r as JSON
    }

    @Secured(["hasAnyRole('USER','ADMIN','SUPERVISOR')"])
    def ajaxPersonName(){
        def em = params.query
        def r = Person.executeQuery("select distinct p.name from Person p where p.name like :em",[em:'%'+em+'%'])
        render r as JSON
    }

    @Secured(["hasAnyRole('ADMIN','SUPERVISOR','BUSINESS')"])
    def monthlyPersonStat(){
        DateTime now = new DateTime()
        def mo = params.month?params.int("month"):now.getMonthOfYear()
        def ye = params.year?params.int("year"):now.getYear()

        if(!params.month)
            params.month = mo
        if(!params.year)
            params.year = ye

        DateTime dt = new DateTime(ye,mo,1,2,0)
        def m1 = dt.dayOfMonth().withMinimumValue().toDate()
        def m2 = dt.dayOfMonth().withMaximumValue().toDate()

        def person = springSecurityService.currentUser

        def ut = Task.executeQuery("select u.name, count(t.id), sum(t.planHour), sum(case when t.evaluate ='good' then 1 else 0 end),sum(case when t.evaluate ='normal' then 1 else 0 end),sum(case when t.evaluate ='bad' then 1 else 0 end), u.id from Task t left join t.finisher u where u.enabled = true and u.company = :org and t.status = :ts and t.finishDate between :f1 and :f2 group by u.name, u.id order by sum(t.planHour) desc",[ts: TaskStatus.ACCOMPLISHED,f1:m1,f2:m2,org:person.company])

        [userTask: ut, params: params]
    }

    @Secured(["hasAnyRole('ADMIN','SUPERVISOR','BUSINESS')"])
    def weeklyPersonStat(){
        DateTime now = new DateTime()

        def person = springSecurityService.currentUser

        def f11 = now.dayOfWeek().withMaximumValue().toDate()
        def f10 = now.dayOfWeek().withMinimumValue().toDate()
        def f9 = now.plusWeeks(-1).dayOfWeek().withMinimumValue().toDate()
        def f8 = now.plusWeeks(-2).dayOfWeek().withMinimumValue().toDate()
        def f7 = now.plusWeeks(-3).dayOfWeek().withMinimumValue().toDate()
        def f6 = now.plusWeeks(-4).dayOfWeek().withMinimumValue().toDate()
        def f5 = now.plusWeeks(-5).dayOfWeek().withMinimumValue().toDate()
        def f4 = now.plusWeeks(-6).dayOfWeek().withMinimumValue().toDate()
        def f3 = now.plusWeeks(-7).dayOfWeek().withMinimumValue().toDate()
        def f2 = now.plusWeeks(-8).dayOfWeek().withMinimumValue().toDate()
        def f1 = now.plusWeeks(-9).dayOfWeek().withMinimumValue().toDate()

        def uwt = Task.executeQuery("select u.name," +
                " sum(case when t.finishDate between :f1 and :f2 then t.planHour else 0 end)," +
                " sum(case when t.finishDate between :f2 and :f3 then t.planHour else 0 end)," +
                " sum(case when t.finishDate between :f3 and :f4 then t.planHour else 0 end)," +
                " sum(case when t.finishDate between :f4 and :f5 then t.planHour else 0 end)," +
                " sum(case when t.finishDate between :f5 and :f6 then t.planHour else 0 end)," +
                " sum(case when t.finishDate between :f7 and :f8 then t.planHour else 0 end)," +
                " sum(case when t.finishDate between :f8 and :f9 then t.planHour else 0 end)," +
                " sum(case when t.finishDate between :f9 and :f10 then t.planHour else 0 end) as workhour," +
                " sum(case when t.finishDate between :f10 and :f11 then t.planHour else 0 end) " +
                " from Task t join t.finisher u where u.company = :org and u.enabled = true and t.status = :ts and t.finishDate between :f1 and :f11 group by u.name order by workhour desc",
                [ts: TaskStatus.ACCOMPLISHED,f1:f1,f2:f2,f3:f3,f4:f4,f5:f5,f6:f6,f7:f7,f8:f8,f9:f9,f10:f10,f11:f11,org:person.company])

        [weekHour:uwt]
    }
}
