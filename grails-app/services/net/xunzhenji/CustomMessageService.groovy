package net.xunzhenji

import grails.transaction.Transactional

@Transactional
class CustomMessageService {
    def weChatPushService

    def sendTextMessage(String openId, String text) {
        log.info("Send text message to ${openId}")
        def message = [
                "touser" : openId,
                "msgtype": "text",
                "text"   :
                        [
                                "content": text
                        ]
        ]
        weChatPushService.customMsgSend(message)
    }

    def sendImageMessage(String openId, String text) {
        log.info("Send text message to ${openId}")
        def message = [
                "touser" : openId,
                "msgtype": "text",
                "text"   :
                        [
                                "content": text
                        ]
        ]
        weChatPushService.customMsgSend(message)
    }

    def sendMessageByMediaId(String openId, String msgType, String mediaId) {
        log.info("Send image message to ${openId}")
        def message = [
                "touser" : openId,
                "msgtype": msgType
        ]
        message.put(msgType, ["media_id": mediaId])

        weChatPushService.customMsgSend(message)
    }
}
