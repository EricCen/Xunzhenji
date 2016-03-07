/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

import grails.transaction.Transactional
import net.xunzhenji.model.Constant
import net.xunzhenji.model.DeliveryStatus
import net.xunzhenji.model.DisplayStatus
import net.xunzhenji.model.PaymentStatus
import net.xunzhenji.util.ErrorCodeUtil
import net.xunzhenji.util.FormatUtil
import org.apache.commons.lang.StringUtils

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class ProductOrderController {
    def orderService
    def paymentService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE", splitOrder: "POST"]

    def index() {
    }

    def searchOrders() {
        log.info("Search orders request, ${params}")

        params.max = Math.min(params.max ? params.int('max') : 20, 100)
        params.offset = params.int('page') ? (params.int('page') - 1 < 0 ? 0 : (params.int('page') - 1) * params.max) : 0

        if (!params.sort) {
            params.sort = 'id'
            params.order = 'desc'
        }

        def countCriteria = ProductOrder.createCriteria()
        def recordCount = countCriteria.count(getSearchCriteria())
        def pageCount = recordCount < params.max ? 1 : (recordCount % params.max == 0 ? recordCount.intdiv(params.max) : recordCount.intdiv(params.max) + 1)
        log.info("record count: ${recordCount}, params max: ${params.max}, page count: ${pageCount}")
        def criteria = ProductOrder.createCriteria()
        def Collection<ProductOrder> productOrderInstanceList = criteria.list(params, getSearchCriteria())

        render ErrorCodeUtil.noError(
                ["productOrderInstanceList": productOrderInstanceList.collect {
                    def userInfo = it.userInfo
                    if (!userInfo) {
                        userInfo = ShoppingCartProductOrder.findByProductOrder(it)?.shoppingCart?.userInfo
                    }
                    [
                            id            : it.id,
                            productTitle  : it.product.title,
                            batchTitle    : it.batch.title,
                            quantity      : it.quantity,
                            orderDate     : it.orderDate.format('yy-MM-dd HH:mm'),
                            orderPrice    : it.orderPrice,
                            address       : it.address?.toString(),
                            phone    : userInfo?.mobile ? userInfo?.mobile : it.address?.phone ?: "",
                            name     : "${userInfo?.name ?: ""} ${it.address?.name ?: ""} ${userInfo?.weChatFans?.nickName ?: ""}",
                            subscribe: userInfo?.weChatFans?.subscribe ? "是" : "否",
                            displayStatus : DisplayStatus.findByName(it.displayStatus).description,
                            paymentStatus : PaymentStatus.valueOf(it.paymentStatus).name,
                            deliveryStatus: DeliveryStatus.valueOf(it.deliveryStatus).name,
                            h5DetailLink : it.productOrderDetailLink()
                    ]
                },
                 "pageCount"               : pageCount]
        )
    }

    def getSearchCriteria() {
        return {
            if (params.product != null && StringUtils.isNotBlank(params.product)) {
                inList("product", Product.findAllByTitleIlike("%" + params.product + "%"))
            }
            if (params.batch != null && StringUtils.isNotBlank(params.batch)) {
                inList("batch", Batch.findAllByTitleIlike("%" + params.batch + "%"))
            }
            if (params.paymentStatus != null && params.paymentStatus != "-1") {
                eq("paymentStatus", params.paymentStatus.toInteger())
            }
            if (params.deliveryStatus != null && params.deliveryStatus != "-1") {
                eq("deliveryStatus", params.deliveryStatus.toInteger())
            }
        }
    }

    def show(ProductOrder productOrderInstance) {
        def userInfo = productOrderInstance.userInfo
        if (!userInfo) {
            userInfo = ShoppingCartProductOrder.findByProductOrder(productOrderInstance)?.shoppingCart?.userInfo
        }
        [productOrderInstance: productOrderInstance, userInfo: userInfo]
    }

    def create() {
        respond new ProductOrder(params)
    }

    @Transactional
    def save(ProductOrder productOrderInstance) {
        if (productOrderInstance == null) {
            notFound()
            return
        }

        if (productOrderInstance.hasErrors()) {
            respond productOrderInstance.errors, view: 'create'
            return
        }

        productOrderInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'productOrder.label', default: 'ProductOrder'), productOrderInstance.id])
                redirect productOrderInstance
            }
            '*' { respond productOrderInstance, [status: CREATED] }
        }
    }

    def edit(ProductOrder productOrderInstance) {
        def deliveryDate = DeliveryProductOrders.findByProductOrder(productOrderInstance)?.delivery?.targetDeliveryDate
        def category = productOrderInstance.product?.category
        def deliveryDates = productOrderInstance.deliverDateList(productOrderInstance.product.category.toDeliverDaysInWeekArr(), new Date().clearTime() - 3, category.specialDays)
        def userInfo = productOrderInstance.userInfo
        if (!userInfo) {
            userInfo = ShoppingCartProductOrder.findByProductOrder(productOrderInstance)?.shoppingCart?.userInfo
        }
        return [productOrderInstance: productOrderInstance, deliveryDates: deliveryDates, deliveryDate: deliveryDate, userInfo: userInfo]
    }

    @Transactional
    def update(ProductOrder productOrderInstance) {
        if (productOrderInstance == null) {
            notFound()
            return
        }
        if(params.deliverDate){
            Date deliveryDate = FormatUtil.parseDate(params.deliverDate)
            productOrderInstance.updateDeliveryDate(deliveryDate, Constant.SYSTEM)
        }

        productOrderInstance.updateDisplayStatus()

        if (productOrderInstance.hasErrors()) {
            respond productOrderInstance.errors, view: 'edit'
            return
        }

        productOrderInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'productOrder.label', default: 'ProductOrder'), productOrderInstance.id])
                redirect productOrderInstance
            }
            '*' { respond productOrderInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(ProductOrder productOrderInstance) {

        if (productOrderInstance == null) {
            notFound()
            return
        }

        ProductOrderPayments.findAllByProductOrder(productOrderInstance)*.delete(flush: true)
        DeliveryProductOrders.findAllByProductOrder(productOrderInstance)*.delete(flush: true)
        ShoppingCartProductOrder.findAllByProductOrder(productOrderInstance)*.delete(flush: true)
        productOrderInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'productOrder.label', default: 'ProductOrder'), productOrderInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'productOrder.label', default: 'ProductOrder'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    //把可付款订单加入到购物车
    @Transactional
    def addToShoppingCart() {
        log.info("Add product order to shopping cart, orderId: ${params.orderId}")

        def orderId = params.orderId
        def order = ProductOrder.get(orderId)
        def shoppingCart = order.userInfo.shoppingCart
        shoppingCart.addToProductOrders(order).save()
        render ErrorCodeUtil.noError()
    }

    //把可付款订单加入到购物车
    @Transactional
    def removeFromShoppingCart() {
        log.info("Remove product order from shopping cart, orderId: ${params.orderId}, shoppingCartId: ${params.shoppingCartId}")

        def orderId = params.orderId
        def order = ProductOrder.get(orderId)
        def shoppingCart = ShoppingCart.get(params.shoppingCartId)
        ShoppingCartProductOrder.findByProductOrder(order)*.delete()
        render ErrorCodeUtil.noError()
    }

    @Transactional
    def refundDeposit(){
        log.info("Cancel order by admin, order id: ${params.id}")

        def order = ProductOrder.get(params.id)
        def result = orderService.refundDeposit(order)

        if(!result.orderId){
            log.error("Refund failure")
        }
        redirect(action: "show", id: params.id)
    }

    @Transactional
    def refundFullPrice(){
        log.info("Cancel order by admin, order id: ${params.id}")

        def order = ProductOrder.get(params.id)
        def result = orderService.refundFullPrice(order)

        if(!result.orderId){
            log.error("Refund failure")
        }
        redirect(action: "show", id: params.id)
    }

    def remindForPayment(){
        log.info("Remind for payment, orderId: ${params.id}")
        ProductOrder order = ProductOrder.get(params.id)
        order.remindForPayment()
        redirect(action: "index")
    }

    def remindDelivery(){
        log.info("Remind for delivery, orderId: ${params.id}")
        ProductOrder order = ProductOrder.get(params.id)
        order.remindDelivery()
        redirect(action: "index")
    }

    def confirmDeliveryTime() {
        log.info("Confirm delivery time, orderId: ${params.id}")
        ProductOrder order = ProductOrder.get(params.id)
        order.confirmDeliveryTime()
        redirect(action: "index")
    }

    def split(ProductOrder productOrderInstance){
        respond productOrderInstance
    }

    @Transactional
    def splitOrder(){
        log.info("Receive split order request, orderId: ${params.id}, remind quantity: ${params.remainQuantity}")
        ProductOrder order = ProductOrder.get(params.id as long)
        def newOrder = order.split(params.remainQuantity as int)
        newOrder.save(flush: true)
        order.save()
        ProductOrderPayments.findAllByProductOrder(order)*.payment?.each{
            new ProductOrderPayments(payment: it, productOrder: newOrder).save()
        }

        redirect(action: "index")
    }

    @Transactional
    def paymentSuccess(){
        ProductOrder order = ProductOrder.get(params.id as long)
        Payment payment = order.lastPayment
        paymentService.paymentSuccess(payment.prepayId, payment.outTradeNo)
        log.info("Complete process payment success")
    }
}
