package net.xunzhenji.wechat

import grails.transaction.Transactional
import net.xunzhenji.wechat.WeChatButton.ButtonType

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class WeChatMenuController {
    def weChatMenuService
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond WeChatMenu.list(params), model: [weChatMenuInstanceCount: WeChatMenu.count()]
    }

    def show(WeChatMenu weChatMenuInstance) {
        respond weChatMenuInstance
    }

    def create() {
        respond new WeChatMenu(params)
    }

    @Transactional
    def save(WeChatMenu weChatMenuInstance) {
        if (weChatMenuInstance == null) {
            notFound()
            return
        }

        if (weChatMenuInstance.hasErrors()) {
            respond weChatMenuInstance.errors, view: 'create'
            return
        }

        weChatMenuInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'weChatMenu.label', default: 'WeChatMenu'), weChatMenuInstance.id])
                redirect weChatMenuInstance
            }
            '*' { respond weChatMenuInstance, [status: CREATED] }
        }
    }

    def edit(WeChatMenu weChatMenuInstance) {
        respond weChatMenuInstance
    }

    @Transactional
    def update(WeChatMenu weChatMenuInstance) {
        if (weChatMenuInstance == null) {
            notFound()
            return
        }

        if (weChatMenuInstance.hasErrors()) {
            respond weChatMenuInstance.errors, view: 'edit'
            return
        }

        weChatMenuInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'weChatMenu.label', default: 'WeChatMenu'), weChatMenuInstance.id])
                redirect weChatMenuInstance
            }
            '*' { respond weChatMenuInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(WeChatMenu weChatMenuInstance) {

        if (weChatMenuInstance == null) {
            notFound()
            return
        }

        weChatMenuInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'WeChatMenu.label', default: 'WeChatMenu'), weChatMenuInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'weChatMenu.label', default: 'WeChatMenu'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    def sync() {
        def ret = weChatMenuService.getCurrentSelfMenuInfo();
        println ret
        def isMenuOpen = ret.is_menu_open
        def selfMenuInfo = ret.selfmenu_info
        def weChatMenu
        if(isMenuOpen){
            if(WeChatMenu.count() == 0){
                weChatMenu = new WeChatMenu()
                weChatMenu.save(flush: true)
            }
        }

        if(selfMenuInfo && selfMenuInfo.button){
            def mainButton = selfMenuInfo.button[0]
            def topLevelBtn = updateButton(mainButton, weChatMenu, WeChatButton.ButtonType.Button, null)

            def subButtons = selfMenuInfo.button.size() > 1 ? selfMenuInfo.button[1].sub_button : null
            if(subButtons){
                subButtons.each{subBtn->
                    updateButton(subBtn, weChatMenu, WeChatButton.ButtonType.SubButton, topLevelBtn)
                }
            }
        }

        redirect(action: 'index')
    }

    private WeChatButton updateButton(mainButton, weChatMenu, ButtonType buttonType, WeChatButton parentButton) {
        def name = mainButton.name
        def type = WeChatButton.ButtonEventType.findByType(mainButton.type)
        def url = mainButton.url
        def key = mainButton.key
        def buttonInDb = WeChatButton.findByName(name)
        if (!buttonInDb) {
            buttonInDb = new WeChatButton(name: name, buttonEventType: type.id, buttonType: buttonType.id, url: url, key: key, weChatMenu: weChatMenu, parentBtn: parentButton)
        }else{
            buttonInDb.properties = mainButton
            buttonInDb.buttonEventType = type.id
            buttonInDb.buttonType = buttonType.id
            buttonInDb.parentBtn = parentButton
        }
        buttonInDb.save(flush:true)
        buttonInDb
    }

    /*
     {
     "button":[
     {
          "type":"click",
          "name":"今日歌曲",
          "key":"V1001_TODAY_MUSIC"
      },
      {
           "name":"菜单",
           "sub_button":[
           {
               "type":"view",
               "name":"搜索",
               "url":"http://www.soso.com/"
            },
            {
               "type":"view",
               "name":"视频",
               "url":"http://v.qq.com/"
            },
            {
               "type":"click",
               "name":"赞一下我们",
               "key":"V1001_GOOD"
            }]
       }]
 }
     */

    def upload() {
        log.info("Upload buttons to server")
        log.info("Upload result: ${weChatMenuService.syncButtonsToServer()}")
        redirect(action: 'index')
    }


}
