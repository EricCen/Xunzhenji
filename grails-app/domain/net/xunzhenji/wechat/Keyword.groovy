package net.xunzhenji.wechat

import net.xunzhenji.util.SessionUtil

/**
 *
 * Created by: Kevin
 * Created time : 2015/5/11 11:14
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */
class Keyword {
    def String keyword

    static belongsTo = [weChatContext: WeChatContext]

    static constraints = {
        keyword size: 1..30, nullable: false, unique: true
    }
    def static List createKeyword(String keyword){
        def k = new Keyword(keyword: keyword, weChatContext: SessionUtil.getWeChatContext())

        [k]
    }

    def static List createKeywords( String... keywords){
        def ks = []
        keywords.each{
            if(it) ks << new Keyword(keyword: it, weChatContext: SessionUtil.getWeChatContext())
        }
        ks
    }

    def getImage(weChatContext){
        WeChatImage.findByKeywordsAndWeChatContext([this], weChatContext)
    }

    def getText(weChatContext){
        WeChatText.findByKeywordsAndWeChatContext([this],weChatContext)
    }

    public String toString(){
        "keyword:${keyword}"
    }
}
