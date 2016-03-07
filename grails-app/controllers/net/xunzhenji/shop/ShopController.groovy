package net.xunzhenji.shop

import grails.transaction.Transactional
import net.xunzhenji.util.ErrorCodeUtil
import net.xunzhenji.util.SessionUtil

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class ShopController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Shop.list(params), model: [shopInstanceCount: Shop.count()]
    }

    def show(Shop shopInstance) {
        respond shopInstance
    }

    def create() {
        respond new Shop(params)
    }

    @Transactional
    def save(Shop shopInstance) {
        if (shopInstance == null) {
            notFound()
            return
        }

        if (shopInstance.hasErrors()) {
            respond shopInstance.errors, view: 'create'
            return
        }

        shopInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'shop.label', default: 'Shop'), shopInstance.id])
                redirect shopInstance
            }
            '*' { respond shopInstance, [status: CREATED] }
        }
    }

    def edit(Shop shopInstance) {
        respond shopInstance
    }

    @Transactional
    def update(Shop shopInstance) {
        if (shopInstance == null) {
            notFound()
            return
        }

        if (shopInstance.hasErrors()) {
            respond shopInstance.errors, view: 'edit'
            return
        }

        shopInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'shop.label', default: 'Shop'), shopInstance.id])
                redirect shopInstance
            }
            '*' { respond shopInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Shop shopInstance) {

        if (shopInstance == null) {
            notFound()
            return
        }

        shopInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'shop.label', default: 'Shop'), shopInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'shop.label', default: 'Shop'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    def queryShops() {
        def userInfo = SessionUtil.userInfo
        def fans = userInfo?.weChatFans

        log.info("Query shops, fans: ${fans}")

        if (!fans) {
            render ErrorCodeUtil.noError()
            return
        }

        def shops = ShopFans.findAllByFans(fans)*.shop
        render ErrorCodeUtil.noError([shops: shops.collect {
            [
                    id        : it.id,
                    name      : it.name,
                    parentName: it.parentName,
                    products  : it.products.collect {
                        [
                                productId  : it.id,
                                productName: it.name,
                                productUnit: it.productUnit.name
                        ]
                    }
            ]
        }])
    }

    def queryShopProducts() {
        def userInfo = SessionUtil.userInfo
        def fans = userInfo?.weChatFans

        log.info("Query shop product, fans: ${fans}, shopId: ${params.shopId}")

        if (!fans) {
            render ErrorCodeUtil.noError()
            return
        }

        def shop = Shop.get(params.shopId)
        render ErrorCodeUtil.noError([
                products: shop.products.collect {
                    [
                            productId  : it.id,
                            productName: it.name,
                            productUnit: it.productUnit.name
                    ]
                }
        ])
    }
}
