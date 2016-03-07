/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji

import net.xunzhenji.mall.UserInfo
import net.xunzhenji.util.ErrorCodeUtil
import net.xunzhenji.util.RamdomNumUtil
import net.xunzhenji.util.SessionUtil

class CaptchaController {
    def mobileMsgService

    def genMobileCode(){
        log.info("Receive validate mobile request, phone:${params.mobile}")
        def mobile = params.mobile
        if(!mobile){
            render ErrorCodeUtil.noMobileNum()
            return
        }

        UserInfo userInfo = UserInfo.findByMobile(mobile)
        if(userInfo) { // user already has account
            log.info("User already registered")
            render ErrorCodeUtil.mobileIsRegistered([userName:userInfo.name, mobile: userInfo.mobile])
            return
        }


        def mobileMsgCount = SessionUtil.getSessionValue(SessionUtil.SESSION_MOBILE_MSG_COUNT)
        mobileMsgCount = mobileMsgCount ? mobileMsgCount+1 :1

        if(mobileMsgCount>2) {
            def String randomCode = SessionUtil.getSessionValue(SessionUtil.SESSION_RANDOM_VERIFY_CODE)
            if(!randomCode || randomCode.toUpperCase()!=params.randomCode?.toUpperCase()){
                render ErrorCodeUtil.invalidRandomCode()
                return
            }
        }
        def seq = SessionUtil.getSessionValue(SessionUtil.SESSION_MOBILE_SEQ)
        seq = seq ? seq + 1 : 1
        def code = mobileMsgService.bindMobile(mobile, seq)
        SessionUtil.setSessionValue(SessionUtil.SESSION_MOBILE_SEQ, seq)
        SessionUtil.setSessionValue(SessionUtil.SESSION_MOBILE_CODE, code)
        SessionUtil.setSessionValue(SessionUtil.SESSION_MOBILE_MSG_COUNT, mobileMsgCount)
        render ErrorCodeUtil.noError([seq:seq])
    }

    def checkMobileCode(){
        def seq = params.seq as int
        def code = params.code
        def seqInSession = SessionUtil.getSessionValue(SessionUtil.SESSION_MOBILE_SEQ)
        def codeInSession = SessionUtil.getSessionValue(SessionUtil.SESSION_MOBILE_CODE)
        if(code==codeInSession&& seq==seqInSession){
            render ErrorCodeUtil.noError()
        }else{
            render ErrorCodeUtil.invalidMobileCode()
        }
    }

    def genRandomCode() {
        def String verifyCode = RamdomNumUtil.generateVerifyCode(4)
        SessionUtil.setSessionValue(SessionUtil.SESSION_RANDOM_VERIFY_CODE, verifyCode);
        def image = RamdomNumUtil.outputImage(80, 25, verifyCode)
        render file: image, contentType: "image/jpeg"
    }

    def checkRandomCode(){
        def String code = params.code
        def String codeInSession = SessionUtil.getSessionValue(SessionUtil.SESSION_RANDOM_VERIFY_CODE)
        if(code.toUpperCase() ==codeInSession.toUpperCase()){
            render ErrorCodeUtil.noError()
        }else{
            render ErrorCodeUtil.invalidRandomCode()
        }
    }
}
