package net.xunzhenji.wechat

import net.xunzhenji.Classification

/**
 * 微信图文消息
 * Created by: Kevin
 * Created time : 2015/5/7 16:15
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */
class WeChatImage extends Areply {
    def Media pic
    def String thumbUrl
    def int showPic = 1
    def String title
    def String digest
    def String content
    def String url
    def String contentSourceUrl
    def int click = 0
    def int usort = 0
    def int isFocus = 0
    def String author

    static hasOne = [classification: Classification]

    static hasMany = [keywords:Keyword]

    static belongsTo = [weChatContext:WeChatContext]

    static constraints = {
        keywords nullable: false
        title size: 2..30, nullable: false
        url nullable: true
        author nullable: true
        digest nullable: true
        pic nullable: true
        classification nullable: true
        contentSourceUrl nullable: true
        thumbUrl nullable: true
        keywords(validator: { val, obj ->
            def retval = true
            if (!obj?.keywords?.size()) {
                retval = 'default.hasnokeywords.error'
            }
            return retval
        })
    }

    static mapping = {
        content type: "text"
    }

    public String toString(){
        "Image(id:${id},title:${title})"
    }
}
