/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

import grails.transaction.Transactional
import net.xunzhenji.delivery.DeliveryRouteInfo
import net.xunzhenji.model.Constant
import net.xunzhenji.model.DeliveryStatus
import net.xunzhenji.model.DisplayStatus
import net.xunzhenji.model.PaymentStatus
import net.xunzhenji.util.FormatUtil
import org.apache.commons.lang.time.DateUtils

class ProductOrder {
    def templateMessageService
    def mobileMsgService

    def static final int PAYMENT_TYPE_UNKNOWN = 0
    def static final int PAYMENT_TYPE_WECHAT = 1
    def static final int PAYMENT_TYPE_ALIPAY = 2

    def static final String PRICE_TYPE_PAY_FOR_DEPOSIT = "订金"
    def static final String PRICE_TYPE_PAY_FOR_FULLPRICE = "预订款"
    def static final String PRICE_TYPE_PAY_FOR_MARKETPRICE = "货款"

    int quantity = 0
    int paymentType = PAYMENT_TYPE_WECHAT
    int paymentStatus = PaymentStatus.UNPAID.id
    int deliveryStatus = DeliveryStatus.INSTORE.id
    String displayStatus = DisplayStatus.PENDING_PAYMENT.name
    Date orderDate
    Date dateCreated
    Date lastUpdated
    BigDecimal marketPrice
    BigDecimal orderPrice // 预售价 or 约定价格
    BigDecimal orderDeposit //已付的订金
    BigDecimal discount     //折
    Address address
    Payment lastPayment
    UserInfo userInfo
    UserInfo organizer
    BigDecimal refundAmount //对消费者的让利，在付款周期结束后退还
    boolean groupon = false //是否成团
    Payment depositPayment
    Payment fullPricePayment
    String deliveryArrangedBy = Constant.SYSTEM
    Date productionDate
    Date paymentDate
    Commission commission
    PromotionCode promotionCode

    static belongsTo = [product: Product, batch: Batch]

    static constraints = {
        address nullable: true
        lastPayment nullable: true
        userInfo nullable: true
        organizer nullable: true
        commission nullable: true
        refundAmount nullable: true
        depositPayment nullable: true
        fullPricePayment nullable: true
        productionDate nullable: true
        paymentDate nullable: true
        promotionCode nullable: true
    }

    static createOrder(Batch batch, int quantity, BigDecimal orderPrice, BigDecimal marketPrice, BigDecimal deposit, BigDecimal discount) {
        return createOrder(batch, quantity, orderPrice, marketPrice, deposit, discount, null)
    }

    static createOrder(Batch batch, int quantity, BigDecimal orderPrice, BigDecimal marketPrice, BigDecimal deposit, BigDecimal discount, UserInfo userInfo) {
        def order = new ProductOrder(quantity: quantity, orderPrice: orderPrice, orderDeposit: deposit,
                marketPrice: marketPrice, batch: batch, orderDate: new Date(), discount: discount, userInfo: userInfo)
        order.batch = batch
        order.product = batch.product
        return order
    }

    /*
     * 显示在支付页面的剩余总价
     */

    def totalPrice() {
        totalMarketPrice() - totalDeposit() - totalDiscount()
    }

    /*
     * 最终商品总价
     */

    def fullPrice() {
        totalMarketPrice() - totalDiscount()
    }

    /*
     * 在预售期或者正在等待付全款，订金都要正常显示
     * 没有付订的订单在预售期以后订金为零
     */
    def totalDeposit() {
        if (batch.isPresales() || pendingPayForFullPrice()) {
            return orderDeposit * quantity
        }
        0
    }

    def totalMarketPrice() {
        marketPrice * quantity
    }

    /*
     * 这个方法只能在销售时使用，付款时不能使用
     * 在预售期或者正在等待付全款，折扣都要正常显示
     * 没有付订的订单在预售期以后折扣为零
     */
    def totalDiscount() {
        if (batch.isPresales() || pendingPayForFullPrice()) {
            return (marketPrice - orderPrice) * quantity
        }
        0
    }

    def priceType() {
        if (pendingPayForDeposit()) {
            return PRICE_TYPE_PAY_FOR_DEPOSIT
        } else if (pendingPayForFullPrice()) {
            return PRICE_TYPE_PAY_FOR_FULLPRICE
        } else {
            return PRICE_TYPE_PAY_FOR_MARKETPRICE
        }
    }

    @Transactional
    def payForDeposit() {
        paymentStatus = PaymentStatus.PAID_FOR_DEPOSIT.id
        updateDisplayStatus()
        if (organizer) {
            def lxGroup = LxGroup.findByOrganizer(organizer)
            lxGroup.addOrderToGroup(this)
        }
    }

    def updateDisplayStatus() {
        displayStatus = DisplayStatus.valueOf(paymentStatus, deliveryStatus).name
    }

    @Transactional
    def payForFullPrice() {
        paymentStatus = PaymentStatus.PAID_FOR_FULLPRICE.id
        updateDisplayStatus()

        // generate commission if required
        if (organizer) {
            if (commission) {
                def currentGroup = LxGroup.findByOrganizer(commission.organizer)
                if (commission.organizer == organizer) {
                    currentGroup.payForOrder(this)
                } else { //group changed
                    currentGroup.removeOrderFromGroup(this)

                    def newGroup = LxGroup.findByOrganizer(organizer)
                    newGroup.addOrderToGroup(this)

                }
            } else { //maybe newly use organizer as address, or group cannot create until now
                def lxGroup = LxGroup.findByOrganizer(organizer)
                lxGroup.addOrderToGroup(this)
            }
        }
    }

    /**
     * Transit payment status to next state.
     * @return
     */
    def pay() {
        if (pendingPayForDeposit()) {
            log.info("Pay for deposit, ${this}")
            payForDeposit()
        } else if (pendingPayForFullPrice() || pendingPayForMarketPrice()) {
            log.info("Pay for full price, ${this}")
            payForFullPrice()
        }

        if (!organizer) {
            refundAmount = 0
            if (commission) {
                commission.cancel()
                commission.save()
                commission = null
            }
        }
    }

    def startConfirmDeliveryDate() {
        deliveryStatus = DeliveryStatus.INSTORE.id
        updateDisplayStatus()
    }

    def confirmDeliveryDate() {
        deliveryStatus = DeliveryStatus.CONFIRM_DELIVER_DATE.id
        updateDisplayStatus()
    }

    def startDelivery() {
        deliveryStatus = DeliveryStatus.PROCESSING.id
        updateDisplayStatus()
    }

    def arriveAtOrganizer() {
        deliveryStatus = DeliveryStatus.ARRIVED_AT_ORGANIZER.id
        updateDisplayStatus()
    }

    def customerGotTheProduct(){
        deliveryStatus = DeliveryStatus.CUSTOMER_GOT_THE_PRODUCT.id
        updateDisplayStatus()
    }

    def completeDelivery() {
        deliveryStatus = DeliveryStatus.DELIVERED.id
        updateDisplayStatus()
    }

    def commentOrder(){
        deliveryStatus = DeliveryStatus.COMMENTED.id
        updateDisplayStatus()
    }

    def confirmCommission(){
        if(organizer && commission){
            commission.extractable()
            commission.save()
        }
    }

    def cancelOrder() {
        if (paymentStatus == PaymentStatus.UNPAID.id) {
            this.paymentStatus = PaymentStatus.UNPAID_CANCELLED.id
        } else if (paymentStatus == PaymentStatus.PAID_FOR_DEPOSIT.id) {
            this.paymentStatus = PaymentStatus.REFUND_DEPOSIT.id
        } else if (paymentStatus == PaymentStatus.PAID_FOR_FULLPRICE.id) {
            this.paymentStatus = PaymentStatus.REFUND_FULLPRICE.id
        }
        updateDisplayStatus()

        if(organizer){
            def oldGroup = LxGroup.findByOrganizer(organizer)
            oldGroup.removeOrderFromGroup(this)
            commission = null
            organizer = null
        }
    }

    def boolean pendingPayForDeposit() {
        if (batch.isPresales() && paymentStatus == PaymentStatus.UNPAID.id) {
            return true
        }
        return false
    }

    def boolean pendingPayForFullPrice() {
        if (!batch.isPresales()) {
            return true
        }
        return false
    }

    def boolean pendingPayForMarketPrice() {
        if (!batch.isPresales() &&
                paymentStatus == PaymentStatus.UNPAID.id) {
            return true
        }
        return false
    }

    def boolean paidForFullPrice(){
        return paymentStatus == PaymentStatus.PAID_FOR_FULLPRICE.id
    }

    def currentPrice() {
        if (pendingPayForDeposit()) {
            totalDeposit()
        } else if (pendingPayForFullPrice()) {
            totalPrice()
        } else {
            totalMarketPrice()
        }
    }

    def refundPrice() {
        if (paymentStatus == PaymentStatus.UNPAID.id) {
            0
        } else if (paymentStatus == PaymentStatus.PAID_FOR_DEPOSIT.id) {
            totalDeposit()
        } else {
            orderPrice * quantity
        }
    }

    def currentUnitPrice() {
        if (pendingPayForDeposit()) {
            orderDeposit
        } else if (pendingPayForFullPrice()) {
            orderPrice
        } else {
            batch.price
        }
    }

    def futurePrice() {
        if (pendingPayForDeposit()) {
            totalPrice()
        } else {
            0
        }
    }

    def String toPayBody() {
        String payBody = "${product.title} ${batch.title}"
        payBody = payBody.length() > 60 ? payBody.substring(0, 60) + "..." :  payBody
        payBody
    }

    def addToPayments(payment) {
        new ProductOrderPayments(payment: payment, productOrder: this).save()
        return this
    }

    def payments() {
        ProductOrderPayments.findAllByProductOrder(this)*.payment
    }

    def getPaymentStatusName() {
        PaymentStatus.valueOf(paymentStatus).name
    }

    def getDeliveryStatusName() {
        DeliveryStatus.valueOf(deliveryStatus).name
    }

    def isInDelivery(){
        DeliveryStatus.valueOf(deliveryStatus) == DeliveryStatus.PROCESSING
    }

    def isRefundable(){
        DisplayStatus.findByName(displayStatus).refundable
    }

    def addressChangable(){
        paymentStatus <= PaymentStatus.PAID_FOR_FULLPRICE.id && deliveryStatus < DeliveryStatus.PROCESSING.id
    }

    def displayStatusDesc(){
        DisplayStatus.findByName(displayStatus).description
    }
    def displayStatusName(){
        DisplayStatus.findByName(displayStatus).name
    }

    def Collection deliverDateList(){
        def orderCutOffTime = DateUtils.addHours(DateUtils.addDays(new Date(), 1), 6)
        def category = product.category
        deliverDateList(category.toDeliverDaysInWeekArr(), orderCutOffTime, category.specialDays)
    }

    def Collection deliverDateList(deliveryDaysInWeek, orderCutOffTime, specialDays) {
        def twoWeek = new Date().clearTime() + 30
        def start = orderCutOffTime > batch.productionDate ? orderCutOffTime: batch.productionDate
        start = start > start.clearTime() ? start.clearTime() + 1 : start + 1
        def end = twoWeek
        if(batch.soldDeadline){
            end = batch.soldDeadline < twoWeek ? batch.soldDeadline : twoWeek
        }
        if(start >= end){
            return []
        }
        def dates = []
        (start..end).each{ date->
            def cal = Calendar.getInstance()
            cal.setTime(date)
            def dayOfWeek = cal.get(Calendar.DAY_OF_WEEK)
            if(deliveryDaysInWeek.contains(dayOfWeek)){
                dates << [date: FormatUtil.formatDate(date), dayInWeek: dayOfWeek, dayInWeekStr: FormatUtil.formatDayInWeek(dayOfWeek)]
            }
        }
        if(dates.size()>10){
            dates = dates.subList(0, 10)
        }
        if (specialDays) {
            specialDays.each { specialDay ->
                if (specialDay.type == SpecialDay.TYPE_EXCLUDE_DAY) {
                    dates.removeAll { it.date == FormatUtil.formatDate(specialDay.date) }
                } else if (specialDay.type == SpecialDay.TYPE_INCLUDE_DAY) {
                    def cal = Calendar.getInstance()
                    cal.setTime(specialDay.date)
                    def dayOfWeek = cal.get(Calendar.DAY_OF_WEEK)
                    dates << [date        : FormatUtil.formatDate(specialDay.date), dayInWeek: dayOfWeek,
                              dayInWeekStr: FormatUtil.formatDayInWeek(dayOfWeek), remark: specialDay.remark]
                } else if (specialDay.type == SpecialDay.TYPE_HOLIDAY) {
                    def date = dates.find { it.date == FormatUtil.formatDate(specialDay.date) }
                    if (date) date.remark = specialDay.remark
                }
            }
            dates.sort { a, b -> FormatUtil.parseDate(a.date) <=> FormatUtil.parseDate(b.date) }
        }
        return dates
    }

    def discountNumber(){
        discount == 0 ? null : FormatUtil.trimZero((1 - discount) * 10 as String) //折
    }

    @Override
    public String toString() {
        "订单:${id}-状态:${DisplayStatus.findByName(displayStatus).description}-" +
                "支付状态;${PaymentStatus.valueOf(paymentStatus).name}-" +
                "发货状态:${DeliveryStatus.valueOf(deliveryStatus).name}"
    }


    def remindForPayment(){
        if(paymentStatus == PaymentStatus.PAID_FOR_DEPOSIT.id){
            def userInfo = userInfo
            def weChatFans = userInfo.weChatFans

            //send sms and send wechat template message to inform user
            try{
                templateMessageService.sendRemindPaymentMsg(weChatFans.openId,
                        productOrderDetailLink(),
                        orderPrice,
                        toPayBody(),
                        batch.productionDate,
                        id,
                        batch.paymentDate + batch.paymentDuration - 1,
                        discountNumber()
                )
            }catch (err){
                log.error("Fail to publish wechat template message", err)
            }

            try{
                mobileMsgService.remindForPay(userInfo.mobile,
                        toPayBody(),
                        FormatUtil.formatDate(batch.paymentDate + batch.paymentDuration - 1),
                        discountNumber())
            }catch(err){
                log.error("Fail to publish sms template message", err)
            }

            log.info("Inform user (mobile: ${userInfo.mobile}, openId: ${weChatFans.openId}), to pay for the order")
        }else{
            log.info("Order no need to remind.")
        }
    }

    def productOrderDetailLink(){
        def openId = userInfo?.weChatFans?.openId
        "http://xunzhenji.net/h5/home?orderId=${id}&openId=${openId}#order-detail-panel"
    }

    def remindDelivery(){
        log.info("Remind delivery, orderId: ${id}")
        if(deliveryStatus == DeliveryStatus.PROCESSING.id){
            def weChatFans = userInfo.weChatFans
            Delivery delivery = DeliveryProductOrders.findByProductOrder(this)?.delivery
            def daysLeft = FormatUtil.formatCountingDate(delivery.targetDeliveryDate)

            //send sms and send wechat template message to inform user
            try{
                templateMessageService.sendDeliveryReminder(weChatFans.openId,
                        "http://xunzhenji.net/h5/home?orderId=${id}&openId=${weChatFans.openId}#order-detail-panel",
                        toPayBody(),
                        FormatUtil.formatSimpleDate(delivery.targetDeliveryDate) + "(${daysLeft})",
                        fullPrice(),
                        delivery.address.toFullAddress()
                )
            }catch (err){
                log.error("Fail to publish wechat template message", err)
            }

            if(delivery){
                try{
                    mobileMsgService.remindDelivery(delivery.address.phone,
                            toPayBody(),
                            FormatUtil.formatSimpleDate(delivery.targetDeliveryDate) + "(${daysLeft})"
                    )
                }catch(err){
                    log.error("Fail to publish sms template message", err)
                }
            }else{
                log.error("Cannot find deliver")
                return
            }
            log.info("Inform user (mobile: ${userInfo.mobile}, openId: ${weChatFans.openId}), to get ready for delivery")
        }else{
            log.info("Order no need to remind for delivery.")
        }
    }

    def confirmDeliveryTime() {
        log.info("Confirm delivery time, orderId: ${id}")
        if (deliveryStatus == DeliveryStatus.CONFIRM_DELIVER_DATE.id) {
            def weChatFans = userInfo.weChatFans
            Delivery delivery = DeliveryProductOrders.findByProductOrder(this)?.delivery

            //send sms and send wechat template message to inform user
            try {
                templateMessageService.sendConfirmDeliveryTime(weChatFans.openId,
                        "http://xunzhenji.net/h5/home?orderId=${id}&openId=${weChatFans.openId}#order-detail-panel",
                        toPayBody(),
                        FormatUtil.formatSimpleDate(delivery.targetDeliveryDate),
                        FormatUtil.formatSimpleDate(delivery.targetDeliveryDate - 2),
                        fullPrice(),
                        delivery.address.toFullAddress()
                )
            } catch (err) {
                log.error("Fail to publish wechat template message", err)
            }
//
//            if(delivery){
//                try{
//                    mobileMsgService.remindDelivery(delivery.address.phone,
//                            toPayBody(),
//                            FormatUtil.formatSimpleDate(delivery.targetDeliveryDate) + "(${daysLeft})"
//                    )
//                }catch(err){
//                    log.error("Fail to publish sms template message", err)
//                }
//            }else{
//                log.error("Cannot find deliver")
//                return
//            }
//            log.info("Inform user (mobile: ${userInfo.mobile}, openId: ${weChatFans.openId}), to get ready for delivery")
        } else {
            log.info("Order no need to remind for delivery.")
        }
    }

    /*
     * @restQuantity the remaining quantity in original order, it cannot be more than the original order quantity
     */
    def split(int remainQuantity){
        if(quantity > remainQuantity){
            ProductOrder newOrder = new ProductOrder()
            newOrder.properties = this.properties
            def product
            newOrder.id = null
            newOrder.quantity = quantity - remainQuantity
            this.quantity = remainQuantity
            return newOrder
        }else if(quantity == remainQuantity){
            log.error("Cannot totally move quantity to another order.")
        }else{
            log.error("Remaining quantity cannot be more than original quantity. Original quantity: ${quantity}, Remind quantity: ${remainQuantity}")
        }
        return null
    }

    Delivery delivery(){
        DeliveryProductOrders.findByProductOrder(this)
    }

    /**
     * @param deliveryDate
     * @return true - success update delivery date; false - skip update or error
     */
    def updateDeliveryDate(Date deliveryDate, String updateBy) {
        return updateDelivery(address, deliveryDate, updateBy)
    }

    def updateDeliveryAddress(Address newAddress, String updateBy) {
        Delivery currentDelivery = DeliveryProductOrders.getDeliveryByOrder(this)
        return updateDelivery(newAddress, currentDelivery?.targetDeliveryDate, updateBy)
    }

    @Transactional
    def updateDelivery(Address address, Date deliveryDate, String updateBy) {
        Delivery currentDelivery = DeliveryProductOrders.getDeliveryByOrder(this)
        if (currentDelivery &&
                currentDelivery.targetDeliveryDate == deliveryDate &&
                currentDelivery.address == address
        ) {
            return false
        }

        if (organizer) { //groupon, update it to another delivery from the group
            LxGroup lxGroup = LxGroupProductOrder.getLxGroupByOrder(this)
            def deliveries = lxGroup.getDeliveryByDate(deliveryDate)
            if (deliveries) {
                deliveries.each {
                    new DeliveryProductOrders(delivery: it, productOrder: this).save()
                    it.save()
                }
            } else {
                // organizer may not available
                return false
            }
        } else { // create another delivery for this order
            def delivery = new Delivery(targetDeliveryDate: deliveryDate, address: address,
                    receiver: userInfo, isGroupon: false, batch: batch, express: product.express)
            delivery.save()
            new DeliveryProductOrders(delivery: delivery, productOrder: this).save(flush: true)
        }

        if (currentDelivery?.targetDeliveryDate != deliveryDate) {
            confirmDeliveryDate()
        }

        deliveryArrangedBy = updateBy
        if (currentDelivery) {
            DeliveryProductOrders.findByProductOrderAndDelivery(this, currentDelivery).delete()
            DeliveryRouteInfo.findAllByDelivery(currentDelivery)*.delete()
            currentDelivery.delete()
        }

        return true
    }

    String toBriefText(){
        "${FormatUtil.formatSimpleDate(orderDate)} ${product.title} ${batch.title} ${quantity}件 ${DisplayStatus.findByName(displayStatus).description}"
    }
}
