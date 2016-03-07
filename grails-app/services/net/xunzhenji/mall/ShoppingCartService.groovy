/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

import grails.transaction.Transactional
import net.xunzhenji.model.PaymentStatus
import net.xunzhenji.util.ErrorCodeUtil
import net.xunzhenji.util.SessionUtil

class ShoppingCartService {

    @Transactional
    def updateShoppingCart(batchId, quantity) {
        log.info("Update shopping cart, batchId: ${batchId}, quanity: ${quantity}")
        ShoppingCart shoppingCart
        UserInfo userInfo = SessionUtil.userInfo?.refresh()
        if(userInfo){
            shoppingCart = userInfo.shoppingCart
        }else{
            shoppingCart = SessionUtil.getSessionValue(SessionUtil.SESSION_SHOPPING_CART)
            if(!shoppingCart){
                shoppingCart = new ShoppingCart()
                //valid in session only, when user login, two shopping cart will be merge
                SessionUtil.setSessionValue(SessionUtil.SESSION_SHOPPING_CART, shoppingCart)
            }
        }

        def batch = Batch.findById(batchId)

        doUpdateShoppingCart(shoppingCart, batch, quantity, userInfo)
    }

    def doUpdateShoppingCart(ShoppingCart shoppingCart, Batch batch, int quantity, UserInfo userInfo) {
        def product = batch.product
        //only unpaid order need to update quantity, paid order cannot be changed
        def orderInCart = shoppingCart?.productOrders?.find {
            it.batch.id == batch.id && it.paymentStatus == PaymentStatus.UNPAID.id
        }
        if (orderInCart) {
            if (quantity > 0) {
                orderInCart.quantity = quantity
            } else { // delete zero quantity order
                if (orderInCart.id) {
                    def prodOrderPayments = ProductOrderPayments.findAllByProductOrder(orderInCart)
                    def deliveryProdutOrders = DeliveryProductOrders.findAllByProductOrder(orderInCart)
                    def deliveries = deliveryProdutOrders*.delivery
                    ProductOrderPayments.withTransaction {
                        ShoppingCartProductOrder.findByProductOrder(orderInCart)*.delete()
                        ProductOrderPayments.deleteAll(prodOrderPayments)
                        DeliveryProductOrders.deleteAll(deliveryProdutOrders)
                        Delivery.deleteAll(deliveries)
                        orderInCart.delete()
                    }
                } else {
                    shoppingCart.productOrders.remove(orderInCart)
                }
            }
        } else if (quantity > 0) {
            def tempOrder = createOrder(batch, quantity)
            if (shoppingCart.id) {
                tempOrder.save()
                shoppingCart.addToProductOrders(tempOrder)
            } else {
                shoppingCart.tempOrders << tempOrder
            }
        }
        if (shoppingCart && userInfo) {
            synchronized (this) {
                shoppingCart.save(flush: true)
                ProductOrder.saveAll(shoppingCart.productOrders)
            }
        }

        ErrorCodeUtil.noError([shoppingCartCount: shoppingCart.totalCount(),
                               shoppingCartPrice: shoppingCart.price(),
                               orderIds         : userInfo ? shoppingCart.productOrders.collect { it.id } : null])
    }

    def createOrder(Batch batch, int quantity) {
        Product product = batch.product
        def deposit = batch.isPresales() ? product.deposit : 0
        def marketPrice = batch.calcDiscount ? product.price : batch.price
        // if batch not calculate discount, batch price is final price
        def tempOrder = ProductOrder.createOrder(batch, quantity, batch.price,
                marketPrice, deposit, batch.discount)
        tempOrder.productionDate = batch.productionDate
        tempOrder.paymentDate = batch.paymentDate
        return tempOrder
    }

    def queryShoppingCart() {
        ShoppingCart shoppingCart = SessionUtil.getSessionValue(SessionUtil.SESSION_SHOPPING_CART)
        UserInfo userInfo = SessionUtil.userInfo
        def shoppingCartId = shoppingCart?.id
        def userInfoId = userInfo?.id

        //refresh shopping cart
        if(shoppingCartId){
            shoppingCart = ShoppingCart.get(shoppingCart.id)
        } else if(userInfoId){
            shoppingCart = ShoppingCart.executeQuery("from ShoppingCart where userInfo.id = ?", userInfoId)
        }

        def ret
        def orders = shoppingCart?.productOrders
        if (shoppingCart && orders?.size()) {
            ret = ErrorCodeUtil.noError([orders: orders.collect {
                def batch = it.batch
                def product = it.product
                def currentPrice = it.currentPrice()
                def quantity = it.quantity
                def paymentDate = batch.paymentSimpleDate()
                def productionDate = batch.productionSimpleDate()
                def showSpinner = it.paymentStatus == PaymentStatus.UNPAID.id
                def unitPrice = it.currentUnitPrice()
                def priceType = it.priceType()
                [orderId       : it.id,
                 batchId       : batch.id,
                 productId     : product.id,
                 productTitle  : product.title,
                 batchTitle    : batch.title,
                 price         : currentPrice,
                 unitPrice     : unitPrice,
                 discount      : it.discount,
                 priceType     : priceType,
                 quantity      : quantity,
                 showSpinner   : showSpinner,
                 productionDate: productionDate,
                 paymentDate   : paymentDate,
                 imageUrl      : product?.banner?.thumbUrl,
                 status        : it.displayStatus,
                 lastUpdated   : it.lastUpdated?.format("yy/MM/dd HH:mm")
                ]
            }, shoppingCartCount               : shoppingCart.totalCount(), shoppingCartPrice: shoppingCart.price()])
        } else {
            log.warn("Shopping cart: ${shoppingCart}, size: ${shoppingCart?.productOrders?.size()}")
            ret = ErrorCodeUtil.shoppingCartEmpty()
        }

        return ret
    }
}


