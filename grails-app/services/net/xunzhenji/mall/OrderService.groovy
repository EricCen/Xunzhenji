/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

import net.xunzhenji.util.IdGenerator
import net.xunzhenji.wechat.WeChatFans

/**
 * Created by Irene on 2015/9/27.
 */
class OrderService {
    def weChatPayService

    def refund(ProductOrder order, Payment payment){
        log.info("Refund order, order Id: ${order.id}")
        def openId = order.userInfo?.weChatFans?.openId
        def subscribe = order.userInfo?.weChatFans?.subscribe

        def outRefundNo = IdGenerator.generateWxTradeId()

        Payment refundPayment = Payment.createRefundPayment(outRefundNo, payment.amount as int, openId, subscribe ? 'Y' : 'N')
        refundPayment.save(flush: true)

        def refundResult = weChatPayService.refundOrder(payment.transactionId, payment.outTradeNo, outRefundNo,
                payment.amount as int, order.refundPrice() as int)
        log.info("Refund result, ${refundResult}")
        if ("SUCCESS".equals(refundResult.resultCode)) {
            order.cancelOrder()
            order.save()
            refundPayment.status = Payment.STATUS_NOTIFIED

            refundPayment.properties = refundResult
            refundPayment.save()
            return [orderId      : order.id,
                                          displayStatus: order.displayStatus]
        } else {
            return [:]
        }
    }

    def refundDeposit(ProductOrder order){
        refund(order, order.depositPayment)
    }

    def refundFullPrice(ProductOrder order){
        refund(order, order.fullPricePayment)
    }

    def recentOrders(openId, maxCount){
        WeChatFans fans = WeChatFans.findByOpenId(openId)
        UserInfo userInfo = fans?.userInfo
        if(!userInfo){
            return []
        }
        def orders = userInfo.orders
        def orderSize = orders.size()
        return orders.sort{a,b->b.lastUpdated<=>a.lastUpdated}.subList(0, orderSize >= maxCount ? maxCount : orderSize)
    }
}
