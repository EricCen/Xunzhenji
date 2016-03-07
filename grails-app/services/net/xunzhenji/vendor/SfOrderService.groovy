/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.vendor

import groovyx.net.http.HttpResponseDecorator
import net.xunzhenji.HttpService
import net.xunzhenji.mall.Delivery
import net.xunzhenji.util.SfMsgUtil
import sun.misc.BASE64Encoder

import java.security.MessageDigest

/**
 * Created by Irene on 2015/10/26.
 */
class SfOrderService extends HttpService {

    public static String md5EncryptAndBase64(String str) {
        return encodeBase64(md5Encrypt(str));
    }

    private static byte[] md5Encrypt(String encryptStr) {
        try {
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            md5.update(encryptStr.getBytes("utf8"));
            return md5.digest();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    private static String encodeBase64(byte[] b) {
        sun.misc.BASE64Encoder base64Encode = new BASE64Encoder();
        String str = base64Encode.encode(b);
        return str;
    }

    def newOrder(Delivery delivery) {
        SfSetting sfSetting = SfSetting.first()
        def order = [clientCode    : sfSetting.clientCode,
                              orderId       : delivery.id + System.currentTimeMillis(),
                              expressType   : sfSetting.expressType,
                              fromCompany   : sfSetting.fromCompany,
                              fromContact   : sfSetting.fromContact,
                              fromTel       : sfSetting.fromTel,
                              fromAddress   : sfSetting.fromAddress,
                              toCompany     : "",
                              toContact     : delivery.address.name,
                              toTel         : delivery.address.phone,
                              toAddress     : delivery.address.toString(),
                              parcelQuantity: delivery.orders().sum { it.quantity },
                              payMethod     : sfSetting.payMethod,
                              custId        : sfSetting.custId,
                              shipperCode   : sfSetting.shipperCode,
                              deliveryCode  : "",
                              totalWeight   : delivery.orders().sum { it.product.grossWeight },
                              sendStartTime : "",
                              remark        : ""
        ]

        def message = SfMsgUtil.newOrderMessage(order) as String

        def ret = [:]

        withHttp(sfSetting.host(), { api ->
            api.post(path: sfSetting.path(),
                    body: [xml: message, verifyCode: md5EncryptAndBase64(message + sfSetting.checkword)],
                    contentType: "application/text;charset=utf-8"
            ) { resp, reader ->
                def response = new XmlParser().parseText(parseXml(reader))
                ret.response = response.Head.text()
                if(ret.response == "OK"){
                    ret.orderId = response.Body.OrderResponse.@orderid[0]
                    ret.mailNo = response.Body.OrderResponse.@mailno[0]
                    ret.originCode = response.Body.OrderResponse.@origincode[0]
                    ret.destCode = response.Body.OrderResponse.@destcode[0]
                    ret.filterResult = response.Body.filter_result.@filter_result[0]
                    ret.remark = response.Body.filter_result.@remark[0]
                    ret.returnTrackingNo = response.Body.filter_result.@return_tracking_no[0]
                }
            }
        })
        return ret
    }

    def static parseXml(inputStream){
        def br = new BufferedReader(new InputStreamReader(inputStream))
        def line = '', ret = ''
        while(line = br.readLine()){
            ret+= line
        }
        return ret
    }

    def confirmOrder(){

    }

    def orderSearch(orderId){
        SfSetting sfSetting = SfSetting.first()

        def message = SfMsgUtil.orderSearch(sfSetting.clientCode, orderId) as String

        def ret = [:]
        withHttp(sfSetting.host(), { api ->
            api.post(path: sfSetting.path(),
                    body: [xml: message, verifyCode: md5EncryptAndBase64(message + sfSetting.checkword)],
                    contentType: "application/text;charset=utf-8"
            ) { resp, reader ->
                def xml = parseXml(reader)
                def response = new XmlParser().parseText(xml)
                ret.response = response.Head.text()
                if(ret.response == "OK"){
                    ret.orderId = response.Body.OrderResponse.@orderid[0]
                    ret.mailNo = response.Body.OrderResponse.@mailno[0]
                    ret.originCode = response.Body.OrderResponse.@origincode[0]
                    ret.destCode = response.Body.OrderResponse.@destcode[0]
                    ret.filterResult = response.Body.OrderResponse.@filter_result[0]
                    ret.remark = response.Body.OrderResponse.@remark[0]
                    ret.returnTrackingNo = response.Body.OrderResponse.@return_tracking_no[0]
                }
            }
        })
        ret
    }

    def orderFilter(){

    }

    def routeRequest(mailNo){
        SfSetting sfSetting = SfSetting.first()

        def message = SfMsgUtil.routeRequest(sfSetting.clientCode, mailNo) as String
        def verifyCode = md5EncryptAndBase64(message + sfSetting.checkword)
        println message
        println "verifyCode : " + verifyCode

        def ret = [:]
        withHttp(sfSetting.host(), { api ->
            api.post(path: sfSetting.path(),
                    body: [xml: message, verifyCode: md5EncryptAndBase64(message + sfSetting.checkword)],
                    contentType: "application/text;charset=utf-8"
            ) { resp, reader ->
                def xml = parseXml(reader)
                println xml
            }
        })
        ret
    }

    def deliveryTmService(){
        SfSetting sfSetting = SfSetting.first()

        def message = SfMsgUtil.deliverTm(sfSetting.clientCode, "2015-11-12 15:00:00") as String

        println message


        def ret = [:]
        withHttp(sfSetting.host(), { api ->
            api.post(path: sfSetting.path(),
                    body: [xml: message, verifyCode: md5EncryptAndBase64(message + sfSetting.checkword)],
                    contentType: "application/text;charset=utf-8"
            ) { resp, reader ->
                def xml = parseXml(reader)
                println xml
            }
        })
        ret
    }

    def wayBillRoute(){

    }
}
