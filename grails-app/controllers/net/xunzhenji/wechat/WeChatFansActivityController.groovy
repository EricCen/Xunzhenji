package net.xunzhenji.wechat

import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class WeChatFansActivityController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def activities = WeChatFansActivity.findAllByFans(WeChatFans.get(params.fansId), params)

        respond activities, model: [weChatFansActivityInstanceCount: WeChatFansActivity.count()]
    }

    def show(WeChatFansActivity weChatFansActivityInstance) {
        respond weChatFansActivityInstance
    }

    def create() {
        respond new WeChatFansActivity(params)
    }

    @Transactional
    def save(WeChatFansActivity weChatFansActivityInstance) {
        if (weChatFansActivityInstance == null) {
            notFound()
            return
        }

        if (weChatFansActivityInstance.hasErrors()) {
            respond weChatFansActivityInstance.errors, view: 'create'
            return
        }

        weChatFansActivityInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'weChatFansActivity.label', default: 'WeChatFansActivity'), weChatFansActivityInstance.id])
                redirect weChatFansActivityInstance
            }
            '*' { respond weChatFansActivityInstance, [status: CREATED] }
        }
    }

    def edit(WeChatFansActivity weChatFansActivityInstance) {
        respond weChatFansActivityInstance
    }

    @Transactional
    def update(WeChatFansActivity weChatFansActivityInstance) {
        if (weChatFansActivityInstance == null) {
            notFound()
            return
        }

        if (weChatFansActivityInstance.hasErrors()) {
            respond weChatFansActivityInstance.errors, view: 'edit'
            return
        }

        weChatFansActivityInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'WeChatFansActivity.label', default: 'WeChatFansActivity'), weChatFansActivityInstance.id])
                redirect weChatFansActivityInstance
            }
            '*' { respond weChatFansActivityInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(WeChatFansActivity weChatFansActivityInstance) {

        if (weChatFansActivityInstance == null) {
            notFound()
            return
        }

        weChatFansActivityInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'WeChatFansActivity.label', default: 'WeChatFansActivity'), weChatFansActivityInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'weChatFansActivity.label', default: 'WeChatFansActivity'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
