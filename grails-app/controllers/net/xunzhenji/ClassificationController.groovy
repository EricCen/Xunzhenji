package net.xunzhenji

import net.xunzhenji.util.SessionUtil

/**
 *
 * Created by: Kevin
 * Created time : 2015/5/26 11:18
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */
class ClassificationController {

    def static scaffold = true

    def save(){
        def weChatContext = SessionUtil.getWeChatContext()
        def classification

        if(!params.id){
            classification = new Classification(weChatContext:weChatContext)
        }else{
            classification = Classification.get(params.id)
            classification.weChatContext = weChatContext
        }

        classification.properties = params

        if(classification.validate()){
            classification.save()
        }else{
            render(view:"edit", model:[classification:classification])
            return
        }
        redirect(action:'index')
    }
}
