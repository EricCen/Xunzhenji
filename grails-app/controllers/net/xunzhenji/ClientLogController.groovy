package net.xunzhenji

import net.xunzhenji.mall.UserInfo
import net.xunzhenji.util.ErrorCodeUtil
import net.xunzhenji.util.SessionUtil

class ClientLogController {

    def log() {
        UserInfo userInfo = SessionUtil.getSessionValue(SessionUtil.SESSION_WECHAT_USERINFO)
        def userId = userInfo?.id
        def info = params.info
        def error = params.error
        if(info){
            log.info("[uid:${userId}] - ${info}")
        }else if(error){
            log.error("[uid:${userId}] - ${error}")
        }
        render ErrorCodeUtil.noError()
    }
}
