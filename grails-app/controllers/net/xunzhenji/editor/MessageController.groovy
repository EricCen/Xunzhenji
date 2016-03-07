package net.xunzhenji.editor

import net.xunzhenji.util.SessionUtil
import net.xunzhenji.wechat.*

class MessageController extends EditorController{
    def weChatPushService
    def weChatMediaService

    def index() {
        def sendMessages = SendMessage.list()
        def sendMessageTotal = SendMessage.count()
        [sendMessages:sendMessages, sendMessageTotal:sendMessageTotal]
    }

    def edit(){
        def sendMessage
        if(!params.id){
            sendMessage = new SendMessage()
        }else{
            sendMessage = SendMessage.get(params.id)
        }
        def weChatContext = session[SessionUtil.SESSION_WECHAT_CONTEXT]

        def weChatGroups = WeChatGroup.findAllByWeChatContext(weChatContext).sort{it.id}

        [sendMessage:sendMessage, weChatGroups:weChatGroups]
    }

    def addImage(){
        def images = WeChatImage.list()
        def multiImages = MultiImage.list()

        [images:images, multiImages:multiImages]
    }

    def save(){
        def sendMessage

        if(params.id){
            sendMessage = SendMessage.get(params.id)
        }else{
            sendMessage = new SendMessage(weChatContext: session[SessionUtil.SESSION_WECHAT_CONTEXT])
        }

        if ((params.sendType as int) == SendMessage.SEND_TYPE_TO_OPENIDS) {
            sendMessage.fans = params.openid
        }

        //check if any image added
        def imageIds = params.imgids?.split(",")

        imageIds = imageIds.findAll {it}.collect {it as Long}
        def images = WeChatImage.withCriteria {
            'in'('id', imageIds)
        }

        sendMessage.images = images
        sendMessage.imageOrder = imageIds.join(',')
        sendMessage.properties = params

        if(sendMessage.validate()){
            sendMessage.save(flush: true)
        }else {
            println sendMessage.errors
            render(view: 'edit', model: [sendMessage: sendMessage])
            return
        }

        redirect(controller: "message", action: "index")
    }

    def send(){
        def sendMessage = SendMessage.get(params.id)

        if (sendMessage.msgType == SendMessage.MSG_TYPE_MPNEWS) {
            sendMpMsg(sendMessage)
        }

        sendMessage.refresh()
        sendMessage = weChatPushService.send(sendMessage)
        if(sendMessage.hasErrors()){
            flash.message = "Send error, [${sendMessage.statusStr}]"
            redirect(controller: "message", action: "index")
            sendMessage.save(flush:true)
            return
        }
        sendMessage.save(flush:true)

        redirect(controller: "message", action: "index")
    }

    def sendTextMsg(sendMessage) {
        def firstImage = sendMessage.images[0]
    }

    def sendMpMsg(sendMessage) {
        def firstImage = sendMessage.images[0]
        def coverPic = firstImage.pic
        //update cover pic
        if (!firstImage.pic.isOnServer()) {
            coverPic = weChatMediaService.uploadMedia(firstImage.pic)
            if (coverPic.hasErrors()) {
                log.error("Fail to upload cover pic during send message")
                render(view: "index", model: [sendMessage: sendMessage])
                return
            }
        }

        //upload news
        if (!sendMessage.mediaId) {
            def uploadNewsResult = weChatMediaService.uploadNews(firstImage.title, coverPic.mediaId, firstImage.author, firstImage.digest, firstImage.showPic, firstImage.content, null)

            if (uploadNewsResult.errorcode) {
                sendMessage.errors.reject(uploadNewsResult.errorcode as String, uploadNewsResult.errormsg)
                render(view: "index", model: [sendMessage: sendMessage])
                return
            }

            sendMessage.mediaId = uploadNewsResult.mediaId
            sendMessage.save(flush: true)
        }
    }

    def preview(){
        if(!params.id) {
            log.warn("Cannot review on null id message")
            redirect(action: 'index')
            return
        }
        def sendMessage = SendMessage.get(params.id)
        weChatPushService.preview('o1zAMuGjKqqNHujegDRo8UCgAQfE',sendMessage.mediaId)
        redirect(action:'index')
    }

    def delete(){
        if(!params.id) {
            log.warn("Cannot delete on null id message")
            redirect(action: 'index')
            return
        }
        def message = SendMessage.get(params.id)
        if(!message){
            log.warn("message not found for id:${params.id}")
            redirect(action: 'index')
            return
        }
        message.delete()
        redirect(action:'index')
    }

    def addFans(){
        def fans = WeChatFans.findAllByWeChatContext(session[SessionUtil.SESSION_WECHAT_CONTEXT])
        [fans:fans]
    }
}
