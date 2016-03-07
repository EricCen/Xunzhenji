package net.xunzhenji.mall

import grails.transaction.Transactional
import net.xunzhenji.model.DeliveryStatus

class Delivery {
    String deliveryCode // unique id for the delivery when initialization

    Date targetDeliveryDate // planned delivery date, inform organizer

    Date startDateTime // 快递收件时间
    Date receiveDateTime // the time the deliveryStatus become 已代收 or 已签收
    Date completionDateTime // the time the deliveryStatus become 已签收 or all the child order become 已签收

    Batch batch
    Address address
    UserInfo receiver
    DeliveryStatus deliveryStatus = DeliveryStatus.INSTORE
    boolean isGroupon
    boolean enable = true
    Date dateCreated
    Date lastUpdated
    Express express

    def Delivery(){
    }

    static mapping = {
    }

    static hasMany = [deliveryRouteUpdate: DeliveryRouteUpdate]

    /**
     * 1. when it's groupon,
     *
     *      when all the child order status become 已签收, it change to 已签收
     *      before that, the status is 已代收
     *
     * 2. when it's not groupon, status the same as it's own product status
     *
     */


    static constraints = {
        deliveryCode nullable: true
        startDateTime nullable: true
        targetDeliveryDate nullable: true
        receiveDateTime nullable: true
        completionDateTime nullable: true
        address nullable: true
        receiver nullable: true
        deliveryStatus nullable: true
        express nullable: true
    }

    def Collection<ProductOrder> orders(){
        DeliveryProductOrders.findAllByDelivery(this)*.productOrder
    }

    int totalQuantity() {
        def orders = orders()
        orders ? orders.sum { it.quantity } : 0
    }

    def unitSavedExpressFee(int totalQuantity) {
        def product = batch.product
        def savedExpressFee = product.express.calcSavedExpressFee(totalQuantity, product.weight / 1000.0)
        return (savedExpressFee / totalQuantity).setScale(2, BigDecimal.ROUND_HALF_UP)
    }

    def unitSavedExpressFee() {
        def orders = orders()
        if(orders.size() == 0 ) return 0

        def totalQuantity = totalQuantity()
        return unitSavedExpressFee(totalQuantity)
    }

    def calcUnitCommissionAmt() {
        return calcUnitCommissionAmt(totalQuantity())
    }

    def calcUnitCommissionAmt(int totalQuantity) {
        def unitBaseCommissionAmt = unitSavedExpressFee(totalQuantity)
        return (unitBaseCommissionAmt / 2 + unitBaseCommissionAmt * batch.unitAllowance).setScale(2, BigDecimal.ROUND_HALF_UP)
    }

    def calcTotalCommission() {
        def orders = orders()
        def unitCommissionAmt = calcUnitCommissionAmt()
        orders.each { order ->
            def buyer = order.userInfo
            if (order.commission) {
                order.commission.amount = unitCommissionAmt * order.quantity
            } else {
                order.commission = new Commission(amount: unitCommissionAmt * order.quantity,
                        productOrder: order,
                        organizer: receiver,
                        state: Commission.CommissionState.STATE_UNREALISED.id,
                        buyer: buyer,
                        buyerName: buyer?.weChatFans?.nickName ? buyer.weChatFans.nickName : buyer.name,
                        buyerHeadImgUrl: buyer?.weChatFans?.headImgUrl,
                        productName: order.toPayBody()
                )
                order.commission.createCommissionEvent(CommissionEvent.EVENT_CREATE)
            }
            def refundAmt = unitSavedExpressFee() * order.quantity / 2
            order.refundAmount = refundAmt
        }
        ProductOrder.saveAll(orders)
        orders.sum{it.quantity * unitCommissionAmt}
    }

    @Transactional
    def updateProcessing(){
        orders()?.each{ order->
            if(order.deliveryStatus == DeliveryStatus.CONFIRM_DELIVER_DATE.id){
                order.startDelivery()
                order.save()
            }
        }
    }

    def confirmDelivered(){
        deliveryStatus = DeliveryStatus.DELIVERED
    }

    def confirmCourier(){
        deliveryStatus = DeliveryStatus.DELIVERING
    }
}