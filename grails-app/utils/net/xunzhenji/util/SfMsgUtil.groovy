/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.util

import groovy.xml.StreamingMarkupBuilder

class SfMsgUtil {

    def static encode(str){
//        new String(str.getBytes("UTF-8"), "ISO-8859-1")
        str
    }

    def static newOrderMessage(data) {
        new StreamingMarkupBuilder(encoding: "UTF-8").bind {
            Request(service: "OrderService", lang: "zh-CN") {
                Head { mkp.yieldUnescaped data.clientCode}
                Body {
                    Order(orderid: data.orderId as String,
                            express_type: data.expressType,
                            j_company: encode(data.fromCompany),
                            j_contact: encode(data.fromContact),
                            j_tel: encode(data.fromTel),
                            j_address: encode(data.fromAddress),
                            d_company: encode(data.toCompany),
                            d_contact: encode(data.toContact),
                            d_tel: data.toTel,
                            d_address: encode(data.toAddress),
                            parcel_quantity: data.parcelQuantity,
                            pay_method: data.payMethod,
                            custid:data.custId,
                            j_shippercode:data.shipperCode, //020,寄件方代码
                            d_deliveryCode:data.deliveryCode, //到件方代码
                            cargo_total_weight:data.totalWeight,
                            sendstarttime:data.sendStartTime, //要求上门收件时间
                            mailno: data.mailto, //运单号
                            remark: data.remark,
                            need_return_tracking_no: "1"
                    ){
                        Cargo( name: "冰鲜鸡肉",  count:'1', unit:'只', weight:'3', amount:'150', currency:'CNY', source_area:'中国')
//                        AddedService(name:"保鲜服务", value: "保鲜服务：5元")
                        Extra(e1:"保鲜服务：5元")
                    }
                }
            }
        }
    }

    def static orderSearch(clientCode, orderId){
        new StreamingMarkupBuilder(encoding: "UTF-8").bind {
            Request(service: "OrderSearchService", lang: "zh-CN") {
                Head { mkp.yieldUnescaped clientCode }
                Body {
                    OrderSearch(orderid: orderId)
                }
            }
        }
    }

    def static routeRequest(clientCode, mailNo){
        new StreamingMarkupBuilder(encoding: "UTF-8").bind {
            Request(service: "RouteService", lang: "zh-CN") {
                Head { mkp.yieldUnescaped clientCode }
                Body {
                    RouteRequest(tracking_number: mailNo)
                }
            }
        }
    }

    def static deliverTm(clientCode, consignedTime) {
        new StreamingMarkupBuilder(encoding: "UTF-8").bind {
            Request(service: "DeliverTmService", lang: "zh-CN") {
                Head { mkp.yieldUnescaped clientCode }
                Body {
                    DeliverTmRequest(business_type: 1, consignedTime: consignedTime) {
                        SrcAddress(province: '广东省',
                                city: '深圳',
                                district: '福田',
                                address: '新洲十一街万基商务大厦')
                        DestAddress(province: '广东省',
                                city: '广州',
                                district: '天河',
                                address: '元岗路600号慧通广场A2栋2304')
                    }
                }
            }
        }
    }
}
