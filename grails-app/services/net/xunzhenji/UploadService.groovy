package net.xunzhenji

import org.springframework.web.multipart.commons.CommonsMultipartFile
import net.xunzhenji.util.SessionUtil

import javax.imageio.ImageIO
import java.awt.image.BufferedImage
import java.text.SimpleDateFormat

/**
 *
 * Created by: Kevin
 * Created time : 2015/5/8 22:39
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */
class UploadService {
    static String IMAGE_UPLOAD_PATH = "/opt/upload/"
    static String IMAGE_URL_PATH = "/"
    static String IMAGE_DELETE_URL_PATH = "/upload/delete/"

    def fileDelete(path) {
        log.info("Delete file at ${path}")
        if (path.exists()) {
            path.delete()
            return 0
        } else {
            return -1
        }
    }

    def fileUpload(type, file, host, cdn) {
        def CommonsMultipartFile files = file

        def uploadName = "", url = "", fileName = "", size = -1, deleteUrl = "", path
        def File filePath
        def File toUploadFile

        if (files != null && !files.isEmpty()) {
            uploadName = files.getOriginalFilename();
            String ext = uploadName.substring(uploadName.lastIndexOf('.'))
            fileName = System.currentTimeMillis() + "-" + Math.random() + ext
            def timePrefix = new SimpleDateFormat("yyyy/MM/").format(new Date())
            path = "${type}/${timePrefix + fileName}"
            url = cdn + IMAGE_URL_PATH + path
            deleteUrl = host + IMAGE_DELETE_URL_PATH + path

            filePath = new File(IMAGE_UPLOAD_PATH + File.separator + type + File.separator + timePrefix)

            if (!filePath.exists()) filePath.mkdirs()
            toUploadFile = new File(filePath.absolutePath + File.separator + fileName)
            def fos = new FileOutputStream(toUploadFile)
            DataOutputStream out = new DataOutputStream(fos);
            InputStream is = null;
            try {
                is = files.getInputStream();
                byte[] b = new byte[is.available()];
                is.read(b);
                out.write(b);

                size = fos.getChannel().position()
            } catch (IOException exception) {
                exception.printStackTrace();
                return [error: "上传失败"]
            } finally {
                if (is != null) {
                    is.close();
                }
                if (out != null) {
                    out.close();
                }
            }
        } else {
            return [error: "上传失败"]
        }
        [url       : url,
         uploadName: uploadName,
         fileName  : fileName,
         path      : path,
         fullPath  : toUploadFile.absolutePath,
         size      : size,
         deleteUrl : deleteUrl]
    }

    def imageUpload(BufferedImage bufferedImage, imageFileName, host) {
        def timePrefix = new SimpleDateFormat("yyyy/MM/").format(new Date())
        def type = "image"
        def path = "${type}/${timePrefix + imageFileName}"
        imageUpload(bufferedImage, imageFileName, host, path)
    }
    def imageUpload(BufferedImage bufferedImage, imageFileName, host, path) {
        def toUploadFile = new File(IMAGE_UPLOAD_PATH + File.separator + path)
        try {
            ImageIO.write(bufferedImage, "jpg", toUploadFile)
        } catch (IOException exception) {
            exception.printStackTrace();
            return [error: "上传失败"]
        }

        def url = host + IMAGE_URL_PATH + path
        [url: url, path: path]
    }
}
