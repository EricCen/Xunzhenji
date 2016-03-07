package net.xunzhenji.jobs

import grails.transaction.Transactional
import net.xunzhenji.Server
import net.xunzhenji.mall.Batch
import net.xunzhenji.mall.ProductOrder
import net.xunzhenji.model.PaymentStatus

/**
 *
 * Created by: Kevin
 * Created time : 2015/6/20 23:39
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */
class RefreshBatchPriceJob {

    static triggers = {
        cron name: 'refreshBatchPrice', cronExpression: "0 0 7 * * ?", timeZone:TimeZone.getTimeZone("Asia/Hong_Kong")
    }
    def name = "更新批次价格任务"
    def group = "MyGroup"

    @Transactional
    def execute() {
        log.info("Update discount prices...")
        if(Server.thisServer.refreshBatchPrice){
            Batch.list().each{batch->
                batch.updateDiscountPrice()
                batch.updateBatchState()
//                batch.updatePayableOrders()  //把待付订单放到购物车
                batch.updateUnpaidOrdersPrice()
            }
        }else {
            log.warn("This server will not refresh batch price")
        }
    }
}
