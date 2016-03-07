package net.xunzhenji.shop

import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class ManufactureController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Manufacture.list(params), model: [manufactureInstanceCount: Manufacture.count()]
    }

    def show(Manufacture manufactureInstance) {
        respond manufactureInstance
    }

    def create() {
        respond new Manufacture(params)
    }

    @Transactional
    def save(Manufacture manufactureInstance) {
        if (manufactureInstance == null) {
            notFound()
            return
        }

        if (manufactureInstance.hasErrors()) {
            respond manufactureInstance.errors, view: 'create'
            return
        }

        manufactureInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'manufacture.label', default: 'Manufacture'), manufactureInstance.id])
                redirect manufactureInstance
            }
            '*' { respond manufactureInstance, [status: CREATED] }
        }
    }

    def edit(Manufacture manufactureInstance) {
        respond manufactureInstance
    }

    @Transactional
    def update(Manufacture manufactureInstance) {
        if (manufactureInstance == null) {
            notFound()
            return
        }

        if (manufactureInstance.hasErrors()) {
            respond manufactureInstance.errors, view: 'edit'
            return
        }

        manufactureInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'manufacture.label', default: 'Manufacture'), manufactureInstance.id])
                redirect manufactureInstance
            }
            '*' { respond manufactureInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Manufacture manufactureInstance) {

        if (manufactureInstance == null) {
            notFound()
            return
        }

        manufactureInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'manufacture.label', default: 'Manufacture'), manufactureInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'manufacture.label', default: 'Manufacture'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
