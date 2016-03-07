/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.util

/**
 * Created by Irene on 2015/7/26.
 */
class WeChatUrlUtil {

    def static String snsapiBaseUrl(appId, path){
        "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${appId}" +
                "&redirect_uri=${path}" +
                "&response_type=code&scope=snsapi_base&state=STATE#wechat_redirect"
    }

    def static String snsapiUserInfoUrl(appId, path){
        "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${appId}" +
                "&redirect_uri=${path}" +
                "&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect"
    }


    def static String weChatSimulatorUrl(appId, path){
        "http://localhost:8080/weChatSimulator/?appid=${appId}" +
                "&redirect_uri=${path}" +
                "&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect"
    }
}
