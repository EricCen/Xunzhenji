/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

import grails.transaction.Transactional
import net.xunzhenji.delivery.DeliveryRouteInfo
import net.xunzhenji.model.DeliveryStatus
import net.xunzhenji.model.PaymentStatus
import net.xunzhenji.util.FormatUtil
import org.apache.commons.lang.time.DateUtils

import static org.springframework.http.HttpStatus.*

class DeliveryController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

//    def sfOrderService
    def routeInfoService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Delivery.list(params), model:[deliveryInstanceCount: Delivery.count()]
    }

    @Transactional
    def show(Delivery deliveryInstance) {
        def searchResult , routeInfo
        if(deliveryInstance.deliveryCode){
            log.info("Query delivery code route info, code: ${deliveryInstance.deliveryCode}")
            def deliveryRouteInfo = DeliveryRouteInfo.findAllByDelivery(deliveryInstance)
            if(deliveryRouteInfo){
                routeInfo = deliveryRouteInfo*.routeInfo?.sort{a,b-> b.timestamp<=>a.timestamp}
            }else{
                def ret = routeInfoService.queryRouteInfo(deliveryInstance)
                routeInfo = ret?.routeInfos
            }
        }
        [deliveryInstance:deliveryInstance, searchResult:searchResult, routeInfo: routeInfo]
    }

    def create() {
        respond new Delivery(params)
    }

    @Transactional
    def save(Delivery deliveryInstance) {
        if (deliveryInstance == null) {
            notFound()
            return
        }

        if(params.completionDateTimeStr){
            deliveryInstance.completionDateTime = DateUtils.parseDate(params.completionDateTimeStr, "yyyy-MM-dd HH:mm:ss")
        }

        if (deliveryInstance.hasErrors()) {
            respond deliveryInstance.errors, view:'create'
            return
        }

        deliveryInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'delivery.label', default: 'Delivery'), deliveryInstance.id])
                redirect deliveryInstance
            }
            '*' { respond deliveryInstance, [status: CREATED] }
        }
    }

    def edit(Delivery deliveryInstance) {
        def deliveryRouteInfo = DeliveryRouteInfo.findAllByDelivery(deliveryInstance)
        def routeInfo = deliveryRouteInfo*.routeInfo?.sort{a,b-> b.timestamp<=>a.timestamp}
        def userInfo = DeliveryProductOrders.findByDelivery(deliveryInstance)?.productOrder?.userInfo
        [deliveryInstance: deliveryInstance, routeInfo: routeInfo, userInfo: userInfo]
    }

    @Transactional
    def update(Delivery deliveryInstance) {
        if (deliveryInstance == null) {
            notFound()
            return
        }

        if (deliveryInstance.hasErrors()) {
            respond deliveryInstance.errors, view:'edit'
            return
        }

        if(params.completionDateTimeStr){
            deliveryInstance.completionDateTime = DateUtils.parseDate(params.completionDateTimeStr, "yyyy-MM-dd HH:mm:ss")
        }
        deliveryInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'delivery.label', default: 'Delivery'), deliveryInstance.id])
                redirect deliveryInstance
            }
            '*'{ respond deliveryInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Delivery deliveryInstance) {

        if (deliveryInstance == null) {
            notFound()
            return
        }

        deliveryInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'delivery.label', default: 'Delivery'), deliveryInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'delivery.label', default: 'Delivery'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    @Transactional
    def removeUselessDelivery(){
        log.info("Remove useless delivery...")
        Delivery.findAllByTargetDeliveryDateNotGreaterThan(new Date().clearTime()).each{
            if(it.orders()?.size() == 0){
                log.info("Delivery ${it.id} should be remove")
                LxGroupDelivery.findByDelivery(it)?.delete()
                it.delete()
            }
        }
        redirect(action: "index")
    }


    def list(){
        def criteria = Delivery.createCriteria()
        def dates = criteria.listDistinct {
            projections {
                distinct("targetDeliveryDate")
            }
            order("targetDeliveryDate")
        }
        def dateMap = [:]
        dates.each{ date->
            def deliveryList = Delivery.findAllByTargetDeliveryDateAndDeliveryStatusNotEqual(date, DeliveryStatus.DELIVERED)?.sort{it.address?.district}
            deliveryList = deliveryList.findAll{it.orders()}
            if(deliveryList){
                deliveryList.each{ delivery->
                    def orderInProcessing = delivery.orders().find{it.paymentStatus == PaymentStatus.PAID_FOR_FULLPRICE.id}
                    if(orderInProcessing){
                        def displayItem = [product : delivery.batch?.product.title + " " + delivery.batch?.title,
                                           name   : delivery.address?.name,
                                           phone  : delivery.address?.phone,
                                           address: delivery.address,
                                           quantity: DeliveryProductOrders.findByDelivery(delivery)?.productOrder?.quantity,
                                           phoneVerified: delivery.address?.phone == DeliveryProductOrders.findByDelivery(delivery)?.productOrder.userInfo?.mobile,
                                           id          : delivery.id,
                                           deliveryCode  : delivery.deliveryCode,
                                           deliveryStatus: delivery.deliveryStatus?.name
                        ]
                        def key = FormatUtil.formatDate(date) + " " + displayItem.product
                        if(!dateMap[key]){
                            dateMap[key] = []
                        }
                        dateMap[key] << displayItem
                        dateMap[key].sort{it.product}
                    }
                }
            }
        }
        return [dateMap: dateMap]
    }

    @Transactional
    def deliveryCompleted(){
        log.info("Delivery completed, deliveryId: ${params.id}")
        def delivery = Delivery.get(params.id)
        delivery.deliveryStatus = DeliveryStatus.DELIVERED
        delivery.orders().each{
            it.deliveryStatus = DeliveryStatus.DELIVERED.id
            it.save()
        }
        delivery.save()
        redirect(action: "list")
    }

    def listDelivered(){
        def criteria = Delivery.createCriteria()
        def dates = criteria.listDistinct {
            projections {
                distinct("targetDeliveryDate")
            }
            order("targetDeliveryDate")
        }
        def dateMap = [:]
        dates.each{ date->
            def deliveryList = Delivery.findAllByTargetDeliveryDateAndDeliveryStatus(date, DeliveryStatus.DELIVERED)?.sort{it.address?.district}
            deliveryList = deliveryList.findAll{it.orders()}
            if(deliveryList){
                deliveryList.each{ delivery->
                    def orderInProcessing = delivery.orders()
                    if(orderInProcessing){
                        def displayItem = [product : delivery.batch?.product.title + "<br>" + delivery.batch?.title,
                                           address : delivery.address?.name + "<br>" + delivery.address?.phone + "<br>" + delivery.address,
                                           quantity: DeliveryProductOrders.findByDelivery(delivery)?.productOrder?.quantity,
                                           phoneVerified: delivery.address?.phone == DeliveryProductOrders.findByDelivery(delivery)?.productOrder.userInfo?.mobile,
                                           id          : delivery.id,
                                           deliveryCode      : delivery.deliveryCode,
                                           startDateTime     : delivery.startDateTime,
                                           completionDateTime: delivery.completionDateTime
                        ]
                        if(dateMap[date]){
                            dateMap[date] << displayItem
                        }else{
                            dateMap[date] = [displayItem]
                        }
                    }
                }
            }
        }
        return [dateMap: dateMap]
    }

    def updateProcessing() {
        log.info("Update processing for delivery, id:${params.id}")
        Delivery delivery = Delivery.get(params.id)
        delivery.updateProcessing()
    }

    @Transactional
    def newExpressOrder() {
        log.info("New express order, delivery id: ${params.id}")
//        Delivery delivery = Delivery.get(params.id)
//        def ret = sfOrderService.newOrder(delivery)
//        if (ret.response == "OK") {
//            delivery.deliveryCode = ret.mailNo
//            delivery.save()
//        }
        redirect(action: "list")
    }
}
