/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */


import net.xunzhenji.About
import net.xunzhenji.Classification
import net.xunzhenji.Server
import net.xunzhenji.mall.*
import net.xunzhenji.security.Authority
import net.xunzhenji.security.Person
import net.xunzhenji.security.PersonAuthority
import net.xunzhenji.security.Requestmap
import net.xunzhenji.shop.*
import net.xunzhenji.vendor.SfSetting
import net.xunzhenji.wechat.Keyword
import net.xunzhenji.wechat.WeChatContext
import net.xunzhenji.wechat.WeChatFans
import net.xunzhenji.wechat.WeChatImage
import net.xunzhenji.workflow.MiaoXinWorkflow
import org.apache.commons.lang.time.DateUtils

class BootStrap {
    def weChatBasicService
    def locationService
    def mobileMsgService

    def init = { servletContext ->
        if (!Requestmap.count()) {
            initSandboxTestingData()
        }

        Server.load()

        try{
            weChatBasicService.getAccessToken()
            weChatBasicService.getJsApiTicket()
            mobileMsgService.syncSmsSetting()
        }catch (e){
        }
    }

    def destroy = {
    }

    def void initSandboxTestingData() {
        new Requestmap(url: '/image/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/text/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/editor/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/areply/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/multiimage/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/message/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/weChatGroup/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/weChatFans/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/media/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/classification/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/product/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/productOrder/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/about/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/home/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/category/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/producer/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/batch/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/organizer/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/delivery/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/payment/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/comment/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/suggestion/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/userInfo/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/template/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/quartz/**', configAttribute: 'ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/express/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/commission/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/lxGroup/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/server/**', configAttribute: 'ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/weChatMenu/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/weChatButton/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/user/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/role/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/requestmap/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/qrCodeSetting/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/sfSetting/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/coupon/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/alipayContext/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url:'/smsSetting/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url:'/promotionCode/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url:'/randomLink/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url:'/link/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/weChatCoupon/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/weChatFansActivity/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/shop/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/shopFans/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/shopProduct/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/warehouse/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/stockItem/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/stockMove/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/procurement/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/manufacture/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/shopDelivery/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/miaoXinWorkflow/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/miaoXinProcess/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);

        new Requestmap(url: '/randomLink/get', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/link/get', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/workflow/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);

        new Requestmap(url: '/', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/*.ico', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/qrCode/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/weChatJsApi/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/**/*.js', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/**/*.css', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/**/*.gif', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/**/*.jpg', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/**/*.png', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/fonts/*', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/upload/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/logout/**', configAttribute: 'IS_AUTHENTICATED_REMEMBERED,IS_AUTHENTICATED_FULLY').save(flush: true);
        new Requestmap(url: '/login/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true)
        new Requestmap(url: '/index/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/captcha/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/h5/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/workflow/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/address/listSupportCities/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/address/getDistricts/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/address/updateDefault/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/address/saveAddress/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/address/deleteAddress/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/address/listAddress/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/malltest/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/mall/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/session/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/help/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/clientLog/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/location/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/healthChecker/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/weChatSimulator/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/shopOrder/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/shop/queryShops', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);
        new Requestmap(url: '/shopProduct/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true);

        new Requestmap(url: '/weChatAccount/index', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/weChatAccount/enter/**', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/weChatAccount/list', configAttribute: 'ROLE_EDITOR,ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/weChatAccount/edit/*', configAttribute: 'ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/weChatAccount/save', configAttribute: 'ROLE_ADMIN').save(flush: true);
        new Requestmap(url: '/testing/**', configAttribute: 'ROLE_ADMIN').save(flush: true);

        def adminRole = new Authority(authority: 'ROLE_ADMIN').save(flush: true)
        def editorRole = new Authority(authority: 'ROLE_EDITOR').save(flush: true)
        def userRole = new Authority(authority: 'ROLE_USER').save(flush: true)

        def admin = new Person(username: "admin", password: "admin", accountExpired: false, accountLocked: false, passwordExpired: false)
        admin.save(flush: true)
        PersonAuthority.create admin, adminRole, true

        def user = new Person(username: "18588898788", password: "password", accountExpired: false, accountLocked: false, passwordExpired: false)
        user.save(flush: true)
        PersonAuthority.create admin, userRole, true

        // 138
//            def weChatContext = new WeChatContext(name:"寻真记", weChatId: "AAAA", username:"kevinmedia", appId: "wx9a1b9c202a0d6da6", appSecret: "e0580c46cd77bedf2b397daf69c3bfde", person: admin)
        //155
        def weChatContext = new WeChatContext(name: "寻真记", weChatId: "寻真记测试号",
                username: "kevinmedia", appId: "wx9a1b9c202a0d6da6", appSecret: "e0580c46cd77bedf2b397daf69c3bfde"
                , merchantId: "1247209001", merchantKey: "mchKey", person: admin, email: "xunzhenji@outlook.com")
        weChatContext.save(flush: true)
        admin.weChatContexts = [weChatContext]

        def clazz = new Classification(name: "寻真日记", weChatContext: weChatContext)
        clazz.save(flush: true)

        def keywords = new Keyword(keyword: "香菇", weChatContext: weChatContext)
        keywords.save(flush: true)
        def image = new WeChatImage(keywords: keywords, showPic: 1,
                title: "深山香菇", digest: "好香菇", content: "tesing", classification: clazz,
                author: "Kevin", weChatContext: weChatContext)
        image.save(flush: true)

        def ip = InetAddress.getLocalHost().getHostAddress()
        def sliderImage1 = new Image(fullPath: "C:\\opt\\upload\\image\\2015\\06\\1434299381803-0.6673105085673872.jpg",
                path: "image/2015/06/1434299381803-0.6673105085673872.jpg",
                thumbPath: "image/2015/06/1434299381803-0.6673105085673872.jpg",
                mobilePath: "image/2015/06/1434299381803-0.6673105085673872.jpg",
                url: "http://${ip}:8080/upload/file/image/2015/06/1434299381803-0.6673105085673872.jpg", host: "_", size: 0, uploadName: "_",
                fileName: "1434299381803-0.6673105085673872.jpg",
                thumbFileName: "1434299381803-0.6673105085673872.jpg",
                mobileFileName: "1434299381803-0.6673105085673872.jpg",
                thumbUrl: "http://${ip}:8080/upload/file/image/2015/06/1434299381803-0.6673105085673872.jpg",
                mobileUrl: "http://${ip}:8080/upload/file/image/2015/06/1434299381803-0.6673105085673872.jpg",
                deleteUrl: "http://${ip}:8080/upload/delete/image/2015/06/1434299381803-0.6673105085673872.jpg")
        def sliderImage2 = new Image(fullPath: "C:\\opt\\upload\\image\\2015\\06\\1434552821231-0.5462334816118023.jpg",
                path: "image/2015/06/1434552821231-0.5462334816118023.jpg",
                thumbPath: "image/2015/06/1434552821231-0.5462334816118023.jpg",
                mobilePath: "image/2015/06/1434552821231-0.5462334816118023.jpg",
                url: "http://${ip}:8080/upload/file/image/2015/06/1434552821231-0.5462334816118023.jpg", host: "_", size: 0, uploadName: "_",
                fileName: "1434552821231-0.5462334816118023.jpg",
                thumbFileName: "1434552821231-0.5462334816118023.jpg",
                mobileFileName: "1434552821231-0.5462334816118023.jpg",
                thumbUrl: "http://${ip}:8080/upload/file/image/2015/06/1434552821231-0.5462334816118023.jpg",
                mobileUrl: "http://${ip}:8080/upload/file/image/2015/06/1434552821231-0.5462334816118023.jpg",
                deleteUrl: "http://${ip}:8080/upload/delete/image/2015/06/1434552821231-0.5462334816118023.jpg")
        def head = new Image(fullPath: "C:\\opt\\upload\\image\\2015\\06\\1441603913610-0.408838412136591.jpg",
                path: "image/2015/06/1441603913610-0.408838412136591.jpg",
                mobilePath: "image/2015/06/1441603913610-0.408838412136591.jpg",
                thumbPath: "image/2015/06/1441603913610-0.408838412136591.jpg",
                url: "http://${ip}:8080/upload/file/image/2015/06/1441603913610-0.408838412136591.jpg", host: "_", size: 0, uploadName: "_",
                fileName: "1441603913610-0.408838412136591.jpg",
                thumbFileName: "1441603913610-0.408838412136591.jpg",
                mobileFileName: "1441603913610-0.408838412136591.jpg",
                thumbUrl: "http://${ip}:8080/upload/file/image/2015/06/1441603913610-0.408838412136591.jpg",
                mobileUrl: "http://${ip}:8080/upload/file/image/2015/06/1441603913610-0.408838412136591.jpg",
                deleteUrl: "http://${ip}:8080/upload/delete/image/2015/06/1441603913610-0.408838412136591.jpg",
        ownerClass: Producer.class.name, ownerField: "head")
        head.save(flush:true)

        Image.saveAll([sliderImage1, sliderImage2, head])
        def homePage = new HomePage(title: "寻真记 - 给你最真实，最天然，最安全，最健康的食材", images: [sliderImage1, sliderImage2])
        homePage.content = "<p>寻真记 - 给你最真实，最天然，最安全，最健康的食材</p>"
        homePage.save(flush: true)
        sliderImage1.ownerClass = homePage.class.getName()
        sliderImage1.ownerId = homePage.id
        sliderImage2.ownerClass = homePage.class.getName()
        sliderImage2.ownerId = homePage.id

        def category = new Category(name: "茶叶", introduction: "非常好的茶", logo: sliderImage2, deliverDaysInWeek: "1,3")
        category.save(flush: true)
        def producer = new Producer(name: "李陶明", introduction: "现代的陶渊明", address: "韶关南雄苍石寨",
                head: [head], latitude: 23.1691053, longitude: 113.32840776)
        producer.save(flush: true)
        head.ownerClass = producer.class.getName()
        head.ownerId = producer.id

        def sfExpress = new Express(name: "顺丰", phone: "123", queryName: "shunfeng", deliverRange: "dsfsdf", firstWeightPrice: 17, continuedWeightPrice: 2, firstWeightTo: 1)
        sfExpress.save()
        def ydExpress = new Express(name: "韵达", phone: "123", queryName: "yunda", deliverRange: "dsfsdf", firstWeightPrice: 17, continuedWeightPrice: 2, firstWeightTo: 1)
        ydExpress.save()
        def youshuExpress = new Express(name: "优速", phone: "123", queryName: "youshuwuliu", deliverRange: "dsfsdf", firstWeightPrice: 17, continuedWeightPrice: 2, firstWeightTo: 1)
        youshuExpress.save()

        def product = new Product(title: '自然保护区好茶', introduction: "青嶂山自然保护区里生长的茶叶", images: [sliderImage1, sliderImage2],
                content: "<p>好好喝</p><p><img data-original=\"/upload/file/image/2015/06/1434641966103-0.21999390526294316.jpg\" class=\"lazy\" style=\"width:100%;\" />\n" +
                        "</p>", price: 200, origin: "韶关南雄青嶂山", extraPeriod: 365, category: category, producer: producer, delivery: "顺丰",
                deposit: 1, express: sfExpress, banner: sliderImage2, grossWeight: 3000)
        product.save(flush: true)

        def product2 = new Product(title: '苍石灵芝鸡', introduction: "最好吃的鸡", images: [sliderImage1, sliderImage2],
                content: "<p>好好喝</p><p><img data-original=\"/upload/file/image/2015/06/1434552821231-0.5462334816118023.jpg\" class=\"lazy\" style=\"width:100%;\" />\n" +
                        "</p>", price: 200, origin: "韶关南雄苍石风景区", extraPeriod: 365, category: category, producer: producer, delivery: "顺丰",
                deposit: 1, express: sfExpress, banner: sliderImage1)
        product2.save(flush: true)

        def product3 = new Product(title: '苍石灵芝鸡', introduction: "最好吃的鸡", images: [sliderImage1, sliderImage2],
                content: "<p>好好喝</p><p><img data-original=\"/upload/file/image/2015/06/1434552821231-0.5462334816118023.jpg\" class=\"lazy\" style=\"width:100%;\" />\n" +
                        "</p>", price: 200, origin: "韶关南雄苍石风景区", extraPeriod: 365, category: category, producer: producer, delivery: "顺丰",
                deposit: 1, express: sfExpress, banner: sliderImage1)
        product3.save(flush: true)


        def batch = new Batch(productionDate: new Date().clearTime() + 40,
                paymentDate: new Date().clearTime() + 10, title: "中秋专供", content: "好好啊", product: product, images: [sliderImage2],
                price: 180, discount: 0.01, cost: 100, unitAllowance: 0.2)

        batch.save(flush: true)

        def city = new City(province: "广东", name: "广州")
        def district1 = new District(name: "天河区", city: city)
        def district2 = new District(name: "番禺区", city: city)
        city.districts = [district1, district2]
        city.save(flush: true)
        District.saveAll(district1, district2)

        //Stub data
        //First, we have a batch that associates with product
        def batchForNationalDay = new Batch(productionDate: DateUtils.parseDate("15-09-26", "yy-MM-dd"),
                paymentDate: DateUtils.parseDate("15-07-01", "yy-MM-dd"), title: "测试专供", content: "好好啊", product: product, images: [sliderImage2],
                price: 180, discount: 0.01, batchState: Batch.BatchState.CURRENT_STATE_AFTER_PAYMENT_DAY.state)

        batchForNationalDay.save(flush: true)

        //Buyer's user info
        def buyerUserInfo = new UserInfo(mobile: "1232423432", name: "cloud", person: user)
        buyerUserInfo.save(flush: true)
        new Address(isDefault: true, name: "cloud家", city: city, district: district1, street: "昌盛街", address: "隆昌巷13号A栋1501室", phone: "13570470000", latitude: 23.1691053, longitude: 113.32840776, userInfo: buyerUserInfo).save(flush: true)


        def ZhangSanFans = new WeChatFans(nickName: 'LiSi', openId: "124543534", subscribeTime: new Date().getTime(),
                weChatContext: weChatContext,
                headImgUrl: "http://wx.qlogo.cn/mmopen/A48S5EHf6sVr7aaOy1WJ95fjjIO6RNMXAvq2b0B1CQlYiaz1ibRDzqmsHJD15SRVFPdicpyS4QSJqGXFCp2v7mib7yFrCmyECicyO/0",
                lastActivityTime: new Date() - 1)
        ZhangSanFans.save()

        //Organizer's user info
        def organizerUserInfo = new UserInfo(mobile: "1232423111", name: "ZhangSan", weChatFans: ZhangSanFans)
        organizerUserInfo.save(flush: true)
        def organizerAddress = new Address(isDefault: true, name: "ZhangSan家", city: city, district: district1, street: "昌盛街", address: "隆昌巷13号A栋1501室", phone: "13570470000", latitude: 23.1691053, longitude: 113.32840776, userInfo: organizerUserInfo).save(flush: true)


        def organizerUserInfo2 = new UserInfo(mobile: "1232423333", name: "LiSi")
        organizerUserInfo2.save(flush: true)
        new Address(isDefault: true, name: "Lisi家", city: city, district: district1, street: "昌盛街",
                address: "隆昌巷13号A栋1501室", phone: "13570470000", latitude: 23.1691053, longitude: 113.32840776,
                userInfo: organizerUserInfo2).save(flush: true)

        //PickupTime
        def pickupTime = new PickupTime(
                dayOfWeek: 1,
                startTime: "00:00",
                endTime: "23:59"
        )
        pickupTime.save(flush: true)

        //Group for organizer and its members
        def group = new LxGroup(
                organizer: organizerUserInfo,
                members: [buyerUserInfo],
                address: organizerAddress,
                pickupTimes: [pickupTime],
                groupName: "永远领鲜群",
                phone: "12345678902",
                wechatAccount: "testingAccount2")
        group.save(flush: true)

        //Group for organizer and its members
        def group2 = new LxGroup(
                organizer: organizerUserInfo2,
                members: [buyerUserInfo],
                address: organizerAddress,
                pickupTimes: [pickupTime],
                groupName: "超级领鲜群",
                phone: "12345678901",
                wechatAccount: "testingAccount")
        group2.save(flush: true)

        group.createOneMonthDelivery()
        group2.createOneMonthDelivery()
        //////////////////////////////////////////////////////////////////////////////


        def userInfo = new UserInfo(name: "张三", mobile: "18588898788", orders: [], weChatFans: ZhangSanFans);
        userInfo.save(flush: true)

        def address = new Address(name: "张三家", city: city, district: district1, street: "昌盛街", address: "隆昌巷13号A栋1501室", phone: "13570470000", userInfo: userInfo, latitude: 100, longitude: 100)
        address.save(flush: true)

        // order still in shopping cart
        def productOrder1 = ProductOrder.createOrder(batch, 1, batch.price, batch.price, 1, 0.2, userInfo)
        userInfo.addToOrders(productOrder1).save(flush: true)


        def productOrder2 = ProductOrder.createOrder(batch, 1, batch.price * 0.9, batch.price, 1, 0.2, userInfo)
//        productOrder2.organizer = organizerUserInfo
        userInfo.orders << productOrder2
        productOrder2.save(flush: true)
        productOrder2.pay()
        productOrder2.save(flush: true)

        def productOrder3 = ProductOrder.createOrder(batch, 2, batch.price * 0.85, batch.price, 2, 0.2, userInfo)
//        productOrder3.organizer = organizerUserInfo
        userInfo.orders << productOrder3
        productOrder3.save(flush: true)
        productOrder3.pay()
        productOrder3.payForFullPrice()
        productOrder3.startConfirmDeliveryDate()
        productOrder3.save(flush: true)

        def productOrder4 = ProductOrder.createOrder(batch, 6, batch.price * 0.85, batch.price, 6, 0.2, userInfo)
//        productOrder4.organizer = organizerUserInfo
        userInfo.orders << productOrder4
        productOrder4.save(flush: true)
        productOrder4.pay()
        productOrder4.organizer = organizerUserInfo2
        productOrder4.payForFullPrice()
        productOrder4.startDelivery()
        productOrder4.arriveAtOrganizer()
        productOrder4.save(flush: true)

        def productOrder5 = ProductOrder.createOrder(batch, 3, batch.price * 0.85, batch.price, 3, 0.2, userInfo)
//        productOrder5.organizer = organizerUserInfo
        userInfo.orders << productOrder5
        productOrder5.save(flush: true)
        productOrder5.pay()
        productOrder5.payForFullPrice()
        productOrder5.startDelivery()
        productOrder5.arriveAtOrganizer()
        productOrder5.completeDelivery()
        productOrder5.save()
        userInfo.save(flush: true)

        def productOrder6 = ProductOrder.createOrder(batch, 4, batch.price * 0.85, batch.price, 10, 0.2, userInfo)
//        productOrder6.organizer = organizerUserInfo
        userInfo.orders << productOrder6
        productOrder6.save(flush: true)
        productOrder6.pay()
        productOrder6.payForFullPrice()
        productOrder6.startDelivery()
        productOrder6.arriveAtOrganizer()
        productOrder6.completeDelivery()
        productOrder6.commentOrder()
        productOrder6.confirmCommission()
        productOrder6.save()
        userInfo.save(flush: true)

        group.paymentCut(batch)

        def payment = Payment.createCustomerPayment(prepayId: "xxxx", amount: 909, cashFee: 909, outTradeNo: "123456", openid: "123456", isSubscribe: "Y", type: Payment.TYPE_WECHAT)
        payment.save()
        userInfo.addToPayments(payment).save()
        productOrder1.addToPayments(payment).save()
        productOrder2.addToPayments(payment).save()

        productOrder3.addToPayments(payment).save()
        productOrder4.addToPayments(payment).save()
        productOrder5.addToPayments(payment).save()

        def suggestions = []
        def weChatFans = new WeChatFans(nickName: 'Mike', openId: "1234", subscribeTime: new Date().getTime(),
                weChatContext: weChatContext)
        weChatFans.save()
        (1..35).each {
            suggestions << new Suggestion(content: "Content ${it}", weChatFans: weChatFans)
        }
        Suggestion.saveAll(suggestions)

        if (About.findAll().size() == 0) {
            def about = new About(content: "<p style=\"text-align:center;\">寻真记 - 给你最真实，最天然，最安全，最健康的食材</p>")
            about.save(flush: true)
        }

        Delivery delivery1 = new Delivery(targetDeliveryDate: new Date().clearTime() + 3, batch: batch, address: address, express: youshuExpress)
        delivery1.save()
        new DeliveryProductOrders(delivery: delivery1, productOrder: productOrder3).save()
        Delivery delivery2 = new Delivery(targetDeliveryDate: new Date().clearTime() + 3, batch: batch, address: address, express: youshuExpress)
        delivery2.save()
        new DeliveryProductOrders(delivery: delivery2, productOrder: productOrder4).save()

        SfSetting sfSetting = new SfSetting(
                serverAddress: "http://218.17.248.244:11080/bsp-oisp/sfexpressService",
                clientCode: "GZSYS",
                checkword: "i0kMMWzlSvhmNNc4",
                expressType: "1",
                fromContact: "寄方地址",
                fromCompany: "广州市源穑农业科技发展有限公司",
                fromTel: "020-87266476",
                fromAddress: "广州市元岗路600号慧通产业广场A2栋2305",
                payMethod: "1",
                custId: "0203120695",
                shipperCode: "020",
                addedServiceCode: ""
        )
        sfSetting.save()

        new PromotionCode(title: "指定价格测试",
                description: "指定价格测试描述",
                code: "1234",
                expiredDate: new Date().clearTime() + 10,
                price: 110,
                minimumOrder: 0,
                maximumUsed: 99999,
                usedCount: 0).save()
        new PromotionCode(title: "指定折扣测试",
                description: "指定折扣测试描述",
                code: "4321",
                expiredDate: new Date().clearTime() + 10,
                discount: 0.9,
                minimumOrder: 0,
                maximumUsed: 99999,
                usedCount: 0).save()
        new PromotionCode(title: "免费支付测试",
                description: "免费支付测试描述",
                code: "0000",
                expiredDate: new Date().clearTime() + 10,
                price: 0,
                minimumOrder: 0,
                maximumUsed: 99999,
                usedCount: 0).save()

        def warehouse1 = new Warehouse(name: "老米仓库", location: "马市镇")
        warehouse1.save()
        def warehouse2 = new Warehouse(name: "千禧仓库", location: "千禧花园")
        warehouse2.save()
        def manufactureProduct = new ShopProduct(name: "毛鸡", quantityUnit: ProductUnit.Zhi, weightUnit: ProductUnit.Jin, defaultPrice: 9, defaultWareHouse: warehouse1,
                saleable: false, procurable: true)
        manufactureProduct.save()
        def deliveryProduct = new ShopProduct(name: "肉鸡", quantityUnit: ProductUnit.Zhi, weightUnit: ProductUnit.Jin, defaultPrice: 15, defaultWareHouse: warehouse2,
                saleable: true, procurable: true)
        deliveryProduct.save()

        new Shop(name: "上步店", displayForSelect: true).save()
        new Source(name: "张三", phone: "12121", address: "南雄").save()
        new MiaoXinWorkflow(name:"淼鑫工作流", manufactureWarehouse: warehouse1, deliveryWarehouse: warehouse2,
                manufactureProduct: manufactureProduct, deliveryProduct: deliveryProduct).save()
    }
}
