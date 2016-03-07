package net.xunzhenji.alipay



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AlipayContextController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond AlipayContext.list(params), model:[alipayContextInstanceCount: AlipayContext.count()]
    }

    def show(AlipayContext alipayContextInstance) {
        respond alipayContextInstance
    }

    def create() {
        respond new AlipayContext(params)
    }

    @Transactional
    def save(AlipayContext alipayContextInstance) {
        if (alipayContextInstance == null) {
            notFound()
            return
        }

        if (alipayContextInstance.hasErrors()) {
            respond alipayContextInstance.errors, view:'create'
            return
        }

        alipayContextInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'alipayContext.label', default: 'AlipayContext'), alipayContextInstance.id])
                redirect alipayContextInstance
            }
            '*' { respond alipayContextInstance, [status: CREATED] }
        }
    }

    def edit(AlipayContext alipayContextInstance) {
        respond alipayContextInstance
    }

    @Transactional
    def update(AlipayContext alipayContextInstance) {
        if (alipayContextInstance == null) {
            notFound()
            return
        }

        if (alipayContextInstance.hasErrors()) {
            respond alipayContextInstance.errors, view:'edit'
            return
        }

        alipayContextInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'alipayContext.label', default: 'AlipayContext'), alipayContextInstance.id])
                redirect alipayContextInstance
            }
            '*'{ respond alipayContextInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(AlipayContext alipayContextInstance) {

        if (alipayContextInstance == null) {
            notFound()
            return
        }

        alipayContextInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'alipayContext.label', default: 'AlipayContext'), alipayContextInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'alipayContext.label', default: 'AlipayContext'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
