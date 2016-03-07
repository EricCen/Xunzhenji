package net.xunzhenji.wechat

import grails.converters.JSON
import groovy.json.JsonSlurper
import groovyx.net.http.ContentType
import groovyx.net.http.Method
import org.apache.http.entity.mime.MultipartEntity
import org.apache.http.entity.mime.content.FileBody

/**
 *
 * Created by: Kevin
 * Created time : 15-4-29 11:58
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */

class WeChatMediaService extends WeChatService{
    def weChatBasicService

    // 新增临时素材，素材3天后自动删除
    def uploadMedia(Media media){
        def token = weChatBasicService.getAccessToken()
        def query = [access_token:token, "type": media.type]
        if(token){
            api.request(Method.POST) { multipartRequest ->
                uri.path = WeChatService.URL_MEDIA_UPLOAD
                uri.query = query
                requestContentType = ContentType.BINARY
                FileBody fileBody = new FileBody(new File(media.path))
                MultipartEntity reqEntity = new MultipartEntity();
                reqEntity.addPart("media", fileBody);

                multipartRequest.entity = reqEntity

                response.success = { resp, reader ->
                    def jsonText = reader.getText()
                    def json = new JsonSlurper().parseText(jsonText)
                    if(json.errcode){
                        media.errors.reject(json.errcode)
                    }else{
                        media.type = json.type
                        media.mediaId= json.media_id
                        media.weChatCreatedAt = new Date((json.created_at as long)* 1000)
                        media.status = Media.STATUS_BECOME_WECHAT_MEDIA
                        log.info("Successfully upload media")
                    }
                }
            }
        }else {
            log.info("WechatContext may not yet defined.")
        }
        media
    }

    //获取临时素材
    def getMedia(){

    }

    //新增永久素材 (image, voice, thumb)
    def addMaterial(Media media){
        def token = weChatBasicService.getAccessToken()
        def query = [access_token:token, "type": media.type]
        if(token){
            api.request(Method.POST) { multipartRequest ->
                uri.path = WeChatService.URL_MATERIAL_UPLOAD
                uri.query = query
                requestContentType = ContentType.BINARY
                FileBody fileBody = new FileBody(new File(media.path))
                MultipartEntity reqEntity = new MultipartEntity()
                reqEntity.addPart("media", fileBody)
                if(Media.TYPE_VIDEO.equals(media.type)){
                    reqEntity.addPart("description", [title:media.title, introduction:media.introduction] as JSON);
                }

                multipartRequest.entity = reqEntity

                response.success = { resp, reader ->
                    def jsonText = reader.getText()
                    def json = new JsonSlurper().parseText(jsonText)
                    if(json.errcode){
                        log.error("Fail to add material to server, err;${json}")
                        media.errors.reject(json.errcode as String, json.errormsg)
                    }else{
                        media.mediaId = json.media_id
                        media.status = Media.STATUS_BECOME_WECHAT_MATERIAL
                        log.info("Successfully upload material")
                    }
                }
            }
        }else {
            log.info("WechatContext may not yet defined.")
        }
        media
    }

    //获取永久素材
    def getMaterial(mediaId){
        def token = weChatBasicService.getAccessToken()
        def query = [access_token:token]
        def body = [media_id: mediaId]
        def ret = []
        if(token){
            api.post(path: WeChatService.URL_GET_MATERIAL, query: query, body: body,
                    requestContentType: ContentType.JSON){ resp, reader ->
                def json = new JsonSlurper().parseText(reader.getText())
                if(json.errcode){
                    log.warn("Error found during get material, ${json}")
                    return ret
                }
                if (json.news_item) {
                    json.news_item.each {
                        ret << [type            : Media.TYPE_NEWS,
                                title           : it.title,
                                thumbMediaId    : it.thumb_media_id,
                                thumbUrl: it.thumb_url,
                                showCoverPic    : it.show_cover_pic,
                                author          : it.author,
                                digest          : it.digest,
                                content         : it.content,
                                url             : it.url,
                                contentSourceUrl: it.content_source_url]
                    }
                } else {
                    ret << [title: json.title, description: json.description, url: json.down_url]
                }
            }
        }else {
            log.info("WechatContext may not yet defined.")
        }

        ret.each {
            println "${it.title} ${it.digest} ${it.thumbUrl}"
        }
        ret
    }

    //删除永久素材
    def deleteMaterial(mediaId){
        def token = weChatBasicService.getAccessToken()
        def query = [access_token:token]
        def body=[media_id:mediaId]
        def ret = []
        if(token){
            api.post(path: WeChatService.URL_DEL_MATERIAL, query: query, body: body,
                    requestContentType: ContentType.JSON){ resp, reader ->
                def json = new JsonSlurper().parseText(reader.getText())
                if(json.errcode){

                    log.warn("Error found during del material, ${ret}")
                }
                ret = json
            }
        }else {
            log.info("WechatContext may not yet defined.")
        }
        ret
    }

    //修改永久图文素材
    def updateMaterial(){

    }

    //获取素材总数
    def getMaterialCount(){
        log.info("Retrieve material count...")

        def query  = [access_token: weChatBasicService.getAccessToken()]

        api.get(path: WeChatService.URL_MATERIAL_COUNT, query: query) { resp, reader ->
            def json = new JsonSlurper().parseText(reader.getText())
            return json
        }
    }

    //获取素材列表
    def batchGetMaterial(type, offset, count){
        log.info("Batch get material, type:${type}, offset:${offset}, count:${count}")
        def token = weChatBasicService.getAccessToken()
        def query = [access_token:token]
        def body=[type:type, offset:offset, count:count]
        def ret = []
        if(token){
            api.post(path: WeChatService.URL_BATCHGET_MATERIAL, query: query, body: body,
                    requestContentType: ContentType.JSON){ resp, reader ->
                def json = new JsonSlurper().parseText(reader.getText())
                if(json.errcode){
                    ret = json
                    log.warn("Error found during get material, ${ret}")
                }else{
                    json.item.each{
                        ret << [mediaId        : it.media_id,
                                name           : it.name,
                                weChatCreatedAt: new Date((it.update_time as long) * 1000),
                                url    : it.url,
                                content: it.content?.news_item
                        ]
                    }
                }
            }
        }else {
            log.info("WechatContext may not yet defined.")
        }
        ret
    }

    //新增永久图文素材, 每天只能调用一次, 进入消息历史
    def addNews(title, thumbMediaId, author, digest, showCoverPic, content, contentSourceUrl){
        def token = weChatBasicService.getAccessToken()
        def query = [access_token:token]
        def body=[articles:[
                [title:title, thumb_media_id:thumbMediaId, author:author, digest:digest, show_cover_pic:showCoverPic, content:content, content_source_url:contentSourceUrl]
        ]]
        def ret = [:]
        if(token){
            api.post(path: WeChatService.URL_ADD_NEWS, query: query, body: body,
                    requestContentType: ContentType.JSON){ resp, reader ->
                def json = new JsonSlurper().parseText(reader.getText())
                if(json.errcode){
                    ret = json
                    log.warn("Error found during add news, ${ret}")
                }else{
                    ret.mediaId = json.media_id
                }
            }
        }else {
            log.info("WechatContext may not yet defined.")
        }
        ret
    }

    //上传图文消息素材, 相当于临时素材
    def uploadNews(title, thumbMediaId, author, digest, showCoverPic, content, contentSourceUrl){
        log.info("Upload news to sever...")
        def token = weChatBasicService.getAccessToken()
        def query = [access_token:token]
        def body
        if(contentSourceUrl){
            body = [articles:[
                    [thumb_media_id:thumbMediaId, author:author, title:title, content:content, content_source_url:contentSourceUrl, digest:digest, show_cover_pic:showCoverPic]
            ]]
        }else{
            body = [articles:[
                    [thumb_media_id:thumbMediaId, author:author, title:title, content:content, digest:digest, show_cover_pic:showCoverPic]
            ]]
        }


        def ret = [:]
        if(token){
            api.post(path: WeChatService.URL_UPLOAD_NEWS, query: query, body: body,
                    requestContentType: ContentType.JSON){ resp, reader ->
                def json = new JsonSlurper().parseText(reader.getText())
                if(json.errcode){
                    ret = json
                    log.warn("Error found during upload news, ${ret}")
                }else{
                    ret.mediaId = json.type
                    ret.mediaId = json.media_id
                    ret.weChatCreatedAt = json.created_at
                }
            }
        }else {
            log.info("WechatContext may not yet defined.")
        }
        ret
    }
}
