package net.xunzhenji.mall

import grails.transaction.Transactional
import net.xunzhenji.util.*
import net.xunzhenji.wechat.WeChatContext
import net.xunzhenji.wechat.WeChatFans

@Transactional
class PaymentService {
    def weChatPayService
    def templateMessageService
    def alipayService

    def pay(orders, useBalance, paymentType, clientIp) {
        UserInfo userInfo = SessionUtil.userInfo?.refresh()
        if (OrderUtil.totalPrice(orders) > 0) {
            if (paymentType == Payment.TYPE_ALIPAY) {
                return processPay(orders, useBalance, processAliPay, clientIp, userInfo)
            } else {
                return processPay(orders, useBalance, processWeChatPay, clientIp, userInfo)
            }
        } else {
            return processPay(orders, useBalance, processCouponPay, clientIp, userInfo)
        }
    }


    def processPay(orders, useBalance, payMethod, clientIp, UserInfo userInfo) {
        def payBody = OrderUtil.convertPayBody(orders)
        if (!payBody) {
            return [errorcode: -1, error: ErrorCodeUtil.failToGeneratePayBody()]
        }

        WeChatFans fans = userInfo?.weChatFans

        def totalAmount = orders.sum { it.currentPrice() } as BigDecimal
        def payAmount = totalAmount
        def outTradeNo = IdGenerator.generateWxTradeId()
        def useBalanceAmt = 0

        if (useBalance) {
            if (totalAmount >= userInfo.balance) {
                useBalanceAmt = userInfo.balance
                payAmount = totalAmount - useBalanceAmt
            } else {
                useBalanceAmt = totalAmount
                payAmount = 0
            }
        }

        def payInfo, payment
        if (payAmount > 0) {       //需要微信支付
            def detail = OrderUtil.covertPayDetail(orders)
            payInfo = payMethod.call(outTradeNo, payBody, detail, totalAmount, payAmount, fans, clientIp)
            payment = payInfo.payment
        } else { //all amount use balance
            payment = Payment.createCustomerPayment(
                    outTradeNo: outTradeNo,
                    amount: totalAmount,
                    cashFee: 0,
                    openid: fans?.openId,
                    isSubscribe: fans ? fans.subscribe : 0,
                    balanceAmount: useBalanceAmt,
                    type: Payment.TYPE_ACCOUNT
            )
            WeChatContext context = WeChatContext.defaultContext()
            payInfo = [appId     : context.appId,
                       timeStamp : new Date(),
                       nonceStr  : SignUtil.create_nonce_str(),
                       outTradeNo: outTradeNo
            ]
        }

        Payment.withTransaction {
            payment.save()
            userInfo.addToPayments(payment).save()
            orders.each { order ->
                order.addToPayments(payment)
                order.lastPayment = payment
                if (order.pendingPayForDeposit()) {
                    order.depositPayment = payment
                } else if (order.pendingPayForFullPrice()) {
                    order.fullPricePayment = payment
                }
                order.save()
            }
        }
        log.info("Pay info: ${payInfo}")
        return [errorcode: 0, data: [appId      : payment.appId,
                                     timeStamp  : payInfo.timeStamp,
                                     nonceStr   : payInfo.nonceStr,
                                     pkg        : payInfo.package,
                                     signType   : payment.signType,
                                     paySign    : payment.sign,
                                     prepayId   : payment.prepayId,
                                     amount     : totalAmount,
                                     payAmount  : payAmount,
                                     outTradeNo : outTradeNo,
                                     subscribe  : userInfo?.weChatFans.subscribe,
                                     paymentType: payment.type
        ]]
    }

    def processCouponPay = { outTradeNo,
                             payBody,
                             detail,
                             totalAmount,
                             payAmount,
                             fans,
                             clientIp ->
        def payment = Payment.createCustomerPayment(
                outTradeNo: outTradeNo,
                amount: totalAmount,
                cashFee: 0,
                openid: fans?.openId,
                isSubscribe: fans ? fans.subscribe : 0,
                balanceAmount: 0,
                type: Payment.TYPE_COUPON
        )
        WeChatContext context = WeChatContext.defaultContext()
        def payInfo = [appId     : context.appId,
                       timeStamp : new Date(),
                       nonceStr  : SignUtil.create_nonce_str(),
                       outTradeNo: outTradeNo,
                       payment   : payment
        ]
        return payInfo
    }

    def processWeChatPay = { outTradeNo,
                             payBody,
                             detail,
                             totalAmount,
                             payAmount,
                             fans,
                             clientIp ->

        def payInfo = weChatPayService.genPrepayOrder(payBody,
                detail,
                payAmount,
                outTradeNo,
                fans?.openId,
                clientIp)
        if (!payInfo) {
            return [errorcode: -1, error: ErrorCodeUtil.failToGenWxPreOrder()]
        }

        def prepayId = payInfo.package.split("=")[1]
        payInfo.prepayId = prepayId

        payInfo.payment = Payment.createCustomerPayment(
                prepayId: prepayId,
                outTradeNo: outTradeNo,
                amount: totalAmount,
                cashFee: payAmount,
                openid: fans?.openId,
                isSubscribe: fans ? fans.subscribe : 0,
                balanceAmount: totalAmount - payAmount,
                type: Payment.TYPE_WECHAT,
                appId: payInfo.appId,
                detail: detail,
                sign: payInfo.paySign,
                signType: payInfo.signType,
                subject: payInfo.payBody
        )
        return payInfo
    }

    def processAliPay = { outTradeNo,
                          payBody,
                          detail,
                          totalAmount,
                          payAmount,
                          fans,
                          clientIp ->
        def payInfo = alipayService.genPrepayOrder(payBody,
                detail,
                payAmount,
                outTradeNo,
                fans?.openId,
                clientIp)
        if (!payInfo) {
            return [errorcode: -1, error: ErrorCodeUtil.failToGenWxPreOrder()]
        }

        payInfo.payment = Payment.createCustomerPayment(
                prepayId: null,
                outTradeNo: outTradeNo,
                amount: totalAmount,
                cashFee: payAmount,
                openid: fans?.openId,
                isSubscribe: fans ? fans.subscribe : 0,
                balanceAmount: totalAmount - payAmount,
                type: Payment.TYPE_ALIPAY,
                appId: payInfo.partner,
                signType: payInfo.sign_type,
                sign: payInfo.sign,
                notifyUrl: payInfo.notify_url,
                returnUrl: payInfo.return_url,
                subject: payInfo.subject,
                detail: payInfo.body
        )
        return payInfo
    }

    @Transactional
    def paymentSuccess(prepayId, outTradeNo) {
        def payment
        if(prepayId){
            payment = Payment.findByPrepayId(prepayId)
        }else{
            payment = Payment.findByOutTradeNo(outTradeNo)
        }

        if (!payment) {
            return [errorcode: -1, error: ErrorCodeUtil.noPaymentFound()]
        }

        processPayment(payment)

        return [errorcode: 0, data: [payment: payment]]
    }

    @Transactional
    def processPayment(Payment payment){
        WeChatFans fans = WeChatFans.findByOpenId(payment.openid)
        UserInfo userInfo = fans.userInfo
        ShoppingCart shoppingCart = userInfo.shoppingCart
        if(!userInfo.orders || userInfo.orders.size() == 0){
            log.info("Deposit to user account after first order")
            userInfo.balance += 10
            userInfo.addToDepositRecords(new DepositRecord(amount: 10, channel: DepositRecord.Channel.CARD_DEPOSIT, remark: "首单后自动充值")).save()
            new Timer().schedule(new TimerTask() {
                @Override
                void run() {
                    templateMessageService.sendAutoDepositMsg(userInfo.weChatFans.openId,
                            "http://xunzhenji.net/h5/home?openId=${userInfo.weChatFans.openId}#my-account-panel", userInfo.balance, userInfo.balance)
                }
            }, 10000)
        }

        payment.status = Payment.STATUS_PAID
        log.info("Before deduct balance amount, balance: ${userInfo.balance}, used balance: ${payment.balanceAmount}")
        userInfo.balance = userInfo.balance - payment.balanceAmount //充值时balanceAmount为负数

        if(payment.balanceAmount < 0){
            userInfo.addToDepositRecords(new DepositRecord(amount: payment.amount, channel: DepositRecord.Channel.WECHAT_DEPOSIT, remark: "客户充值")).save()
            templateMessageService.sendDepositMsg(userInfo.weChatFans.openId,
                    "http://xunzhenji.net/h5/home?openId=${userInfo.weChatFans.openId}#my-account-panel", payment.amount, userInfo.balance)
        }

        Payment.withTransaction {
            PromotionCode promotionCode
            payment.productOrders().each { order ->
                if (!order.userInfo) {
                    order.userInfo = userInfo
                    order.orderDate = new Date() //update order date when payment success
                    userInfo.addToOrders(order).save()
                }
                order.pay()
                order.save()
                if (order.promotionCode) promotionCode = order.promotionCode
                shoppingCart?.removeFromProductOrders(order)
            }
            if (promotionCode) {
                promotionCode.addUsedCount()
                promotionCode.save()
            }
            payment.save()
            shoppingCart?.save()
            userInfo.save()
        }
    }

    def deposit(amount, clientIp) {
        UserInfo userInfo = SessionUtil.userInfo?.refresh()

        def payBody
        WeChatFans fans = SessionUtil.getSessionValue(SessionUtil.SESSION_WECHAT_FANS)
        payBody = "寻真记账户充值"

        def outTradeNo = IdGenerator.generateWxTradeId()
        //Generate trade id
        def payInfo = weChatPayService.genPrepayOrder(payBody,
                "寻真记账户充值${amount}元",
                amount as int,
                outTradeNo,
                fans?.openId,
                clientIp)

        if (!payInfo) {
            return null
        }

        def prepayId = payInfo.package.split("=")[1]
        payInfo.prepayId = prepayId
        def payment = Payment.createDepositPayment(
                prepayId: prepayId,
                outTradeNo: outTradeNo,
                amount: amount,
                openid: fans.openId,
                isSubscribe: fans.subscribe,
        )
        payment.save()
        userInfo.addToPayments(payment).save()

        log.info("Pay info: ${payInfo}")

        return [appId    : payInfo.appId,
                timeStamp: payInfo.timeStamp,
                nonceStr : payInfo.nonceStr,
                pkg      : payInfo.package,
                signType : payInfo.signType,
                paySign  : payInfo.paySign,
                prepayId : payInfo.prepayId]
    }
}
