package net.xunzhenji.shop

import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class ShopFansController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ShopFans.list(params), model: [shopFansInstanceCount: ShopFans.count()]
    }

    def show(ShopFans shopFansInstance) {
        respond shopFansInstance
    }

    def create() {
        respond new ShopFans(params)
    }

    @Transactional
    def save(ShopFans shopFansInstance) {
        if (shopFansInstance == null) {
            notFound()
            return
        }

        if (shopFansInstance.hasErrors()) {
            respond shopFansInstance.errors, view: 'create'
            return
        }

        shopFansInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'shopFans.label', default: 'ShopFans'), shopFansInstance.id])
                redirect shopFansInstance
            }
            '*' { respond shopFansInstance, [status: CREATED] }
        }
    }

    def edit(ShopFans shopFansInstance) {
        respond shopFansInstance
    }

    @Transactional
    def update(ShopFans shopFansInstance) {
        if (shopFansInstance == null) {
            notFound()
            return
        }

        if (shopFansInstance.hasErrors()) {
            respond shopFansInstance.errors, view: 'edit'
            return
        }

        shopFansInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'ShopFans.label', default: 'ShopFans'), shopFansInstance.id])
                redirect shopFansInstance
            }
            '*' { respond shopFansInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(ShopFans shopFansInstance) {

        if (shopFansInstance == null) {
            notFound()
            return
        }

        shopFansInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'ShopFans.label', default: 'ShopFans'), shopFansInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'shopFans.label', default: 'ShopFans'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
