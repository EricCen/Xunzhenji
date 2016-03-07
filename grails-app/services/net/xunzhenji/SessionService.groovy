/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji

import grails.transaction.Transactional
import net.xunzhenji.mall.UserInfo
import net.xunzhenji.security.Authority
import net.xunzhenji.security.PersonAuthority
import net.xunzhenji.util.SessionUtil
import net.xunzhenji.util.WeChatUrlUtil
import net.xunzhenji.wechat.WeChatContext
import net.xunzhenji.wechat.WeChatFans

/**
 * Created by Kevin on 2015/7/27.
 */
class SessionService {
    def weChatBasicService
    def weChatUserService

    def init(params, redirectUrl) {
        WeChatFans fans = SessionUtil.getSessionValue(SessionUtil.SESSION_WECHAT_FANS)

        if(!fans && params.openId){ // try to find by openId
            fans = WeChatFans.findByOpenId(params.openId)
            if(fans){
                updateSession(fans)
            }
        }
        // just check no fans and no code case for page filter
        if(!fans && !params.code){
            def ret = noCode(redirectUrl)
            if(ret){
                return ret
            }
        }

        log.info(SessionUtil.dumpSession())
        return null
    }

    def process(params, redirectLink) {
        WeChatFans fans = SessionUtil.getSessionValue(SessionUtil.SESSION_WECHAT_FANS)

        def ret = null

        if(fans){
            ret = hasFans(fans, params.code)
        }else{

            if(params.code){
                ret = hasCode(params.code, redirectLink)
            }else{
                ret = noCode(redirectLink)
            }
        }
        initSessionValues()

        log.info("Init session result: ${ret}")
        return ret
    }

    def initSessionValues(){
        WeChatFans fans = SessionUtil.getSessionValue(SessionUtil.SESSION_WECHAT_FANS)
        UserInfo userInfo = SessionUtil.getSessionValue(SessionUtil.SESSION_WECHAT_USERINFO)

        if(!userInfo && fans){
            userInfo = fans.userInfo
            SessionUtil.setSessionValue(SessionUtil.SESSION_WECHAT_USERINFO, userInfo)
        }
        if(userInfo && userInfo.shoppingCart){
            SessionUtil.setSessionValue(SessionUtil.SESSION_SHOPPING_CART, userInfo.shoppingCart)
        }
    }

    def hasFans = { WeChatFans fans, code ->
        log.info("Init session, has fans: ${fans.openId}")
        UserInfo userInfo = fans.userInfo
        if(!userInfo) {     //user open public account and updated location
            log.info("Create userInfo...")
            userInfo = new UserInfo(weChatFans: fans)
            userInfo.save(flush: true)
            fans = fans.refresh()
            fans.userInfo = userInfo
            fans.save()

            updateSession(fans)
        }

        def userInfoIndicator = SessionUtil.getSessionValue(SessionUtil.SESSION_SNSAPI_USERINFO_INDICATOR)
        if(userInfoIndicator){
            fans.refresh()
            def token = weChatBasicService.getOauth2AccessToken(code)
            fans.visitCount = fans.visitCount + 1
            fans.properties = token
            def fansInfo = weChatUserService.getSnsFansInfo(token.accessToken, fans.openId)
            log.info("sns user info: ${fansInfo}")
            if(fansInfo.openId){
                fans.properties = fansInfo
                fans.save()
            }
            SessionUtil.setSessionValue(SessionUtil.SESSION_SNSAPI_USERINFO_INDICATOR, Boolean.FALSE)
        }

        return [name      : userInfo?.name ? userInfo?.name : (fans?.nickName ? fans?.nickName : "未登陆"),
                mobile    : fans.userInfo?.mobile,
                headImgUrl: fans.headImgUrl,
                openId    : fans.openId]
    }

    def void updateSession(WeChatFans fans) {
        def userInfo = fans?.userInfo
        if(userInfo){
            SessionUtil.setSessionValue(SessionUtil.SESSION_WECHAT_USERINFO, userInfo)
            SessionUtil.setSessionValue(SessionUtil.SESSION_SHOPPING_CART, userInfo?.shoppingCart)
        }

        SessionUtil.setSessionValue(SessionUtil.SESSION_WECHAT_FANS, fans)
    }

    def hasCode = { code, homeLink->
        log.info("Init session, code=${code}")
        WeChatFans fans =  retrieveFans(code)
        if (!fans) {
            def weChatContext = WeChatContext.defaultContext()
            def url = WeChatUrlUtil.snsapiUserInfoUrl(weChatContext.appId, homeLink)
            log.info("Redirect user to snsapi_userinfo page..${url}")
            return [snsapiUserInfoUrl: url]
        }
        return [name      : fans?.userInfo?.name ? fans?.userInfo?.name : (fans?.nickName ? fans?.nickName : "未登陆"),
                mobile    : fans.userInfo?.mobile,
                headImgUrl: fans.headImgUrl,
                openId    : fans.openId]
    }

    def retrieveFans(code){
        def weChatContext = WeChatContext.defaultContext()
        WeChatFans fans = retrieveUserInfoFromWeChatServer(code, weChatContext)
        if(fans){
            log.info("Retrieved fans, openId: ${fans.openId}")
            SessionUtil.setSessionValue(SessionUtil.SESSION_WECHAT_FANS, fans)
        }
        fans
    }

    def noCode = {requestUrl->
        log.warn("Code does not exist in params...")
        def weChatContext = WeChatContext.defaultContext()
        // if wechat version < 6.0.2, skip redirect

        def url
        if(requestUrl.indexOf('xunzhenji.net') < 0) { // for testing
            url = WeChatUrlUtil.weChatSimulatorUrl(weChatContext.appId, requestUrl)
            UserInfo userInfo = SessionUtil.getSessionValue(SessionUtil.SESSION_WECHAT_USERINFO)
            if(!userInfo){
                def openId = "145dsdfddd22d"

                def weChatFans = WeChatFans.findByOpenId(openId)
                if (weChatFans) {
                    userInfo = weChatFans.userInfo
                } else {
                    weChatFans = new WeChatFans(openId: "145dsdfddd22d", weChatContext: weChatContext)
                    userInfo = new UserInfo()
                    UserInfo.withTransaction {
                        weChatFans.save()
                        userInfo.weChatFans = weChatFans
                        userInfo.save()
                        weChatFans.userInfo = userInfo
                        weChatFans.save()
                    }
                }

                SessionUtil.setSessionValue(SessionUtil.SESSION_WECHAT_USERINFO, userInfo)
                SessionUtil.setSessionValue(SessionUtil.SESSION_WECHAT_FANS, userInfo.weChatFans)
                SessionUtil.setSessionValue(SessionUtil.SESSION_SHOPPING_CART, userInfo.shoppingCart)
            }

        }else{
            url = WeChatUrlUtil.snsapiBaseUrl(weChatContext.appId, java.net.URLEncoder.encode(requestUrl))
        }
        log.info("Redirect user to snsapi_base page..${url}")
        return [snsapiBaseUrl: url]
    }

    @Transactional
    private WeChatFans retrieveUserInfoFromWeChatServer(code, weChatContext) {
        def fans
        // get the open id and find the user info from DB and response to result
        def token = weChatBasicService.getOauth2AccessToken(code)
        log.info("Wechat fans Oauth2 token: ${token}")
        if (token.scope == "snsapi_base") {
            fans = WeChatFans.findByOpenId(token.openId)
            if (!fans) {
                // user may not subscribe the wechat account or server not yet sync the account
                // try to sync information first
                def fansInfo = weChatUserService.getFansInfo(token.openId)
                weChatUserService.createUser(fansInfo)
            }else{
                if(!fans.userInfo){
                    fans.userInfo =  new UserInfo(weChatFans: fans)
                    fans.userInfo.save(flush: true)
                }
                fans.visitCount = fans.visitCount + 1
                fans.save()
            }
        } else if(token && token.expiresIn) {
            def fansInfo = weChatUserService.getFansInfo(token.openId)
            fans = WeChatFans.findByOpenId(token.openId)
            if(fans){
                fans.accessToken = token.accessToken
                fans.refreshToken = token.refreshToken
                fans.expiresIn = token.expiresIn
                fans.scope = token.scope
            }else{
                fans = new WeChatFans(accessToken: token.accessToken, refreshToken: token.refreshToken,
                        expiresIn: token.expiresIn, scope: token.scope, weChatContext: weChatContext)
                fans.userInfo = new UserInfo()
                fans.userInfo.save(flush: true)

                fans.userInfo.weChatFans = fans
                fans.updateFansInfo(fansInfo)
            }
            fans.save()

            fans.userInfo.save()
        }

        updateSession(fans)
        fans
    }

    def addUserInfo(name, mobile, password, openId = null) {
        log.info("Add user info, openId: ${openId}")
        WeChatFans fans = SessionUtil.getSessionValue(SessionUtil.SESSION_WECHAT_FANS)
        if(!fans) {
            if(openId){
                fans = WeChatFans.findByOpenId(openId)
            }else{
                log.error("No fans and no openId")
            }
        }
        UserInfo userInfo
        def role = Authority.findByAuthority("ROLE_USER")

        if (fans) { //wechat fans already created, update user info
            fans = fans.refresh()
            userInfo = fans.userInfo
        }

        userInfo.mobile = mobile
        userInfo.name = name

        if (!userInfo.person) {
            userInfo.createPerson(password)
        }
        userInfo.mobile = mobile
        userInfo.name = name
        try{
            UserInfo.withTransaction {
                userInfo.person.save()
                userInfo.save()
                PersonAuthority.create userInfo.person, role, true
                userInfo.shoppingCart.save()
                if (fans) fans.save()
            }
        }catch(e){
            log.error("Hit error during save userInfo, skip Person Authority and do again")
            UserInfo.withTransaction {
                userInfo.person.save()
                userInfo.save()
//                PersonAuthority.create userInfo.person, role, true
                userInfo.shoppingCart.save()
                if (fans) fans.save()
            }
        }

        SessionUtil.setSessionValue(SessionUtil.SESSION_WECHAT_USERINFO, userInfo)

        log.info("Successfully add user: ${name}")
    }
}
