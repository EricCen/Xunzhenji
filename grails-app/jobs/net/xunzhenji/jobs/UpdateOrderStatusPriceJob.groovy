/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.jobs

import grails.transaction.Transactional
import net.xunzhenji.Server
import net.xunzhenji.mall.Batch
import net.xunzhenji.mall.Delivery
import net.xunzhenji.mall.ProductOrder
import net.xunzhenji.model.DeliveryStatus

class UpdateOrderStatusPriceJob {

    static triggers = {
        cron name: 'updateOrderStatus', cronExpression: "0 0 1 * * ?", timeZone:TimeZone.getTimeZone("Asia/Hong_Kong")
    }
    def name = "更新订单状态任务"
    def group = "MyGroup"

    @Transactional
    def execute() {
        log.info("Update order status...")
        if(Server.thisServer.refreshBatchPrice){
            def deliveries = Delivery.findAllByTargetDeliveryDate(new Date().clearTime() + 2)
            deliveries.each{ delivery->
                delivery.updateProcessing()
            }
        }else {
            log.warn("This server will not refresh batch price")
        }
    }
}
