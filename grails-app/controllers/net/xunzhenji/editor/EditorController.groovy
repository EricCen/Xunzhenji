package net.xunzhenji.editor

import net.xunzhenji.mall.Image
import net.xunzhenji.model.MarkerLocation

import java.awt.image.BufferedImage

/**
 *
 * Created by: Kevin
 * Created time : 2015/5/8 15:56
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */
class EditorController {
    def springSecurityService
    def uploadService
    def imageService

    def upload(){
        def userId = params.id
        if (!userId || !springSecurityService.isLoggedIn()){
            log.warn("User not yet login, not allow upload.")
            return
        }

        println params

        [:]
    }

    def fileUpload (params) {
        def currentUser = springSecurityService.getCurrentUser()
        if(!currentUser) {
            redirect(controller: "login")
            return
        }

        def BufferedImage thumbBufferedImage = imageService.compressImage(params.imgFile.getInputStream(),
                Image.ImageCompressionType.MOBILE_FIXED_WIDTH,
                MarkerLocation.None)
        def host = params.requestUrl
        def file = uploadService.imageUpload(thumbBufferedImage, System.currentTimeMillis() + ".png", host)
        file
    }
}
