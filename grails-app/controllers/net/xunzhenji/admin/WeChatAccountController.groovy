package net.xunzhenji.admin

import net.xunzhenji.util.SessionUtil
import net.xunzhenji.wechat.WeChatContext

/**
 *
 * Created by: Kevin
 * Created time : 2015/5/11 21:27
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */
class WeChatAccountController {
    def springSecurityService

    def index(){
        redirect(action: "list")
    }

    def edit(){
        def weChatContext = WeChatContext.get(params.id)
        if(!weChatContext){
            weChatContext = new WeChatContext()
        }

        [weChatContext: weChatContext]
    }

    def delete(){
        WeChatContext.get(params.id).delete()
        redirect(controller: "weChatAccount", action: "list")
    }

    def save(){
        def weChatContext
        if(params.id){
            weChatContext = WeChatContext.get(params.id)
        }else{
            weChatContext = new WeChatContext()
            weChatContext.person = springSecurityService.getCurrentUser()
        }
        weChatContext.properties = params
        weChatContext.save(flush: true)

        WeChatContext.reloadDefaultContext()
        redirect(action: "list")
    }

    def list(){
        def weChatContexts = WeChatContext.findAllByPerson(springSecurityService.getCurrentUser())
        [weChatContexts:weChatContexts]
    }

    def enter(){
        if(!params.id){
            log.error("Cannot enter wechat account with null id")
            redirect(controller: 'weChatAccount')
            return
        }
        def weChatContext = WeChatContext.get(params.id)
        if(!weChatContext){
            log.error("Cannot find wechat context, id:${params.id}")
            redirect(controller: 'weChatAccount')
            return
        }
        session[SessionUtil.SESSION_WECHAT_CONTEXT] = weChatContext

        redirect(controller: 'image')
    }

    def changePassword(){

    }

    def editUser(){

    }

    def listUser(){

    }
}
