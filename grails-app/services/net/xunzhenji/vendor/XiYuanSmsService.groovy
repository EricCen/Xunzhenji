/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.vendor

import groovyx.net.http.HTTPBuilder
import net.xunzhenji.GenericSmsService
import net.xunzhenji.SmsSetting

/**
 * Created by Irene on 2015/10/21.
 */
class XiYuanSmsService implements GenericSmsService {
    def static String XIYUAN_ACCOUNT = "yuanse"
    def static String XIYUAN_PASSWORD = "123123"
    def static String XIYUAN_USERID = "637"
    def static api = new HTTPBuilder("http://120.25.202.19:8888/")

    //http://120.25.202.19:8888/sms.aspx?action=send&userid=637&account=yuanse&password=123123&mobile=18588898788&content=%E6%B5%8B%E8%AF%95%E5%86%85%E5%AE%B9&sendTime=&extno=

    @Override
    def sendSms(Object mobile, Object text) {
        def postBody = [action  : "send",
                        userid  : XIYUAN_USERID,
                        account : XIYUAN_ACCOUNT,
                        password: XIYUAN_PASSWORD,
                        mobile  : mobile,
                        content : text,
                        sendTime: "",
                        extno   : ""]
        api.post(path: "/sms.aspx", query: [:], body: postBody) { resp, json ->
            println json
            if (json.code == 0 && json.result.fee == 1) {
                def smsSetting = SmsSetting.first()
                smsSetting.balance = smsSetting.balance - 1
                smsSetting.save()
                log.info("Send mobile message success")
            }
        }
    }
}
