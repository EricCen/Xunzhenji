/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

import grails.converters.JSON
import grails.transaction.Transactional
import net.xunzhenji.About
import net.xunzhenji.QrCode
import net.xunzhenji.QrCodeSetting
import net.xunzhenji.QrCodeSettingWeChatFans
import net.xunzhenji.alipay.AlipayContext
import net.xunzhenji.model.DeliveryStatus
import net.xunzhenji.model.DisplayStatus
import net.xunzhenji.util.*
import net.xunzhenji.wechat.WeChatContext
import net.xunzhenji.wechat.WeChatFans
import org.apache.commons.lang.time.DateFormatUtils

import static net.xunzhenji.mall.Commission.CommissionState.*

class H5Controller {
    def weChatBasicService
    def weChatPayService
    def locationService
    def paymentService
    def shoppingCartService
    def orderService
    def sessionService

    def home() {
        log.info("Enter h5 home page, params: ${params}")
        def products = Product.listOrderByHomePageWeight(order: "desc")
        def categories = Category.list()
        def weChatContext = WeChatContext.defaultContext()
        def ticket = weChatBasicService.getJsApiTicket()
        def url = "${params.requestUrl}${request.queryString ? "?" + request.queryString : ""}"
        log.info("Sign for url: ${url}")
        def signature = SignUtil.sign(ticket, url)
        signature.appId = weChatContext.appId

        if (params.redirectUrl) {
            redirect(url: params.redirectUrl)
            return
        }

        [products: products, categories: categories, signature: signature]
    }

    def producer(Producer producerInstance) {
        respond producerInstance
    }

    def batch(Batch batchInstance) {
        respond batchInstance
    }

    def widget(Product productInstance) {
        respond productInstance
    }

    def confirmOrder() {
        log.info("Confirm order, ${params}")
        UserInfo userInfo
        try {
            userInfo = SessionUtil.userInfo
            if (!userInfo) {
                redirect(controller: "h5", action: "home")
                return
            } else {
                userInfo = userInfo.refresh()
            }
        } catch (e) {
        }

        Collection<ProductOrder> orderList

        if (params.orderIds) {
            def ids = ObjectUtils.convertList(params.orderIds)
            orderList = ProductOrder.findAllByIdInList(ids.collect { it as long })
        } else {
            def shoppingCart = userInfo.shoppingCart
            orderList = shoppingCart?.productOrders
        }

        // remove empty order
        def toRemove = []
        orderList.each { order ->
            if (order.quantity == 0) toRemove << order
        }
        orderList.removeAll(toRemove)
        toRemove.each {
            userInfo.shoppingCart?.removeFromProductOrders(it)
        }

        if (!orderList) {
            redirect(action: "home")
            return
        }

        def address = userInfo.defaultAddress
        def lxGroup = address ? LxGroup.findByOrganizer(address.userInfo) : null
        def receiverName = lxGroup?.groupName ? lxGroup.groupName : address?.name

        def firstOrder = orderList ? orderList.first() : null
        def deliverReceiver = firstOrder?.organizer ? firstOrder.organizer : userInfo
        def headImageUrl = deliverReceiver?.weChatFans?.headImgUrl ? deliverReceiver.weChatFans.headImgUrl : null
        def currentTotalPrice = orderList.sum { it.currentPrice() }
        def deliveryDateList = []
        def totalFuturePrice = orderList.sum {
            it.futurePrice()
        }

        if (orderList.size() == 1) {  //两个产品或批次同时下单不显示发货日期的选择
            deliveryDateList = orderList[0].deliverDateList()
        }
        render ErrorCodeUtil.noError([orderList        : orderList.collect { ProductOrder order ->
            [id                    : order.id,
             quantity              : order.quantity,
             productTitle          : order.product?.title,
             batchTitle            : order.batch?.title,
             productionDate        : order.batch?.productionSimpleDate(),
             imageUrl              : order.product?.banner.thumbUrl,
             orderPrice            : order.orderPrice,
             orderDeposit          : order.orderDeposit,
             totalMarketPrice      : order.totalMarketPrice(),
             totalDiscount         : order.totalDiscount(),
             totalDeposit          : order.totalDeposit(),
             totalPrice            : order.totalPrice(),
             pendingPayForDeposit  : order.pendingPayForDeposit(),
             pendingPayForFullPrice: order.pendingPayForFullPrice() || order.pendingPayForMarketPrice()
            ]
        },
                                      totalCurrentPrice: FormatUtil.formatFullPrice(currentTotalPrice),
                                      totalFuturePrice : FormatUtil.formatFullPrice(totalFuturePrice),
                                      hasTotalFuturePrice: totalFuturePrice > 0,
                                      orderIds: orderList.collect { it.id }.join(","),
                                      useGroup         : lxGroup != null,
                                      name             : receiverName,
                                      phone            : address?.phone,
                                      province         : address?.city?.province,
                                      city             : address?.city?.name,
                                      district         : address?.district?.name,
                                      districtId       : address?.district?.id,
                                      street           : address?.street,
                                      address          : address?.address,
                                      addressId        : address?.id,
                                      headImageUrl     : headImageUrl,
                                      hasBalance       : userInfo.balance > 0,
                                      balance          : userInfo.balance,
                                      promotionCode: firstOrder?.promotionCode?.code,
                                      wxPayAmount      : FormatUtil.formatFullPrice(currentTotalPrice >= userInfo.balance ? currentTotalPrice - userInfo.balance : 0),
                                      useBalance      : FormatUtil.formatFullPrice(currentTotalPrice >= userInfo.balance ? userInfo.balance : currentTotalPrice),
                                      deliverDateList : deliveryDateList.size() > 2 ? deliveryDateList.subList(0, 2) : deliveryDateList.subList(0, deliveryDateList.size()),
                                      deliverDateList2: deliveryDateList.size() > 2 ? deliveryDateList.subList(2, deliveryDateList.size()) : [],
                                      hasDeliveryDates: deliveryDateList.size() > 0
        ])
    }

    def queryOrders() {
        log.info("Received query order request, ${params}")

        UserInfo _userInfo = SessionUtil.getSessionValue(SessionUtil.SESSION_WECHAT_USERINFO)

        Collection<ProductOrder> productOrders
        if (!_userInfo) {
            log.info("User not yet login.")
            render ErrorCodeUtil.userNotYetLogin()
            return
        } else {
            _userInfo.refresh()
        }

        if (params.status == "allStatus") {
            productOrders = _userInfo.orders
        } else {
            productOrders = _userInfo.getOrdersByDisplayStatus(params.status)
        }
        def hasPaymentOrderIds = ProductOrderPayments.findAllByProductOrderInList(productOrders)*.productOrder*.id

        def displayStatusList = ProductOrder.executeQuery("select distinct(displayStatus) " +
                "from ProductOrder where userInfo = :userInfo", [userInfo: _userInfo])
        //filter out no payment orders
        productOrders = productOrders.findAll { hasPaymentOrderIds.contains(it.id) }

        log.info("Retrieved size of orders: " + productOrders.size())

        def orderList = productOrders.collect {
            log.debug("order ID: " + it.id + ", status: " + it.displayStatus)
            def displayStatus = DisplayStatus.findByName(it.displayStatus)
            def deliveryDate = DeliveryProductOrders.getDeliveryByOrder(it)?.targetDeliveryDate
            def ret = [orderId        : it.id,
                       productThumbUrl: it.product?.banner?.thumbUrl,
                       productTitle   : it.product.title,
                       batchDesc      : it.batch.title,
                       productionDate : it.batch.productionSimpleDate(),
                       quantity       : it.quantity,
                       orderPrice     : it.orderPrice,
                       orderDeposit: it.orderDeposit,
                       discount       : it.discount,
                       status         : displayStatus.name,
                       orderDate      : FormatUtil.formatSimpleDatetime(it.orderDate),
                       deliverDate    : FormatUtil.formatSimpleDate(deliveryDate),
                       refundable     : it.isRefundable(),
                       payable        : displayStatus.payable && it.batch.isInPaymentWindow(),
                       commentable    : displayStatus.commentable,
                       lastUpdated    : FormatUtil.formatDatetime(it.lastUpdated),
                       lastUpdatedDate : it.lastUpdated
            ]
            ret.hasAction = ret.refundable || ret.payable || ret.commentable
            ret
        }

        def statusList = displayStatusList.collect {
            def status = DisplayStatus.findByName(it)
            [statusName: status.name,
             statusDesc: status.description,
             visible   : status.visible,
             weight    : status.weight]
        }

        render ErrorCodeUtil.noError([orderList : orderList.sort { a, b -> b.lastUpdatedDate <=> a.lastUpdatedDate },
                                      statusList: statusList.findAll { it.visible }.sort { a, b -> a.weight <=> b.weight
                                      }])
    }

    @Transactional
    def useAddress() {
        log.info("Use address, address id: ${params.addressId}")
        if (!SessionUtil.sessionValid()) {
            render ErrorCodeUtil.userNotYetLogin()
        }

        UserInfo userInfo = UserInfo.get(SessionUtil.userInfo.id)
        def address = Address.get(params.addressId)
        def addressOwner = address.userInfo
        def isGroupAddress = LxGroup.findByOrganizer(addressOwner)?.address == address
        def productOrders
        if (params.orderIds) {
            productOrders = ProductOrder.findAllByIdInList(ObjectUtils.convertList(params.orderIds))
        }
        if (isGroupAddress) {
            userInfo.groupDefaultAddress = address
            userInfo.useGroupAddressAsDefault = true
        } else {
            userInfo.myDefaultAddress = address
            userInfo.useGroupAddressAsDefault = false
        }
        userInfo.save(flush: true)

        if (productOrders) {
            productOrders.each {
                it.updateDeliveryAddress(address, userInfo.mobile)
                it.address = address
                if (isGroupAddress) {
                    it.organizer = addressOwner
                } else {
                    it.organizer = null
                }
            }
            ProductOrder.saveAll(productOrders)
        }
        render ErrorCodeUtil.noError()
    }

    def updateGroupAddress() {
        log.info("Update group address, address id: ${params.addressId}, group id: ${params.groupId}")
        if (!SessionUtil.sessionValid()) {
            render ErrorCodeUtil.userNotYetLogin()
        }

        def lxGroup = LxGroup.get(params.groupId)
        lxGroup.address = Address.get(params.addressId)
        lxGroup.save()

        render ErrorCodeUtil.noError()
    }

    def pay() {
        log.info("Receive pay for orders request, orderIds: ${params.orderId}")
        def orders, payBody

        if (params.orderId) {
            def ids = ObjectUtils.convertList(params.orderId)
            orders = ProductOrder.findAllByIdInList(ids)
        } else {
            ShoppingCart shoppingCart = SessionUtil.getSessionValue(SessionUtil.SESSION_SHOPPING_CART)
            if(shoppingCart) {
                orders = shoppingCart.refresh().productOrders
            }

            if(!orders){
                log.error("Fail to pay for the orders.")
                redirect(action: "home")
                return
            }
        }
        payBody = OrderUtil.convertPayBody(orders)
        if (!payBody) {
            log.error("Fail to generate pay body..")
            redirect(action: "home")
            return
        }
        def useBalance = params?.useBalance == "on"
        def clientIp = request.getRemoteAddr()

        UserInfo userInfo = SessionUtil.userInfo?.refresh()
        orders.each { order ->
            if (order.promotionCode?.address) {
                order.address = order.promotionCode?.address
            } else {
                order.address = userInfo.getDefaultAddress()
            }
        }

        //create delivery if it has
        if(params.deliverDate){
            params.skipRender = true
            confirmDeliveryDate()
        }

        def ret = paymentService.pay(orders, useBalance, params.paymentType, clientIp)

        if (ret.errorcode == 0) {
            render ErrorCodeUtil.noError(ret.data)
        } else {
            render ErrorCodeUtil.paymentFail()
        }
    }

    def paymentSuccess() {
        log.info("Payment success, prepayId: ${params.prepayId}, outTradeNo: ${params.outTradeNo}")
        def outTradeNo = params.outTradeNo
        if(!outTradeNo){ //alipay payment
            outTradeNo = params.out_trade_no
        }
        def payment = Payment.findByPrepayId(params.prepayId)
        if(!payment) {
            payment = Payment.findByOutTradeNo(outTradeNo)
        }

        if(payment && payment.balanceAmount == payment.amount){
            paymentService.processPayment(payment)
        }

        if (payment) {
            return [payment:payment]
        } else {
            redirect(action: "home")
            return
        }
    }

    def refund() {
        log.info("Receive refund order request, order id:${params?.orderId}")
        ProductOrder order = ProductOrder.findById(params?.orderId)
        if (!order) {
            render ErrorCodeUtil.noOrderFound()
            return
        }
        if (order.refundPrice() == 0) {
            render ErrorCodeUtil.noAmountForRefund()
            return
        }
        Payment lastPayment = order.lastPayment

        if (!lastPayment) {
            render ErrorCodeUtil.refundFail()
            return
        }

        def ret = orderService.refund(order, lastPayment)
        if(ret.orderId){
            render ErrorCodeUtil.noError(ret)
        }else{
            render ErrorCodeUtil.refundFail()
        }
    }

    @Transactional
    def updateShoppingCart() {
        render shoppingCartService.updateShoppingCart(params.batchId as long, params.quantity as int)
    }


    def queryShoppingCart() {
        log.info("query shopping cart")

        render shoppingCartService.queryShoppingCart()
    }

    //查询建议
    def querySuggestion() {
        log.info('query Suggestion...')

        Suggestion[] suggestions = Suggestion.listOrderByDateCreated(order: "desc", max: 10, offset: params.offset);

        def total = Suggestion.count();

        render ErrorCodeUtil.noError(suggestions.collect {
            [
                    nickName  : it.weChatFans?.nickName,
                    headImgUrl: it.weChatFans?.headImgUrl,
                    content   : it.content, reply: it.reply,
                    time      : it.dateCreated?.format("yyyy-MM-dd HH:mm"),
                    replyDate : it.replyDate?.format("yyyy-MM-dd HH:mm"),
                    total     : total
            ]
        })
    }

    //提交建议：
    def submitSuggestion(params) {
        log.info('submit Suggestion...' + ' , content = ' + params.content)

        //检查验证码
        def String code = params.code
        def String codeInSession = SessionUtil.getSessionValue(SessionUtil.SESSION_RANDOM_VERIFY_CODE)
        if (code.toUpperCase() != codeInSession.toUpperCase()) {
            //验证失败，返回错误信息
            render ErrorCodeUtil.invalidRandomCode()
            return
        }

        //验证通过，保存建议
        String suggContent = params.content
        WeChatFans fans = SessionUtil.getSessionValue(SessionUtil.SESSION_WECHAT_FANS)

        fans.refresh()
        Suggestion s = new Suggestion(content: suggContent, weChatFans: fans)
        s.save()
        render ErrorCodeUtil.noError()
    }

    def editGroupInfo() {
        log.info("Edit group info, groupId: ${params.groupId}")
        def UserInfo userInfo = SessionUtil.getSessionValue(SessionUtil.SESSION_WECHAT_USERINFO)
        def WeChatFans fans
        if (!userInfo) {
            render ErrorCodeUtil.userNotYetLogin()
            return
        } else {
            userInfo.refresh()
            fans = userInfo.weChatFans
        }

        if (params.groupId) { // edit group info
            def group = LxGroup.get(params.groupId)

            render ErrorCodeUtil.noError([name         : group.groupName,
                                          phone        : group.phone,
                                          wechatAccount: group.wechatAccount,
                                          address      : group.address as String,
                                          addressId    : group.address?.id,
                                          organizerId  : userInfo.id,
                                          groupId      : group.id,
                                          deliverable  : group.deliverable,
                                          pickupTimes  : group.pickupTimes?.collect { it.dayOfWeek }.join(",")
            ])
        } else { // create group
            render ErrorCodeUtil.noError([name         : userInfo.name,
                                          phone        : userInfo.mobile,
                                          wechatAccount: userInfo.mobile,
                                          address      : userInfo.defaultAddress as String,
                                          addressId    : userInfo.defaultAddress?.id,
                                          organizerId  : userInfo.id
            ])
        }
    }

    def saveLxGroup() {
        log.info("Receive save lx group request, params: ${params["group.id"]}")
        def LxGroup group
        if (params["group.id"]) {
            group = LxGroup.get(params["group.id"])
        } else {
            group = new LxGroup(pickupTimes: [])
        }

        params.deliverable = params.deliverable == 'on' ? true : false

        group.properties = params
        def pickupTimes = group.pickupTimes
        (1..7).each { i ->
            if (params["availableTime_${i}"] == 'on') {
                if (!pickupTimes.find { it.dayOfWeek == i }) {
                    group.addToPickupTimes(new PickupTime(dayOfWeek: i))
                }
            } else {
                def pkupTime = pickupTimes.find { it.dayOfWeek == i }
                if (pkupTime) {
                    group.removeFromPickupTimes(pkupTime)
                }
            }
        }
        group.validate()
        if (group.hasErrors()) {
            def e = group.errors.getFieldError()
            def fieldCode = ErrorCodeUtil.fieldCode(e)
            def errmsg = message(code: e.defaultMessage, args: [message(code: fieldCode)])
            render ErrorCodeUtil.fieldError(e.field, errmsg)
            return
        }

        group.save(flush: true)
        group.organizer.isOrganizer = true
        group.organizer.save(flush: true)

        render ErrorCodeUtil.noError([groupId    : group.id,
                                      organizerId: group.organizer.id,
                                      headImgUrl : group.organizer?.weChatFans?.headImgUrl,
                                      address    : group.address.toSimpleAddress()
        ])
    }


    def queryMyGroup() {
        log.info("Query my group.")
        def UserInfo userInfo = SessionUtil.getSessionValue(SessionUtil.SESSION_WECHAT_USERINFO)
        if (!userInfo) {
            render ErrorCodeUtil.userNotYetLogin()
            return
        } else {
            userInfo.refresh()
        }
        def ret = [:]
        def myGroupAsOrganizer = LxGroup.findByOrganizer(userInfo)
        if (myGroupAsOrganizer) {
            ret.isOrganizer = true
            ret.myGroupId = myGroupAsOrganizer.id
        }

        def myLxGroups = LxGroupMembers.findAllByUserInfo(userInfo)*.lxGroup
        if (myLxGroups) {
            ret.isGroupMember = true
            ret.myLxGroups = myLxGroups.collect {
                [
                        groupId      : it.id,
                        name         : it.organizer.name,
                        phone        : it.phone,
                        address      : it.address.toString(),
                        addressId    : it.address.id,
                        weChatAccount: it.wechatAccount,
                        deliverable  : it.deliverable,
                        headImgUrl   : it.organizer?.weChatFans?.headImgUrl,
                        distance     : userInfo.defaultAddress ? it.getDistance(userInfo.defaultAddress) : 0
                ]
            }.sort { it.distance }
        }
        render ErrorCodeUtil.noError(ret)
    }

    def queryGroupsNearBy() {
        log.info("Query groups nearby, size: ${params.size}")
        Long defaultDistance = 1000L;
        UserInfo userInfo = SessionUtil.getUserInfo()
        userInfo = userInfo?.id ? userInfo.refresh() : null
        if(!userInfo || !userInfo?.myDefaultAddress){
            render ErrorCodeUtil.noAddressFound()
            return
        }
        def deliverDaysInWeek
        if (params.productId) {
            deliverDaysInWeek = Product.get(params.productId)?.category?.deliverDaysInWeek
        }

        List<LxGroup> groupNearMyDefaultAddress = [];
        Double lat, lng

        Address address = userInfo.myDefaultAddress
        if (address.getLatitude() && address.getLongitude()) {
            lat = address.getLatitude()
            lng = address.getLongitude()
            groupNearMyDefaultAddress = LxGroup.findNearby(lat, lng, defaultDistance, params.size, userInfo, deliverDaysInWeek);
        }
        log.info("groupNearMyDefaultAddress: $groupNearMyDefaultAddress")

        if (groupNearMyDefaultAddress.size() == 0) {
            render ErrorCodeUtil.noLxGroupNearby()
        } else {
            render ErrorCodeUtil.noError([lat                       : lat, lng: lng,
                                          groupsNearMyDefaultAddress: groupNearMyDefaultAddress])
        }

    }

    def joinGroup() {
        log.info("User join group, groupId: ${params.groupId}")
        UserInfo userInfo = SessionUtil.getSessionValue(SessionUtil.SESSION_WECHAT_USERINFO)
        if (userInfo && params.groupId) {
            if (userInfo && userInfo.id) userInfo = userInfo.refresh()
            def group = LxGroup.get(params.groupId)
            LxGroupMembers.withTransaction {
                new LxGroupMembers(userInfo: userInfo, lxGroup: group).save()
            }
            render ErrorCodeUtil.noError()
        } else {
            render ErrorCodeUtil.unknownError()
        }
    }

    def quitGroup() {
        log.info("User quit group, groupId: ${params.groupId}")
        UserInfo userInfo = SessionUtil.getSessionValue(SessionUtil.SESSION_WECHAT_USERINFO)
        if (userInfo && params.groupId) {
            userInfo = userInfo.refresh()
            def group = LxGroup.get(params.groupId)
            LxGroup.withTransaction {
                def lxGroupMembers = LxGroupMembers.findByLxGroupAndUserInfo(group, userInfo)
                lxGroupMembers.delete()
            }
            render ErrorCodeUtil.noError()
        } else {
            render ErrorCodeUtil.unknownError()
        }
    }

    def kickMemberOut() {
        log.info("kick member out of the group, groupId: ${params.groupId}, memberId: ${params.memberId}")
        if (params.memberId && params.groupId) {
            def userInfo = UserInfo.get(params.memberId)
            def group = LxGroup.get(params.groupId)
            LxGroup.withTransaction {
                def lxGroupMembers = LxGroupMembers.findByLxGroupAndUserInfo(group, userInfo)
                lxGroupMembers.delete()
            }
            render ErrorCodeUtil.noError()
        } else {
            render ErrorCodeUtil.unknownError()
        }
    }

    def getLxGroupInfo() {
        log.info("Query lx group info, groupId: ${params.groupId}")

        if (!params.groupId) {
            log.error("Invalid lx group id")
            render ErrorCodeUtil.unknownError()
            return
        }
        UserInfo userInfo = SessionUtil.getSessionValue(SessionUtil.SESSION_WECHAT_USERINFO)
        if (userInfo && userInfo.id) {
            userInfo.refresh()
        } else {
            ErrorCodeUtil.userNotYetLogin()
        }
        def group = LxGroup.get(params.groupId)
        if (group) {
            render ErrorCodeUtil.noError([
                    groupId      : group.id,
                    headImgUrl   : group.organizer?.weChatFans?.headImgUrl,
                    name         : group.groupName,
                    wechatAccount: group.wechatAccount,
                    distance     : group.getDistance(userInfo.defaultAddress),
                    phone        : group.phone,
                    address      : group.address?.toString(),
                    simpleAddress: group.address?.toSimpleAddress(),
                    addressId    : group.address?.id,
                    deliverable  : group.deliverable,
                    pickupTimes  : group.pickupTimes?.sort { it.dayOfWeek }.collect { it.toDayStr() }.join(",")
            ])
        } else {
            render ErrorCodeUtil.noGroupFound()
        }
    }

    def queryLxGroupMembers() {
        log.info("Handle query lx group members, id: ${params.groupId}")
        if (!params.groupId) {
            log.error("Invalid lx group id")
            render ErrorCodeUtil.unknownError()
            return
        }

        def group = LxGroup.get(params.groupId)
        def members = LxGroupMembers.findAllByLxGroup(group)*.userInfo

        if (members) {
            render ErrorCodeUtil.noError([members: members.collect {
                [
                        id        : it.id,
                        groupId   : group.id,
                        headImgUrl: it.headImageUrl(),
                        name      : it?.weChatFans ? it.weChatFans.nickName : it.name,
                        distance  : group.getDistance(it.defaultAddress),
                        address   : it.defaultAddress,
                        phone     : it.mobile
                ]
            }
            ])
        } else {
            render ErrorCodeUtil.noMemberInGroupFound()
        }

    }

    def getLxGroupMemberInfo() {
        log.info("Get lx group member info, member id: ${params.memberId}, groupdId: ${params.groupId}")

        if (!params.memberId) {
            log.error("Invalid member id")
            render ErrorCodeUtil.unknownError()
            return
        }
        if (!SessionUtil.sessionValid()) {
            render ErrorCodeUtil.userNotYetLogin()
            return
        }

        UserInfo member = UserInfo.get(params.memberId)
        LxGroup group = LxGroup.get(params.groupId)
        if (member) {
            render ErrorCodeUtil.noError([
                    memberId  : member.id,
                    groupId   : group.id,
                    headImgUrl: member?.weChatFans?.headImgUrl,
                    name      : member?.weChatFans ? member.weChatFans.nickName : member.name,
                    distance  : group.getDistance(member.defaultAddress),
                    phone     : member.mobile,
                    address   : member.defaultAddress?.toString(),
                    addressId : member.defaultAddress?.id
            ])
        } else {
            render ErrorCodeUtil.noGroupFound()
        }
    }

    def queryMyCommission() {
        log.info("Query my commission.")
        if (!SessionUtil.sessionValid()) {
            render ErrorCodeUtil.userNotYetLogin()
            return
        }
        UserInfo userInfo = SessionUtil.getUserInfo()
        def commissions = Commission.findAllByOrganizer(userInfo)
        def todayCommission = Commission.todayCommission(commissions)
        def extractableCommission = Commission.stateOfCommission(commissions, STATE_EXTRACTABLE)
        def realisedCommission = Commission.stateOfCommission(commissions, STATE_REALISED)
        def unrealisedCommission = Commission.stateOfCommission(commissions, STATE_UNREALISED)
        def oneWeekCommission = Commission.daysRangeOfCommission(commissions, 7)
        def oneMonthCommission = Commission.daysRangeOfCommission(commissions, 30)
        def extractedCommission = Commission.stateOfCommission(commissions, STATE_DONE)
        def totalCommission = Commission.totalCommission(commissions)

        render ErrorCodeUtil.noError([todayCommission      : todayCommission,
                                      extractableCommission: extractableCommission,
                                      realisedCommission   : realisedCommission,
                                      unrealisedCommission : unrealisedCommission,
                                      oneWeekCommission    : oneWeekCommission,
                                      oneWeekCommission    : oneWeekCommission,
                                      oneMonthCommission   : oneMonthCommission,
                                      extractedCommission  : extractedCommission,
                                      totalCommission      : totalCommission
        ])
    }

    def queryCommissionHistory() {
        log.info("Query commission history")
        if (!SessionUtil.sessionValid()) {
            render ErrorCodeUtil.userNotYetLogin()
            return
        }
        UserInfo userInfo = SessionUtil.getUserInfo()
        def commissions = CommissionEvent.findAllByOrganizer(userInfo)

        render ErrorCodeUtil.noError([commissionList: commissions.sort { a, b -> b.dateCreated <=> a.dateCreated }.collect {
            [
                    id             : it.id,
                    event          : it.event,
                    amount         : it.amount,
                    state          : Commission.CommissionState.valueOf(it.state).description,
                    dateCreated    : DateFormatUtils.format(it.dateCreated, "MM-dd"),
                    product        : it.commission?.productName,
                    buyer          : it.commission?.buyerName,
                    buyerHeadImgUrl: it.commission?.buyerHeadImgUrl
            ]
        }
        ])
    }

    def extractCommissionToAccount() {
        log.info("Extract Commission to account")
        if (!SessionUtil.sessionValid()) {
            render ErrorCodeUtil.userNotYetLogin()
            return
        }
        UserInfo userInfo = SessionUtil.getUserInfo()?.refresh()
        def commissions = Commission.findAllByOrganizer(userInfo)
        def extractableCommissions = commissions.findAll { it.state == STATE_EXTRACTABLE.id }
        def extractableAmount = extractableCommissions.sum { it.amount }
        Commission.withTransaction {
            userInfo.balance += extractableAmount
            userInfo.save()
            extractableCommissions.each { it.extractCommission() }
            Commission.saveAll(extractableCommissions)
        }
        def extractedCommission = Commission.stateOfCommission(commissions, STATE_DONE)

        render ErrorCodeUtil.noError([extractedAmount: extractableAmount, extractedCommission: extractedCommission])
    }

    def extractCommissionToWeChat() {
        log.info("Extract Commission to wechat account")
        if (!SessionUtil.sessionValid()) {
            render ErrorCodeUtil.userNotYetLogin()
            return
        }
        UserInfo userInfo = SessionUtil.getUserInfo()
        userInfo = userInfo?.refresh()
        def commissions = Commission.findAllByOrganizer(userInfo)
        def extractableCommissions = commissions.findAll { it.state == STATE_EXTRACTABLE.id }
        def extractableAmount = extractableCommissions.sum { it.amount }

        def tradeNo = IdGenerator.generateWxTradeId() // 商户订单号
        def result = weChatPayService.transferAmount(userInfo?.weChatFans?.openId, userInfo?.name,
                tradeNo, extractableAmount, "领鲜群主佣金", request.getRemoteAddr())

        if ("SUCCESS".equals(result.resultCode)) {
            def payment = new Payment(cashFlowDirection: Payment.CASH_FLOW_DIRECTION_OUT,
                    status: Payment.STATUS_RECONCILED,
                    amount: extractableAmount,
                    cashFee: extractableAmount,
                    openid: userInfo.weChatFans.openId,
                    isSubscribe: userInfo.weChatFans.subscribe ? "Y" : "N",
                    outTradeNo: tradeNo
            )
            payment.properties = result

            Commission.withTransaction {
                payment.save()
                extractableCommissions.each { it.extractCommission() }
                Commission.saveAll(extractableCommissions)
            }
            def extractedCommission = Commission.stateOfCommission(commissions, STATE_DONE)
            render ErrorCodeUtil.noError([extractedAmount: extractableAmount, extractedCommission: extractedCommission])
        } else {
            render ErrorCodeUtil.extractCommissionFail()
        }
        return
    }

    def queryLxGroupOrders() {
        log.info("Query lx group orders, lx group id: ${params.groupId}")
        if (!SessionUtil.sessionValid()) {
            render ErrorCodeUtil.userNotYetLogin()
            return
        }
        if (!params.groupId) {
            render ErrorCodeUtil.noGroupFound()
            return
        }

        LxGroup group = LxGroup.get(params.groupId)

        def orders = LxGroupProductOrder.findAllByLxGroup(group).collect { it.productOrder }
        render ErrorCodeUtil.noError([orderList: orders.collect { order ->
            [id          : order.id,
             quantity    : order.quantity,
             productTitle: order.product?.title,
             batchTitle  : order.batch?.title,
             headImgUrl  : order.userInfo?.weChatFans?.headImgUrl,
             inDelivery  : order.isInDelivery(),
             refundable  : order.isRefundable(),
             status      : order.displayStatusName(),
             lastUpdated : DateFormatUtils.format(order.lastUpdated, "yy/MM/dd HH:mm"),
             name        : order.userInfo.name,
             mobile      : order.userInfo.mobile,
             address     : order.userInfo.defaultAddress
            ]
        }
        ])
    }

    def queryLxGroupDeliveries() {
        log.info("Query Lx group deliveries, groupId: ${params.groupId}")
        if (!SessionUtil.sessionValid()) {
            render ErrorCodeUtil.userNotYetLogin()
            return
        }
        if (!params.groupId) {
            render ErrorCodeUtil.noGroupFound()
            return
        }
        LxGroup group = LxGroup.get(params.groupId)

        def orderCountList = DeliveryProductOrders.executeQuery("""select dpo.delivery.id, sum(dpo.productOrder.quantity)
                                        from DeliveryProductOrders dpo
                                        where dpo.delivery.receiver = :organizer group by dpo.delivery.id""", [organizer: group.organizer])

        def criteria = {
            if (params.filterOutstanding || params.filterNonEmpty) {
                and {
                    if (params.filterOutstanding == "on") {
                        'in'('deliveryStatus', DeliveryStatus.outstandingStatus())
                    }
                    if (params.filterNonEmpty == "on") {
                        'in'("id", orderCountList.collect { it[0] })
                    }
                    eq('receiver', group.organizer)
                }
            } else {
                eq('receiver', group.organizer)
            }
        }

        Collection<Delivery> deliveries = Delivery.withCriteria(criteria)

        render ErrorCodeUtil.noError([deliveryList: deliveries.collect { delivery ->
            def orderCount = orderCountList?.find { it?.getAt(0) == delivery.id }?.getAt(1)
            [
                    deliveryId    : delivery.id,
                    deliveryDate  : delivery.targetDeliveryDate.format("yyyy-MM-dd"),
                    deliveryCode  : delivery.deliveryCode,
                    productTitle  : delivery.batch.product.title,
                    batchTitle    : delivery.batch.title,
                    productImg    : delivery.batch.product.banner?.thumbUrl,
                    deliveryStatus: delivery.deliveryStatus.name,
                    enable        : delivery.enable,
                    orderCount    : orderCount ? orderCount : 0,
                    lastUpdated   : delivery.lastUpdated
            ]
        }])
    }

    def queryOrderDetail() {
        log.info("Query order detail, order id: ${params.orderId}")
        if (!SessionUtil.sessionValid()) {
            render ErrorCodeUtil.userNotYetLogin()
            return
        }

        def order = ProductOrder.get(params.orderId)
        if (!order) {
            render ErrorCodeUtil.noOrderFound()
            return
        }

        if((order.userInfo?.id != SessionUtil.userInfo?.id && params.openId == null) ||
                (params.openId != null && order.userInfo.weChatFans.openId != params.openId)){
            render ErrorCodeUtil.noOrderFound()
            return
        }

        def displayStatus = DisplayStatus.findByName(order.displayStatus)
        LxGroup lxGroup
        if (order.groupon) {
            lxGroup = LxGroupProductOrder.findByProductOrder(order)?.lxGroup
        }
        def groupDeliverDaysInWeek = lxGroup ? lxGroup.intersectDeliveryDaysInWeek(order.product.category.toDeliverDaysInWeekArr()) : order.product.category.toDeliverDaysInWeekArr()
        def deliverDaysInWeek = order.product.category.toDeliverDaysInWeekArr()
        def delivery = DeliveryProductOrders.findByProductOrder(order)?.delivery
        def deliveryDateList = order.deliverDateList()
        def ret =
                [orderId               : order.id,
                 productThumbUrl       : order.product?.banner?.thumbUrl,
                 productTitle          : order.product.title,
                 batchDesc             : order.batch.title,
                 productionDate        : order.batch.productionSimpleDate(),
                 quantity              : order.quantity,
                 orderPrice            : order.orderPrice,
                 orderDeposit        : order.orderDeposit,
                 discountNumber        : order.discountNumber(), //折
                 discount            : order.discount, //价格
                 status                : displayStatus.name,
                 orderDate             : FormatUtil.formatDatetime(order.orderDate),
                 refundable            : order.isRefundable(),
                 payable               : displayStatus.payable,
                 deliverTimeEditable   : displayStatus.deliverTimeEditable,
                 commentable           : displayStatus.commentable,
                 addressChangable      : order.addressChangable(),
                 deliveryConfirmable   : displayStatus.deliveryConfirmable,
                 lastUpdated           : FormatUtil.formatDatetime(order.lastUpdated),
                 depositPaymentNo    : order.depositPayment?.id,
                 depositPayTime        : order.depositPayment?.dateCreated ? FormatUtil.formatDatetime(order.depositPayment?.dateCreated) : null,
                 depositPaymentType  : order.depositPayment?.getPaymentTypeString(),
                 depositAmount       : order.depositPayment?.amount,
                 fullPricePaymentNo  : order.fullPricePayment?.id,
                 fullPricePayTime      : order.fullPricePayment?.dateCreated ? FormatUtil.formatDatetime(order.fullPricePayment?.dateCreated) : null,
                 fullPricePaymentType: order.fullPricePayment?.getPaymentTypeString(),
                 fullPriceAmount     : order.fullPricePayment?.amount,
                 to                    : order.address?.name,
                 phone                 : order.address?.phone,
                 address               : order.address?.toString(),
                 isGroupon             : order.groupon,
                 groupName             : lxGroup?.groupName,
                 weChatAccount         : lxGroup?.wechatAccount,
                 displayStatus         : order.displayStatus,
                 deliverDaysInWeek     : deliverDaysInWeek,
                 groupDeliverDaysInWeek: groupDeliverDaysInWeek,
                 deliverDateList       : deliveryDateList.size() > 4 ? deliveryDateList.subList(0, 4) : deliveryDateList.subList(0, deliveryDateList.size()),
                 deliverDateList2      : deliveryDateList.size() > 4 ? deliveryDateList.subList(4, deliveryDateList.size()) : [],
                 deliverDate           : delivery ? FormatUtil.formatDate(delivery.targetDeliveryDate) : null
                ]
        ret.hasAction = ret.refundable || ret.payable || ret.commentable
        render ErrorCodeUtil.noError(ret)
    }

    @Transactional
    def confirmDeliveryDate() {
        log.info("Confirm delivery date, orderId: ${params.orderId}, deliveryDate: ${params.deliverDate}")
        def deliveryDateStr = ObjectUtils.convertList(params.deliverDate)[0]
        if(!deliveryDateStr){
            if(!params.skipRender) render ErrorCodeUtil.wrongDeliveryDate()
            return
        }
        UserInfo userInfo = SessionUtil.userInfo
        def deliveryDate = FormatUtil.parseDate(deliveryDateStr)

        ProductOrder order = ProductOrder.get(params.orderId)

        if (!order.updateDeliveryDate(deliveryDate, userInfo.mobile)) {
            log.warn("Fail to update delivery date.")
            if(!params.skipRender) render ErrorCodeUtil.noError()
            return
        }
        log.info("Update delivery date to ${deliveryDate.format("yyyy-MM-dd")}")
        if(!params.skipRender) render ErrorCodeUtil.noError([deliverDate: deliveryDate.format("yyyy-MM-dd")])
    }

    @Transactional
    def confirmDelivery(){
        log.info("Confirm delivery, orderId: ${params.orderId}")
        ProductOrder order = ProductOrder.get(params.orderId)
        if(order){
            order.completeDelivery()
        }else{
            log.error("Cannot find the order")
            return
        }

        Delivery delivery = DeliveryProductOrders.findByProductOrder(order)?.delivery
        if(delivery){
            delivery.confirmDelivered()
        }else{
            log.error("Cannot find the delivery")
            return
        }
        ProductOrder.withTransaction {
            order.save()
            delivery.save()
        }

        render ErrorCodeUtil.noError([status: order.displayStatus])
    }

    def queryLxGroupDeliveryDetail() {
        log.info("Query LxGroup Delivery detail, deliveryId: ${params.deliveryId}")
        Delivery delivery = Delivery.get(params.deliveryId)
        Collection<ProductOrder> orders = DeliveryProductOrders.findAllByDelivery(delivery)*.productOrder

        def totalQuantity = delivery.totalQuantity()
        def batch = delivery.batch
        def product = batch.product
        def commission = orders.size() > 0 ? delivery.calcTotalCommission() : 0
        render ErrorCodeUtil.noError([
            productTitle : product?.title,
            batchTitle   : batch?.title,
            productImgUrl: product?.banner.thumbUrl,
            totalQuantity: totalQuantity,
            quantityLeft : LxGroup.GROUP_MIN_QUANTITY - totalQuantity,
            commission   : commission,
            status       : totalQuantity >= LxGroup.GROUP_MIN_QUANTITY,
            orderList    : orders.collect { order ->
                [orderId    : order.id,
                 quantity   : order.quantity,
                 headImgUrl : order.userInfo?.weChatFans?.headImgUrl,
                 inDelivery : order.isInDelivery(),
                 refundable : order.isRefundable(),
                 status     : order.displayStatusName(),
                 lastUpdated: DateFormatUtils.format(order.lastUpdated, "yy/MM/dd HH:mm"),
                 name       : order.userInfo.name,
                 mobile     : order.userInfo.mobile,
                 address    : order.userInfo.defaultAddress?.toString(),
                 hasAction  : order.deliveryStatus == DeliveryStatus.PROCESSING.id || order.deliveryStatus == DeliveryStatus.CONFIRM_DELIVER_DATE.id
                ]
            }
        ])
    }

    //查询关于我们
    def queryAbout() {
        log.info('query About page...')

        About aboutPage = About.first()

        render ErrorCodeUtil.noError([content: aboutPage?.content])
    }

    /*
     * 群主确认顾客已经领货
     */
    def customerGotTheProduct() {
        log.info("Customer already get the product, order id: ${params.orderId}")
        ProductOrder order = ProductOrder.get(params.orderId)
        order.customerGotTheProduct()
        order.save()
        render ErrorCodeUtil.noError()
    }

    def completeDelivery() {
        log.info("Customer confirm complete delivery, order id: ${params.orderId}")
        ProductOrder order = ProductOrder.get(params.orderId)
        order.completeDelivery()
        order.save()
        render ErrorCodeUtil.noError()
    }

    def queryMyAccount() {
        log.info("Query my account info")
        UserInfo userInfo = SessionUtil.userInfo?.refresh()
        Address address = userInfo?.defaultAddress

        render ErrorCodeUtil.noError([
                addressId : address?.id,
                address   : address?.toString(),
                headImgUrl: userInfo?.headImageUrl(),
                phone     : userInfo?.mobile,
                name      : userInfo?.name,
                balance   : userInfo?.balance
        ])
    }

    @Transactional
    def deposit() {
        log.info("Deposit to my account, amount: ${params.amount}")
        def clientIp = request.getRemoteAddr()
        def ret = paymentService.deposit(params.amount as BigDecimal, clientIp)
        if(ret){
            render ErrorCodeUtil.noError(ret)
        }else{
            redirect(action: "home")
        }
    }

    @Transactional
    def depositSuccess() {
        log.info("Deposit success")
        def payment = Payment.findByPrepayId(params.prepayId)
        if (!payment) {
            log.error("No payment found, redirect home.")
            redirect(controller: "h5", action: "home")
            return
        }

        [payment:payment]
    }

    def queryDepositRecords() {
        log.info("Query deposit records")
        UserInfo userInfo = SessionUtil.userInfo?.refresh()

        render ErrorCodeUtil.noError([depositList: userInfo.depositRecords.sort{a,b-> b.dateCreated <=> a.dateCreated}.collect {
            [
                    channel: it.channel.description,
                    amount : it.amount,
                    date   : it.dateCreated.format("yy/MM/dd HH:mm"),
                    remark : it.remark
            ]
        }])
    }

    def updateOrderAddress() {
        log.info("Update order address, addressId: ${params.addressId}, orderId: ${params.orderId}")

        def order = ProductOrder.get(params.orderId)
        def address = Address.get(params.addressId)
        def userInfo = order.userInfo

        if(order && address){
            order.address = address
            order.save()

            //change delivery
            order.updateDeliveryAddress(address, userInfo.mobile)
        }else {
            log.error("Cannot find order: ${order} or address: ${address}")
        }

        render ErrorCodeUtil.noError([address: address?.toString(), name: address?.name, mobile: address?.phone])
    }

    def shareToFriends(){
        WeChatFans fans = SessionUtil.getSessionValue(SessionUtil.SESSION_WECHAT_FANS)
        log.info("Share to friends, openId: ${fans?.openId}")
        fans = WeChatFans.findByOpenId(fans?.openId)
        if(fans) {
            fans.shareToFriendsCount++
            fans.save()
        }
        render ErrorCodeUtil.noError()
    }

    def cancelSharingToFriends(){
        WeChatFans fans = SessionUtil.getSessionValue(SessionUtil.SESSION_WECHAT_FANS)
        log.info("Cancel share to friends, openId: ${fans?.openId}")
        fans = WeChatFans.findByOpenId(fans?.openId)
        if(fans){
            fans.shareToFriendsCount--
            if(fans.shareToFriendsCount < 0) fans.shareToFriendsCount = 0
            fans.save()
        }
        render ErrorCodeUtil.noError()
    }

    def shareToTimeline(){
        WeChatFans fans = SessionUtil.getSessionValue(SessionUtil.SESSION_WECHAT_FANS)
        log.info("Share to timeline, openId: ${fans?.openId}")
        fans = WeChatFans.findByOpenId(fans?.openId)
        if(fans) {
            fans.shareToTimelineCount++
            fans.save()
        }
        render ErrorCodeUtil.noError()
    }
    def cancelSharingToTimeline(){
        WeChatFans fans = SessionUtil.getSessionValue(SessionUtil.SESSION_WECHAT_FANS)
        log.info("Cancel share to timeline, openId: ${fans?.openId}")
        fans = WeChatFans.findByOpenId(fans?.openId)
        if(fans) {
            fans.shareToTimelineCount--
            if (fans.shareToTimelineCount < 0) fans.shareToTimelineCount = 0
            fans.save()
        }
        render ErrorCodeUtil.noError()
    }

    def qrcode() {
        log.info("Receive qrcode request, id: ${params.id}")
        QrCode qrCode = QrCode.findByQrCodeId(params.id)
        if(qrCode && qrCode.qrCodeSetting){
            def age = qrCode.dateCreated - qrCode.qrCodeSetting.batch?.birthday
            def variableJson = JSON.parse(qrCode.qrCodeSetting.variable)
            variableJson.id= params.id
            variableJson.age = age
            return [title: qrCode.qrCodeSetting.title,
                    content: qrCode.qrCodeSetting.content,
                     variable: variableJson as JSON]
        }

        WeChatFans fans = SessionUtil.getSessionValue(SessionUtil.SESSION_WECHAT_FANS)
        def hasFans = { f->
            QrCodeSetting setting = QrCodeSettingWeChatFans.findByWeChatFans(f.refresh())?.qrCodeSetting
            if(!setting){
                return [:] //product qrcode not found
            }

            // register
            log.info("Register qrcode..")
            qrCode = new QrCode(qrCodeId: params.id, qrCodeSetting: setting)
            qrCode.save()
        }
        if(fans){
            def ret = hasFans(fans)
            if(ret instanceof Map){
                return ret
            }
            redirect(action: "qrcodeRegisterSuccess")
        }else if(params.code){
            fans = sessionService.retrieveFans(params.code)
            def ret = hasFans(fans)
            if(ret instanceof Map){
                return ret
            }
            redirect(action: "qrcodeRegisterSuccess")
        } else {
            def context = WeChatContext.defaultContext()
            def url = WeChatUrlUtil.snsapiBaseUrl(context.appId, params.requestUrl)
            return [redirectUrl: url] //product qrcode not found
        }
    }

    def qrcodeRegisterSuccess(){
        [:]
    }

    def coupon(){
        log.info("Receive coupon request, coupon Id: ${params.id}, weChatFans open id: ${params.referee}")

        def coupon = CouponTemplate.get(params.id)

        if(!coupon){
            redirect(action: "home")
            return
        }
        def WeChatFans refereeFans = WeChatFans.findByOpenId(params.referee)
        def title
        if(refereeFans){
            title = coupon?.title?.replace("{{user}}", refereeFans.nickName)
        }else{
            log.info("Referee(openId:${params.referee})not found, ")
        }

        WeChatFans currentFans = SessionUtil.getSessionValue(SessionUtil.SESSION_WECHAT_FANS)
        if(currentFans){
            return [coupon : coupon, refereeFans : refereeFans, title : title, openId: currentFans.openId]
        }else if(params.code){
            currentFans = sessionService.retrieveFans(params.code)
            return [coupon : coupon, refereeFans : refereeFans, title : title, openId: currentFans.openId]
        } else {
            def context = WeChatContext.defaultContext()
            def url = WeChatUrlUtil.snsapiBaseUrl(context.appId, params.requestUrl+"?referee=${params.referee}")
            return [redirectUrl: url] //product qrcode not found
        }
    }

    @Transactional
    def acceptCoupon(){
        log.info("Accept coupon, referee: ${params.referee}, couponId: ${params.couponId}")
        WeChatFans refereeFans = WeChatFans.findByOpenId(params.referee)
        WeChatFans currentFans = SessionUtil.getSessionValue(SessionUtil.SESSION_WECHAT_FANS)

        UserInfo refereeUserInfo = refereeFans?.userInfo
        UserInfo currentUserInfo = currentFans?.userInfo
        CouponTemplate couponTemplate = CouponTemplate.get(params.couponId)

        Coupon coupon = Coupon.findByConsumer(currentUserInfo)
        def used = false
        if(coupon){
            log.info("The consumer already accept the coupon")
            used = true
        }else{
            coupon = new Coupon(referee: refereeUserInfo, consumer: currentUserInfo, coupon: couponTemplate, valid: true)
        }
        coupon.save()

        [productId: couponTemplate.product.id, used: used]
    }

    def alipay(){
        log.info("Use alipay to pay, outTradeNo: ${params.outTradeNo}")

        Payment payment = Payment.findByOutTradeNo(params.outTradeNo)
        AlipayContext context = AlipayContext.first()
        [payment  : payment,
         context  : context
        ]
    }

    @Transactional
    def refreshOrderPrice() {
        log.info("Refresh order price, orderIds: ${params.orderIds}, promotionCode: ${params.promotionCode}")

        Collection<ProductOrder> orders
        def newPriceList = []

        if (params.orderIds) {
            def ids = ObjectUtils.convertList(params.orderIds)
            orders = ProductOrder.findAllByIdInList(ids)
        }

        if (!orders) {
            render ErrorCodeUtil.noOrderFound()
            return
        }
        def userInfo = SessionUtil.userInfo?.refresh()
        PromotionCode promotionCode = PromotionCode.findByCode(params.promotionCode)

        // Promotion code is invalid or expired
        if (!promotionCode || !promotionCode.isValid(orders)) {
            orders.each { order ->
                order.address = order.userInfo?.defaultAddress
                if (order.promotionCode != null) {        //only refresh when original order has promotion code
                    newPriceList << originalPrice(order)
                }
            }

            def userAddress = userInfo?.defaultAddress
            render ErrorCodeUtil.noError([newPriceList: newPriceList,
                                          totalPrice  : orders.sum { it.currentPrice() },
                                          desc      : promotionCode?.description,
                                          address   : userAddress ? [name   : userAddress.name,
                                                                     address: userAddress.toString(),
                                                                     phone: userAddress.phone,
                                                                     id   : userAddress.id] : null,
                                          isLxGroup : false,
                                          fixAddress: false

            ])
            return
        }

        //promotion code only valid for no discount order
        orders.each { order ->
            if (!order.batch.isPresales()) {
                if (promotionCode.isPromotionOrder(order)) {
                    def discountedPrice
                    if (promotionCode.price != null) {
                        discountedPrice = promotionCode.price
                    } else {
                        discountedPrice = (order.marketPrice * promotionCode.discount).setScale(1, BigDecimal.ROUND_HALF_UP).setScale(2, BigDecimal.ROUND_HALF_UP)
                    }

                    order.orderPrice = discountedPrice
                    order.promotionCode = promotionCode
                    if (promotionCode.address) {
                        order.updateDeliveryAddress(promotionCode.address, userInfo.mobile)
                    }
                    order.discount = ((order.marketPrice - order.orderPrice) / order.marketPrice).setScale(2, BigDecimal.ROUND_HALF_UP)
                    if (order.quantity > promotionCode.maximumUsed - promotionCode.usedCount) {
                        order.quantity = promotionCode.maximumUsed - promotionCode.usedCount
                    }
                    newPriceList << [orderId : order.id,
                                     price   : order.orderPrice,
                                     discount: order.marketPrice - order.orderPrice,
                                     quantity: order.quantity]
                    if (promotionCode.address) {
                        order.address = promotionCode.address
                    }
                } else {
                    order.address = order.userInfo?.defaultAddress
                    newPriceList << originalPrice(order)
                }
            }
        }
        def totalPrice = orders.sum { it.currentPrice() }
        ProductOrder.saveAll(orders)

        def refreshAddress = promotionCode.address ? promotionCode.address : userInfo?.defaultAddress

        render ErrorCodeUtil.noError([newPriceList: newPriceList,
                                      totalPrice  : totalPrice,
                                      desc        : promotionCode.description,
                                      isValid     : promotionCode.isValid(orders),
                                      expireDate  : FormatUtil.formatDate(promotionCode.expiredDate),
                                      address  : refreshAddress ? [name   : refreshAddress.name,
                                                                   address: refreshAddress.toString(),
                                                                   phone  : refreshAddress.phone,
                                                                   id     : refreshAddress.id] : null,
                                      isLxGroup: refreshAddress ? true : false,
                                      headImage: refreshAddress?.userInfo?.weChatFans?.headImgUrl,
                                      fixAddress: promotionCode.address != null])
    }

    def originalPrice(ProductOrder order) {
        order.orderPrice = order.batch.price
        if (order.batch.batchState == Batch.BatchState.CURRENT_STATE_PRESALES.state
        ) {
            order.discount = order.batch.discount
        } else {
            order.discount = 0
        }
        return [orderId : order.id, price: order.orderPrice,
                discount: order.marketPrice - order.orderPrice,
                quantity: order.quantity]
    }

    def wechatpay() {
        def weChatContext = WeChatContext.defaultContext()
        def ticket = weChatBasicService.getJsApiTicket()
        def url = "${params.requestUrl}${request.queryString ? "?" + request.queryString : ""}"
        log.info("Sign for url: ${url}")
        def signature = SignUtil.sign(ticket, url)
        signature.appId = weChatContext.appId

        [signature: signature]
    }

    @Transactional
    def processWechatPay() {
        log.info("Process wechat pay, openId: ${params.openId}, batchId:${params.batchId}, quantity:${params.quantity}")

        if (!(params.openId && params.batchId && params.quantity)) {
            log.error("Cannot pay for missing info order, openId: ${params.openId}, batchId:${params.batchId}, quantity:${params.quantity}")
            render ErrorCodeUtil.cannotPayForMissingInfoOrder()
            return
        }
        //create order
        WeChatFans fans = WeChatFans.findByOpenId(params.openId)
        UserInfo userInfo = fans?.userInfo

        if (!userInfo) {
            render ErrorCodeUtil.userNotYetRegister()
            return
        }

        Batch batch = Batch.get(params.batchId)
        ProductOrder order = shoppingCartService.createOrder(batch, params.quantity as int)
        order.save()

        //generate pay info
        def payInfo = paymentService.processPay([order], true, paymentService.processWeChatPay, request.getRemoteAddr(), userInfo)

        if (payInfo.errorcode == 0) {
            render ErrorCodeUtil.noError(payInfo.data)
        } else {
            render ErrorCodeUtil.paymentFail()
        }
    }
}
