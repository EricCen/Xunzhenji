package net.xunzhenji.wechat


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class WeChatButtonController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond WeChatButton.list(params), model: [weChatButtonInstanceCount: WeChatButton.count()]
    }

    def show(WeChatButton weChatButtonInstance) {
        respond weChatButtonInstance
    }

    def create() {
        respond new WeChatButton(params)
    }

    @Transactional
    def save(WeChatButton weChatButtonInstance) {
        if (weChatButtonInstance == null) {
            notFound()
            return
        }

        if (weChatButtonInstance.hasErrors()) {
            respond weChatButtonInstance.errors, view: 'create'
            return
        }

        weChatButtonInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'weChatButton.label', default: 'WeChatButton'), weChatButtonInstance.id])
                redirect weChatButtonInstance
            }
            '*' { respond weChatButtonInstance, [status: CREATED] }
        }
    }

    def edit(WeChatButton weChatButtonInstance) {
        respond weChatButtonInstance
    }

    @Transactional
    def update(WeChatButton weChatButtonInstance) {
        if (weChatButtonInstance == null) {
            notFound()
            return
        }

        if (weChatButtonInstance.hasErrors()) {
            respond weChatButtonInstance.errors, view: 'edit'
            return
        }

        weChatButtonInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'WeChatButton.label', default: 'WeChatButton'), weChatButtonInstance.id])
                redirect weChatButtonInstance
            }
            '*' { respond weChatButtonInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(WeChatButton weChatButtonInstance) {

        if (weChatButtonInstance == null) {
            notFound()
            return
        }

        weChatButtonInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'WeChatButton.label', default: 'WeChatButton'), weChatButtonInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'weChatButton.label', default: 'WeChatButton'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
