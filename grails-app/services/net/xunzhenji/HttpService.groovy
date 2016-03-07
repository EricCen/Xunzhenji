/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji

import groovyx.net.http.HTTPBuilder

/**
 * Created by Irene on 2015/8/28.
 */
class HttpService {
    def static int TENSECONDS  = 10*1000
    def static int THIRTYSECONDS = 30*1000
    def static String USER_AGENT_BROWSER = "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5"

    def static void setTimeout(HTTPBuilder builder) {
        builder.getClient().getParams().setParameter("http.connection.timeout", new Integer(TENSECONDS))
        builder.getClient().getParams().setParameter("http.socket.timeout", new Integer(THIRTYSECONDS))
    }

    def withHttp = { url, closure->
        def httpBuilder = new HTTPBuilder(url)
        setTimeout(httpBuilder)
        try{
            closure(httpBuilder)
        }catch(e){
            log.error("Fail to execute http request", e)
        } finally{
            httpBuilder.shutdown()
        }
    }
}
