/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.jobs

import net.xunzhenji.Server
import net.xunzhenji.mall.Batch
import net.xunzhenji.mall.Delivery
import net.xunzhenji.mall.ProductOrder

class RemindDeliveryJob {
    def templateMessageService

    static triggers = {
        cron name: 'remindDelivery', cronExpression: "0 0 12 * * ?", timeZone:TimeZone.getTimeZone("Asia/Hong_Kong")
    }
    def name = "提醒发货"
    def group = "MyGroup"

    def execute() {
        if(Server.thisServer.remindPayment){
            log.info("Start to remind delivery")
            def deliveries = Delivery.findAllByTargetDeliveryDate(new Date().clearTime() + 1)
            log.info("Total ${deliveries.size()} to remind...")
            deliveries.each{ delivery->
                delivery.orders().each {order->
                    order.remindDelivery()
                }
            }
            log.info("Remind delivery completed")
        }else{
            log.warn("This server will not remind for payment")
        }
    }
}
