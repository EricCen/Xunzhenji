package net.xunzhenji.wechat

/**
 *
 * Created by: Kevin
 * Created time : 2015/5/8 10:59
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */
class WeChatText extends Areply{
    def String text
    def int click = 0

    static hasMany = [keywords:Keyword]

    static belongsTo = [weChatContext:WeChatContext]

    static mapping = {

    }

    static constraints = {
        keywords(validator: { val, obj ->
            def retval = true
            if (!obj?.keywords?.size()) {
                retval = 'default.hasnokeywords.error'
            }
            return retval
        })
    }
}
