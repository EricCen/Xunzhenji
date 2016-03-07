package net.xunzhenji.shop

import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class StockItemController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond StockItem.list(params), model: [stockItemInstanceCount: StockItem.count()]
    }

    def show(StockItem stockItemInstance) {
        respond stockItemInstance
    }

    def create() {
        respond new StockItem(params)
    }

    @Transactional
    def save(StockItem stockItemInstance) {
        if (stockItemInstance == null) {
            notFound()
            return
        }

        if (stockItemInstance.hasErrors()) {
            respond stockItemInstance.errors, view: 'create'
            return
        }

        stockItemInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'stockItem.label', default: 'StockItem'), stockItemInstance.id])
                redirect stockItemInstance
            }
            '*' { respond stockItemInstance, [status: CREATED] }
        }
    }

    def edit(StockItem stockItemInstance) {
        respond stockItemInstance
    }

    @Transactional
    def update(StockItem stockItemInstance) {
        if (stockItemInstance == null) {
            notFound()
            return
        }

        if (stockItemInstance.hasErrors()) {
            respond stockItemInstance.errors, view: 'edit'
            return
        }

        stockItemInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'StockItem.label', default: 'StockItem'), stockItemInstance.id])
                redirect stockItemInstance
            }
            '*' { respond stockItemInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(StockItem stockItemInstance) {

        if (stockItemInstance == null) {
            notFound()
            return
        }

        stockItemInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'StockItem.label', default: 'StockItem'), stockItemInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'stockItem.label', default: 'StockItem'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
