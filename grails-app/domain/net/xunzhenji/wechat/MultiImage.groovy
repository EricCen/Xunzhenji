package net.xunzhenji.wechat

/**
 *
 * Created by: Kevin
 * Created time : 2015/5/11 11:09
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */
class MultiImage extends Areply{

    static hasMany = [images: WeChatImage, keywords: Keyword]

    static belongsTo = [weChatContext:WeChatContext]

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
