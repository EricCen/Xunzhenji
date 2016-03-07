package net.xunzhenji.editor

import net.xunzhenji.wechat.Keyword
import net.xunzhenji.exception.DuplicatedKeywordException

/**
 *
 * Created by: Kevin
 * Created time : 2015/5/11 13:20
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */
abstract class EditorControllerBase {
    def springSecurityService

    // merge keywords into obj's keywords, it need to make sure new keyword didn't duplicated with other auto reply
    protected void mergeKeywords(obj, keywords) {
        def toRemoveKeywords = []
        obj.keywords.each { kw ->
            if (!keywords.contains(kw.keyword)) {
                toRemoveKeywords << kw
            }
        }
        keywords.each { keyword ->
            if(!keyword) return
            if (!obj.keywords.find { it.keyword == keyword }) { // the keyword is new keyword to the auto reply
                if(!obj.keywords) obj.keywords = []
                def _k = Keyword.findByKeyword(keyword)

                if(_k) { //if DB already exists, means other auto reply use this
                     throw new DuplicatedKeywordException()
                }else{ //if DB didn't has one then create one
                    _k=Keyword.createKeyword(keyword)
                }
                obj.keywords.addAll(_k)
            }
        }
        toRemoveKeywords.each {
            Keyword.get(it.id).delete()
            obj.keywords.remove(it);
        }
    }
}
