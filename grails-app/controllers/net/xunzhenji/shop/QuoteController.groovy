package net.xunzhenji.shop

import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class QuoteController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Quote.list(params), model: [quoteInstanceCount: Quote.count()]
    }

    def show(Quote quoteInstance) {
        respond quoteInstance
    }

    def create() {
        respond new Quote(params)
    }

    @Transactional
    def save(Quote quoteInstance) {
        if (quoteInstance == null) {
            notFound()
            return
        }

        //populate the product unit


        if (quoteInstance.hasErrors()) {
            respond quoteInstance.errors, view: 'create'
            return
        }

        quoteInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'quote.label', default: 'Quote'), quoteInstance.id])
                redirect quoteInstance
            }
            '*' { respond quoteInstance, [status: CREATED] }
        }
    }

    def edit(Quote quoteInstance) {
        respond quoteInstance
    }

    @Transactional
    def update(Quote quoteInstance) {
        if (quoteInstance == null) {
            notFound()
            return
        }

        if (quoteInstance.hasErrors()) {
            respond quoteInstance.errors, view: 'edit'
            return
        }

        quoteInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Quote.label', default: 'Quote'), quoteInstance.id])
                redirect quoteInstance
            }
            '*' { respond quoteInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Quote quoteInstance) {

        if (quoteInstance == null) {
            notFound()
            return
        }

        quoteInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Quote.label', default: 'Quote'), quoteInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'quote.label', default: 'Quote'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
