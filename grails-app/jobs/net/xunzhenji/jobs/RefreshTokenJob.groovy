package net.xunzhenji.jobs

import net.xunzhenji.wechat.WeChatContext

/**
 *
 * Created by: Kevin
 * Created time : 2015/6/20 23:39
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */
class RefreshTokenJob {
    def weChatBasicService

    static triggers = {
        cron name: 'refreshToken', cronExpression: "25 8 /2 * * ?",timeZone:TimeZone.getTimeZone("Asia/Hong_Kong")
    }

    def name = "刷新令牌任务"
    def group = "MyGroup"

    def execute() {
//        log.info("Refresh access token...")
//        weChatBasicService.getAccessToken()
//        log.info("Refresh Js API ticket...")
//        weChatBasicService.getJsApiTicket()
    }
}
