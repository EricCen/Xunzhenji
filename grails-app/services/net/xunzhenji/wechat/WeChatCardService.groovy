/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.wechat

/**
 * Created by Irene on 2015-12-27.
 */
class WeChatCardService extends WeChatService {
    def weChatBasicService

    def createCard() {
        def query = [access_token: weChatBasicService.getAccessToken()]
        def menus
        withHttp(WeChatService.WECHAT_API_URL, { api ->
            api.get(path: WeChatService.URL_CARD_CREATE,
                    query: query) { resp, json ->
                menus = json
            }
        });
        menus
    }
}
