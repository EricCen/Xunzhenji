/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

import grails.transaction.Transactional
import net.xunzhenji.util.OrderUtil
import net.xunzhenji.wechat.WeChatFans
import net.xunzhenji.wechat.WeChatFansActivity
import org.apache.commons.lang.time.DateUtils

class MalltestController {
    def weChatPayService
    def paymentService

    def index() {
        if (request.method == 'GET') {
            log.info("Receive wechat get request: ${params}")
        } else if (request.method == 'POST'){
            handlePost(params)
        }
    }

    @Transactional
    def handlePost(params){
        log.info("Receive wechat payment notification.")
        def xml = request.reader.text
        log.info("XML: ${xml}")
        def msg = new XmlParser().parseText(xml)
        def notification = [:]
        notification.appId =  msg.appid.text()
        notification.bankType =  msg.bank_type.text()
        notification.cashFee =  (msg.cash_fee.text() as BigDecimal) / 100
        notification.feeType =  msg.fee_type.text()
        notification.isSubscribe =  msg.is_subscribe.text() == "Y" ? 1 : 0
        notification.nonceStr =  msg.nonce_str.text()
        notification.openId =  msg.openid.text()
        notification.outTradeNo =  msg.out_trade_no.text()
        notification.resultCode =  msg.result_code.text()
        notification.returnCode =  msg.return_code.text()
        notification.sign =  msg.sign.text()
        notification.timeEnd =  DateUtils.parseDate(msg.time_end.text(), 'yyyyMMddHHmmss')
        notification.totalFee =  msg.total_fee.text()
        notification.tradeType =  msg.trade_type.text()
        notification.transactionId =  msg.transaction_id.text()

        def payment = Payment.findByOutTradeNo(notification.outTradeNo)
        if(Payment.STATUS_UNPAID == payment.status){
            paymentService.paymentSuccess(payment.prepayId, notification.outTradeNo)
        }

        def result = weChatPayService.receiveNotification(notification)

        if (notification.openId) {
            def fans = WeChatFans.findByOpenId(notification.openId)
            fans.lastActivityTime = new Date()
            fans.save()
            fans.addToWeChatFansActivity(new WeChatFansActivity(
                    actionType: WeChatFansActivity.ActionType.PAYMENT, actionContent: OrderUtil.convertPayBody(payment.productOrders())))
        }
        if(result){
            log.info("Response notification result, ${result}")
            response.outputStream << result
        }
    }

    def alipay(params){
        log.info("Receive wechat payment notification.")
        log.info("XML: ${xml}")
        def msg = new XmlParser().parseText(xml)
        def notification = [:]
        notification.appId =  params.seller_id
        notification.cashFee =  params.total_fee as BigDecimal
        notification.outTradeNo =  params.out_trade_no
        notification.resultCode =  params.trade_status == "TRADE_SUCCESS" ? "SUCCESS" : "FAIL"
        notification.sign =  params.sign
        notification.timeEnd =  DateUtils.parseDate(params.notify_time, 'yyyy-MM-dd HH:mm:ss')
        notification.totalFee =  params.total_fee as BigDecimal
        notification.tradeType =  params.service
        notification.transactionId = params.trade_no

        def payment = Payment.findByOutTradeNo(notification.outTradeNo)
        if(Payment.STATUS_UNPAID == payment.status){
            paymentService.paymentSuccess(payment.prepayId, notification.outTradeNo)
        }

        def result = weChatPayService.receiveNotification(notification)
        if(result){
            log.info("Response notification result, ${result}")
            response.outputStream << result
        }
    }
}
