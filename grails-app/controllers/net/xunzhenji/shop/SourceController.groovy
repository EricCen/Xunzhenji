package net.xunzhenji.shop

import grails.transaction.Transactional
import net.xunzhenji.util.ErrorCodeUtil

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class SourceController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Source.list(params), model: [sourceInstanceCount: Source.count()]
    }

    def show(Source sourceInstance) {
        respond sourceInstance
    }

    def create() {
        respond new Source(params)
    }

    @Transactional
    def save(Source sourceInstance) {
        if (sourceInstance == null) {
            notFound()
            return
        }

        if (sourceInstance.hasErrors()) {
            respond sourceInstance.errors, view: 'create'
            return
        }

        sourceInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'source.label', default: 'Source'), sourceInstance.id])
                redirect sourceInstance
            }
            '*' { respond sourceInstance, [status: CREATED] }
        }
    }

    def edit(Source sourceInstance) {
        respond sourceInstance
    }

    @Transactional
    def update(Source sourceInstance) {
        if (sourceInstance == null) {
            notFound()
            return
        }

        if (sourceInstance.hasErrors()) {
            respond sourceInstance.errors, view: 'edit'
            return
        }

        sourceInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'source.label', default: 'Source'), sourceInstance.id])
                redirect sourceInstance
            }
            '*' { respond sourceInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Source sourceInstance) {

        if (sourceInstance == null) {
            notFound()
            return
        }

        sourceInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'source.label', default: 'Source'), sourceInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'source.label', default: 'Source'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
