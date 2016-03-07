package net.xunzhenji.editor

import net.xunzhenji.wechat.WeChatImage
import net.xunzhenji.wechat.Keyword
import net.xunzhenji.wechat.MultiImage
import net.xunzhenji.util.SessionUtil

class MultiimageController extends EditorControllerBase{

    def index() {
        [:]
    }

    def list(){
        def multiImages = MultiImage.list(sort: "id", order:"desc")
        def multiImageCount = MultiImage.count()
        println multiImages
        [multiImages:multiImages, multiImageCount: multiImageCount]
    }

    def edit() {
        println params
        def image
        if(!params.id){
            image = new WeChatImage()
        }else{
            image = WeChatImage.get(params.id)
        }
        def result = [image:image]
        if(params.from_action) result.put("from_action", params.from_action)
        result
    }

    def save(){
        def keywords = params.keywords?.split(" ")

        def multiimage = new MultiImage(weChatContext: session[SessionUtil.SESSION_WECHAT_CONTEXT])

        // check empty keywords
        if(keywords){
            multiimage.keywords = Keyword.createKeywords(keywords)
        }

        multiimage.keywords.each{
            if(!it.validate()){
                def code = it.errors.getFieldError('keyword').getCode()
                multiimage.errors.rejectValue('keywords', 'default.keywords.'+code)
            }
        }

        //check if any image added
        def imageIds = params.imgids?.split(",")
        imageIds = imageIds.findAll {it}.collect {it as Long}
        def images = WeChatImage.withCriteria {
            'in'('id', imageIds)
        }
        if(!images) {
            multiimage.errors.rejectValue(
                    'images',
                    'multiimage.images.noimages',
                    'No multiple image')
        }

        multiimage.images = images

        if(!multiimage.hasErrors() && multiimage.validate()){
            multiimage.save(flush: true)
        }else{
            render(view: 'index', model: [multiimage:multiimage])
            return
        }

        redirect(controller: "multiimage", action: "list")
    }

    def delete() {
        if(!params.id) {
            log.warn("Cannot delete on null id message")
            redirect(action: 'list')
            return
        }
        def multiImage = MultiImage.get(params.id)
        if(!multiImage){
            log.warn("Image not found for id:${params.id}")
            redirect(action: 'list')
            return
        }
        multiImage.delete()
        redirect(action:'list')
    }

    def img(){
        def images = WeChatImage.list(order: 'desc', sort: "id")
        def items = []
        images.each{ image->
            items << [id: image.id, title: image.title, pic: image.pic, digest: image.digest, linkcode:createLink(controller: "h5", action: "show", id:image.id), linkurl:'']
        }
        [list:items]
    }
}
