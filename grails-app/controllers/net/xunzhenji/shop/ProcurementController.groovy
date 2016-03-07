package net.xunzhenji.shop

import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class ProcurementController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Procurement.list(params), model: [procurementInstanceCount: Procurement.count()]
    }

    def show(Procurement procurementInstance) {
        respond procurementInstance
    }

    def create() {
        respond new Procurement(params)
    }

    @Transactional
    def save(Procurement procurementInstance) {
        if (procurementInstance == null) {
            notFound()
            return
        }

        if (procurementInstance.hasErrors()) {
            respond procurementInstance.errors, view: 'create'
            return
        }

        procurementInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'procurement.label', default: 'Procurement'), procurementInstance.id])
                redirect procurementInstance
            }
            '*' { respond procurementInstance, [status: CREATED] }
        }
    }

    def edit(Procurement procurementInstance) {
        respond procurementInstance
    }

    @Transactional
    def update(Procurement procurementInstance) {
        if (procurementInstance == null) {
            notFound()
            return
        }

        if (procurementInstance.hasErrors()) {
            respond procurementInstance.errors, view: 'edit'
            return
        }

        procurementInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'procurement.label', default: 'Procurement'), procurementInstance.id])
                redirect procurementInstance
            }
            '*' { respond procurementInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Procurement procurementInstance) {

        if (procurementInstance == null) {
            notFound()
            return
        }

        procurementInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'procurement.label', default: 'Procurement'), procurementInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'procurement.label', default: 'Procurement'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
