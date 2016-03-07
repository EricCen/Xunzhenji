package net.xunzhenji

import groovyx.net.http.ContentType
import groovyx.net.http.HTTPBuilder

import java.text.DecimalFormat

/**
 *
 * Created by: Kevin
 * Created time : 2015/5/27 17:20
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */
class MobileMsgService {
    def static String APIKEY = ""
    def static String TEMPLATE_BIND_MOBILE_CODE = "【寻真记】#code# (手机绑定验证码,请勿泄露,序号:#seq#)"
    def static String TEMPLATE_REMIND_FOR_PAYMENT = "【寻真记】您预订的商品(#product#)是时候付款啦!你可以在微信搜索框输入“寻真记”，进入寻真记公众号，点击“我的订单”进入付款界面。如果在#date#前未能及时付款，您的#discount#折订单将会自动取消。"
    def static String TEMPLATE_REMIND_DELIVERY = "【寻真记】您的#product#将会在#time#到货，快递大哥会在派送前联系您，请保持手机畅通。签收货物前请先验货，如有异常，请拒接签收。如有疑问请致电寻真记客服热线：400-056-9766。"
    def static String TEMPLATE_COURIER_CONFIRM = "【寻真记】我们为您安排了最可靠的快递员派送货物，他正骑着小火箭飞往您家。如果您现在不方便接收货物，请及时联系快递大哥，他叫#name#，电话是#phone#，您只要报上地址或单号#deliveryCode#，他就会为您更改宝贝派送时间，祝您开箱愉快。"
    def static api = new HTTPBuilder("http://yunpian.com/")


    def syncSmsSetting(){
        log.info("Synchronize sms setting..")
        def smsSetting = SmsSetting.first()
        if(!smsSetting){
            smsSetting = new SmsSetting()
            smsSetting.apiKey = APIKEY
        }

        def postBody  = [apikey: smsSetting?.apiKey]
        api.post( path: "/v1/user/get.json", query : [:], body: postBody) { resp, json ->
            if(json.code==0){
                def balance = json.user?.balance as int;
                def ipWhiteList = json.user?.ip_whitelist;
                def alarmBalance = json.user?.alarm_balance as int

                smsSetting.balance = balance
                smsSetting.ipWhiteList = ipWhiteList
                smsSetting.alarmBalance = alarmBalance
                smsSetting.save()
            }else{
                log.error("Found error during synchronize, ${json}")
            }
        }
    }

    def updateAlarmBalance(alarmBalance){
        def smsSetting = SmsSetting.first()
        def postBody  = [apikey: smsSetting.apiKey, alarm_balance:alarmBalance]
        api.post( path: "/v1/user/set.json", query : [:], body: postBody) { resp, json ->
            if(json.code == 0){
                smsSetting.alarmBalance = alarmBalance
                smsSetting.save()
                log.info("Update mobile alarm balance success.")
            }
        }
    }

    def sendSms(mobile, text){
        def smsSetting = SmsSetting.first()
        def postBody  = [apikey: smsSetting?.apiKey, mobile:mobile, text: text]
        api.post( path: "/v1/sms/send.json", query : [:], body: postBody) { resp, json ->
            println json
            if(json.code == 0&& json.result.fee == 1){
                smsSetting.balance = smsSetting.balance - 1
                smsSetting.save()
                log.info("Send mobile message success")
            }
        }
    }

    def bindMobile(mobile, seq){
        log.info("Bind mobile, mobile num: ${mobile}, seq: ${seq}")
        def code = new DecimalFormat('0000').format(Math.random()*10000 as int)
        def text = TEMPLATE_BIND_MOBILE_CODE.replace("#code#", code as String).replace("#seq#", seq as String)
        sendSms(mobile, text)
        log.info("Generate code for ${mobile}(${seq}), code:${code}")
        return code
    }

    def remindForPay(mobile, product, date, discount){
        log.info("Remind for payment, mobile: ${mobile}, product: ${product}, date: ${date}, discount: ${discount}")
        if(discount == null){
            discount = ""
        }
        def text = TEMPLATE_REMIND_FOR_PAYMENT.replace("#product#", product as String)
                .replace("#date#", date as String).replace("#discount#", discount as String)
        sendSms(mobile, text)
    }

    def remindDelivery(mobile, product, time){
        log.info("Remind for delivery, mobile: ${mobile}, product: ${product}, date: ${time}")
        def text = TEMPLATE_REMIND_DELIVERY.replace("#product#", product as String)
                .replace("#time#", time as String)
        sendSms(mobile, text)
    }

    def remindCourierConfirm(mobile, name, phone, deliveryCode){
        log.info("Remind for courier confirm, mobile: ${mobile}, name: ${name}, mobile: ${phone}, deliveryCode: ${deliveryCode}")
        def text = TEMPLATE_COURIER_CONFIRM.replace("#name#", name as String)
                .replace("#phone#", phone as String).replace("#deliveryCode#", deliveryCode as String)
        sendSms(mobile, text)
    }
}
