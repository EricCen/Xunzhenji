package net.xunzhenji.editor

import net.xunzhenji.wechat.WeChatText
import net.xunzhenji.exception.DuplicatedKeywordException
import net.xunzhenji.util.SessionUtil

class TextController extends EditorControllerBase{

    def index() {
        def texts = WeChatText.list()
        def textTotal = WeChatText.count()
        [texts:texts, textTotal:textTotal]
    }

    def add(){
        redirect(action: 'edit')
    }

    def edit() {
        def text
        if(!params.id){
            text = new WeChatText()
        }else{
            text = WeChatText.get(params.id)
        }
        [text:text]
    }

    def save(){
        def text
        if(!params.id){
            text = new WeChatText(weChatContext: session[SessionUtil.SESSION_WECHAT_CONTEXT])
        }else{
            text = WeChatText.get(params.id)
        }
        def keywords = params.keywords
        params.remove("keywords")
        text.properties = params

        try{
            mergeKeywords(text, keywords.split(' '))
        }catch(DuplicatedKeywordException e){
            text.errors.rejectValue('keywords', 'default.keywords.unique')
            render(view: 'edit', model: [text: text])
            return
        }

        if(text.keywords.find{!it.validate()}){
            render(view: 'edit', model: [text: text])
            return
        }

        if(text.validate()){
            text.save(flush:true)
        }else{
            render(view: 'edit', model: [text: text])
            return
        }
        redirect(action:'index')
    }

    def delete() {
        if(!params.id) {
            log.warn("Cannot delete on null id message")
            redirect(action: 'index')
            return
        }
        def text = WeChatText.get(params.id)
        if(!text){
            log.warn("Image not found for id:${params.id}")
            redirect(action: 'index')
            return
        }
        text.delete()
        redirect(action:'index')
    }
}
