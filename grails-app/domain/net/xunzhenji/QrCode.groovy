package net.xunzhenji

import net.xunzhenji.mall.Batch

class QrCode {
    String qrCodeId
    Date dateCreated

    static belongsTo = [qrCodeSetting: QrCodeSetting]

    static constraints = {
    }
}
