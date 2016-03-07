package net.xunzhenji.wechat

import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class WeChatCouponController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def weChatPayService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond WeChatCoupon.list(params), model: [weChatCouponInstanceCount: WeChatCoupon.count()]
    }

    def show(WeChatCoupon weChatCouponInstance) {
        respond weChatCouponInstance
    }

    def create() {
        respond new WeChatCoupon(params)
    }

    @Transactional
    def save(WeChatCoupon weChatCouponInstance) {
        if (weChatCouponInstance == null) {
            notFound()
            return
        }

        def stockId = params.stockId

        if (WeChatCoupon.findByStockId(stockId)) {
            flash.message = "微信代金券存在，无需创建"
            redirect(action: "index")
            return
        }
        def coupon = weChatPayService.queryCouponStock(stockId)
        weChatCouponInstance.properties = coupon

        weChatCouponInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'weChatCoupon.label', default: 'WeChatCoupon'), weChatCouponInstance.id])
                redirect weChatCouponInstance
            }
            '*' { respond weChatCouponInstance, [status: CREATED] }
        }
    }

    def edit(WeChatCoupon weChatCouponInstance) {
        respond weChatCouponInstance
    }

    @Transactional
    def update(WeChatCoupon weChatCouponInstance) {
        if (weChatCouponInstance == null) {
            notFound()
            return
        }

        if (weChatCouponInstance.hasErrors()) {
            respond weChatCouponInstance.errors, view: 'edit'
            return
        }

        weChatCouponInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'weChatCoupon.label', default: 'WeChatCoupon'), weChatCouponInstance.id])
                redirect weChatCouponInstance
            }
            '*' { respond weChatCouponInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(WeChatCoupon weChatCouponInstance) {

        if (weChatCouponInstance == null) {
            notFound()
            return
        }

        weChatCouponInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'WeChatCoupon.label', default: 'WeChatCoupon'), weChatCouponInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'weChatCoupon.label', default: 'WeChatCoupon'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    def sendToAllUser() {
        log.info("Send coupon to all user, stockId: ${params.stockId}")
        def fans = WeChatFans.findAllBySubscribe(1)
        fans.each {
            weChatPayService.sendCoupon(it.openId, params.stockId)
        }
        redirect(action: "index")
    }
}
