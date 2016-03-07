package net.xunzhenji.editor

import net.xunzhenji.wechat.Keyword
import net.xunzhenji.wechat.SubscribeReply
import net.xunzhenji.util.SessionUtil

class AreplyController extends EditorController{

    def index() {
        def subscribeReplies = SubscribeReply.list()
        if(!subscribeReplies){
            return [:]
        }

        [subscribeReply: subscribeReplies[0]]
    }

    def save(){
        def subscribeReply
        if(params.keyword){
            def subscribeReplies = SubscribeReply.list()
            def weChatContext = session[SessionUtil.SESSION_WECHAT_CONTEXT]

            //check if keyword exists
            def keyword = Keyword.findByKeyword(params.keyword as String)
            if(!keyword){
                redirect(action: 'index', params:[error:"找不到关键字"])
                return
            }

            if(!subscribeReplies){
                subscribeReply = new SubscribeReply(keyword: keyword)
                subscribeReply.weChatContext = weChatContext
            }else{
                subscribeReply = subscribeReplies[0]
                subscribeReply.keyword = keyword
            }
            subscribeReply.save()
        }
        redirect(action:'index')
    }
}
