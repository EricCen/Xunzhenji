package net.xunzhenji.wechat

import net.xunzhenji.util.SignUtil

/**
 *
 * Created by: Kevin
 * Created time : 15-4-29 ����10:18
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */

class WeChatController {
    def weChatBasicService
    def weChatPullService

    def index(){
        if (request.method == 'GET') {
            def result =  handleGet(params)
            if(result) render result
        } else if (request.method == 'POST'){
            return handlePost(params)
        }

    }

    def handleGet(params){
        log.info("Handle get request : ${params}")

        String signature = params.signature;
        String timestamp = params.timestamp;
        String nonce = params.nonce;
        String echostr = params.echostr;

        if(signature && timestamp && nonce && SignUtil.checkSignature(signature, timestamp, nonce)){
            return echostr;
        }

        return "success"
    }

    def handlePost(params){
        log.info("Handle post: ${params}")

        def result = weChatPullService.process(request.reader.text)

        if(result){
            response.outputStream << result
        }else{
            response.outputStream << "success"
        }
    }
}
