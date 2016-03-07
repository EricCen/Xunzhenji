/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.wechat

import grails.converters.JSON
import groovyx.net.http.ContentType

class WeChatPushService extends WeChatService{
    def weChatBasicService

    def _send(url, postBody){
        def token = weChatBasicService.getAccessToken()
        def ret = [:]

        if(token){
            withHttp(WeChatService.WECHAT_API_URL, {api->
                api.post( path: url, query : [access_token:token], body: postBody,
                        requestContentType: ContentType.JSON ) { resp, json ->
                    if(json.errcode){
                        ret = json
                        log.warn("Error found during send message, ${ret}")
                    }else{
                        ret.msgId = json.msg_id
                    }
                }
            })
        }else {
            log.info("WechatContext may not yet defined.")
        }
        ret
    }

    def send(SendMessage message){
        def sendResult = _send(message.sendUrl(), message.toSendContext())

        if(sendResult.errcode){
            message.errors.reject(sendResult.errcode as String, sendResult.errmsg)
            message.status = SendMessage.STATUS_SEND_FAIL
        }else{
            message.msgId = sendResult.msgId
            message.status = SendMessage.STATUS_SENT
            message.latestSendTime = new Date()
        }
        message
    }

    def preview(openId, mediaId, content) {
        log.info("Preview message, send message to openId:${openId}")
        def postBody = ["touser": openId, mpnews: content, msgtype: "mpnews"]

        def token = weChatBasicService.getAccessToken()
        if(token){
            withHttp(WeChatService.WECHAT_API_URL, { api ->
                api.post( path: WeChatService.URL_PREVIEW, query : [access_token:token], body: postBody,
                        requestContentType: ContentType.JSON ) { resp, reader ->

                    log.info("POST Success: ${resp.statusLine}")
                    log.info(reader)
                }
            })
        }else {
            log.info("WechatContext may not yet defined.")
        }
    }

    def sendTemplateMessage(message){
        log.info("Send template message to user, ${message as JSON}")
        def token = weChatBasicService.getAccessToken()
        if(token){
            withHttp(WeChatService.WECHAT_API_URL, { api ->
                api.post( path: WeChatService.URL_TEMPLATE_SEND, query : [access_token:token], body: message,
                        requestContentType: ContentType.JSON ) { resp, reader ->

                    log.info("POST Success: ${resp.statusLine}")
                    println reader
                }
            })
        }else {
            log.info("WechatContext may not yet defined.")
        }
    }

    def getTemplateId(templateShortId){
        log.info("Get template short id, ${templateShortId}")
        def token = weChatBasicService.getAccessToken()
        def postBody = ["template_id_short": templateShortId]
        def templateId
        if(token){
            withHttp(WeChatService.WECHAT_API_URL){ api ->
                api.post( path: WeChatService.URL_ADD_TEMPLATE, query : [access_token:token], body: postBody,
                        requestContentType: ContentType.JSON ) { resp, json ->
                    if(json.errcode == 0){
                        templateId = json.template_id
                    }else{
                        log.error("eorcode: ${json.errcode}, errmsg: ${json.errmsg}")
                    }
                }
            }
        }else {
            log.info("WechatContext may not yet defined.")
        }
        templateId
    }

    def customMsgSend(message) {
        log.info("Send custom message to user, ${message}")
        def token = weChatBasicService.getAccessToken()
        if (token) {
            withHttp(WeChatService.WECHAT_API_URL, { api ->
                api.post(path: WeChatService.URL_MESSAGE_CUSTOM_SEND, query: [access_token: token], body: message,
                        requestContentType: ContentType.JSON) { resp, reader ->
                    log.info("POST Success: ${reader}")
                }
            })
        } else {
            log.info("WechatContext may not yet defined.")
        }
    }
}
