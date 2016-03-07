package net.xunzhenji.shop

import grails.transaction.Transactional
import net.xunzhenji.util.ErrorCodeUtil
import net.xunzhenji.util.FormatUtil
import net.xunzhenji.util.SessionUtil
import net.xunzhenji.util.SignUtil
import net.xunzhenji.wechat.WeChatContext

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class ShopOrderController {
    def weChatBasicService
    def erpService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ShopOrder.list(params), model: [shopOrderInstanceCount: ShopOrder.count()]
    }

    def show(ShopOrder shopOrderInstance) {
        respond shopOrderInstance
    }

    def create() {
        respond new ShopOrder(params)
    }

    @Transactional
    def save(ShopOrder shopOrderInstance) {
        if (shopOrderInstance == null) {
            notFound()
            return
        }

        if (shopOrderInstance.hasErrors()) {
            respond shopOrderInstance.errors, view: 'create'
            return
        }

        shopOrderInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'shopOrder.label', default: 'ShopOrder'), shopOrderInstance.id])
                redirect shopOrderInstance
            }
            '*' { respond shopOrderInstance, [status: CREATED] }
        }
    }

    def edit(ShopOrder shopOrderInstance) {
        respond shopOrderInstance
    }

    @Transactional
    def update(ShopOrder shopOrderInstance) {
        if (shopOrderInstance == null) {
            notFound()
            return
        }

        if (shopOrderInstance.hasErrors()) {
            respond shopOrderInstance.errors, view: 'edit'
            return
        }

        shopOrderInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'ShopOrder.label', default: 'ShopOrder'), shopOrderInstance.id])
                redirect shopOrderInstance
            }
            '*' { respond shopOrderInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(ShopOrder shopOrderInstance) {

        if (shopOrderInstance == null) {
            notFound()
            return
        }

        shopOrderInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'ShopOrder.label', default: 'ShopOrder'), shopOrderInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'shopOrder.label', default: 'ShopOrder'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    def createOrder() {
        log.info("Create shop order, shopId: ${params.shopId}")
        def shop = Shop.get(params.shopId)
        def fans = SessionUtil.userInfo?.weChatFans
        params.each {
            if (it.getKey().startsWith("quantity.")) {
                def productId = it.getKey().split("quantity.")[1] as long
                def product = ShopProduct.get(productId)
                def quote = new Quote(shopProduct: product, price: 15, quantity: it.getValue())
                quote.save()
                def order = new ShopOrder(quote: quote)
                order.save()
            }
        }

        render ErrorCodeUtil.noError()
    }

    def init() {
        log.info("Init shop orders...")
        def partners = erpService.listPartners()

        partners.each { partner ->
            def name = FormatUtil.iso2Utf8(partner.name)
            def parentName = partner.parent_name ? FormatUtil.iso2Utf8(partner.parent_name) : null
            def shop = Shop.findByNameAndParentName(name, parentName)
            if (!shop) {
                shop = new Shop(name: name, parentName: parentName)
                shop.save()
                log.info("Added shop ${shop}")
            } else {
                log.info("Shop ${shop} already exists")
            }
        }

        redirect(action: "salesOrder")
    }


    def salesOrder() {
        log.info("Create a sales order, shopId: ${params.id}")

        def weChatContext = WeChatContext.defaultContext()
        def ticket = weChatBasicService.getJsApiTicket()
        def url = "${params.requestUrl}${request.queryString ? "?" + request.queryString : ""}"
        log.info("Sign for url: ${url}")
        def signature = SignUtil.sign(ticket, url)
        signature.appId = weChatContext.appId
        def dateList = (new Date().clearTime() - 30..new Date().clearTime() + 2).collect {
            def calendar = Calendar.getInstance()
            calendar.setTime(it)
            [date     : FormatUtil.formatDate(it),
             dayOfWeek: "周${FormatUtil.formatDayInWeek(calendar.get(Calendar.DAY_OF_WEEK))}",
             default  : it == new Date().clearTime() + 1]
        }

        [signature: signature, dateList: dateList]
    }
}
