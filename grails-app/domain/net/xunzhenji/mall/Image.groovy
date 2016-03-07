package net.xunzhenji.mall
/**
 *
 * Created by: Kevin
 * Created time : 2015/6/12 12:53
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */
class Image {

    static int IMAGE_MOBILE_WIDTH = 640
    static int IMAGE_MOBILE_HEIGHT = 480
    static int IMAGE_THUMB_WIDTH = 400
    static int IMAGE_THUMB_HEIGHT = 300

    static enum ScaleType {
        FIXED_WIDTH, FIXED_HEIGHT, FIXED_SIZE
    }

    static enum ImageCompressionType {
        MOBILE_FIXED_WIDTH("MOBILE_FIXED_WIDTH", Image.IMAGE_MOBILE_WIDTH, 0, "mobile", ScaleType.FIXED_WIDTH),
        MOBILE_FIXED_HEIGHT("MOBILE_FIXED_HEIGHT", 0, Image.IMAGE_MOBILE_HEIGHT, "mobile", ScaleType.FIXED_HEIGHT),
        MOBILE_FIXED_SIZE("MOBILE_FIXED_SIZE", Image.IMAGE_MOBILE_WIDTH, Image.IMAGE_MOBILE_HEIGHT, "mobile", ScaleType.FIXED_SIZE),
        THUMB_FIXED_WIDTH("THUMB_FIXED_WIDTH", Image.IMAGE_THUMB_WIDTH, 0, "thumb", ScaleType.FIXED_WIDTH),
        THUMB_FIXED_HEIGHT("THUMB_FIXED_HEIGHT", 0, Image.IMAGE_THUMB_HEIGHT, "thumb", ScaleType.FIXED_HEIGHT),
        THUMB_FIXED_SIZE("THUMB_FIXED_SIZE", Image.IMAGE_THUMB_WIDTH, Image.IMAGE_THUMB_HEIGHT, "thumb", ScaleType.FIXED_SIZE)

        public String name
        public int scaledWidth
        public int scaledHeight
        public String type
        public ScaleType scaleType

        ImageCompressionType(String name, int scaledWidth, int scaledHeight, String type, ScaleType scaleType) {
            this.name = name
            this.scaledWidth = scaledWidth
            this.scaledHeight = scaledHeight
            this.type = type
            this.scaleType = scaleType
        }
    }

    /*
    * The absolute path at server
     */
    def String fullPath
    /*
    * The relative path in upload root folder
     */
    def String path
    def String thumbPath
    def String mobilePath

    def String uploadName
    def String fileName
    def String thumbFileName
    def String mobileFileName
    def String url
    def String thumbUrl
    def String mobileUrl
    def String deleteUrl
    def String host
    def long size = 0
    def String description
    def String buttonName
    def String ownerClass
    def String ownerField
    def long ownerId = 0
    def int order = 0

    static constraints = {
        description nullable: true
        buttonName nullable: true
        ownerClass nullable: true
        ownerField nullable: true
    }

    static mapping = {
        order column: "image_order"
    }

    public String toString() {
        "<img src=\"${url}\" style=\"max-width:200px\"\\>"
    }
}
