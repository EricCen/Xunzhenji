package net.xunzhenji.editor

import net.xunzhenji.Classification
import net.xunzhenji.exception.DuplicatedKeywordException
import net.xunzhenji.util.SessionUtil
import net.xunzhenji.wechat.Media
import net.xunzhenji.wechat.MediaWeChatImage
import net.xunzhenji.wechat.WeChatImage

class ImageController extends EditorControllerBase{
    def weChatMediaService

    def index() {
        redirect(action: "list")
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def images = WeChatImage.list(params)
        def imageTotal = WeChatImage.count()
        [images:images, imageTotal:imageTotal]
    }

    def add(){
        redirect(action: 'edit')
    }

    def edit() {
        def image
        if(!params.id){
            image = new WeChatImage()
        }else{
            image = WeChatImage.get(params.id)
        }
        [image:image]
    }

    def save(){
        log.info("Saving the image(${params.id})...")
        def WeChatImage image

        if(!params.id){
            image = new WeChatImage(weChatContext: session[SessionUtil.SESSION_WECHAT_CONTEXT])
        }else{
            image = WeChatImage.get(params.id)
        }
        try{
            mergeKeywords(image, params.keywords.split(' '))
        }catch(DuplicatedKeywordException e){
            image.errors.rejectValue('keywords', 'default.keywords.unique')
            render(view: 'edit', model: [image: image])
            return
        }
        params.remove("keywords")

        image.properties = params
        if(params.picId && ((params.picId as long)!= image.pic?.id)){
            image.pic = Media.get(params.picId)
        }

        if(params.classid && ((params.classid as long)!= image.classification?.id)){
            image.classification = Classification.get(params.classid as long)
        }

        if(image.validate() && !image.keywords.find{!it.validate()}){
            // upload cover pic as material to wechat server|||| donot upload to save request number
//            if(uploadMedia){
//                def ret = weChatMediaService.addMaterial(image.pic)
//                if(ret.hasErrors()){
//                    log.error("Fail to upload media to server, err;${ret.errors}")
//                }else{
//                    image.pic.mediaId = ret.mediaId
//                }
//            }
            image.save(flush:true)
        }else{
            log.error("Validation fail, error:${image.errors}")
            render(view: 'edit', model: [image: image])
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
        def image = WeChatImage.get(params.id)

        if(!image){
            log.warn("Image not found for id:${params.id}")
            redirect(action: 'index')
            return
        }
        MediaWeChatImage.findAllByWeChatImage(image)*.delete()
        image.keywords*.delete()
        image.delete()
        redirect(action:'index')
    }
}
