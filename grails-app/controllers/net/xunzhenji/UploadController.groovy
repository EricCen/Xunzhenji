/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji

import grails.converters.JSON
import net.xunzhenji.mall.Image
import net.xunzhenji.mall.Product
import net.xunzhenji.model.MarkerLocation
import net.xunzhenji.util.ErrorCodeUtil
import org.apache.commons.lang.time.DateFormatUtils

import java.awt.image.BufferedImage
import java.util.concurrent.TimeUnit

/*
Get URL pattern: http://server:port/upload/file/type/year/month/filename.ext
Delete URL pattern http://server:port/upload/delete/type/year/month/filename.ext
 */

class UploadController {
    static String UPLOAD_PATH = "/opt/upload/"
    static String CDN_HOST = "http://assets.xunzhenji.net"
    def springSecurityService
    def uploadService
    def imageService

    def file(params) {
        log.debug("Receive file request, ${params}")
        def type = params.type
        def filename = params.id
        def year = params.year
        def month = params.month

        File image = getFile("${type}/${year}/${month}/${filename}")

        if (!filename || !image.exists()) {
            return
        }

        def contentType
        if (((String) filename).endsWith('.jpg')) {
            contentType = "image/jpeg"
        } else {
            contentType = "image/png"
        }
        render file: image.newInputStream(), contentType: contentType
    }

    def File getFile(file) {
        new File(UPLOAD_PATH + File.separator + file)
    }

    def fileUpload(params) {
        log.info("Receive file upload request...")
        def currentUser = springSecurityService.getCurrentUser()
        if (!currentUser) {
            redirect(controller: "login")
            return
        }
        def uid = currentUser.id
        def host = params.requestUrl

        def file = uploadService.imageUpload(uid, params.ZZZZZ, host)

        render file as JSON
    }

    def imageUpload(params) {
        log.info("Receive image upload request..., ${params}")

        def host = params.host

        def slideImage = doImageUpload(params["files[]"], host, CDN_HOST, params.addMarker)

        def slideImgFile = new File(slideImage.fullPath)
        def fullPath = slideImgFile.getParent()
        def fileName = slideImgFile.getName()
        fileName = fileName.substring(0, fileName.lastIndexOf("."))
        def ext = slideImage.fullPath.substring(slideImage.fullPath.lastIndexOf(".")+1)
        try{
            Server.otherServerIps().each{ip->
                scp(ip, "${fullPath}${File.separator}${fileName}.${ext}", fullPath)
                scp(ip, "${fullPath}${File.separator}${fileName}-mobile.${ext}", fullPath)
                scp(ip, "${fullPath}${File.separator}${fileName}-thumb.${ext}", fullPath)
            }
        }catch (e){
            log.error("Fail to sync file to other server", e)
        }
        render slideImage as JSON
    }

    private void scp(ip, filename, targetPath) {
        String cmd = "/usr/bin/scp ${filename} root@${ip}:${targetPath}"
        log.info("Execute command: ${cmd}")
        Process p = Runtime.getRuntime().exec(cmd)
        if (p.waitFor(10, TimeUnit.SECONDS)) {
            int r = 0;
            byte[] b = new byte[1024];
            while ((r = p.getErrorStream().read(b, 0, 1024)) > -1) {
                log.error(new String(b, 0, r));
            }
        }
    }

    private void remoteDelete(ip, filename){
        String cmd = "/usr/bin/ssh root@${ip} rm -f ${filename}"
        log.info("Execute command: ${cmd}")
        Process p = Runtime.getRuntime().exec(cmd)
        if (p.waitFor(10, TimeUnit.SECONDS)) {
            int r = 0;
            byte[] b = new byte[1024];
            while ((r = p.getErrorStream().read(b, 0, 1024)) > -1) {
                log.error(new String(b, 0, r));
            }
        }
    }

    private Image doImageUpload(imageFile, host, cdn, addMarker) {
        def imageUploadResult = uploadService.fileUpload("image", imageFile, host, cdn)

        log.info("Original image upload result: " + imageUploadResult)

        def image
        if (!imageUploadResult.error) {
            def imageFileName = imageUploadResult.fileName
            def imageFileNameWithoutExt = imageFileName.substring(0, imageFileName.lastIndexOf('.'))
            def ext = imageFileName.substring(imageFileName.lastIndexOf('.'))

            def BufferedImage thumbBufferedImage = imageService.compressImage(imageFile.getInputStream(),
                    Image.ImageCompressionType.THUMB_FIXED_WIDTH,
                    MarkerLocation.None)
            def thumbFileName = imageFileNameWithoutExt + "-" + Image.ImageCompressionType.THUMB_FIXED_WIDTH.type + ext
            def thumbUploadResult = uploadService.imageUpload(thumbBufferedImage, thumbFileName, cdn)
            log.info("Thumbnail image upload result: " + thumbUploadResult)

            def BufferedImage mobileBufferedImage = imageService.compressImage(imageFile.getInputStream(),
                    Image.ImageCompressionType.MOBILE_FIXED_WIDTH,
                    addMarker ? MarkerLocation.BottomRight : MarkerLocation.None)
            def mobileFileName = imageFileNameWithoutExt + "-" + Image.ImageCompressionType.MOBILE_FIXED_WIDTH.type + ext
            def mobileUploadResult = uploadService.imageUpload(mobileBufferedImage, mobileFileName, cdn)
            log.info("Image in mobile size upload result: " + mobileUploadResult)

            if (!mobileUploadResult.error && !mobileUploadResult.error) {
                image = new Image(imageUploadResult)
                image.thumbUrl = thumbUploadResult.url
                image.thumbFileName = thumbFileName
                image.thumbPath = thumbUploadResult.path
                image.mobileUrl = mobileUploadResult.url
                image.mobileFileName = mobileFileName
                image.mobilePath = mobileUploadResult.path
                image.host = cdn
                image.save(flush: true)
                imageUploadResult.id = image.id
            }
        }

        image
    }

    def delete(params) {
        log.info("Recieve delete request, ${params}")
        def type = params.type
        def filename = params.id
        def year = params.year
        def month = params.month
        def image = Image.findByFileName(filename)
        File filePath = getFile("${type}/${year}/${month}/${filename}")
        def resultCode = -1

        if (image && filePath.exists()) {
            Image.withTransaction {
                if (image.ownerClass) {
                    def owner = Image.executeQuery("from ${image.ownerClass} where id = ${image.ownerId}")

                    if(image.ownerField){
                        owner[0][image.ownerField] = null
                    }else{
                        owner[0].images.remove(image)
                        owner[0].save(flush: true)
                    }
                } else
                    log.warn("The image doesn't have a owner..")

                resultCode = uploadService.fileDelete(filePath)
                if (resultCode == 0) {
                    def fileNameWithoutExt = filename.substring(0, filename.lastIndexOf('.'))
                    def ext = filename.substring(filename.lastIndexOf('.'))

                    def thumbImageFileName =  fileNameWithoutExt + "-thumb" + ext
                    File thumbImageFilePath = getFile("${type}/${year}/${month}/${thumbImageFileName}")
                    if (thumbImageFilePath.exists()) {
                        uploadService.fileDelete(thumbImageFilePath)
                    }

                    def mobileImageFileName =  fileNameWithoutExt + "-mobile" + ext
                    File mobileImageFilePath = getFile("${type}/${year}/${month}/${mobileImageFileName}")
                    if (mobileImageFilePath.exists()) {
                        uploadService.fileDelete(mobileImageFilePath)
                    }
                }

                deleteImageOnOtherServer(image.fullPath)

                image.delete()
            }
        } else if (image && !filePath.exists()) {
            log.warn("Image not found on server..")
            if (image.ownerClass) {
                def owner = Image.executeQuery("from ${image.ownerClass} where id = ${image.ownerId}")
                if(owner){
                    if(image.ownerField){
                        owner[0][image.ownerField] = null
                    }else{
                        owner[0].images.remove(image)
                        owner[0].save(flush: true)
                    }
                }else{
                    log.error("Cannot find the owner object, maybe it doesn't update the ownerId field")
                }
            } else
                log.warn("The image doesn't have a owner..")

            deleteImageOnOtherServer(image.fullPath)
            image.delete()
            resultCode = 0
        }

        render([result: resultCode] as JSON)
    }

    private void deleteImageOnOtherServer(String imgFullPath) {
        try {
            def slideImgFile = new File(imgFullPath)
            def fullPath = slideImgFile.getParent()
            def fileName = slideImgFile.getName()
            fileName = fileName.substring(0, fileName.lastIndexOf("."))
            def ext = imgFullPath.substring(imgFullPath.lastIndexOf(".") + 1)
            Server.otherServerIps().each { ip ->
                remoteDelete(ip, "${fullPath}${File.separator}${fileName}.${ext}")
                remoteDelete(ip, "${fullPath}${File.separator}${fileName}-mobile.${ext}")
                remoteDelete(ip, "${fullPath}${File.separator}${fileName}-thumb.${ext}")
            }
        } catch (e) {
            log.error("Fail to delete file to other server", e)
        }
    }

    def chgMarkerLocation(){
        log.info("Change marker location, imageId: ${params.imageId}, location: ${params.location}")
        def image = Image.get(params.imageId)

        def imageFileName = image.fileName
        def imageFileNameWithoutExt = imageFileName.substring(0, imageFileName.lastIndexOf('.'))
        def ext = imageFileName.substring(imageFileName.lastIndexOf('.'))
        new File(image.mobilePath).delete()

        def BufferedImage mobileBufferedImage = imageService.compressImage(new FileInputStream(image.fullPath),
                Image.ImageCompressionType.MOBILE_FIXED_WIDTH,
                MarkerLocation.findById(params.location))
        def mobileFileName = imageFileNameWithoutExt + "-" + Image.ImageCompressionType.MOBILE_FIXED_WIDTH.type + ext
        def mobileUploadResult = uploadService.imageUpload(mobileBufferedImage, mobileFileName, CDN_HOST, image.mobilePath)
        log.info("Image in mobile changed marker location result: " + mobileUploadResult)

        def fullPath = new File(image.fullPath).getParent()
        try{
            Server.otherServerIps().each{ip->
                scp(ip, fullPath + File.separator + mobileFileName, fullPath)
            }
        }catch (e){
            log.error("Fail to sync file to other server", e)
        }

        render ErrorCodeUtil.noError()
    }

    def fileManager(){
        def owner = Image.executeQuery("from ${params.ownerClass} where id = ${params.id}")
        def images = owner.images[0]
        def fileList = []
        def currentUrl
        images.each{ image->
            if(!currentUrl) currentUrl=image.host
            def fileName = image.mobileFileName
            def createdDate = new Date(fileName.substring(0, fileName.indexOf('-')) as long)
            fileList << [is_dir:false,has_file:false,filesize:image.size, dir_path:"",
                         is_photo:true, filetype:'jpg', filename:image.mobilePath,
                         datetime:DateFormatUtils.format(createdDate, 'yyyy-MM-dd HH:mm:ss')]
        }
        def ret = [current_url:currentUrl + "/",total_count:images.size(), file_list:fileList]
        render (ret as JSON)
    }
}
