package net.xunzhenji.wechat
/**
 *
 * Created by: Kevin
 * Created time : 15-4-29 ����10:18
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */

class WeChatPushController {


    def weChatPushService


    def push(){
        weChatPushService.send("o1zAMuGjKqqNHujegDRo8UCgAQfE", "lolTieGQ2QGLmt4q_d9MRxu2BlxfdYayzWDDKRFwLpiggWPt8C23338Z3lDFSv-6")
    }
}
