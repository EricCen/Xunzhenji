package net.xunzhenji.shop

import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class StockMoveController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond StockMove.list(params), model: [stockMoveInstanceCount: StockMove.count()]
    }

    def show(StockMove stockMoveInstance) {
        respond stockMoveInstance
    }

    def create() {
        respond new StockMove(params)
    }

    @Transactional
    def save(StockMove stockMoveInstance) {
        if (stockMoveInstance == null) {
            notFound()
            return
        }

        if (stockMoveInstance.hasErrors()) {
            respond stockMoveInstance.errors, view: 'create'
            return
        }

        stockMoveInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'stockMove.label', default: 'StockMove'), stockMoveInstance.id])
                redirect stockMoveInstance
            }
            '*' { respond stockMoveInstance, [status: CREATED] }
        }
    }

    def edit(StockMove stockMoveInstance) {
        respond stockMoveInstance
    }

    @Transactional
    def update(StockMove stockMoveInstance) {
        if (stockMoveInstance == null) {
            notFound()
            return
        }

        if (stockMoveInstance.hasErrors()) {
            respond stockMoveInstance.errors, view: 'edit'
            return
        }

        stockMoveInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'stockMove.label', default: 'StockMove'), stockMoveInstance.id])
                redirect stockMoveInstance
            }
            '*' { respond stockMoveInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(StockMove stockMoveInstance) {

        if (stockMoveInstance == null) {
            notFound()
            return
        }

        stockMoveInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'stockMove.label', default: 'StockMove'), stockMoveInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'stockMove.label', default: 'StockMove'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
