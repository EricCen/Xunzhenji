/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.wechat

import groovyx.net.http.ContentType

/**
 * Created by Irene on 2015/9/11.
 */
class WeChatMenuService extends WeChatService {
    def weChatBasicService

    def getCurrentSelfMenuInfo(){
        log.info("Get current selfmenu info...")

        def query  = [access_token: weChatBasicService.getAccessToken()]
        def menus
        withHttp(WeChatService.WECHAT_API_URL, { api ->
            api.get(path: WeChatService.URL_GET_CURRENT_SELFMENU_INFO,
                    query: query) { resp, json ->
                menus = json
            }
        });
        menus
    }
    //https://api.weixin.qq.com/cgi-bin/menu/create?access_token=ACCESS_TOKEN
    def createMenu(button){
        log.info("Create menu... ${button}")
        def query  = [access_token: weChatBasicService.getAccessToken()]
        def ret
        withHttp(WeChatService.WECHAT_API_URL, { api ->
            api.post(path: WeChatService.URL_MENU_CREATE, query: query, body: button,
                    requestContentType: ContentType.JSON) { resp, json ->
                ret = json
            }
        });
        ret
    }

    def syncButtonsToServer() {
        def weChatMenu = WeChatMenu.first()
        def menu = [button: new ArrayList()]
        weChatMenu.buttons.sort { it.key }.findAll { it.buttonType == WeChatButton.ButtonType.Button.id }.each { btn ->
            def buttons = [btn]

            buttons.addAll(weChatMenu.buttons.sort { it.key }.findAll { it.parentBtn == btn })
            def button = createButton(buttons)
            menu.button << button
        }

        return createMenu(menu)
    }

    private Object createButton(List<WeChatButton> weChatButtons) {
        WeChatButton button = weChatButtons.find { it.buttonType == WeChatButton.ButtonType.Button.id }
        List<WeChatButton> subButtons = weChatButtons.findAll { it.buttonType == WeChatButton.ButtonType.SubButton.id }
        def buttonToUpload

        if (subButtons.size()) { //sub_button
            buttonToUpload = [name: button.name, sub_button: []]
            buttonToUpload.sub_button = subButtons.sort { it.key }.collect { btn ->
                [
                        name   : btn.name,
                        type   : WeChatButton.ButtonEventType.findById(btn.buttonEventType).type,
                        key    : btn.key,
                        url    : btn.url,
                        mediaId: button.mediaId
                ]
            }
        } else {
            buttonToUpload = [type   : WeChatButton.ButtonEventType.findById(button.buttonEventType).type,
                              name   : button.name,
                              key    : button.key,
                              url    : button.url,
                              mediaId: button.mediaId]
        }
        buttonToUpload
    }
}
