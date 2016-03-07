/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji

import net.xunzhenji.mall.UserInfo
import net.xunzhenji.util.ErrorCodeUtil
import net.xunzhenji.util.SessionUtil
import net.xunzhenji.util.SignUtil
import net.xunzhenji.util.WeChatUrlUtil
import net.xunzhenji.wechat.WeChatContext

class SessionController {
    def sessionService
    def springSecurityService
    def weChatBasicService

    def bindWxJsApi(){
        log.info("Receive js api request, url:${params.url}")
        def url = params.url
        if(!url){
            render "Missing url"
        }
        def weChatContext = WeChatContext.defaultContext()
        def ticket = weChatBasicService.getJsApiTicket()
        def signature = SignUtil.sign(ticket, url)
        signature.appId = weChatContext.appId
        render ErrorCodeUtil.noError(signature)
    }

    def initSession() {
        log.info("Init session, params:${params}")
        def url = createLink(controller: "h5", action: "home", absolute: true)
        def ret = sessionService.process(params, url)
        redirect(url: url)
    }

    def initErpSession() {
        log.info("Init Erp session, params:${params}")
        def url = createLink(controller: params.c, action: params.a, absolute: true)
        def ret = sessionService.process(params, url)
        redirect(url: url)
    }

    def addUserInfo() {
        log.info("Add user information, ${params}")
        def seq = params.seq as int
        def mobileCode = params.mobileCode
        def randomCode = params.randomCode

        //validate code
        if (!validateCode(seq, mobileCode)) {
            render ErrorCodeUtil.invalidMobileCode()
            return
        }

        def mobile = params.mobile
        def name = params.name
        def password = params.setPassword
        def openId = params.openId

        sessionService.addUserInfo(name, mobile, password, openId)

        log.info("Add user success, ${name}")
        render ErrorCodeUtil.noError([userName:name, mobile:mobile])
    }

    private boolean validateCode(seq, mobileCode) {
        SessionUtil.getSessionValue(SessionUtil.SESSION_MOBILE_SEQ) == seq &&
                SessionUtil.getSessionValue(SessionUtil.SESSION_MOBILE_CODE) == mobileCode
    }

    def auth(){
        if(springSecurityService.isLoggedIn()){
            UserInfo userInfo = UserInfo.findByPerson(springSecurityService.getCurrentUser())
            render ErrorCodeUtil.noError([userName:userInfo.name, mobile:userInfo.mobile])
        }
    }

    def snsapiUserInfo(){
        def redirectUrl = params.url ? params : createLink(controller: "h5", action: "home", absolute: true)
        SessionUtil.setSessionValue(SessionUtil.SESSION_SNSAPI_USERINFO_INDICATOR, Boolean.TRUE)
        def url = WeChatUrlUtil.snsapiUserInfoUrl(WeChatContext.defaultContext().appId, redirectUrl)
        redirect(url: url)
    }
}
