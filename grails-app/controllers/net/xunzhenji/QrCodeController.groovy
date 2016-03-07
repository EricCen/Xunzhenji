package net.xunzhenji

import grails.converters.JSON
import net.glxn.qrgen.QRCode
import net.glxn.qrgen.image.ImageType
import net.xunzhenji.mall.Image

class QrCodeController {

    def index (params) {
        log.info("Receive qrcode request..., ${params}")
        def link = params.link

        ByteArrayOutputStream out = QRCode.from(link).to(ImageType.PNG).stream();

        render file: new ByteArrayInputStream(out.toByteArray()) , contentType: "image/png"
    }
}
