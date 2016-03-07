package net.xunzhenji.editor

import net.xunzhenji.wechat.WeChatGroup
import net.xunzhenji.security.Person
import net.xunzhenji.util.SessionUtil

class WeChatGroupController extends EditorController{
    def weChatUserService

    def index() {
        def weChatGroups = WeChatGroup.listOrderByWeChatContext(session[SessionUtil.SESSION_WECHAT_CONTEXT])
        def weChatGroupTotal = WeChatGroup.countByWeChatContext(session[SessionUtil.SESSION_WECHAT_CONTEXT])
        [weChatGroups:weChatGroups, weChatGroupTotal:weChatGroupTotal]
    }

    def show(){

    }
    def edit(){
        def weChatGroup
        if(!params.id){
            weChatGroup = new WeChatGroup(weChatContext: session[SessionUtil.SESSION_WECHAT_CONTEXT])
        }else{
            weChatGroup = WeChatGroup.get(params.id)
        }
        def result = [weChatGroup:weChatGroup]
        result
    }

    def save(){
        def weChatContext = session[SessionUtil.SESSION_WECHAT_CONTEXT]
        def weChatGroup

        if(!params.id){
            weChatGroup = new WeChatGroup(weChatContext:weChatContext)

        }else{
            weChatGroup = WeChatGroup.get(params.id)
        }

        weChatGroup.properties = params

        if(weChatGroup.validate()){
            if(!params.id){
                def ret = weChatUserService.createGroup(params.name)
                if(ret.errorcode){
                    weChatGroup.errors.reject(ret.errorcode, ret.errmsg)
                    render(view:"edit", model:[weChatGroup:weChatGroup])
                    return
                }else{
                    weChatGroup.wechatGroupId = ret.wechatGroupId
                }
            }else{
                def ret = weChatUserService.updateGroup(weChatGroup.wechatGroupId, params.name)
                if(ret.errorcode){
                    weChatGroup.errors.reject(ret.errorcode, ret.errmsg)
                    render(view:"edit", model:[weChatGroup:weChatGroup])
                    return
                }
            }

            weChatGroup.save(flush:true)
        }else{
            render(view:"edit", model:[weChatGroup:weChatGroup])
            return
        }

        redirect(action:'index')
    }

    def syncGroup(){
        def Person person = springSecurityService.getCurrentUser()
        //TODO distingush the wechatContext
        def weChatContext = person.weChatContexts[0]

        def groups = weChatUserService.retrieveAllGroups()

        def groupsInDb = WeChatGroup.findByWeChatContext(weChatContext)
        groupsInDb.each{groupInDb->
            if(groups.find{it.id.equals(groupInDb.wechatGroupId)} != null){
                log.info("Delete group,id: ${groupInDb.id}")
                groupInDb.delete()
            }
        }

        groups.each{ group->
            def weChatGroup = WeChatGroup.findByWechatGroupId(group.id)
            if(!weChatGroup){
                weChatGroup = new WeChatGroup(wechatGroupId:group.id)
            }
            weChatGroup.name = group.name
            weChatGroup.fansCount = group.count
            weChatGroup.weChatContext = weChatContext
            weChatGroup.save(flush: true)
        }
        Thread.sleep(1000)
        redirect(action:'index')
    }

    // wechat api doesn't support delete group
    def delete(){
        def weChatGroup = WeChatGroup.get(params.id)
        def ret = weChatUserService.deleteGroup(weChatGroup.wechatGroupId)
        if(ret.errcode){
            weChatGroup.errors.reject(ret.errorcode, ret.errmsg)
        }else{
            weChatGroup.delete(flush: true)

            Thread.sleep(1000)
        }
        redirect(action:'index')
    }
}
