package net.xunzhenji.wechat

/**
 *
 * Created by: Kevin
 * Created time : 2015/5/7 16:03
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */
class SendMessage {
    public static final int SEND_TYPE_TO_GROUP = 1
    public static final int SEND_TYPE_TO_OPENIDS = 2
    public static final int SEND_TYPE_TO_ALL = 3

    public static final String MSG_TYPE_MPNEWS = "mpnews"
    public static final String MSG_TYPE_TEXT = "text"
    public static final String MSG_TYPE_VOICE = "voice"
    public static final String MSG_TYPE_MUSIC = "music"
    public static final String MSG_TYPE_IMAGE = "image"
    public static final String MSG_TYPE_VIDEO = "video"
    public static final String MSG_TYPE_WXCARD = "wxcard"

    public static final int STATUS_NOT_SEND = 0
    public static final int STATUS_SENT = 1
    public static final int STATUS_DELIVERED_SUCCESS = 2
    public static final int STATUS_SEND_FAIL = 3

    def String title
    def String mediaId
    def String text         //Either media or text
    def int reachCount = 0
    def int totalCount = 0
    def int filterCount = 0
    def int errorCount = 0
    def int groupId = -1
    def int sendType = 0
    def Date latestSendTime
    def long msgId = 0
    def String msgType = MSG_TYPE_MPNEWS
    def String imageOrder
    def int status = STATUS_NOT_SEND
    def String statusStr
    def String fans

    static hasMany = [images:WeChatImage]

    static belongsTo = [weChatContext:WeChatContext]

    static constraints = {
        mediaId nullable: true
        text nullable: true
        latestSendTime nullable: true
        imageOrder nullable:true
        statusStr nullable:true
        images(validator: { val, obj ->
            def retval = true

            if (obj?.msgType == MSG_TYPE_MPNEWS && !obj?.images?.size()) {
                retval = 'default.hasnoimages.error'
            }
            return retval
        })
        text(validator: { val, obj ->
            def retval = true

            if (obj?.msgType == MSG_TYPE_TEXT && !obj?.text) {
                retval = 'default.hasnotext.error'
            }
            return retval
        })
    }

    static mapping = {
        autoTimestamp true
    }

    def firstImage(){
        if(!imageOrder || !images) return null
        if(!imageOrder && images) return images[0]

        def orders = imageOrder.split(',')
        images.find{it.id == (orders[0] as long)}
    }

    def fromSecondImages(){
        if(!imageOrder || !images) return null
        if(!imageOrder && images) return null

        def orders = imageOrder.split(',')
        def orderedImages = []
        orders.each { order->
            orderedImages << images.find{it.id==(order as long)}
        }
        orderedImages.minus(firstImage())
    }

    def toSendContext() {
        def postBody
        if (sendType == SEND_TYPE_TO_OPENIDS) {
            postBody = ["touser": Arrays.asList(fans.split(",")), msgtype: msgType]
        } else if (sendType == SEND_TYPE_TO_GROUP) {
            postBody = ["filter": [is_to_all: true],
                        mpnews  : [media_id: mediaId], msgtype: msgType]
        } else {
            postBody = ["filter": [groupd_id: (groupId as String)], msgtype: msgType]
        }

        if (msgType == MSG_TYPE_MPNEWS) {
            postBody.mpnews = [media_id: mediaId]
        } else if (msgType == MSG_TYPE_TEXT) {
            postBody.text = [content: text]
        }
        return postBody
    }

    def sendUrl() {
        if (sendType == SEND_TYPE_TO_OPENIDS) {
            return WeChatService.URL_SEND
        } else {
            return WeChatService.URL_SENDALL
        }
    }
}
