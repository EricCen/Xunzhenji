package net.xunzhenji.editor

import grails.transaction.Transactional
import net.xunzhenji.security.Person
import net.xunzhenji.util.SessionUtil
import net.xunzhenji.wechat.WeChatFans
import net.xunzhenji.wechat.WeChatGroup

class WeChatFansController extends EditorController{
    def weChatUserService
    def customMessageService

    def index(Integer max) {
        def Person person = springSecurityService.getCurrentUser()
        def weChatContext = SessionUtil.weChatContext

        def weChatFans
        def weChatFansTotal
        def weChatGroups = WeChatGroup.list()
        def groupId = -1

        params.max = Math.min(max ?: 20, 100)

        if(params.groupId){
            def group = WeChatGroup.get(params.groupId)
            groupId = group.id
            weChatFans = WeChatFans.findAllByWeChatContextAndWeChatGroup(weChatContext, group, params)
            weChatFansTotal = WeChatFans.countByWeChatContextAndWeChatGroup(weChatContext, group)
        }else{
            weChatFans = WeChatFans.findAllByWeChatContext(weChatContext, params)
            weChatFansTotal = WeChatFans.countByWeChatContext(weChatContext)
        }

        [weChatFans:weChatFans, weChatFansTotal:weChatFansTotal, weChatGroups:weChatGroups, groupId:groupId]
    }

    def show(WeChatFans weChatFansInstance) {
        respond weChatFansInstance
    }

    def edit(WeChatFans weChatFansInstance) {
        respond weChatFansInstance
    }

    @Transactional
    def update(WeChatFans weChatFansInstance) {
        if (weChatFansInstance == null) {
            notFound()
            return
        }

        if (weChatFansInstance.hasErrors()) {
            respond weChatFansInstance.errors, view: 'edit'
            return
        }

        weChatFansInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'weChatFans.label', default: 'WeChatFans'), weChatFansInstance.id])
                redirect weChatFansInstance
            }
            '*' { respond weChatFansInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(WeChatFans weChatFansInstance) {

        if (weChatFansInstance == null) {
            notFound()
            return
        }

        weChatFansInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'weChatFans.label', default: 'WeChatFans'), weChatFansInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'weChatFans.label', default: 'WeChatFans'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    @Transactional
    def save(WeChatFans weChatFansInstance) {
        if (weChatFansInstance == null) {
            notFound()
            return
        }

        if (weChatFansInstance.hasErrors()) {
            respond weChatFansInstance.errors, view: 'create'
            return
        }

        weChatFansInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'weChatFans.label', default: 'WeChatFans'), weChatFansInstance.id])
                redirect weChatFansInstance
            }
            '*' { respond weChatFansInstance, [status: CREATED] }
        }
    }

    // synchronize the fans list with wechat
    def syncFans(){
        def fans = weChatUserService.listFans()
        def weChatContext = SessionUtil.weChatContext

        def weChatFans = WeChatFans.findAllByWeChatContext(weChatContext)

        fans.usersOpenIds.each{ fan->
            if(!weChatFans.find {fan.equals(it.openId)}){
                new WeChatFans(openId: fan, weChatContext: weChatContext, subscribe: 1).save()
            }
        }

        Thread.sleep(1000)
        redirect(action:'index')
    }

    //loop the fans list and update each fans information
    def updateFansInfo(){
        def weChatContext = session[SessionUtil.SESSION_WECHAT_CONTEXT]

        def weChatFans = WeChatFans.findAllByWeChatContext(weChatContext)

        weChatFans.each{ fans->
            try{
                def fansInfo = weChatUserService.getFansInfo(fans.openId)
                fans = fans.refresh()
                fans.updateFansInfo(fansInfo)
                fans.save(flush: true)
            }catch (e){
                log.error("Fail in updating we chat fans", e)
            }
        }

        Thread.sleep(1000)
        redirect(action:'index')
    }

    def setGroup(){
        def ids = params.findAll{it.key.startsWith("id_")}.collect {it.value as Long}
        def fans = WeChatFans.withCriteria {
            'in'('id', ids)
        }
        def group = WeChatGroup.get(params.groupId)
        def ret
        if(ids.size() == 1){
            ret = weChatUserService.updateFansGroup(fans[0].openId, group.wechatGroupId)
        }else if(ids.size() > 1){
            ret = weChatUserService.batchUpdateFansGroup(fans[0].collect {it.openId}, group.wechatGroupId)
        }

        if(!ret.errcode){
            fans.each{
                it.weChatGroup = group
            }
            WeChatFans.saveAll(fans)
        }
        redirect(action:'index')
    }

    def searchFans(){
        def fans = WeChatFans.findAllByNickNameLike("%${params.keyword}%")
        render(view: 'index', model: [weChatFans:fans, weChatFansTotal:fans.size(), weChatGroups:WeChatGroup.list()])
    }

    def activeFans() {
        if (!params.sort) {
            params.sort = "lastActivityTime"
            params.order = "desc"
        }
        def fans = WeChatFans.findAllByLastActivityTimeGreaterThan(new Date() - 2, params)
        render(view: 'index', model: [weChatFans: fans, weChatFansTotal: fans.size(), weChatGroups: WeChatGroup.list()])
    }

    def sendTextMsg() {
        log.info("Send text message to fans(${params.openId}), text:${params.text}")
        customMessageService.sendTextMessage(params.openId, params.text)
        redirect(action: "show", id: params.id)
    }

    def sendMediaMsg() {
        log.info("Send text message to fans(${params.openId}), type:${params.msgType}, mediaId: ${params.mediaId}")
        customMessageService.sendMessageByMediaId(params.openId, params.msgType, params.mediaId)
        redirect(action: "show", id: params.id)
    }
}

