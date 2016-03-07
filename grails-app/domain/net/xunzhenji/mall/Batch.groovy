/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

import net.xunzhenji.model.PaymentStatus
import net.xunzhenji.util.FormatUtil
import org.apache.commons.lang.time.DateFormatUtils

class Batch {
    def orderService

    def static final String FULL_DATE_PATTERN = "yyyy-MM-dd";
    def static final String SIMPLE_DATE_PATTERN = "MM-dd";

    static enum BatchState {

        CURRENT_STATE_PRESALES(0, "预售期[prepayEnd]结束 (还剩[daysToPayment]天)"),
        CURRENT_STATE_IN_PAYMENT_WINDOW(10, "截止预订了,按市场价销售"),
        CURRENT_STATE_AFTER_PAYMENT_DAY(20, "截止预订了,按市场价销售"),
        CURRENT_STATE_AFTER_PRODUCTION_DAY(30, "现货销售,数量有限"),
        CURRENT_STATE_SOLD_OUT(40, "已售罄")

        int state
        String description

        BatchState(int state, String description) {
            this.state = state;
            this.description = description;
        }

        public static BatchState valueOf(int state) {
            BatchState.values().find { it.state == state }
        }
        def static matchAndDo(int state, Closure closure){
            def batchState = valueOf(state)
            if(batchState) closure.call(batchState)
        }
    }

    def Date productionDate
    def Date paymentDate
    def Date birthday
    def Date soldDeadline //截至发货时间
    def String title
    def BigDecimal price
    def BigDecimal discount
    def BigDecimal cost //成本，不对外显示
    def BigDecimal unitAllowance //补贴比例，用于领鲜群的补贴。补贴金额=省出来的快递费×补贴比例
    def int paymentDuration = 7
    def int batchState = BatchState.CURRENT_STATE_PRESALES.state
    long quantityInStore = 0      //库存
    def Boolean display = Boolean.TRUE
    def Boolean calcDiscount = Boolean.TRUE
    def int productPageWeight = 0

    static belongsTo = [product:Product]

    static hasMany = [orders:ProductOrder]

    static constraints = {
        title nullable: true
        price nullable: true
        discount nullable: true
        cost nullable: true
        unitAllowance nullable: true
        birthday nullable: true
        soldDeadline nullable: true
    }

    static mapping = {
        sort "productPageWeight", order: 'desc'
    }

    def productionFullDate(){
        DateFormatUtils.format(productionDate, FULL_DATE_PATTERN)
    }

    def productionSimpleDate(){
        DateFormatUtils.format(productionDate, SIMPLE_DATE_PATTERN)
    }

    def paymentFullDate(){
        DateFormatUtils.format(paymentDate, FULL_DATE_PATTERN)
    }
    def paymentSimpleDate(){
        DateFormatUtils.format(paymentDate, SIMPLE_DATE_PATTERN)
    }

    def int daysToProduction(){
        daysToProduction(new Date())
    }

    def int daysToProduction(now){
        (productionDate - now) as int
    }

    def int daysToPayment(){
        daysToPayment(new Date())
    }

    def int daysToPayment(now){
        (paymentDate - now) as int
    }

    def updateDiscountPrice(){
        updateDiscountPrice(new Date())
    }

    def updateDiscountPrice(now){
        if(!calcDiscount){
            return
        }

        def daysToProduction = daysToProduction(now)
        if(isPresales(now) && daysToProduction>=0){
            def weeks = BigDecimal.valueOf(daysToProduction / 7.0).setScale(0, BigDecimal.ROUND_DOWN) as int
            discount = weeks * product.weeklyDiscount
            price = (product.price * (1 - discount) as BigDecimal).setScale(0, BigDecimal.ROUND_UP)
        }else{
            if(discount){
                discount = 0
                price = product.price
            }
        }
    }

    def updateBatchState(){
        if(!calcDiscount){
            return
        }
        if(isPresales()) {
            batchState = BatchState.CURRENT_STATE_PRESALES.state
        }else if(isInPaymentWindow()){
            batchState = BatchState.CURRENT_STATE_IN_PAYMENT_WINDOW.state
        }else if(isAfterPaymentButNotYetLive()){
            if(batchState == BatchState.CURRENT_STATE_IN_PAYMENT_WINDOW.state){
                orders.each{ order->
                    if(order.paymentStatus == PaymentStatus.PAID_FOR_DEPOSIT){
                        orderService.refundDeposit(order)
                    }
                }
            }
            batchState = BatchState.CURRENT_STATE_AFTER_PAYMENT_DAY.state
        }else{
            if(quantityInStore > 0){
                batchState = BatchState.CURRENT_STATE_AFTER_PRODUCTION_DAY.state
            }else{
                batchState = BatchState.CURRENT_STATE_SOLD_OUT.state
            }
        }
    }

    def updatePayableOrders(){
        if(batchState == BatchState.CURRENT_STATE_IN_PAYMENT_WINDOW.state){
            Batch.withTransaction {
                orders.each{ order->
                    UserInfo u = order.userInfo
                    if(!u){ // the order not yet pay at all, only in shopping cart
                        return
                    }
                    ShoppingCart shoppingCart = u.shoppingCart
                    if(!shoppingCart.productOrders.contains(order)){
                        shoppingCart.addToProductOrders(order)
                    }
                    shoppingCart.save()
                }
            }
        }
    }

    def updateUnpaidOrdersPrice(){
        orders.findAll{ it.paymentStatus == PaymentStatus.UNPAID.id}.each{ order->
            if(batchState == BatchState.CURRENT_STATE_PRESALES.state){
                order.orderPrice = price
                order.discount = discount
            } else {
                if (calcDiscount) {
                    order.orderPrice = product.price
                } else {
                    order.orderPrice = price
                }
                order.discount = 0
            }
        }
    }
    def currentPrice() {
        if (isPresales()) {
            return product.deposit
        } else{
            return price
        }
    }

    def isPresales(){
        isPresales(new Date())
    }

    def isPresales(now){
        paymentDate > now
    }
    /*
     * 订货的客户可以付全额货款
     */
    def isInPaymentWindow(){
        def now = new Date()
        paymentDate < now && (paymentDate + paymentDuration) > now
    }

    /*
     * 付款窗口已过但未上市
     */
    def isAfterPaymentButNotYetLive(){
        def now = new Date()
        (paymentDate + paymentDuration) < now && productionDate > now
    }

    /*
     * 已经上市了
     */
    def isAfterLive(){
        def now = new Date()
        productionDate < now
    }

    def currentState(){
        def stateText
        BatchState.matchAndDo(batchState){ BatchState state->
            if(isPresales()){
                stateText = state.description.replace("[daysToPayment]", String.valueOf(daysToPayment()))
                        .replace("[prepayEnd]", String.valueOf(DateFormatUtils.format(paymentDate - 1, SIMPLE_DATE_PATTERN)))
            }else{
                stateText = state.description
            }
        }
    }

    def isAfterProduction(){
        batchState < BatchState.CURRENT_STATE_AFTER_PRODUCTION_DAY.state
    }

    def discountNumber(){
        discount == 0 ? null : FormatUtil.trimZero((1 - discount) * 10 as String) //折
    }
    @Override
    public String toString(){
        "${title} : ${id}"
    }
}
