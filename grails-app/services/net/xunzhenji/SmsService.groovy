/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji

import groovyx.net.http.HTTPBuilder

import java.text.DecimalFormat

class SmsService implements GenericSmsService{

    def static api = new HTTPBuilder("http://yunpian.com/")
    def yunPianSmsService
    def xiYuanSmsService

    def syncSmsSetting(){
        log.info("Synchronize sms setting..")
        def postBody  = [apikey: yunPianSmsService.YUNPIAN_APIKEY]
        api.post( path: "/v1/user/get.json", query : [:], body: postBody) { resp, json ->
            if(json.code==0){
                def balance = json.user?.balance as int;
                def ipWhiteList = json.user?.ip_whitelist;
                def alarmBalance = json.user?.alarm_balance as int
                def smsSetting = SmsSetting.first()
                if(!smsSetting){
                    smsSetting = new SmsSetting()
                }
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
        def postBody  = [apikey: yunPianSmsService.YUNPIAN_APIKEY, alarm_balance:alarmBalance]
        api.post( path: "/v1/user/set.json", query : [:], body: postBody) { resp, json ->
            if(json.code == 0){
                def smsSetting = SmsSetting.first()
                smsSetting.alarmBalance = alarmBalance
                smsSetting.save()
                log.info("Update mobile alarm balance success.")
            }
        }
    }


    def sendSms(mobile, text){
        yunPianSmsService.sendSms(mobile, text)
    }
}
