/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.wechat

import grails.transaction.Transactional
import groovy.xml.XmlUtil
import groovyx.net.http.ContentType
import net.xunzhenji.mall.Payment
import net.xunzhenji.util.SignUtil
import net.xunzhenji.util.WeChatMsgUtil
import org.apache.commons.lang.time.DateUtils

class WeChatPayService extends WeChatService implements PayService{

    def genPrepayOrder(String body, String detail, totalFee, String outTradeNo,String  openId, String clientIp) {
        log.info("Generate wechat prepay order")
        WeChatContext weChatContext = WeChatContext.defaultContext()

        def bodyParams = [appid           : weChatContext.appId,
                          body            : body,
                          detail          : detail,
                          mch_id          : weChatContext.merchantId,
                          nonce_str       : SignUtil.create_nonce_str(),
                          notify_url      : "http://xunzhenji.net/mall",
                          openid          : openId,
                          out_trade_no    : outTradeNo,
                          spbill_create_ip: clientIp,
                          total_fee       : totalFee * 100 as int,
                          trade_type      : "JSAPI"]
        def sign = SignUtil.signWechatPayInfo(bodyParams, weChatContext.merchantKey)
        bodyParams.sign = sign

        log.info("Sign body : ${bodyParams}")
        def bodyXmlStr = WeChatMsgUtil.unifiedOrderMessage(bodyParams) as String

        def payInfo

        withHttp(WeChatService.WECHAT_MCH_API_URL, { payApi ->
            payApi.post(path: WeChatService.URL_PAY_UNIFIEDORDER, body: bodyXmlStr,
                    requestContentType: ContentType.XML) { resp, xml ->
                def xmlText = xml.getText()
                def msg = new XmlParser().parseText(xmlText)
                def returnCode = msg.return_code.text()
                def returnMsg = msg.return_msg.text()
                def appId = msg.appid.text()
                def mchId = msg.mch_id.text()
                def nonceStr = msg.nonce_str.text()
                def retSign = msg.sign.text()
                def resultCode = msg.result_code.text()
                def prepayId = msg.prepay_id.text()
                def tradeType = msg.trade_type.text()

                if ("SUCCESS".equals(returnCode)) {
                    def payNonceStr = SignUtil.create_nonce_str()
                    payInfo = [appId   : appId,
                               timeStamp: String.valueOf((System.currentTimeMillis() / 1000) as int),
                               nonceStr: payNonceStr,
                               package: "prepay_id=${prepayId}",
                               signType: "MD5"]
                    def paySign = SignUtil.signWechatPayInfo(payInfo, weChatContext.merchantKey)
                    payInfo.paySign = paySign
                } else {
                    log.error("Generate pre-order fail, reason: ${returnMsg}, xml: ${xmlText}")
                }
            }
        })
        log.info("Generated wechat prepay order..")
        return payInfo
    }

    def refundOrder(String transactionId, String outTradeNo, String outRefundNo,
                    int totalFee, int refundFee) {
        log.info("Generate wechat refund order")
        WeChatContext weChatContext = WeChatContext.defaultContext()

        def bodyParams = [appid         : weChatContext.appId,
                          mch_id        : weChatContext.merchantId,
                          nonce_str     : SignUtil.create_nonce_str(),
                          transaction_id: transactionId,
                          out_trade_no  : outTradeNo,
                          out_refund_no : outRefundNo,
                          total_fee     : totalFee * 100 as int,
                          refund_fee    : refundFee * 100 as int,
                          op_user_id    : weChatContext.merchantId]
        def sign = SignUtil.signWechatPayInfo(bodyParams, weChatContext.merchantKey)
        bodyParams.sign = sign
        def bodyXmlStr = WeChatMsgUtil.refundMessage(bodyParams) as String

        def refundResult = [:]

        getSecApi().post(path: WeChatService.URL_PAY_REFUND, body: bodyXmlStr,
                requestContentType: ContentType.XML) { resp, xml ->
            def xmlText = xml.getText()
            def msg = new XmlParser().parseText(xmlText)
            refundResult.returnCode = msg.return_code.text()
            refundResult.returnMsg = msg.return_msg.text()
            refundResult.appId = msg.appid.text()
            refundResult.mchId = msg.mch_id.text()
            refundResult.nonceStr = msg.nonce_str.text()
            refundResult.sign = msg.sign.text()
            refundResult.resultCode = msg.result_code.text()
            refundResult.transactionId = msg.transaction_id.text()
            refundResult.outTradeNo = msg.out_trade_no.text()
            refundResult.outRefundNo = msg.out_refund_no.text()
            refundResult.refundId = msg.refund_id.text()
            refundResult.refundChannel = msg.refund_channel.text()
            refundResult.retRefundFee = msg.refund_fee.text()
            refundResult.couponRefundFee = msg.coupon_refund_fee.text()
            refundResult.timeEnd = new Date()
            refundResult.tradeType = "JSAPI"

            if ("SUCCESS".equals(refundResult.resultCode)) {
                log.info("Refund success!")
            } else {
                log.error("Generate pre-order fail, reason: ${refundResult.returnMsg}, xml: ${xmlText}")
            }
        }
        return refundResult
    }

    @Transactional
    def receiveNotification(notification) {
        def payment = Payment.findByOutTradeNo(notification.outTradeNo)
        if(Payment.STATUS_PAID == payment.status) {
            payment.properties = notification
            payment.status = Payment.STATUS_NOTIFIED
            payment.save()
        }
        return WeChatMsgUtil.notificationAckMessage([returnCcode: "SUCCESS", returnMsg: "OK"])
    }

    def transferAmount(openId, name, partnerTradeNo, amount, desc, clientIp) {
        log.info("Transfer amount to user: ${name}(${openId}), amount: ${amount}")
        WeChatContext weChatContext = WeChatContext.defaultContext()

        def bodyParams = [mch_appid       : weChatContext.appId,
                          mchid           : weChatContext.merchantId,
                          nonce_str       : SignUtil.create_nonce_str(),
                          partner_trade_no: partnerTradeNo,
                          openid      : openId,
                          check_name      : "OPTION_CHECK",
                          re_user_name: name,
                          amount          : amount * 100 as int,
                          desc            : desc,
                          spbill_create_ip: clientIp]
        def sign = SignUtil.signWechatPayInfo(bodyParams, weChatContext.merchantKey)
        bodyParams.sign = sign
        def bodyXmlStr = WeChatMsgUtil.transferMessage(bodyParams) as String
        def transferResult = [:]

        getSecApi().post(path: WeChatService.URL_PAY_TRANSFER, body: bodyXmlStr,
                requestContentType: ContentType.XML, contentType: ContentType.XML) { resp, xml ->
            log.info("Transfer xml result: ${XmlUtil.serialize(xml)}")
            transferResult.returnCode = xml.return_code.text()
            transferResult.returnMsg = xml.return_msg.text()
            transferResult.resultCode = xml.result_code.text()
            transferResult.mchAppid = xml.mch_appid.text()
            transferResult.deviceInfo = xml.device_info.text()
            transferResult.nonceStr = xml.nonce_str.text()
            transferResult.outTradeNo = xml.partner_trade_no.text()
            transferResult.transctionId = xml.payment_no.text()
            transferResult.timeEnd = xml.payment_time.text() ?  DateUtils.parseDate(xml.payment_time.text(), "yyyy-MM-dd HH:mm:ss") : null

            if ("SUCCESS".equals(transferResult.resultCode)) {
                log.info("Transfer success!")
            } else {
                log.error("Generate pre-order fail, reason: ${transferResult.returnMsg}")
            }
        }
        return transferResult
    }

    def redpack(openId, amount, totalNum, sendName, wishing, actName, remark, clientIp) {
        log.info("Transfer amount to user: ${openId}, amount: ${amount}")
        WeChatContext weChatContext = WeChatContext.defaultContext()

        def timeStr = System.currentTimeMillis() as String
        timeStr = timeStr.substring(timeStr.size() - 10, timeStr.size())
        def bodyParams = [wxappid     : weChatContext.appId,
                          mch_id      : weChatContext.merchantId,
                          nonce_str   : SignUtil.create_nonce_str(),
                          mch_billno  : "${weChatContext.merchantId}${new Date().format('yyyyMMdd')}${timeStr}",
                          nick_name   : sendName,
                          send_name   : sendName,
                          re_openid   : openId,
                          total_amount: amount * 100 as int,
                          total_num   : totalNum,
                          min_value   : amount * 100 as int,
                          max_value   : amount * 100 as int,
                          wishing     : wishing,
                          act_name    : actName,
                          remark      : remark,
                          client_ip   : clientIp]
        def sign = SignUtil.signWechatPayInfo(bodyParams, weChatContext.merchantKey)
        bodyParams.sign = sign
        def bodyXmlStr = WeChatMsgUtil.redPackMessage(bodyParams) as String
        def transferResult = [:]
        println bodyXmlStr

        getSecApi().post(path: WeChatService.URL_PAY_TRANSFER, body: bodyXmlStr,
                requestContentType: ContentType.URLENC, contentType: ContentType.XML) { resp, xml ->
            log.info("Transfer xml result: ${XmlUtil.serialize(xml)}")
            transferResult.returnCode = xml.return_code.text()
            transferResult.returnMsg = xml.return_msg.text()
            transferResult.resultCode = xml.result_code.text()
            transferResult.errCode = xml.err_code.text()
            transferResult.errCodeDes = xml.err_code_des.text()
            transferResult.mchAppid = xml.mch_appid.text()
            transferResult.deviceInfo = xml.device_info.text()
            transferResult.nonceStr = xml.nonce_str.text()
            transferResult.outTradeNo = xml.partner_trade_no.text()
            transferResult.transctionId = xml.payment_no.text()
            transferResult.timeEnd = xml.payment_time.text() ? DateUtils.parseDate(xml.payment_time.text(), "yyyy-MM-dd HH:mm:ss") : null

            if ("SUCCESS".equals(transferResult.resultCode)) {
                log.info("Transfer success!")
            } else {
                log.error("Generate pre-order fail, reason: ${transferResult.returnMsg}")
            }
        }

        return transferResult
    }

    def sendCoupon(openId, couponStockId) {
        log.info("Send coupon to user: ${openId}")
        WeChatContext weChatContext = WeChatContext.defaultContext()

        def timeStr = System.currentTimeMillis() as String
        timeStr = timeStr.substring(timeStr.size() - 10, timeStr.size())
        def bodyParams = [appid           : weChatContext.appId,
                          coupon_stock_id : couponStockId,
                          mch_id          : weChatContext.merchantId,
                          nonce_str       : SignUtil.create_nonce_str(),
                          openid          : openId,
                          openid_count: 1,
                          partner_trade_no: "${weChatContext.merchantId}${new Date().format('yyyyMMdd')}${timeStr}"]
        def sign = SignUtil.signWechatPayInfo(bodyParams, weChatContext.merchantKey)
        bodyParams.sign = sign
        def bodyXmlStr = WeChatMsgUtil.couponMessage(bodyParams) as String
        def couponResult = [:]

        getSecApi().post(path: WeChatService.URL_PAY_SENDCOUPON, body: bodyXmlStr,
                requestContentType: ContentType.URLENC, contentType: ContentType.XML) { resp, xml ->
            log.info("Send coupon result: ${XmlUtil.serialize(xml)}")
            couponResult.resultCode = xml.result_code as String
            couponResult.errCodeDesc = xml.err_code_des as String

            if ("SUCCESS".equals(couponResult.resultCode)) {
                log.info("Send coupon success!")
            } else {
                log.error("Send coupon fail, reason: ${couponResult.returnMsg}")
            }
        }

        return couponResult
    }

    def queryCouponStock(stockId) {
        log.info("Query coupon stock, id: ${stockId}")
        WeChatContext weChatContext = WeChatContext.defaultContext()

        def bodyParams = [appid          : weChatContext.appId,
                          coupon_stock_id: stockId,
                          mch_id         : weChatContext.merchantId,
                          nonce_str      : SignUtil.create_nonce_str()]
        def sign = SignUtil.signWechatPayInfo(bodyParams, weChatContext.merchantKey)
        bodyParams.sign = sign
        def bodyXmlStr = WeChatMsgUtil.queryCouponStockMessage(bodyParams) as String
        def couponResult = [:]
        println bodyXmlStr

        payApi.post(path: WeChatService.URL_PAY_QUERYCOUPON, body: bodyXmlStr,
                requestContentType: ContentType.URLENC, contentType: ContentType.XML) { resp, xml ->
            log.info("Send coupon result: ${XmlUtil.serialize(xml)}")
            couponResult.resultCode = xml.result_code as String
            couponResult.errCodeDesc = xml.err_code_des as String

            if ("SUCCESS".equals(couponResult.resultCode)) {
                couponResult.appId = xml.appid
                couponResult.mchId = xml.mch_id
                couponResult.couponStockId = xml.coupon_stock_id
                couponResult.name = xml.coupon_name.text()
                couponResult.value = xml.coupon_value.text() as BigDecimal
                couponResult.couponMininumn = (xml.coupon_mininumn.text() as BigDecimal) / 100
                couponResult.couponType = WeChatCoupon.CouponType.findById(xml.coupon_type.text() as int)
                couponResult.couponStockStatus = WeChatCoupon.CouponStockStatus.findById(xml.coupon_stock_status.text() as int)
                couponResult.couponTotal = xml.coupon_total.text() as int
                couponResult.beginTime = new Date((xml.begin_time.text() as long) * 1000l)
                couponResult.endTime = new Date((xml.end_time.text() as long) * 1000l)
                couponResult.createTime = new Date((xml.create_time.text() as long) * 1000l)
                couponResult.couponBudget = (xml.coupon_budget.text() as BigDecimal) / 100
            } else {
                log.error("Send coupon fail, reason: ${couponResult.errCodeDesc}")
            }
        }

        return couponResult
    }
}
