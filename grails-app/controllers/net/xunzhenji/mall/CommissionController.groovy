package net.xunzhenji.mall


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CommissionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Commission.list(params), model: [commissionInstanceCount: Commission.count()]
    }

    def show(Commission commissionInstance) {
        [commissionInstance:commissionInstance, commissionEvents: commissionInstance.commissionEvents]
    }

    def edit(Commission commissionInstance) {
        respond commissionInstance
    }

    @Transactional
    def update(Commission commissionInstance) {
        if (commissionInstance == null) {
            notFound()
            return
        }

        if (commissionInstance.hasErrors()) {
            respond commissionInstance.errors, view: 'edit'
            return
        }

        commissionInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'commission.label', default: 'Commission'), commissionInstance.id])
                redirect commissionInstance
            }
            '*' { respond commissionInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Commission commissionInstance) {

        if (commissionInstance == null) {
            notFound()
            return
        }

        commissionInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'commission.label', default: 'Commission'), commissionInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'commission.label', default: 'Commission'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
