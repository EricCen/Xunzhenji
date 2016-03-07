package net.xunzhenji.mall


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ExpressController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Express.list(params), model: [expressInstanceCount: Express.count()]
    }

    def show(Express expressInstance) {
        respond expressInstance
    }

    def create() {
        respond new Express(params)
    }

    @Transactional
    def save(Express expressInstance) {
        if (expressInstance == null) {
            notFound()
            return
        }

        if (expressInstance.hasErrors()) {
            respond expressInstance.errors, view: 'create'
            return
        }

        expressInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'express.label', default: 'Express'), expressInstance.id])
                redirect expressInstance
            }
            '*' { respond expressInstance, [status: CREATED] }
        }
    }

    def edit(Express expressInstance) {
        respond expressInstance
    }

    @Transactional
    def update(Express expressInstance) {
        if (expressInstance == null) {
            notFound()
            return
        }

        if (expressInstance.hasErrors()) {
            respond expressInstance.errors, view: 'edit'
            return
        }

        expressInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Express.label', default: 'Express'), expressInstance.id])
                redirect expressInstance
            }
            '*' { respond expressInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Express expressInstance) {

        if (expressInstance == null) {
            notFound()
            return
        }

        expressInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'express.label', default: 'Express'), expressInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'express.label', default: 'Express'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
