/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

import grails.test.mixin.TestFor
import net.xunzhenji.model.DeliveryStatus
import net.xunzhenji.model.DisplayStatus
import net.xunzhenji.model.PaymentStatus
import net.xunzhenji.security.Authority
import net.xunzhenji.security.Person
import net.xunzhenji.security.PersonAuthority
import net.xunzhenji.wechat.WeChatContext
import net.xunzhenji.wechat.WeChatFans
import org.apache.commons.lang.time.DateUtils
import org.junit.Before
import org.junit.BeforeClass
import org.junit.Test

@TestFor(ProductOrder.class)
class OrderLifeCycleTest extends GroovyTestCase {
    def producer
    def category
    def product
    def batch
    def express
    def userInfo
    def organizer1
    def organizer2

    void setUp() {
        def ip = InetAddress.getLocalHost().getHostAddress()
        def sliderImage2 = new Image(fullPath: "C:\\opt\\upload\\image\\2015\\06\\1434299591530-0.895102787291178.jpg",
                path: "image/2015/06/1434299591530-0.895102787291178.jpg",
                thumbPath: "image/2015/06/1434299591530-0.895102787291178.jpg",
                mobilePath: "image/2015/06/1434299591530-0.895102787291178.jpg",
                url: "http://${ip}:8080/upload/file/image/2015/06/1434299591530-0.895102787291178.jpg", host: "_", size: 0, uploadName: "_",
                fileName: "1434299591530-0.895102787291178.jpg",
                thumbFileName: "1434299591530-0.895102787291178.jpg",
                mobileFileName: "1434299591530-0.895102787291178.jpg",
                thumbUrl: "http://${ip}:8080/upload/file/image/2015/06/1434299591530-0.895102787291178.jpg",
                mobileUrl: "http://${ip}:8080/upload/file/image/2015/06/1434299591530-0.895102787291178.jpg",
                deleteUrl: "http://${ip}:8080/upload/delete/image/2015/06/1434299591530-0.895102787291178.jpg")
        sliderImage2.save(flush:true)
        def head = new Image(fullPath: "C:\\opt\\upload\\image\\2015\\06\\1434769221557-0.2586717082746728.jpg",
                path: "image/2015/06/1434769221557-0.2586717082746728.jpg",
                mobilePath: "image/2015/06/1434769221557-0.2586717082746728.jpg",
                thumbPath: "image/2015/06/1434769221557-0.2586717082746728.jpg",
                url: "http://${ip}:8080/upload/file/image/2015/06/1434769221557-0.2586717082746728.jpg", host: "_", size: 0, uploadName: "_",
                fileName: "1434769221557-0.2586717082746728.jpg",
                thumbFileName: "1434769221557-0.2586717082746728.jpg",
                mobileFileName: "1434769221557-0.2586717082746728.jpg",
                thumbUrl: "http://${ip}:8080/upload/file/image/2015/06/1434769221557-0.2586717082746728.jpg",
                mobileUrl: "http://${ip}:8080/upload/file/image/2015/06/1434769221557-0.2586717082746728.jpg",
                deleteUrl: "http://${ip}:8080/upload/delete/image/2015/06/1434769221557-0.2586717082746728.jpg")
        head.save(flush: true)

        category = new Category(name: "茶叶", introduction: "非常好的茶", logo: sliderImage2, deliverDaysInWeek: "1,3")
        category.save(flush: true)
        producer = new Producer(name: "李陶明", introduction: "现代的陶渊明", address: "韶关南雄苍石寨",
                head: [head], latitude: 23.1691053, longitude: 113.32840776)
        producer.save(flush: true)
        head.ownerClass = producer.class.getName()
        head.ownerId = producer.id

        express = new Express(name: "顺丰", phone: "123", deliverRange: "dsfsdf", firstWeightPrice: 25, continuedWeightPrice: 5, firstWeightTo: 1)
        express.save()

        product = new Product(title: '自然保护区好茶', introduction: "青嶂山自然保护区里生长的茶叶", images: [sliderImage2],
                content: "<p>好好喝</p><p><img data-original=\"/upload/file/image/2015/06/1434299591530-0.895102787291178.jpg\" class=\"lazy\" style=\"width:100%;\" />\n" +
                        "</p>", price: 200, origin: "韶关南雄青嶂山", extraPeriod: 365, category: category, producer: producer, delivery: "顺丰",
                deposit: 1, express: express)
        product.save(flush: true)

        batch = new Batch(productionDate: new Date().clearTime() + 40,
                paymentDate: new Date().clearTime() + 10, title: "中秋专供", content: "好好啊", product: product, images: [sliderImage2],
                price: 180, discount: 0.01, cost: 100, unitAllowance: 0.2)

        batch.save(flush: true)

        def city = new City(province: "广东", name: "广州")
        def district1 = new District(name: "天河区", city: city)
        def district2 = new District(name: "番禺区", city: city)
        city.districts = [district1, district2]
        city.save(flush: true)
        District.saveAll(district1, district2)

        //Buyer's user info
        def buyerUserInfo = new UserInfo(mobile: "1232423432", name: "cloud", person: Person.first())
        buyerUserInfo.save(flush: true)
        new Address(isDefault: true, name: "cloud家", city: city, district: district1, street: "昌盛街", address: "隆昌巷13号A栋1501室", phone: "13570470000", latitude: 23.1691053, longitude: 113.32840776, userInfo: buyerUserInfo).save(flush: true)


        def ZhangSanFans = new WeChatFans(nickName: 'LiSi', openId: "14524543534", subscribeTime: new Date().getTime(),
                weChatContext: WeChatContext.defaultContext(),
                headImgUrl: "http://wx.qlogo.cn/mmopen/A48S5EHf6sVr7aaOy1WJ95fjjIO6RNMXAvq2b0B1CQlYiaz1ibRDzqmsHJD15SRVFPdicpyS4QSJqGXFCp2v7mib7yFrCmyECicyO/0")
        ZhangSanFans.save()

        //Organizer's user info
        organizer1 = new UserInfo(mobile: "0232423111", name: "ZhangSan", weChatFans: ZhangSanFans)
        organizer1.save(flush: true)
        def organizerAddress = new Address(isDefault: true, name: "ZhangSan家", city: city, district: district1, street: "昌盛街", address: "隆昌巷13号A栋1501室", phone: "13570470000", latitude: 23.1691053, longitude: 113.32840776, userInfo: organizer1).save(flush: true)


        organizer2 = new UserInfo(mobile: "0232423333", name: "LiSi")
        organizer2.save(flush: true)
        new Address(isDefault: true, name: "Lisi家", city: city, district: district1, street: "昌盛街",
                address: "隆昌巷13号A栋1501室", phone: "13570470000", latitude: 23.1691053, longitude: 113.32840776,
                userInfo: organizer2).save(flush: true)

        //PickupTime
        def pickupTime = new PickupTime(
                dayOfWeek: 1
        )
        pickupTime.save(flush: true)

        //Group for organizer and its members
        def group = new LxGroup(
                organizer: organizer1,
                members: [buyerUserInfo],
                address: organizerAddress,
                pickupTimes: [new PickupTime(dayOfWeek: 1), ],
                groupName: "永远领鲜群",
                phone: "12345678902",
                wechatAccount: "testingAccount2")
        group.addToPickupTimes(new PickupTime(dayOfWeek: 1)).addToPickupTimes(new PickupTime(dayOfWeek: 3)).save()

        //Group for organizer and its members
        def group2 = new LxGroup(
                organizer: organizer2,
                members: [buyerUserInfo],
                address: organizerAddress,
                pickupTimes: [pickupTime],
                groupName: "超级领鲜群",
                phone: "12345678901",
                wechatAccount: "testingAccount")
        group.addToPickupTimes(new PickupTime(dayOfWeek: 2)).addToPickupTimes(new PickupTime(dayOfWeek: 4)).save()
        group2.save(flush: true)

        //////////////////////////////////////////////////////////////////////////////
        userInfo = new UserInfo(name: "张三", mobile: "03570470000", orders: [], weChatFans: ZhangSanFans);
        userInfo.save(flush: true)

        def address = new Address(name: "张三家", city: city, district: district1, street: "昌盛街", address: "隆昌巷13号A栋1501室", phone: "13570470000", userInfo: userInfo)
        address.save(flush: true)
    }

    @Test
    void testOrderLifecycle() {
        def userInfo = UserInfo.findByMobile("03570470000")
        def order = ProductOrder.createOrder(batch, 1, batch.price, batch.price, 1,  0.2,   userInfo)
        userInfo.addToOrders(order).save(flush: true)

        assert order.displayStatus == DisplayStatus.PENDING_PAYMENT.name
        assert order.paymentStatus == PaymentStatus.UNPAID.id
        assert order.deliveryStatus == DeliveryStatus.INSTORE.id

        order.organizer = UserInfo.findByMobile("0232423111")
        order.pay()
        order.save(flush: true)
        assert order.displayStatus == DisplayStatus.PENDING_PAYMENT.name
        assert order.paymentStatus == PaymentStatus.PAID_FOR_DEPOSIT.id
        assert order.deliveryStatus == DeliveryStatus.INSTORE.id
        def lxGroup = LxGroup.findByPhone("02345678902")
        def orders = LxGroupProductOrder.findByLxGroup(lxGroup)*.productOrder
        assert orders.size() == 1
        assert order.commission?.state == Commission.CommissionState.STATE_UNREALISED.id
        assert order.refundAmount == 9.50

        order.payForFullPrice()
        order.save(flush: true)
        assert order.displayStatus == DisplayStatus.PENDING_CONFIRM_DELIVER_TIME.name
        assert order.paymentStatus == PaymentStatus.PAID_FOR_FULLPRICE.id
        assert order.deliveryStatus == DeliveryStatus.INSTORE.id

        order.confirmDeliveryDate()
        order.save(flush: true)
        assert order.displayStatus == DisplayStatus.PENDING_DELIVERY.name
        assert order.paymentStatus == PaymentStatus.PAID_FOR_FULLPRICE.id
        assert order.deliveryStatus == DeliveryStatus.CONFIRM_DELIVER_DATE.id

        order.startDelivery()
        order.save(flush: true)
        assert order.displayStatus == DisplayStatus.DELIVERY_PROCESSING.name
        assert order.paymentStatus == PaymentStatus.PAID_FOR_FULLPRICE.id
        assert order.deliveryStatus == DeliveryStatus.PROCESSING.id

        order.arriveAtOrganizer()
        order.save(flush: true)
        assert order.displayStatus == DisplayStatus.PENDING_RETRIEVAL.name
        assert order.paymentStatus == PaymentStatus.PAID_FOR_FULLPRICE.id
        assert order.deliveryStatus == DeliveryStatus.ARRIVED_AT_ORGANIZER.id

        //群主确认顾客已经取货
        order.customerGotTheProduct()
        order.save(flush: true)
        assert order.displayStatus == DisplayStatus.ALREADY_RETRIEVAL.name
        assert order.paymentStatus == PaymentStatus.PAID_FOR_FULLPRICE.id
        assert order.deliveryStatus == DeliveryStatus.CUSTOMER_GOT_THE_PRODUCT.id

        //顾客确认已经取货或货到
        order.completeDelivery()
        order.save(flush: true)
        assert order.displayStatus == DisplayStatus.DELIVERED.name
        assert order.paymentStatus == PaymentStatus.PAID_FOR_FULLPRICE.id
        assert order.deliveryStatus == DeliveryStatus.DELIVERED.id

        order.commentOrder()
        order.save(flush: true)
        assert order.displayStatus == DisplayStatus.COMMENTED.name
        assert order.paymentStatus == PaymentStatus.PAID_FOR_FULLPRICE.id
        assert order.deliveryStatus == DeliveryStatus.COMMENTED.id
    }

    @Test
    void testOrderCommission() {
        def userInfo1 = UserInfo.findByMobile("03570470000")
        def userInfo2 = UserInfo.findByMobile("0232423432")
        def order1 = ProductOrder.createOrder(batch, 2, batch.price, batch.price, 1,  0.2,  userInfo1)
        userInfo1.addToOrders(order1).save(flush: true)

        def order2 = ProductOrder.createOrder(batch, 6, batch.price, batch.price, 1,  0.2,  userInfo2)
        userInfo1.addToOrders(order2).save(flush: true)

        order1.organizer = UserInfo.findByMobile("0232423111")
        order1.pay()
        order1.save(flush: true)
        assert order1.commission.amount == 14
        assert order1.refundAmount == 10

        order2.organizer = UserInfo.findByMobile("0232423111")
        order2.pay()
        order2.save(flush: true)
        assert order1.commission.amount == 24.5
        assert order2.commission.amount == 73.5
        assert order1.refundAmount == 17.5
        assert order2.refundAmount == 52.5
        assert order1.commission.state == Commission.CommissionState.STATE_UNREALISED.id
        assert order2.commission.state == Commission.CommissionState.STATE_UNREALISED.id

        order1.payForFullPrice()
        order1.save(flush: true)
        assert order1.commission.amount == 24.5
        assert order2.commission.amount == 73.5
        assert order1.refundAmount == 17.5
        assert order2.refundAmount == 52.5
        assert order1.commission.state == Commission.CommissionState.STATE_UNREALISED.id
        assert order2.commission.state == Commission.CommissionState.STATE_UNREALISED.id

        order2.payForFullPrice()
        order2.save(flush: true)
        assert order1.commission.amount == 24.5
        assert order2.commission.amount == 73.5
        assert order1.refundAmount == 17.5
        assert order2.refundAmount == 52.5
        assert order1.commission.state == Commission.CommissionState.STATE_REALISED.id
        assert order2.commission.state == Commission.CommissionState.STATE_REALISED.id

        order1.confirmDeliveryDate()
        order1.save(flush: true)

        order1.startDelivery()
        order1.save(flush: true)


        order1.arriveAtOrganizer()
        order1.save(flush: true)


        //群主确认顾客已经取货
        order1.customerGotTheProduct()
        order1.save(flush: true)


        //顾客确认已经取货或货到
        order1.completeDelivery()
        order1.save(flush: true)

        order1.commentOrder()
        order1.save(flush: true)

    }

}
