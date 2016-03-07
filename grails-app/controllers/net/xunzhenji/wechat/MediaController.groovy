package net.xunzhenji.wechat

import net.xunzhenji.Classification
import net.xunzhenji.util.SessionUtil

class MediaController {
    def weChatMediaService
    def customMessageService

    def static scaffold = true

    def sync(){
        def materialsCounts = weChatMediaService.getMaterialCount()

        if(materialsCounts.errcode){
            log.error("Fail to get materials count, ${materialsCounts}")
            redirect(action: "index")
            return
        }

        def imageCount = materialsCounts.image_count
        def newsCount = materialsCounts.news_count
        def videoCount = materialsCounts.video_count
        def voiceCount = materialsCounts.voice_count

        if(imageCount){
            syncMadia(imageCount, Media.TYPE_IMAGE)
        }
        if (newsCount) {
            syncMadia(newsCount, Media.TYPE_NEWS)
        }

        redirect(action: "index")
    }

    def syncMadia(imageCount, mediaType) {
        def imageBatch = (imageCount - imageCount % 20) / 20
        imageBatch = imageBatch > 0 ? imageBatch - 1: 0
        def lastBatch = imageCount % 20
        def items = []
        (0..imageBatch).each{i->
            items.addAll(weChatMediaService.batchGetMaterial(mediaType, i * 20, imageCount > 20 ? 20 : imageCount))
        }
        if (imageBatch > 0 && lastBatch) items.addAll(weChatMediaService.batchGetMaterial(mediaType, imageBatch * 20, lastBatch))

        def weChatContext = session[SessionUtil.SESSION_WECHAT_CONTEXT]
        def medias = Media.findAllByTypeAndWeChatContext(mediaType, weChatContext)
        items.each{ item->
            def media = medias.find{it.mediaId.equals(item.mediaId)}
            if(media){
                media.weChatCreatedAt = item.weChatCreatedAt
                media.status = Media.STATUS_BECOME_WECHAT_MEDIA
            }else{
                if (item.content) {
                    //create WeChatImage
                    def title = item.content[0].title
                    def digest = item.content[0].digest
                    media = new Media(mediaId: item.mediaId,
                            type: mediaType,
                            fileName: item.name,
                            uploadName: item.name,
                            weChatCreatedAt: item.weChatCreatedAt,
                            status: Media.STATUS_BECOME_WECHAT_MEDIA,
                            title: title,
                            introduction: digest,
                            weChatContext: weChatContext)
                    media.save()
                    item.content.each { newsItem ->
                        def weChatImage = new WeChatImage(weChatContext: weChatContext)
                        weChatImage.showPic = newsItem.showPic ? newsItem.showPic as int : 0
                        weChatImage.title = newsItem.title
                        weChatImage.thumbUrl = newsItem.thumb_url
                        weChatImage.author = newsItem.author
                        weChatImage.digest = newsItem.digest
                        weChatImage.content = newsItem.content
                        weChatImage.url = newsItem.url
                        weChatImage.contentSourceUrl = newsItem.content_source_url
                        weChatImage.classification = Classification.first()
                        weChatImage.save()

                        new MediaWeChatImage(media: media, weChatImage: weChatImage).save()
                    }
                } else {
                    media = new Media(mediaId: item.mediaId,
                            type: mediaType,
                            fileName: item.name,
                            uploadName: item.name,
                            weChatCreatedAt: item.weChatCreatedAt,
                            url: item.url,
                            status: Media.STATUS_BECOME_WECHAT_MEDIA,
                            weChatContext: weChatContext)
                    media.save()
                }
            }
        }
    }

    def syncSingleMedia() {
        log.info("Sync single media, id: ${params.id}")
        def mediaFromWeChat = weChatMediaService.getMaterial(params.id)
        def mediaInDb = Media.findByMediaId(params.id)
        def weChatContext = WeChatContext.first()
        mediaFromWeChat.each { media ->
            if (media.type == Media.TYPE_NEWS) {
                def mediaWeChatImage = MediaWeChatImage.findAllByMedia(mediaInDb)
                def weChatImage = mediaWeChatImage*.weChatImage.find { it.title == media.title }
                log.info("Add or update wechat image, ${media.title}")
                if (!weChatImage) {
                    log.info("Add wechat image, ${media.title}")
                    weChatImage = new WeChatImage(weChatContext: weChatContext)
                    mediaWeChatImage = new MediaWeChatImage(media: mediaInDb, weChatImage: weChatImage)
                }

                if (!weChatImage.keywords) {
                    weChatImage.addToKeywords(new Keyword(keyword: media.title, weChatContext: weChatContext))
                }
                weChatImage.title = media.title
                weChatImage.thumbUrl = media.thumbUrl
                weChatImage.showPic = media.showPic ? media.showPic as int : 0
                weChatImage.author = media.author
                weChatImage.digest = media.digest
                weChatImage.content = media.content
                weChatImage.url = media.url
                weChatImage.contentSourceUrl = media.contentSourceUrl
                weChatImage.pic = Media.findByMediaId(media.thumbMediaId)

                weChatImage.save()
                mediaWeChatImage*.save()

            } else {
                mediaInDb.title = media.title
                mediaInDb.introduction = media.description
                mediaInDb.url = media.title
            }
        }
        mediaInDb.title = mediaFromWeChat[0]?.title
        mediaInDb.introduction = mediaFromWeChat[0]?.introduction
        mediaInDb.save()
        log.info("Return media, ${mediaInDb}")
        redirect(action: "show", id: mediaInDb.id)
    }

    def sendToAllActiveUser(){
        log.info("Send custom message to all active user, mediaId: ${params.id}")
        def Media media = Media.findByMediaId(params.id)
        customMessageService.sendMessageByMediaId("o_KJxsxO_hf2iyPeVY_8IF17YoSI", media.type, params.id)
        redirect(action: "show", id: media.id)
    }

    def delete(){
        if(!params.id){
            log.error("Cannot delete media without id")
            redirect(action: 'index')
            return
        }
        def media = Media.get(params.id)


        if(!ret.errcode){
            WeChatImage.findByPic(media).delete()
            media.delete()
        }
        redirect(action: 'index')
    }
}
