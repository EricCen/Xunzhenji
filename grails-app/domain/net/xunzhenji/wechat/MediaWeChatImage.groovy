/*
 * Copyright (c) 2016 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.wechat

import org.apache.commons.lang.builder.HashCodeBuilder

/**
 * Created by Irene on 2016-01-06.
 */
class MediaWeChatImage implements Serializable {
    def Media media
    def WeChatImage weChatImage

    boolean equals(other) {
        if (!(other instanceof MediaWeChatImage)) {
            return false
        }

        other.media?.id == media?.id &&
                other.weChatImage?.id == weChatImage?.id
    }

    int hashCode() {
        def builder = new HashCodeBuilder()
        if (media) builder.append(media.id)
        if (weChatImage) builder.append(weChatImage.id)
        builder.toHashCode()
    }
}
