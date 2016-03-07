/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.wechat
/**
 * Created by Irene on 2015/9/11.
 */
class WeChatButton {
    def weChatTextService

    def static final String BUTTON_TYPE_BUTTON = "button"
    def static final String BUTTON_TYPE_SUBBUTTON = "sub_button"

    static enum ButtonType {
        Button(10, "button", "菜单"),
        SubButton(20, "sub_button", "子菜单")
        int id
        String type
        String desc

        def ButtonType(int id, String type, String desc) {
            this.id = id
            this.type = type
            this.desc = desc
        }
        public static ButtonType valueOf(int id) {
            ButtonType.values().find { it.id == id }
        }
    }

    static enum ButtonEventType {
        CLICK(10, "click", "点击推事件"),
        VIEW(20, "view", "跳转URL"),
        WAITMSG(30, "scancode_waitmsg", "扫码带提示"),//扫码带提示
        SCANCODE_PUSH(40, "scancode_push", "扫码推事件且弹出“消息接收中”提示框"),//扫码推事件
        SYSPHOTO(50, "pic_sysphoto", "弹出系统拍照发图"),//系统拍照发图
        PIC_PHOTO_OR_ALBUM(60, "pic_photo_or_album", "弹出拍照或者相册发图"),//拍照或者相册发图
        WEIXIN(70, "pic_weixin", "弹出微信相册发图器"),//微信相册发图
        LOCATION_SELECT(80, "location_select", "弹出地理位置选择器"), //发送位置
        MEDIA_ID(90, "media_id", "下发消息（除文本消息）"),//图片
        VIEW_LIMIT(100, "view_limited", "跳转图文消息URL") //图文消息

        int id
        String type
        String desc

        def ButtonEventType(int id, String type, String desc) {
            this.id = id
            this.type = type
            this.desc = desc
        }
        public static ButtonEventType findById(int id) {
            ButtonEventType.values().find { it.id == id }
        }

        public static ButtonEventType findByType(String type) {
            ButtonEventType.values().find { it.type == type }
        }
    }


    int buttonType
    int buttonEventType
    String name
    String key
    String url
    String mediaId
    int order = 0
    WeChatButton parentBtn
    String pushContent

    static belongsTo = [weChatMenu: WeChatMenu]

    static constraints = {
        key nullable: true
        url nullable: true
        mediaId nullable: true
        parentBtn nullable: true
        pushContent nullable: true
    }

    static mapping = {
        key column: "button_key"
        order column: "button_order"
    }

    String toString(){
        "${name}"
    }

    String clickMessage(openId) {
        return weChatTextService.mapText(pushContent, [openId: openId, url: url])
    }
}
