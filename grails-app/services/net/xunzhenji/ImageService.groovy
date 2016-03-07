/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji

import net.xunzhenji.mall.Image
import net.xunzhenji.mall.Image.ImageCompressionType
import net.xunzhenji.model.Constant
import net.xunzhenji.model.MarkerLocation
import org.springframework.core.io.ByteArrayResource
import org.springframework.web.context.support.ServletContextResource
import org.springframework.web.multipart.commons.CommonsMultipartFile
import sun.awt.image.ToolkitImage

import javax.imageio.ImageIO
import javax.swing.ImageIcon
import java.awt.AlphaComposite
import java.awt.Graphics2D
import java.awt.RenderingHints
import java.awt.image.BufferedImage
import org.springframework.core.io.Resource

/**
 * Created by jackeyjian on 15/8/24.
 */
class ImageService {
    def assetResourceLocator

    def BufferedImage compressImage(InputStream inputStream, ImageCompressionType imageCompressionType, MarkerLocation markerLocation) {
        BufferedImage compressedBufferedImage
        try {
            BufferedImage originalBufferedImage = ImageIO.read(inputStream);

            int scaledWidth
            int scaledHeight
            if (imageCompressionType.scaleType == Image.ScaleType.FIXED_WIDTH) {
                scaledWidth = imageCompressionType.scaledWidth
                scaledHeight = originalBufferedImage.getHeight() * imageCompressionType.scaledWidth / originalBufferedImage.getWidth()
            } else if (imageCompressionType.scaleType == Image.ScaleType.FIXED_HEIGHT) {
                scaledWidth = originalBufferedImage.getWidth() * imageCompressionType.scaledHeight / originalBufferedImage.getHeight()
                scaledHeight = imageCompressionType.scaledHeight
            } else if (imageCompressionType.scaleType == Image.ScaleType.FIXED_SIZE) {
                scaledWidth = imageCompressionType.scaledWidth
                scaledHeight = imageCompressionType.scaledHeight
            } else {
                scaledWidth = originalBufferedImage.getWidth()
                scaledHeight = originalBufferedImage.getHeight()
            }

            java.awt.Image scaledImage = originalBufferedImage.getScaledInstance(scaledWidth, scaledHeight, BufferedImage.SCALE_DEFAULT);
            compressedBufferedImage = new BufferedImage(scaledWidth, scaledHeight, BufferedImage.TYPE_INT_BGR);
            Graphics2D g = compressedBufferedImage.getGraphics()
            g.drawImage(scaledImage, 0, 0, null);

            g.setRenderingHint(RenderingHints.KEY_INTERPOLATION,
                    RenderingHints.VALUE_INTERPOLATION_BILINEAR);

            if(MarkerLocation.None != markerLocation){
                addMarker(g, scaledWidth, scaledHeight, markerLocation)
            }

            g.dispose();
        } catch (IOException exception) {
            log.warn("Failed to compress image: " + imageFile.getOriginalFilename())
            exception.printStackTrace();
        } finally {
            if (inputStream != null) {
                inputStream.close();
            }
        }
        return compressedBufferedImage
    }

    private void addMarker(Graphics2D g, int imageWidth, int imageHeight, MarkerLocation markerLocation) {
        // 水印图象的路径 水印一般为gif或者png的，这样可设置透明度
        Resource makerResource = assetResourceLocator.findResourceForURI('marker.png')
        ImageIcon imgIcon
        if(makerResource instanceof ServletContextResource){
            imgIcon = new ImageIcon(Constant.ASSETS_PATH + makerResource.path)
            log.info("Resource location: ${Constant.ASSETS_PATH + makerResource.path}")
        }else if(makerResource instanceof ByteArrayResource) {
            imgIcon = new ImageIcon(makerResource.byteArray)
        }else{
            log.error("Cannot access the resource, skip adding marker")
            return
        }

        // 得到Image对象。
        ToolkitImage img = imgIcon.getImage();
        def x = imageWidth - imgIcon.getIconWidth()
        def y = imageHeight - imgIcon.getIconHeight()
        if(MarkerLocation.BottomRight.equals(markerLocation)){
            x = imageWidth - imgIcon.getIconWidth()
            y = imageHeight - imgIcon.getIconHeight()
        }else if(MarkerLocation.BottomLeft.equals(markerLocation)) {
            x = 0
            y = imageHeight - imgIcon.getIconHeight()
        }else if(MarkerLocation.TopLeft.equals(markerLocation)) {
            x = 0
            y = 0
        }else if(MarkerLocation.TopRight.equals(markerLocation)){
            x = imageWidth - imgIcon.getIconWidth()
            y = 0
        }
        g.drawImage(img, x, y, null);
    }
}
