/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji

import net.xunzhenji.mall.Batch
import net.xunzhenji.mall.Delivery
import net.xunzhenji.mall.Image
import net.xunzhenji.mall.LxGroupProductOrder
import net.xunzhenji.mall.ProductOrder
import net.xunzhenji.wechat.WeChatFans
import org.apache.commons.lang.builder.HashCodeBuilder

/**
 * Created by Irene on 2015/10/10.
 */
class QrCodeSettingWeChatFans implements Serializable {
    QrCodeSetting qrCodeSetting
    WeChatFans weChatFans

    static mapping = {
        id composite: ['qrCodeSetting', 'weChatFans']
        version false
    }

    boolean equals(other) {
        if (!(other instanceof QrCodeSettingWeChatFans)) {
            return false
        }

        other.qrCodeSetting?.id == qrCodeSetting?.id &&
                other.weChatFans?.id == weChatFans?.id
    }

    int hashCode() {
        def builder = new HashCodeBuilder()
        if (qrCodeSetting) builder.append(qrCodeSetting.id)
        if (weChatFans) builder.append(weChatFans.id)
        builder.toHashCode()
    }
}
