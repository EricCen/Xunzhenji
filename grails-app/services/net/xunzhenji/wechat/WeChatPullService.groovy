package net.xunzhenji.wechat

import msg.Msg
import net.xunzhenji.datacollect.FansLocation
import net.xunzhenji.util.WeChatMsgUtil
import net.xunzhenji.wechat.WeChatFansActivity.ActionType

/**
 *
 * Created by: Kevin
 * Created time : 15-4-29 11:58
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */

class WeChatPullService {
    def static final int FIVE_MINUTE = 5*60*1000;
    def locationService
    def weChatUserService
    def weChatTextService
    def sessionService

    def process(String xml) {
        log.info("Receive xml : ${xml}")
        def msg = new XmlParser().parseText(xml)
        def msgType =  msg.MsgType.text()
        def event = msg.Event.text()
        def content = msg.Content.text()
        def createTime = new Date((msg.CreateTime.text() as long) * 1000)
        def fromUserName = msg.FromUserName.text()
        def toUserName = msg.ToUserName.text()

        def header = [msgType:msgType, event:event, createTime:createTime, fromUserName:fromUserName, toUserName:toUserName, content:content]

        if(Msg.MSG_TYPE_TEXT.equals(msgType)){
            def textReply = processText(header, msg)
            updateWeChatActiveTime(fromUserName, ActionType.TEXT_MSG, header.content)
            return textReply
        }else if(Msg.MSG_TYPE_EVENT.equals(msgType)){
            return processEvent(header, msg)
        }
        defaultReply()
    }

    def defaultReply() {

    }

    def processEvent(header, msg) {
        if(Msg.MSG_EVENT_LOCATION.equals(header.event)){
            saveFansLocation(header, msg)
        } else if(Msg.MSG_EVENT_MASSSENDJOBFINISH.equals(header.event)){
            updateMessageStatus(msg)
        } else if(Msg.MSG_EVENT_SUBSCRIBE.equals(header.event)){
            weChatUserService.userSubscribe(header.fromUserName)
            updateWeChatActiveTime(header.fromUserName, ActionType.SUBSCRIBE, null)
            header.content = SubscribeReply.count() ? SubscribeReply.first()?.keyword.keyword : null
            return processText(header, msg)

        } else if (Msg.MSG_EVENT_UNSUBSCRIBE.equals(header.event)) {
            weChatUserService.userUnsubscribe(header.fromUserName, header.createTime)
        } else if(Msg.MSG_EVENT_CLICK.equals(header.event)){
            return processClickEvent(header, msg)
        }
    }

    private void updateMessageStatus(msg) {
        def msgId = msg.MsgID.text() as long
        def status = msg.Status.text()
        def totalCount = msg.TotalCount.text() as int
        def filterCount = msg.FilterCount.text() as int
        def sentCount = msg.SentCount.text() as int
        def errorCount = msg.ErrorCount.text() as int
        def createTime = new Date((msg.CreateTime.text() as long) * 1000)

        def message = SendMessage.findByMsgId(msgId)
        if ('send success'.equals(status)) {
            message.status = SendMessage.STATUS_DELIVERED_SUCCESS
            message.reachCount = sentCount
            message.totalCount = totalCount
            message.filterCount = filterCount
            message.errorCount = errorCount
            message.latestSendTime = createTime
        } else {
            message.status = SendMessage.STATUS_SEND_FAIL
            message.status = status
        }
    }

    private void saveFansLocation(header, msg) {
        def latitude = msg.Latitude?.text() as Double
        def longitude = msg.Longitude?.text() as Double
        def precision = msg.Precision?.text() as Double

        def fansLocation = FansLocation.withCriteria {
            eq("openId", header.fromUserName)
            order('createTime', 'desc')
            maxResults(1)
        }

        if(!fansLocation.size() || header.createTime.getTime() -  fansLocation[0].createTime.getTime() > FIVE_MINUTE){
            def fans = WeChatFans.findByOpenId(header.fromUserName)
            if(!fans){
                log.warn("No we chat fans in DB, sync the fans")
                fans = weChatUserService.syncFans(header.fromUserName)
            }
            if(fans){
                def newLocation = new FansLocation(openId: header.fromUserName, latitude: latitude, longitude: longitude,
                        locationPrecision: precision, createTime: header.createTime, weChatFans: fans)
                def address = locationService.getGpsAddress(latitude, longitude)
                if(address.status==0){
                    newLocation.properties = address
                    newLocation.save(flush:true)
                }
            }else{
                log.error("No we chat fans, skip update")
            }
        }
    }

    def processText(header, msg) {
        log.info("process ${header.content}")
        def weChatContext = WeChatContext.defaultContext()
        if (weChatTextService.acceptPattern(header.content)) {
            return weChatTextService.handlePattern(header.fromUserName, header.content)
        }

        def keyword = Keyword.findByKeywordAndWeChatContext(header.content, weChatContext)
        def reply = keyword ? WeChatText.createCriteria().list {
            keywords{
                inList("keyword", keyword.keyword)
            }
        } : null
        reply = reply ? reply[0] : reply

        if(reply){
            def text = weChatTextService.mapText(reply.text, [openId: header.fromUserName])
            return WeChatMsgUtil.textMessage(header.toUserName, header.fromUserName, text)
        }

        log.info("Cannot find text keyword, find image keyword")
        reply = keyword ? WeChatImage.createCriteria().list {
            keywords {
                inList("keyword", keyword.keyword)
            }
        } : null
        reply = reply ? reply[0] : reply
        if (reply) {
            def article = WeChatMsgUtil.articleMessage(header.toUserName,
                    header.fromUserName,
                    reply.title,
                    reply.digest,
                    reply.pic?.url ? reply.pic?.url : reply.thumbUrl,
                    reply.url ? reply.url : "http://xunzhenji.net/h5/home")
            return article
        }

        log.info("Cannot find image keyword, find multi image keyword")
        reply = keyword ? MultiImage.createCriteria().list {
            keywords {
                inList("keyword", keyword.keyword)
            }
        } : null

        if (reply) {
            def article = WeChatMsgUtil.multiArticleMessage(header.toUserName,
                    header.fromUserName,
                    reply[0])
            return article
        }

        return null
    }

    def processClickEvent(header, msg) {
        def key = msg.EventKey.text()
        WeChatButton button = WeChatButton.findByKey(key)
        updateWeChatActiveTime(header.fromUserName, ActionType.CLICK_MENU, button.name)
        if(button){
            def retMsg = button.clickMessage(header.fromUserName)
            log.info("Return message: " + retMsg)
            return WeChatMsgUtil.textMessage(header.toUserName, header.fromUserName, retMsg)
        }
    }

    def updateWeChatActiveTime(String openId, ActionType actionType, String actionContent) {
        def fans = WeChatFans.findByOpenId(openId)
        fans.lastActivityTime = new Date()

        fans.addToWeChatFansActivity(new WeChatFansActivity(
                actionType: actionType, actionContent: actionContent))
    }
}
