/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

import grails.transaction.Transactional
import net.xunzhenji.util.OrderUtil


class ShoppingCart {
    def tempOrders = []
    static belongsTo = [userInfo:UserInfo]

    static transients = ["tempOrders"]

    def getProductOrders() {
        def orders = ShoppingCartProductOrder.findAllByShoppingCart(this)*.productOrder
        if (!orders) {
            orders = tempOrders
        }
        return orders
    }

    def totalMarketPrice(){
        getProductOrders()?.sum { it.product.price * it.quantity }
    }

    def totalPrice(){
        getProductOrders()?.sum { it.product.price * it.quantity }
    }

    def totalDeposit(){
        getProductOrders()?.sum { it.product.deposit * it.quantity }
    }

    def updateOrderedDate(){
        getProductOrders()?.each { order ->
            order.orderDate = new Date()
        }
    }

    @Transactional
    def combine(ShoppingCart shoppingCart){
        if (!shoppingCart) return

        if(this == shoppingCart){
            log.warn("It's the same shopping cart, not need to merge")
            return
        }
        def thisOrders = getProductOrders()
        def thatOrders = shoppingCart.productOrders
        if (!thisOrders || thisOrders.size() == 0) {
            if (thatOrders) {
                thatOrders.each {
                    new ShoppingCartProductOrder(shoppingCart: shoppingCart, productOrder: it).save()
                }
            }
        }else{
            thatOrders?.each { order ->
                def duplicatedOrder = thisOrders.find { it.batchId == order.batchId }
                if(duplicatedOrder){
                    println "Add duplicate order ${order.quantity}"
                    duplicatedOrder.quantity += order.quantity
                }else{
                    new ShoppingCartProductOrder(shoppingCart: shoppingCart, productOrder: order).save()
                }
            }
        }
    }

    def totalCount(){
        getProductOrders().sum { it.quantity }
    }

    def price(){
        getProductOrders().sum { it.currentPrice() }
    }

    def futurePrice(){
        getProductOrders().sum { it.futurePrice() }
    }

    def batchCount(batchId){
        getProductOrders().sum { it.quantity }
    }

    def toDetails(){
        OrderUtil.covertPayDetail(getProductOrders())
    }

    def toPayBody(){
        OrderUtil.convertPayBody(getProductOrders())
    }

    def addToProductOrders(order) {
        new ShoppingCartProductOrder(shoppingCart: this, productOrder: order).save()
    }

    def removeFromProductOrders(ProductOrder order) {
        ShoppingCartProductOrder.findByShoppingCartAndProductOrder(this, order)?.delete()
    }
}
