/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.jobs

import net.xunzhenji.Server
import net.xunzhenji.mall.Batch
import net.xunzhenji.mall.ProductOrder
import net.xunzhenji.model.PaymentStatus

class RemindPaymentJob {
    def templateMessageService

    static triggers = {
        cron name: 'remindPayment', cronExpression: "0 0 8 * * ?", timeZone:TimeZone.getTimeZone("Asia/Hong_Kong")
    }
    def name = "提醒支付任务"
    def group = "MyGroup"

    def execute() {
        if(Server.thisServer.remindPayment){
            log.info("Start to remind payment")
            def batches = Batch.findAllByBatchState(Batch.BatchState.CURRENT_STATE_IN_PAYMENT_WINDOW.state)

            batches*.orders*.each{ProductOrder order->
                order.remindForPayment()
            }
            log.info("Remind payment completed")
        }else{
            log.warn("This server will not remind for payment")
        }
    }
}
