/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji

import net.xunzhenji.mall.Batch
import net.xunzhenji.mall.Image
import net.xunzhenji.wechat.WeChatFans

/**
 * Created by Irene on 2015/10/10.
 */
class QrCodeSetting {
    Batch batch
    String variable
    String title
    String content

    static hasMany = [qrCodes: QrCode, images: Image]

    static constraints = {
        variable nullable: true
        content nullable: true
    }

    static mapping = {
        content type: "text"
    }
}
