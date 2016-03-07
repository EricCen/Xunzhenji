package net.xunzhenji.editor

import groovy.json.JsonSlurper
import net.xunzhenji.wechat.Template

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TemplateController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def weChatPushService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Template.list(params), model: [templateInstanceCount: Template.count()]
    }

    def show(Template templateInstance) {
        templateInstance.renderTemplate()
        respond templateInstance
    }

    def create() {
        respond new Template(params)
    }

    @Transactional
    def save(Template templateInstance) {
        if (templateInstance == null) {
            notFound()
            return
        }

        if (templateInstance.hasErrors()) {
            respond templateInstance.errors, view: 'create'
            return
        }

        try{
            new JsonSlurper().parseText(templateInstance.templateJson.replace("\r","").replace("\n",""))
        }catch(e){
            e.printStackTrace()
            templateInstance.errors.reject("FailToParseJson","不能解释模板对象")
        }

        templateInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'Template.label', default: 'Template'), templateInstance.id])
                redirect templateInstance
            }
            '*' { respond templateInstance, [status: CREATED] }
        }
    }

    def edit(Template templateInstance) {
        respond templateInstance
    }

    @Transactional
    def update(Template templateInstance) {
        if (templateInstance == null) {
            notFound()
            return
        }

        try{
            new JsonSlurper().parseText(templateInstance.templateJson.replace("\r","").replace("\n",""))
        }catch(e){
            e.printStackTrace()
            templateInstance.errors.reject("FailToParseJson","不能解释模板对象")
        }

        if (templateInstance.hasErrors()) {
            respond templateInstance.errors, view: 'edit'
            return
        }

        templateInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Template.label', default: 'Template'), templateInstance.id])
                redirect templateInstance
            }
            '*' { respond templateInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Template templateInstance) {

        if (templateInstance == null) {
            notFound()
            return
        }

        templateInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Template.label', default: 'Template'), templateInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'template.label', default: 'Template'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    @Transactional
    def addToWechat(){
        if(!params.id){
            log.error("No id in params")
            redirect(controller: "template")
            return
        }
        def template = Template.get(params.id)
        if(!template){
            log.error("No template found")
            redirect(controller: "template")
            return
        }
        def templateId = weChatPushService.getTemplateId(template.templateIdShort)
        log.info("TemplateId: ${templateId}")
        template.templateId = templateId
        template.save()

        redirect(controller: "template")
    }

    def send(){
        log.info("Test send template message to a user, ${params.openId}")
        if(!params.id){
            log.error("No id in params")
            redirect(controller: "template")
            return
        }
        def template = Template.get(params.id)
        if(!template){
            log.error("No template found")
            redirect(controller: "template")
            return
        }
        def data = new JsonSlurper().parseText(params.templateJson.replace("\r","").replace("\n",""))
        log.info("Send message to user, data: ${data}")
        if(!params.url)         params.url ="http://xunzhenji.net/h5/home"
        weChatPushService.sendTemplateMessage(template.buildMsg(params.openId, params.url, data))
        redirect(controller: "template")
    }
}
