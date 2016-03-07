/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji

import net.xunzhenji.util.FormatUtil
import net.xunzhenji.wechat.Template
import org.apache.commons.lang.time.DateFormatUtils

/**
 * Created by Irene on 2015/8/14.
 */
class TemplateMessageService {
    def weChatPushService

    def sendRemindPaymentMsg(openId, url, price, productDetail, productionDate, orderId, prepayEnd, discount){
        log.info("Send remind payment message to ${openId}")
        Template template = Template.findByTemplateIdShort("OPENTM207940667")
        def date = DateFormatUtils.format(prepayEnd, "MM月dd日")
        def daysLeft = (prepayEnd - new Date().clearTime()) as int
        discount = discount == null ? "" : "${discount}折"
        def data = template.templateData()
        data.first = "您预订的商品是时候付款啦!"
        data.keyword1 = price + "元"
        data.keyword2 = productDetail
        data.keyword3 = FormatUtil.formatDate(productionDate)
        data.keyword4 = orderId
        daysLeft = daysLeft == 0 ? "(今天)" : daysLeft == 1 ? "(明天)" : "(${daysLeft}天后)"

        data.remark = "猛戳详情进入付款界面，如果${date}前${daysLeft}不及时付款，您的${discount}订单将会自动取消。"
        def message = template.buildMsg(openId, url, data)
        weChatPushService.sendTemplateMessage(message)
    }

    def sendAutoDepositMsg(openId, url, amount, balance){
        log.info("Send auto deposit message to ${openId}")
        Template template = Template.findByTemplateIdShort("OPENTM202535907")
        def data = template.templateData()
        data.first = "首单支付成功自动充值"
        data.keyword1 = FormatUtil.formatDatetime(new Date())    //充值时间
        data.keyword2 = "${amount}元"        //充值金额
        data.keyword3 = "首单自动充值"
        data.keyword4 = "${balance}元"     //当前余额

        def message = template.buildMsg(openId, url, data)
        weChatPushService.sendTemplateMessage(message)
    }

    def sendDepositMsg(openId, url, amount, balance){
        log.info("Send auto deposit message to ${openId}")
        Template template = Template.findByTemplateIdShort("OPENTM202535907")
        def data = template.templateData()
        data.first = "充值成功"
        data.keyword1 = FormatUtil.formatDatetime(new Date())    //充值时间
        data.keyword2 = "${amount}元"        //充值金额
        data.keyword3 = "客户充值"
        data.keyword4 = "${balance}元"     //当前余额

        def message = template.buildMsg(openId, url, data)
        weChatPushService.sendTemplateMessage(message)
    }

    def sendDeliveryReminder(openId, url, product, time, amount, addressDetail){
        log.info("Send delivery remind message to ${openId}")
        Template template = Template.findByTemplateIdShort("OPENTM203331384")
        def data = template.templateData()
        data.first = "您的商品将会在${time}到货，快递大哥会在派送前联系您，请保持手机畅通。"
        data.keyword1 = "${amount}元"
        data.keyword2 = product
        data.keyword3 = addressDetail

        def message = template.buildMsg(openId, url, data)
        weChatPushService.sendTemplateMessage(message)
    }

    def sendConfirmDeliveryTime(openId, url, product, time, allowChangeTime, amount, addressDetail) {
        log.info("Send confirm delivery time message to ${openId}")
        Template template = Template.findByTemplateIdShort("OPENTM203331384")
        def data = template.templateData()
        data.first = "您订购的${product}最终确定在${time}到货。"
        data.keyword1 = "${amount}元"
        data.keyword2 = product
        data.keyword3 = addressDetail
        data.remark = "如需更改收货信息，请在${allowChangeTime}前完成,如需帮助请致电寻真记客服热线：400-056-9766。"
        def message = template.buildMsg(openId, url, data)
        weChatPushService.sendTemplateMessage(message)
    }

    def sendCourierConfirm(openId, url, product, name, phone, deliveryCode) {
        log.info("Send courier confirm message to ${openId}")
        Template template = Template.findByTemplateIdShort("OPENTM400644757")
        def data = template.templateData()
        data.first = "我们为您安排了最可靠的快递员派送${product}，他正骑着小火箭飞往您家。"
        data.keyword1 = name
        data.keyword2 = phone
        data.keyword3 = deliveryCode

        def message = template.buildMsg(openId, url, data)
        weChatPushService.sendTemplateMessage(message)
    }
}
