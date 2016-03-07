package net.xunzhenji.mall

import grails.transaction.Transactional
import net.xunzhenji.model.PaymentStatus
import net.xunzhenji.security.PersonAuthority
import net.xunzhenji.wechat.WeChatFans

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class UserInfoController {
    def weChatPayService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        log.info("Query userinfo: ${params}")
        params.max = Math.min(max ?: 20, 100)
        def fans
        def list = UserInfo.createCriteria().list(params){
            if (params.name || params.mobile || params.openId) {
                and {
                    if (params.userId) eq("userId", params.name)
                    if (params.name) ilike("name", "%${params.name}%")
                    if (params.mobile) eq("mobile", params.mobile)
                    if (params.openId) {
                        fans = WeChatFans.findByOpenId(params.openId)
                        eq("weChatFans", fans)
                    }
                }
            }
        }

        def count = UserInfo.createCriteria().get {
            if (params.name || params.mobile || params.openId) {
                and {
                    if (params.userId) eq("userId", params.name)
                    if (params.name) eq("name", params.name)
                    if (params.mobile) eq("mobile", params.mobile)
                    if (params.openId) {
                        eq("weChatFans", fans)
                    }
                }
            }
            projections{
                rowCount()
            }
        }
        def fansCount = WeChatFans.count()
        def visitCount = WeChatFans.executeQuery("select sum(visitCount) from WeChatFans")[0]
        def orderCount = ProductOrder.executeQuery("select sum(quantity) from ProductOrder where paymentStatus in (?, ?)",
                [PaymentStatus.PAID_FOR_DEPOSIT.id, PaymentStatus.PAID_FOR_FULLPRICE.id])[0]
        def fansSendToFriendsCount = WeChatFans.executeQuery("select sum(shareToFriendsCount) from WeChatFans")[0]
        def fansShareToTimelineCount = WeChatFans.executeQuery("select sum(shareToTimelineCount) from WeChatFans")[0]
        def subscribeCount = WeChatFans.countBySubscribe(1)

        respond list, model: [userInfoInstanceCount: count,
                              id: params.id,
                              name                 : params.name,
                              mobile               : params.mobile,
                              openId               : params.openId,
                              fansSendToFriendsCount  : fansSendToFriendsCount,
                              fansShareToTimelineCount: fansShareToTimelineCount,
                              subscribeCount: subscribeCount,
                              fansCount     : fansCount,
                              visitCount    : visitCount,
                              orderCount    : orderCount
        ]
    }

    def show(UserInfo userInfoInstance) {
        respond userInfoInstance
    }

    def edit(UserInfo userInfoInstance) {
        respond userInfoInstance
    }

    @Transactional
    def update(UserInfo userInfoInstance) {
        if (userInfoInstance == null) {
            notFound()
            return
        }

        if (userInfoInstance.hasErrors()) {
            respond userInfoInstance.errors, view:'edit'
            return
        }

        userInfoInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'userInfo.label', default: 'UserInfo'), userInfoInstance.id])
                redirect userInfoInstance
            }
            '*'{ respond userInfoInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(UserInfo userInfoInstance) {

        if (userInfoInstance == null) {
            notFound()
            return
        }
        def person = userInfoInstance.person
        def orders = userInfoInstance.orders
        def payments = userInfoInstance.payments
        def shoppingCartOrders = userInfoInstance.shoppingCart?.productOrders
        def fans = userInfoInstance.weChatFans
        def suggestions = Suggestion.findAllByWeChatFans(fans)
        def lxGroupMembers = LxGroupMembers.findAllByUserInfo(userInfoInstance)
        def lxGroups = LxGroup.findAllByOrganizer(userInfoInstance)

        UserInfo.withTransaction {
            if (person) PersonAuthority.removeAll(person)
            payments.each { payment ->
                def pop = ProductOrderPayments.findAllByPayment(payment)
                ProductOrderPayments.deleteAll(pop)
            }
            shoppingCartOrders.each { order ->
                def pop = ProductOrderPayments.findAllByProductOrder(order)
                ProductOrderPayments.deleteAll(pop)
            }
            ProductOrder.deleteAll(shoppingCartOrders)
            ProductOrder.deleteAll(orders)
            Payment.deleteAll(payments)
            Suggestion.deleteAll(suggestions)
            userInfoInstance.groupDefaultAddress = null
            userInfoInstance.myDefaultAddress = null
            LxGroupMembers.deleteAll(lxGroupMembers)
            LxGroup.deleteAll(lxGroups)

            fans?.delete()
            userInfoInstance?.delete()

            person?.delete()
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'userInfo.label', default: '用户信息'), userInfoInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'userInfo.label', default: 'UserInfo'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def sendCoupon() {
        log.info("Send coupon, openId: ${params.openId}, couponStockId: ${params.stockId}")
        if (!params.stockId) {
            redirect(action: "index")
            return
        }
        weChatPayService.sendCoupon(params.openId, params.stockId)
        redirect(action: "index")
    }
}
