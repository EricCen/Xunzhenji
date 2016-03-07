/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.wechat

import net.xunzhenji.mall.ProductOrder
import net.xunzhenji.mall.UserInfo
import net.xunzhenji.model.TextMapping

/**
 * Created by Irene on 2015/12/11.
 */
class WeChatTextService {
    def orderService
    def locationService
    def mobileMsgService

    def static Map openIdCache = [:]
    def static PATTERN_REGISTER = /^注册,.*,\d*/
    def static PATTERN_CODE = /^码,\d{4}/
    def static pattern = [PATTERN_REGISTER, PATTERN_CODE]

    def acceptPattern(String text) {
        def flag = false
        pattern.each {
            if (text ==~ it) {
                flag = true
            }
        }
        return flag
    }

    def handlePattern(openId, text) {
        if (text ==~ PATTERN_REGISTER) {
            confirmRegister(openId, text)
        } else (text ==~ PATTERN_CODE) {
            confirmPhone(openId, text)
        }
    }

    def String mapText(String text, params) {
        log.info("Map text, params: ${params}")
        def ret = text

        if (ret.indexOf(TextMapping.RECENT_ORDERS) >= 0 && params.openId) {
            ret = ret.replace(TextMapping.RECENT_ORDERS, recentOrders(params.openId))
        }
        if (ret.indexOf(TextMapping.LINK) >= 0 && params.url && params.openId) {
            ret = ret.replace(TextMapping.LINK, url(params.url, params.openId))
        }
        if (ret.indexOf(TextMapping.USERNAME) >= 0 && params.openId) {
            def username = username(params.openId)
            ret = ret.replace(TextMapping.USERNAME, username ? username : "")
        }

        log.info("Mapped text, params: ${ret}")
        return ret
    }

    def String recentOrders(openId) {
        Collection<ProductOrder> recentOrders = orderService.recentOrders(openId, 5)
        def recentOrderText = recentOrders.inject("") { text, order ->
            text + order.toBriefText() + " <a href='http://xunzhenji.net/h5/home?orderId=${order.id}&openId=${openId}#order-detail-panel'>详情</a>\n"
        }
        recentOrderText
    }

    def String url(url, openId) {
        def beforeHash = url.indexOf("#") > 0 ? url.substring(0, url.indexOf("#")) : url
        def afterHash = url.indexOf("#") > 0 ? url.substring(url.indexOf("#")) : ""
        def newUrl = beforeHash
        if (beforeHash.indexOf("?") > 0) {
            newUrl += "&openId=${openId}" + afterHash
        } else {
            newUrl += "?openId=${openId}" + afterHash
        }
        newUrl
    }

    def username(openId) {
        WeChatFans fans = WeChatFans.findByOpenId(openId)
        if (fans) {
            return fans.userInfo?.name ? fans.userInfo.name : fans?.nickName
        } else {
            log.warn("No fans found, ${openId}")
        }
        return null
    }

    def confirmRegister(String openId, String text) {
        log.info("Confirm register info, text:${text}")
        if (text != ~PATTERN_REGISTER) {
            return "输入格式有误，例如：注册,张三,18888888888"
        }
        def comps = text.split(",")
        def name = comps[1]
        def phone = comps[2]

        if (!openIdCache[openId]) {
            openIdCache[openId] = [:]
        }

        def seq = openIdCache[openId].seq
        seq = seq ? seq + 1 : 1
        def code = mobileMsgService.bindMobile(phone, seq)
        openIdCache[openId].seq = seq
        openIdCache[openId].code = code
        openIdCache[openId].name = name
        openIdCache[openId].phone = phone
        return "请收到验证短信后输入验证码，格式：<b>码,####</b>  (####代表4位验证码)"
    }

    def confirmPhone(String openId, String text) {
        log.info("Confirm register info, text:${text}")
        if (text != ~PATTERN_CODE) {
            return "输入格式有误，例如：注册,张三,18888888888"
        }
        def code = text.split(",")[1]
        if (openIdCache[openId].code != code) {
            return "验证码有误，请重新输入"
        }

        register(openId, openIdCache[openId].name, openIdCache[openId].phone)
        return "注册成功。如果要添加地址请回复：地址,<姓名>,<电话>,<详细地址>\n例如：地址,张三,18888888888,广州市天河区沙太路322号橡树园D栋1234房"
    }

    def register(String openId, String name, String phone) {
        WeChatFans fans = WeChatFans.findByOpenId(openId)
        UserInfo userInfo = fans.userInfo

        if (userInfo?.name) {
            return
        }

        if (!userInfo) {
            userInfo = new UserInfo(name: name, mobile: phone, weChatFans: fans)
        } else {
            userInfo.name = name
            userInfo.mobile = phone
            userInfo.weChatFans = fans
        }
        userInfo.save()
    }


}
