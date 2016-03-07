package net.xunzhenji

import net.xunzhenji.wechat.WeChatImage
import net.xunzhenji.wechat.WeChatContext

/**
 *
 * Created by: Kevin
 * Created time : 2015/5/7 17:09
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */
class Classification {
    def String name
    def String introduction

    static hasMany = [images : WeChatImage]

    static belongsTo = [weChatContext:WeChatContext]

    static constraints = {
        introduction nullable: true
    }

    public String toString(){
        name
    }
}
