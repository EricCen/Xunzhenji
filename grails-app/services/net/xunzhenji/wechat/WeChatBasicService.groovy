/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.wechat

import net.xunzhenji.Server
import org.apache.commons.lang.time.DateUtils

class WeChatBasicService extends WeChatService{
    def accessToken
    def jsApiTicket
    def refreshTimer = new Timer()

    def synchronized refreshAccessToken(){
        def weChatContext = WeChatContext.defaultContext()

        if(weChatContext.expiresIn > DateUtils.addSeconds(new Date(), 20)){
            log.info("Access token refreshed")
            return
        }

        log.info("Refresh access token...")
        def refreshTokenTime

        def query  = [grant_type:'client_credential', appid:weChatContext.appId, secret:weChatContext.appSecret]
        log.info(query)

        withHttp(WeChatService.WECHAT_API_URL, {api->
            api.get( path : WeChatService.URL_REFRESH_TOKEN, query : query ) { resp, json ->
                if(json.errcode && json.errcode != 0){
                    log.info("Hit error during refresh access token. result:${json}")
                    return
                }
                weChatContext = WeChatContext.get(weChatContext.id)
                def expiresIn = json.expires_in as Integer
                refreshTokenTime = DateUtils.addSeconds(new Date(), expiresIn - 100)
                weChatContext.expiresIn = refreshTokenTime
                accessToken = json.access_token
                weChatContext.accessToken = json.access_token
                try{
                    weChatContext.save(flush: true)
                }catch(e){
                    log.error("Save weChatContext error", e)
                }

                weChatContext.reloadDefaultContext()

                if(Server.thisServer.refreshAccessToken){
                    log.info("Next refresh time @ ${refreshTokenTime}")
                    refreshTimer.schedule(new TimerTask() {
                        @Override
                        void run() {
                            refreshAccessToken()
                        }
                    }, refreshTokenTime)
                }
            }
        })
    }

    def getAccessToken(){
        def weChatContext = WeChatContext.first()
        if(!weChatContext.accessToken || !weChatContext.expiresIn || new Date().compareTo(weChatContext.expiresIn) > 0){
            if(Server.thisServer.refreshAccessToken || weChatContext.expiresIn < new Date()) {
                log.info("Access token expired, expire tiem @ ${weChatContext.expiresIn}")
                refreshAccessToken()
            }else{
                weChatContext = weChatContext.refresh()
                accessToken = weChatContext.accessToken
            }
            log.info("Access token: ${weChatContext.accessToken}, expire in ${weChatContext.expiresIn}")
        } else {
            accessToken = weChatContext.accessToken
        }

        return accessToken
    }

    def synchronized refreshJsApiTicket(){
        def weChatContext = WeChatContext.first()
        log.info("Refresh JS API ticket...")

        def refreshTicketTime
        def accessToken = getAccessToken()
        def query  = [access_token:accessToken, type:"jsapi"]
        log.info(query)

        withHttp(WeChatService.WECHAT_API_URL, {api->
            api.get( path : WeChatService.URL_GET_TICKET, query : query ) { resp, json ->
                if(json.errcode==0){
                    weChatContext.ticket = json.ticket
                    jsApiTicket = json.ticket
                    def ticketExpiresIn = json.expires_in as Integer
                    refreshTicketTime = DateUtils.addSeconds(new Date(), ticketExpiresIn - 10)
                    weChatContext.ticketExpiresIn = refreshTicketTime
                    weChatContext.save()
                }else{
                    log.error("Hit error when refresh access token, ${json}")
                }

                log.info("Next refresh time @ ${refreshTicketTime}")

                if(Server.thisServer.refreshJsApiTicket) {
                    refreshTimer.schedule(new TimerTask() {
                        @Override
                        void run() {
                            refreshJsApiTicket()
                        }
                    }, refreshTicketTime)
                }
            }
        })
    }

    def getJsApiTicket(){
        try {
            def weChatContext = WeChatContext.defaultContext()
            if (!weChatContext.ticket || !weChatContext.ticketExpiresIn || new Date().compareTo(weChatContext.ticketExpiresIn) > 0) {
                if (Server.thisServer.refreshJsApiTicket) {
                    refreshJsApiTicket()
                } else {
                    weChatContext.refresh()
                }
                log.info("Js Api Ticket: ${jsApiTicket}")
            } else {
                jsApiTicket = weChatContext.ticket
            }
        } catch (e) {
            log.error("Hit error when get js api ticket")
        }
        return jsApiTicket
    }

    def getOauth2AccessToken(code) {
        def ret = [:]
        def weChatContext = WeChatContext.defaultContext()

        log.info("Get oauth2 access token, code=${code}")

        def query = [appid: weChatContext.appId, secret: weChatContext.appSecret, code: code, grant_type: "authorization_code"]

        withHttp(WeChatService.WECHAT_API_URL, {api->
            api.get(path: WeChatService.URL_REFRESH_OAUTH_TOKEN, query: query, contentType: groovyx.net.http.ContentType.JSON) { resp, json ->
                if(json.errcode && json.errcode != 0) {
                    log.error("Fail to refresh oauth token, msg: ${json}")
                    return
                }
                def accessToken = json.access_token
                def cal = Calendar.getInstance()
                cal.add(Calendar.SECOND, json.expires_in as int)
                def expiresIn = cal.getTime()
                def refreshToken = json.refresh_token
                def openId = json.openid
                def scope = json.scope
                def unionId = json.unionid
                ret.accessToken = accessToken
                ret.expiresIn = expiresIn
                ret.refreshToken = refreshToken
                ret.openId = openId
                ret.scope = scope
                ret.unionId = unionId
            }
        })
        log.info("Oauth2 result: ${ret}")
        ret
    }
}
