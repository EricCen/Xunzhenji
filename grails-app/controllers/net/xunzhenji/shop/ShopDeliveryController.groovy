package net.xunzhenji.shop

import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class ShopDeliveryController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ShopDelivery.list(params), model: [shopDeliveryInstanceCount: ShopDelivery.count()]
    }

    def show(ShopDelivery shopDeliveryInstance) {
        respond shopDeliveryInstance
    }

    def create() {
        respond new ShopDelivery(params)
    }

    @Transactional
    def save(ShopDelivery shopDeliveryInstance) {
        if (shopDeliveryInstance == null) {
            notFound()
            return
        }

        if (shopDeliveryInstance.hasErrors()) {
            respond shopDeliveryInstance.errors, view: 'create'
            return
        }

        shopDeliveryInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'shopDelivery.label', default: 'ShopDelivery'), shopDeliveryInstance.id])
                redirect shopDeliveryInstance
            }
            '*' { respond shopDeliveryInstance, [status: CREATED] }
        }
    }

    def edit(ShopDelivery shopDeliveryInstance) {
        respond shopDeliveryInstance
    }

    @Transactional
    def update(ShopDelivery shopDeliveryInstance) {
        if (shopDeliveryInstance == null) {
            notFound()
            return
        }

        if (shopDeliveryInstance.hasErrors()) {
            respond shopDeliveryInstance.errors, view: 'edit'
            return
        }

        shopDeliveryInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'shopDelivery.label', default: 'ShopDelivery'), shopDeliveryInstance.id])
                redirect shopDeliveryInstance
            }
            '*' { respond shopDeliveryInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(ShopDelivery shopDeliveryInstance) {

        if (shopDeliveryInstance == null) {
            notFound()
            return
        }

        shopDeliveryInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'shopDelivery.label', default: 'ShopDelivery'), shopDeliveryInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'shopDelivery.label', default: 'ShopDelivery'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
