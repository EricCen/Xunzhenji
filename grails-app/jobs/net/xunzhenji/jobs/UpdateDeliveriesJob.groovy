/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.jobs

import net.xunzhenji.Server
import net.xunzhenji.mall.Batch
import net.xunzhenji.mall.Delivery
import net.xunzhenji.mall.LxGroup
import net.xunzhenji.mall.ProductOrder
import net.xunzhenji.model.PaymentStatus

class UpdateDeliveriesJob {
    def weChatBasicService

    static triggers = {
        cron name: 'createDeliveriesJob', cronExpression: "0 0 2 * * ?", timeZone:TimeZone.getTimeZone("Asia/Hong_Kong")
    }
    def name = "创建发货批次任务"
    def group = "MyGroup"

    def execute() {
        if(Server.thisServer.createDelivery){
            log.info("Start to create Delivery")
            LxGroup.list().each{
                it.createOneMonthDelivery()
            }

            log.info("Start to remove useless delivery")
            Delivery.findAllByTargetDeliveryDateNotGreaterThan(new Date().clearTime()).each{
                if(it.orders()?.size() == 0){
                    log.info("Delivery ${it.id} should be remove")
                    it.delete()
                }
            }
        }else{
            log.warn("This server will not create Delivery")
        }
    }
}
