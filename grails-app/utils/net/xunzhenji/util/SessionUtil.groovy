/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.util

import net.xunzhenji.mall.UserInfo
import net.xunzhenji.wechat.WeChatContext
import org.springframework.web.context.request.RequestContextHolder

class SessionUtil {
    public static final SESSION_WECHAT_CONTEXT = "WECHAT_CONTEXT"
    public static final SESSION_WECHAT_FANS = "WECHAT_FANS"
    public static final SESSION_WECHAT_USERINFO = "WECHAT_USERINFO"
    public static final SESSION_MOBILE_CODE= "MOBILE_CODE"
    public static final SESSION_MOBILE_SEQ = "MOBILE_SEQ"
    public static final SESSION_SHOPPING_CART = "SHOPPING_CART"
    public static final SESSION_LATITUDE = "LATITUDE"
    public static final SESSION_LONGITUDE = "LONGITUDE"
    public static final SESSION_RANDOM_VERIFY_CODE = "RANDOM_VERIFY_CODE"
    public static final SESSION_MOBILE_MSG_COUNT = "MOBILE_MSG_COUNT"
    public static final SESSION_SNSAPI_USERINFO_INDICATOR = "SNSAPI_USERINFO_INDICATOR"
    public static final SESSION_PAY_INFO = "SNSAPI_USERINFO_INDICATOR"

    def static getSession(){
         RequestContextHolder.currentRequestAttributes().getSession()
    }

    def static getSessionValue(key){
        getSession()[key]
    }
    def static setSessionValue(key, value){
        getSession()[key] = value
    }

    def static WeChatContext getWeChatContext(){
        getSession()[SESSION_WECHAT_CONTEXT]
    }

    def static UserInfo getUserInfo(){
        getSession()[SESSION_WECHAT_USERINFO]
    }

    def static sessionValid(){
        getUserInfo() != null
    }

    def static dumpSession(){
        "${getSession()}"
    }
}
