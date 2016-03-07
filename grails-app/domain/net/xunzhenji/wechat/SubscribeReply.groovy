package net.xunzhenji.wechat

/**
 *
 * Created by: Kevin
 * Created time : 2015/5/7 16:15
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */
class SubscribeReply extends Areply {
    def Keyword keyword

    static belongsTo = [weChatContext:WeChatContext]
}
