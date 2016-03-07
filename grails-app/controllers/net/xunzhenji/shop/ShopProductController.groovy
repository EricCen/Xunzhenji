package net.xunzhenji.shop

import grails.transaction.Transactional
import net.xunzhenji.util.ErrorCodeUtil

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class ShopProductController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ShopProduct.list(params), model: [shopProductInstanceCount: ShopProduct.count()]
    }

    def show(ShopProduct shopProductInstance) {
        respond shopProductInstance
    }

    def create() {
        respond new ShopProduct(params)
    }

    @Transactional
    def save(ShopProduct shopProductInstance) {
        if (shopProductInstance == null) {
            notFound()
            return
        }

        if (shopProductInstance.hasErrors()) {
            respond shopProductInstance.errors, view: 'create'
            return
        }

        shopProductInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'shopProduct.label', default: 'ShopProduct'), shopProductInstance.id])
                redirect shopProductInstance
            }
            '*' { respond shopProductInstance, [status: CREATED] }
        }
    }

    def edit(ShopProduct shopProductInstance) {
        respond shopProductInstance
    }

    @Transactional
    def update(ShopProduct shopProductInstance) {
        if (shopProductInstance == null) {
            notFound()
            return
        }

        if (shopProductInstance.hasErrors()) {
            respond shopProductInstance.errors, view: 'edit'
            return
        }

        shopProductInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'shopProduct.label', default: 'ShopProduct'), shopProductInstance.id])
                redirect shopProductInstance
            }
            '*' { respond shopProductInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(ShopProduct shopProductInstance) {

        if (shopProductInstance == null) {
            notFound()
            return
        }

        shopProductInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'shopProduct.label', default: 'ShopProduct'), shopProductInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'shopProduct.label', default: 'ShopProduct'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    def getProductList() {
        log.info("Get product list")

        render ErrorCodeUtil.noError([products: ShopProduct.list().collect {
            [
                    id  : it.id,
                    name: it.name
            ]
        }])
    }
}
