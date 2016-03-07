/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

class Payment {
    public static final String TYPE_WECHAT = "WECHAT"
    public static final String TYPE_ALIPAY = "ALIPAY"
    public static final String TYPE_ACCOUNT = "ACCOUNT"
    public static final String TYPE_COUPON = "COUPON"

    public static final String STATUS_UNPAID = "UNPAID"
    public static final String STATUS_PAID = "PAID"
    public static final String STATUS_NOTIFIED = "NOTIFIED"
    public static final String STATUS_RECONCILED = "RECONCILED"

    public static final String CASH_FLOW_DIRECTION_IN = 'IN'
    public static final String CASH_FLOW_DIRECTION_OUT = 'OUT'

    def String type = TYPE_WECHAT
    def String cashFlowDirection
    def String prepayId
    def String outTradeNo       //商户订单号
    def String transactionId    //微信支付单号
    def String status = STATUS_UNPAID
    def BigDecimal amount  //total_fee, 总金额，包括微信支金额和使用消费账户的余额， 单位：元; amount = cashFee + balanceAmount
    def BigDecimal cashFee //现金支付金额， 单位：元
    def BigDecimal balanceAmount //使用余额的金额, 单位：元
    def Date timeEnd // 支付完成时间
    def String resultCode //业务结果
    def String errCode // 错误代码
    def String errCodeDes //错误代码描述
    def String openid
    def String isSubscribe //是否关注公众账号
    def String tradeType //交易类型
    def String bankType //付款银行

    def Date dateCreated

    def String appId //微信叫AppId，支付宝叫PartnerId
    def String signType // MD5, RSA, DSA
    def String sign
    def String subject
    def String detail

    static constraints = {
        prepayId nullable: true
        timeEnd nullable: true
        transactionId nullable: true
        cashFee nullable: true
        balanceAmount nullable: true
        errCode nullable: true
        errCodeDes nullable: true
        resultCode nullable: true
        isSubscribe nullable: true
        tradeType nullable: true
        bankType nullable: true
        openid nullable: true

        appId nullable: true
        signType nullable: true
        sign nullable: true
        subject nullable: true
        detail nullable: true
    }

    def static Payment createCustomerPayment(params) {
        createCustomerPayment(params.prepayId,
                params.outTradeNo,
                params.amount,
                params.cashFee,
                params.openid,
                params.isSubscribe,
                params.balanceAmount,
                params.type,
                params.appId,
                params.signType,
                params.sign,
                params.notifyUrl,
                params.returnUrl,
                params.subject,
                params.detail)
    }

    def static Payment createCustomerPayment(prepayId,
                                             outTradeNo,
                                             amount,
                                             cashFee,
                                             openid,
                                             isSubscribe,
                                             balanceAmount,
                                             type,
                                             appId,
                                             signType,
                                             sign,
                                             notifyUrl,
                                             returnUrl,
                                             subject,
                                             detail) {
        new Payment(cashFlowDirection: CASH_FLOW_DIRECTION_IN,
                prepayId: prepayId,
                outTradeNo: outTradeNo,
                amount: amount,
                cashFee: cashFee,
                openid: openid,
                isSubscribe: isSubscribe,
                balanceAmount: balanceAmount,
                type: type,
                appId: appId,
                signType: signType,
                sign : sign,
                notifyUrl : notifyUrl,
                returnUrl : returnUrl,
                subject : subject,
                detail : detail)
    }

    def static Payment createDepositPayment(params) {
        createDepositPayment(params.prepayId, params.outTradeNo, params.amount, params.openid, params.isSubscribe)
    }

    def static Payment createDepositPayment(prepayId, outTradeNo, BigDecimal amount, openid, isSubscribe) {
        new Payment(cashFlowDirection: CASH_FLOW_DIRECTION_IN,
                prepayId: prepayId,
                outTradeNo: outTradeNo,
                amount: amount,
                cashFee: amount,
                openid: openid,
                isSubscribe: isSubscribe,
                balanceAmount: -1 * amount)
    }

    def static Payment createRefundPayment(params) {
        createRefundPayment(params.outRefundNo, params.amount, params.openid, params.isSubscribe)
    }

    def static Payment createRefundPayment(outRefundNo, amount, openid, isSubscribe) {
        new Payment(outTradeNo: outRefundNo, cashFlowDirection: CASH_FLOW_DIRECTION_OUT,
                amount: amount, cashFee: amount, isSubscribe: isSubscribe, openid: openid, balanceAmount: 0)
    }

    def addToProductOrders(productOrder) {
        new ProductOrderPayments(payment: this, productOrder: productOrder).save()
        return this
    }

    def productOrders() {
        ProductOrderPayments.findAllByPayment(this)*.productOrder
    }

    @Override
    public String toString() {
        "支付${amount}元 : ${id}"
    }

    def getPaymentTypeString() {
        if (type == TYPE_WECHAT) {
            return "微信支付"
        } else if (type == TYPE_ALIPAY) {
            return "支付宝"
        } else if (type == TYPE_ACCOUNT) {
            return "账户余额"
        } else if (type == TYPE_COUPON) {
            return "优惠券支付"
        }
    }
}
