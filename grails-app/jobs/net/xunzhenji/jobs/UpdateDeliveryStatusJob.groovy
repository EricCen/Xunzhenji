/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.jobs

import grails.transaction.Transactional
import net.xunzhenji.Server
import net.xunzhenji.mall.Delivery
import net.xunzhenji.mall.DeliveryProductOrders
import net.xunzhenji.model.DeliveryStatus
import net.xunzhenji.model.RouteInfoState
import net.xunzhenji.util.OrderUtil

class UpdateDeliveryStatusJob {
    def templateMessageService
    def routeInfoService
    def mobileMsgService

    static triggers = {
        cron name: 'updateDelivery', cronExpression: "0 /5 8-19 * * ?", timeZone:TimeZone.getTimeZone("Asia/Hong_Kong")
    }
    def name = "更新发货情况"
    def group = "MyGroup"

    @Transactional
    def execute() {
        if (Server.thisServer?.remindPayment) {
            log.info("Start to update delivery")
            def deliveries = Delivery.withCriteria {
                and {
                    isNotNull("deliveryCode")
                    isNull("completionDateTime")
                    lt("targetDeliveryDate", new Date())
                }
            }
            deliveries.each { delivery ->
                def ret = routeInfoService.queryRouteInfo(delivery)
                def routeWithPhone = ret.routeInfos.find { it.routeInfoState == RouteInfoState.CONFIRM_COURIER }
                if (routeWithPhone && delivery.deliveryStatus <= DeliveryStatus.PROCESSING) {
                    log.info("Delivering the package to customer, deliver code: ${delivery.deliveryCode}, courier name: ${routeWithPhone.courier}, courier phone: ${routeWithPhone.mobile}")
                    def orders = DeliveryProductOrders.findAllByDelivery(delivery)*.productOrder
                    def openId = delivery.receiver?.weChatFans?.openId
                    def productInfo = OrderUtil.convertPayBody(orders)
                    if (openId && productInfo) {
                        try {
                            templateMessageService.sendCourierConfirm(openId,
                                    "http://xunzhenji.net/h5/home?openId=${openId}#listOrder",
                                    productInfo,
                                    routeWithPhone.courier,
                                    routeWithPhone.mobile,
                                    delivery.deliveryCode
                            )
                        } catch (e) {
                            log.error("Fail to send template message, openId:${openId}, productInfo:${productInfo}")
                        }
                    } else {
                        log.warn("Fail to send template message, openId:${openId}, productInfo:${productInfo}")
                    }
                    try {
                        mobileMsgService.remindCourierConfirm(delivery.address.phone, routeWithPhone.courier, routeWithPhone.mobile, delivery.deliveryCode)
                    } catch (e) {
                        log.error("Fail to send mobile message, openId:${openId}, phone:${delivery.address.phone}")
                    }
                    Delivery.withTransaction {
                        def d = Delivery.get(delivery.id)
                        d.confirmCourier()
                        d.save()
                    }
                }
            }
            log.info("Update delivery completed")
        }
    }
}
