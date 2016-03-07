/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.vendor

import grails.transaction.Transactional
import groovyx.net.http.Method
import net.xunzhenji.HttpService
import net.xunzhenji.delivery.DeliveryRouteInfo
import net.xunzhenji.delivery.RouteInfo
import net.xunzhenji.mall.Delivery
import net.xunzhenji.mall.DeliveryProductOrders
import net.xunzhenji.model.DeliveryStatus
import net.xunzhenji.model.RouteInfoState

/**
 * Created by Irene on 2015/12/5.
 */
class RouteInfoService extends HttpService {
    public static final String BAIDU_APP_HOST = "https://sp0.baidu.com/"
    public static final String BAIDU_APP_PATH = "/9_Q4sjW91Qh3otqbppnN2DJv/pae/channel/data/asyncqury"
    public static final String BAIDU_APP_ID = "4001"

    public static final String BAIDU_COOKIE = "BDUSS=jc4SElOSlcyWXZuNkUwSG5IRWE1bkh-LXIyYkVWNW5WZDFBN0Nadjg2VUlTNE5XQVFBQUFBJCQAAAAAAAAAAAEAAAB4KeRieHlwNTg1OAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAi-W1YIvltWZ; BAIDUID=C2336186A246409263079FF63799B67E:FG=1; BIDUPSID=B3D2307A1D928E2A3A25D4D9E1603137; BDRCVFR[feWj1Vr5u3D]=I67x6TjHwwYf0;"

    @Transactional
    def queryRouteInfo(Delivery delivery) {
        log.info("Query route info, ${delivery}")
        def query = [appid: BAIDU_APP_ID,
                     com  : delivery?.express?.queryName ? delivery?.express?.queryName : "shunfeng",
                     nu   : delivery?.deliveryCode,
                     "_"  : System.currentTimeMillis(),
        ]

        def deliveryRouteInfos = DeliveryRouteInfo.findAllByDelivery(delivery)

        def ret = [routeInfos:[]]
        withHttp(BAIDU_APP_HOST, { api ->
            api.request( Method.GET ) { req ->
                uri.path = BAIDU_APP_PATH
                uri.query = query
                headers.Cookie = BAIDU_COOKIE
                headers."User-Agent" = USER_AGENT_BROWSER
                response.success = { resp, json ->
                    if(!json) return
                    def routeInfos = json.data.info.context
                    RouteInfo.withTransaction {
                        routeInfos?.each{
                            def routeInfo = RouteInfo.parse(it.desc, delivery.express)
                            routeInfo.timestamp = new Date((it.time as long) * 1000)
                            if(deliveryRouteInfos.find{it.routeInfo.timestamp == routeInfo.timestamp}){
                                log.info("Route Info already exists, ${routeInfo}")
                            }else{
                                log.info("Save new route info, ${routeInfo}")
                                routeInfo.save()
                                delivery = delivery.refresh()
                                if(routeInfo.routeInfoState == RouteInfoState.DELIVERED){
                                    delivery.completionDateTime = routeInfo.timestamp
                                    delivery.deliveryStatus = DeliveryStatus.DELIVERED
                                    delivery.save(flush: true)
                                    def orders = DeliveryProductOrders.findAllByDelivery(delivery)*.productOrder
                                    orders*.completeDelivery()
                                    orders*.save()
                                }else if(routeInfo.routeInfoState == RouteInfoState.PACKAGE_RECEIVED){
                                    delivery.startDateTime = routeInfo.timestamp
                                    if (delivery.deliveryStatus.id < DeliveryStatus.PROCESSING.id) {
                                        delivery.deliveryStatus = DeliveryStatus.PROCESSING
                                    }
                                    delivery.save(flush:true)
                                } else { //auto fill start date time if cannot match the package received pattern
                                    if (!delivery.startDateTime) {
                                        delivery.startDateTime = routeInfo.timestamp
                                    }
                                }
                                new DeliveryRouteInfo(delivery: delivery, routeInfo: routeInfo).save()
                            }
                            ret.routeInfos << routeInfo
                        }
                    }
                }
            }
        })
        return ret
    }
}
