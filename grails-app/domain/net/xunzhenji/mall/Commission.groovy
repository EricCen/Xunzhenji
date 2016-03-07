/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */
package net.xunzhenji.mall

import net.xunzhenji.mall.ProductOrder
import org.h2.engine.User

class Commission {
    static enum CommissionState {
        STATE_UNREALISED(0, "未确定"),     //顾客未付全款，而且付款期还没有结束。无论成团或为成团，只要未付款都是未确定状态
        STATE_REALISED(10, "已确定"),      //顾客已付全款，付款期已经结束
        STATE_EXTRACTABLE(20, "可提取"),  //商品已经成功领鲜，并且订单生命周期结束
        STATE_DONE(30, "已提取"),          //佣金已经被提取
        STATE_CANCELLED(40, "已取消");     //顾客在付款期内没付款，或者退订了

        def int id
        def String description

        CommissionState(id, description) {
            this.id = id
            this.description = description
        }

        public static CommissionState valueOf(int id) {
            CommissionState.values().find { it.id == id }
        }
    }

    BigDecimal amount
    int state = CommissionState.STATE_UNREALISED.id
    UserInfo organizer
    UserInfo buyer
    String buyerName
    String buyerHeadImgUrl
    String productName
    Date lastUpdated
    Date dateCreated

    static belongsTo = [productOrder: ProductOrder]

    static hasMany = [commissionEvents: CommissionEvent]

    static constraints = {
        buyerHeadImgUrl nullable: true
    }

    def cancel() {
        def originalAmt = amount
        amount = BigDecimal.ZERO
        state = Commission.CommissionState.STATE_CANCELLED.id
        createCommissionEvent(CommissionEvent.EVENT_CANCEL, -1 * originalAmt)
    }

    def unrealise(){
        state = Commission.CommissionState.STATE_UNREALISED.id
        createCommissionEvent(CommissionEvent.EVENT_REALISE, 0)
    }
    def realise() {
        state = Commission.CommissionState.STATE_REALISED.id
        createCommissionEvent(CommissionEvent.EVENT_REALISE, 0)
    }

    def extractable(){
        state = Commission.CommissionState.STATE_EXTRACTABLE.id
    }

    def extractCommission(){
        state = Commission.CommissionState.STATE_DONE.id
    }

    def createCommissionEvent(event) {
        createCommissionEvent(event, null)
    }

    def createCommissionEvent(event, amt) {
        if (!commissionEvents) commissionEvents = []
        commissionEvents << new CommissionEvent(event: event, amount: amt ? amt : amount, state: state, organizer: organizer, commission: this)
    }

    def getCommissionStateName(){
        CommissionState.valueOf(state).description
    }

    def isRealised(){
        state == CommissionState.STATE_REALISED.id
    }

    def isUnrealised(){
        state == CommissionState.STATE_UNREALISED.id
    }

    def isCancelled(){
        state == CommissionState.STATE_CANCELLED.id
    }

    def static todayCommission(Collection<Commission> commissions) {
        return commissions.inject(0) { result, commission ->
            if (commission.dateCreated > new Date().clearTime() &&
                    commission.state != CommissionState.STATE_CANCELLED) {
                result += commission.amount
            }
            result
        }
    }

    def static stateOfCommission(Collection<Commission> commissions, CommissionState state) {
        return commissions.inject(0) { result, commission ->
            if (commission.state == state.id) {
                result += commission.amount
            }
            result
        }
    }

    def static daysRangeOfCommission(Collection<Commission> commissions, int days) {
        return commissions.inject(0) { result, commission ->
            if (commission.dateCreated >= (new Date() - days).clearTime() &&
                    commission.state != CommissionState.STATE_CANCELLED) {
                result += commission.amount
            }
            result
        }
    }

    def static totalCommission(Collection<Commission> commissions) {
        return commissions.inject(0) { result, commission ->
            if (commission.state != CommissionState.STATE_CANCELLED) {
                result += commission.amount
            }
            result
        }
    }
}
