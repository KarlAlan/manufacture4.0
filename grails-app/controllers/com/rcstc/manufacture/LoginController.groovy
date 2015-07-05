/* Copyright 2013-2014 SpringSource.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.rcstc.manufacture

import com.rcstc.acl.Role
import com.rcstc.acl.UserRole
import com.rcstc.personnel.InviteCode
import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityUtils
import org.springframework.security.access.annotation.Secured
import org.springframework.security.authentication.AccountExpiredException
import org.springframework.security.authentication.CredentialsExpiredException
import org.springframework.security.authentication.DisabledException
import org.springframework.security.authentication.LockedException
import org.springframework.security.core.context.SecurityContextHolder as SCH
import org.springframework.security.web.WebAttributes

import javax.servlet.http.HttpServletResponse

@Secured('permitAll')
class LoginController {

    /**
     * Dependency injection for the authenticationTrustResolver.
     */
    def authenticationTrustResolver

    /**
     * Dependency injection for the springSecurityService.
     */
    def springSecurityService

    /**
     * Default action; redirects to 'defaultTargetUrl' if logged in, /login/auth otherwise.
     */
    def index() {
        if (springSecurityService.isLoggedIn()) {
            redirect uri: SpringSecurityUtils.securityConfig.successHandler.defaultTargetUrl
        }
        else {
            redirect action: 'auth', params: params
        }
    }

    /**
     * Show the login page.
     */
    def auth() {

        def config = SpringSecurityUtils.securityConfig

        if (springSecurityService.isLoggedIn()) {
            redirect uri: config.successHandler.defaultTargetUrl
            return
        }

        String view = 'auth'
        String postUrl = "${request.contextPath}${config.apf.filterProcessesUrl}"
        render view: view, model: [postUrl: postUrl,
                rememberMeParameter: config.rememberMe.parameter]
    }

    /**
     * The redirect action for Ajax requests.
     */
    def authAjax() {
        response.setHeader 'Location', SpringSecurityUtils.securityConfig.auth.ajaxLoginFormUrl
        response.sendError HttpServletResponse.SC_UNAUTHORIZED
    }

    /**
     * Show denied page.
     */
    def denied() {
        if (springSecurityService.isLoggedIn() &&
                authenticationTrustResolver.isRememberMe(SCH.context?.authentication)) {
            // have cookie but the page is guarded with IS_AUTHENTICATED_FULLY
            redirect action: 'full', params: params
        }
    }

    /**
     * Login page for users with a remember-me cookie but accessing a IS_AUTHENTICATED_FULLY page.
     */
    def full() {
        def config = SpringSecurityUtils.securityConfig
        render view: 'auth', params: params,
                model: [hasCookie: authenticationTrustResolver.isRememberMe(SCH.context?.authentication),
                        postUrl: "${request.contextPath}${config.apf.filterProcessesUrl}"]
    }

    /**
     * Callback after a failed login. Redirects to the auth page with a warning message.
     */
    def authfail() {

        String msg = ''
        def exception = session[WebAttributes.AUTHENTICATION_EXCEPTION]
        if (exception) {
            if (exception instanceof AccountExpiredException) {
                msg = g.message(code: "springSecurity.errors.login.expired")
            }
            else if (exception instanceof CredentialsExpiredException) {
                msg = g.message(code: "springSecurity.errors.login.passwordExpired")
            }
            else if (exception instanceof DisabledException) {
                msg = g.message(code: "springSecurity.errors.login.disabled")
            }
            else if (exception instanceof LockedException) {
                msg = g.message(code: "springSecurity.errors.login.locked")
            }
            else {
                msg = g.message(code: "springSecurity.errors.login.fail")
            }
        }

        if (springSecurityService.isAjax(request)) {
            render([error: msg] as JSON)
        }
        else {
            flash.message = msg
            redirect action: 'auth', params: params
        }
    }

    /**
     * The Ajax success redirect url.
     */
    def ajaxSuccess() {
        render([success: true, username: springSecurityService.authentication.name] as JSON)
    }

    /**
     * The Ajax denied redirect url.
     */
    def ajaxDenied() {
        render([error: 'access denied'] as JSON)
    }

    def createPerson(){
        def code = params.inviteCode
        if(!code||code==""){
            flash.message = "邀请码不能为空！"
            redirect action: 'auth', params: params
            return
        }

        def ics = InviteCode.findAllByInviteCode(code)
        if (ics.size() == 0){
            flash.message = "邀请码错误或已经过期，请联系邀请人重新发邀请函！"
            redirect action: 'auth', params: params
            return
        }

        def personInstance = new Person(params)
        personInstance.email = ics.get(0).inviteeEmail
        if (!personInstance.save(flush: true)) {
            render(view: "auth", model: [personInstance: personInstance])
            return
        }

        def ic = ics.get(0)
        if(!ic.auth){
            def r = Role.findByAuthority(Role.USER)

            UserRole.create personInstance, r, true
        } else {
            def r = Role.findByAuthority(ic.auth)

            UserRole.create personInstance, r, true
        }


        // direct join project team

        if(ic.project){
            // join team
            def project = Project.get(ic.project.toLong())
            def person = personInstance
            def pp = ProjectRole.valueOf(ic.role)

            PersonProject.create(person,project,pp,true)

            event topic:"TEAM-JOIN", data:new PersonProject(project:project,person:person,projectRole:pp), fork:false
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'person.label', default: 'Person'), personInstance.id])
        redirect(controller: "person", action: "show", id: personInstance.id)
    }

    def register(){
        [personInstance: new Person(params)]
    }
}
