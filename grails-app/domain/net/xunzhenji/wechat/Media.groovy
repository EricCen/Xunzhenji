package net.xunzhenji.wechat
/**
 * All video, image, voice are media, in wechat it will be deleted 3 days after upload, but will never be auto deleted
 * in this platform.
 */
class Media {
    public static final String TYPE_NEWS = "news"
    public static final String TYPE_IMAGE = "image"
    public static final String TYPE_VOICE = "voice"
    public static final String TYPE_VIDEO = "video"
    public static final String TYPE_THUMB = "thumb"
    public static final String TYPE_MPNEWS = "mpnews"

    public static final int STATUS_AT_LOCAL = 0
    public static final int STATUS_BECOME_WECHAT_MEDIA = 1      //还是临时素材
    public static final int STATUS_BECOME_WECHAT_MATERIAL = 2   //变成永久素材

    def String type
    def String url
    def String fileName
    def String path //server fullPath
    def String host
    def String uploadName
    def Long size = -1
    def String thumbUrl

    //for video
    def String title
    def String introduction

    //for wechat
    def int status = STATUS_AT_LOCAL
    def String mediaId
    def Date weChatCreatedAt

    static belongsTo = [weChatContext:WeChatContext]

    static constraints = {
        type size: 4..6, blank: false
        title nullable: true
        introduction nullable: true
        mediaId nullable: true, unique: true
        weChatCreatedAt nullable: true
        host nullable: true
        path nullable: true
        thumbUrl nullable: true
        url nullable: true
        fileName nullable: true
        uploadName nullable: true
    }

    def isOnServer(){
        if(status == STATUS_BECOME_WECHAT_MATERIAL){
            return true
        } else if(status == STATUS_BECOME_WECHAT_MEDIA){
            return ((weChatCreatedAt + 3).getTime() - new Date().getTime()) > 0
        }
        return false
    }

    def getFullUrl(){
        'http://'+host+'/'+url
    }
}
