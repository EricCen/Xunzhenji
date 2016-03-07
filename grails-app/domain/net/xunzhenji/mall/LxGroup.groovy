package net.xunzhenji.mall

import grails.transaction.Transactional
import net.xunzhenji.util.LocationUtil

class LxGroup {
    def static final int GROUP_MIN_QUANTITY = 8
    def String groupName
    def String wechatAccount
    def String phone
    def UserInfo organizer;
    def Address address;
    def Boolean deliverable = Boolean.FALSE  //提供送货服务
    def Date dateCreated

    static hasMany = [pickupTimes: PickupTime]

    static mapping = {
        pickupTimes lazy: false
    }

    static constraints = {
        address nullable: true;
    }


    def getDistance(Address _address) {
        return shieldDistance(LocationUtil.distance(
                address.latitude,
                address.longitude,
                _address.latitude,
                _address.longitude));
    }

    def static findNearby(Double lat, Double lng, Long targetDistance, size, userInfo, deliverDaysInWeek) {
        def addressList = Address.findAllByLatitudeBetweenAndLongitudeBetween(
                lat - LocationUtil.HALF_KM_LATLNG, lat + LocationUtil.HALF_KM_LATLNG,
                lng - LocationUtil.HALF_KM_LATLNG, lng + LocationUtil.HALF_KM_LATLNG)
        def groups = LxGroup.findAllByAddressInList(addressList)
        def daysFilter = deliverDaysInWeek?.split(",").collect { it ? it as int : null}

        if (daysFilter) {
            groups = groups.findAll {
                it.intersectDeliveryDaysInWeek(daysFilter)?.size() > 0
            }
        }

        def ret = groups.collect {
            double actualDistance = LocationUtil.distance(
                    it.address.latitude,
                    it.address.longitude,
                    lat,
                    lng);
            [groupName          : it.groupName,
             groupId            : it.id,
             wechatAccount      : it.wechatAccount,
             phone              : it.phone,
             organizerHeadImgUrl: it.organizer?.weChatFans?.headImgUrl,
             address            : it.address.toString(),
             addressId          : it.address.id,
             distance           : shieldDistance(actualDistance),
             lat                : it.address.latitude,
             lng                : it.address.longitude,
             isMyGroup          : it.containsMember(userInfo),
             memberCount        : it.memberCount()
            ]
        }.findAll { it.distance < targetDistance }

        if (size) return ret.take(size as int)
        return ret
    }

    def containsMember(userInfo) {
        return LxGroupMembers.countByUserInfoAndLxGroup(userInfo, this) > 0
    }

    def memberCount() {
        return LxGroupMembers.countByLxGroup(this)
    }

    def headImageUrl() {
        return organizer.headImageUrl()
    }

    def static shieldDistance(double distance) {
        def distanceList = [10, 20, 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000]
        def shieldedDistance = -1
        distanceList.reverse().each {
            if (it > distance) {
                shieldedDistance = it
            } else {
                return
            }
        }
        return shieldedDistance
    }

    Collection<ProductOrder> sameBatchOrders(Batch batch) {
        LxGroupProductOrder.findAllByLxGroup(this)?.collect{it.productOrder}?.findAll { it.batch == batch }
    }

    int totalQuantity(batch) {
        def _sameBatchOrders = sameBatchOrders(batch)
        _sameBatchOrders ? _sameBatchOrders.sum { it.quantity } : 0
    }

    def unitSavedExpressFee(batch) {
        def product = batch.product
        def savedExpressFee = product.express.calcSavedExpressFee(totalQuantity(batch), product.weight / 1000.0)
        return (savedExpressFee / totalQuantity(batch)).setScale(2, BigDecimal.ROUND_HALF_UP)
    }

    def calcUnitCommissionAmt(batch) {
        def unitBaseCommissionAmt = unitSavedExpressFee(batch)
        return (unitBaseCommissionAmt / 2 + unitBaseCommissionAmt * batch.unitAllowance).setScale(2, BigDecimal.ROUND_HALF_UP)
    }

    def calcCommission(batch) {
        def orders = sameBatchOrders(batch)
        def unitCommissionAmt = calcUnitCommissionAmt(batch)
        orders.each { order ->
            def buyer = order.userInfo
            if (order.commission) {
                order.commission.amount = unitCommissionAmt * order.quantity
            } else {
                order.commission = new Commission(amount: unitCommissionAmt * order.quantity,
                        productOrder: order,
                        organizer: organizer,
                        state: Commission.CommissionState.STATE_UNREALISED.id,
                        buyer: buyer,
                        buyerName: buyer?.weChatFans?.nickName ? buyer.weChatFans.nickName : buyer.name,
                        buyerHeadImgUrl: buyer?.weChatFans?.headImgUrl,
                        productName: order.toPayBody()
                )
                order.commission.createCommissionEvent(CommissionEvent.EVENT_CREATE)
            }
            def refundAmt = unitSavedExpressFee(order.batch) * order.quantity / 2
            order.refundAmount = refundAmt
        }
        ProductOrder.saveAll(orders)
    }

    @Transactional
    def addOrderToGroup(ProductOrder order) {
        new LxGroupProductOrder(lxGroup: this, productOrder: order).save()
        def totalQuantity = totalQuantity(order.batch)
        calcCommission(order.batch)

        if (totalQuantity >= LxGroup.GROUP_MIN_QUANTITY) {
            sameBatchOrders(order.batch).each {
                it.groupon = true
            }
        }
    }

    @Transactional
    def removeOrderFromGroup(ProductOrder order) {
        order.commission.cancel()
        order.commission = null
        LxGroupProductOrder.findByLxGroupAndProductOrder(this, order).delete()

        calcCommission(order.batch)

        if (totalQuantity(order.batch) < GROUP_MIN_QUANTITY) {
            log.warn("Because one user quit the group, cause the group broken..")
            // break the group
            sameBatchOrders(order.batch).each {
                it.groupon = false
            }
        }
    }

    def paidCount(batch) {
        def orders = sameBatchOrders(batch)
        return orders.sum { it.paidForFullPrice() ? it.quantity : 0 }
    }

    def payForOrder(order) {
        if (paidCount(order.batch) >= GROUP_MIN_QUANTITY) {
            sameBatchOrders(order.batch).each {
                if (it.paidForFullPrice() && it.commission.isUnrealised()) {
                    it.commission.realise()
                }
            }
        }
    }

    //检查所有还没有付完款的群，检查是否符合成群要求，如果不成群，取消commission
    @Transactional
    def paymentCut(batch) {
        if (paidCount(batch) < GROUP_MIN_QUANTITY) {
            sameBatchOrders(batch).each { order ->
                order.commission.cancel()
                order.commission = null
                order.groupon = false
            }
        } else {
            def notYetPaid = sameBatchOrders(batch).find { !it.paidForFullPrice() }
            notYetPaid.each {
                removeOrderFromGroup(it)
            }
        }

    }

    def getDeliveryByDate(Date date) {
        LxGroupDelivery.findAllByLxGroup(this)?.find{it.delivery.targetDeliveryDate == date}*.delivery
    }

    def intersectDeliveryDaysInWeek(deliverDaysInWeek){
        pickupTimes*.dayOfWeek.intersect(deliverDaysInWeek)
    }

    @Transactional
    def createOneMonthDelivery(){
        def today= new Date().clearTime()
        def oneMonth = today + 42
        def dayOfWeeks = pickupTimes*.dayOfWeek
        def dates = []
        (today..oneMonth).each{
            def cal = Calendar.getInstance()
            cal.setTime(it)
            if(dayOfWeeks.contains(cal.get(Calendar.DAY_OF_WEEK))){
                dates << it
            }
        }
        def delivery = LxGroupDelivery.findAllByLxGroup(this)*.delivery
        def datesNeedsToCreateDelivery = dates.minus(delivery*.targetDeliveryDate)
        def chain = this
        def batches = Batch.list()
        datesNeedsToCreateDelivery.each{ day->
            batches.each{ batch->
                if(day < batch.productionDate) return
                def cal = Calendar.getInstance()
                cal.setTime(day)
                def deliverDaysInWeekArr = batch.product.category.toDeliverDaysInWeekArr()
                if(deliverDaysInWeekArr.contains(cal.get(Calendar.DAY_OF_WEEK))){
                    def newDelivery = new Delivery(targetDeliveryDate: day, address: address,
                            receiver: organizer, isGroupon: true, batch: batch, express: batch.product.express)
                    newDelivery.save(flush: true)
                    new LxGroupDelivery(lxGroup: this, delivery: newDelivery).save()
                }
            }
        }
        chain.save()
    }
}
