/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.util

/**
 * Created by Irene on 2015/8/20.
 */
class OrderUtil {
    def static convertPayBody(orders){
        def payBody = null
        if (orders.size() == 1) {
            payBody = orders[0].toPayBody()
        } else if (orders.size() > 1) {
            payBody = "${orders[0].toPayBody()}等${orders.sum{it.quantity}}件商品"
        }
        payBody
    }

    def static covertPayDetail(orders){
        def sb = new StringBuilder()
        orders.each{ order->
            sb.append("${order.product.title} ${order.batch.title} ${order.quantity}件\n")
        }
        sb.toString()
    }

    def static totalPrice(orders) {
        orders.sum { it.orderPrice }
    }
}
