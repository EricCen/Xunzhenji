/*
 * Copyright (c) 2016 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.shop

import net.xunzhenji.wechat.WeChatFans
import org.apache.commons.lang.builder.HashCodeBuilder

class ShopFans implements Serializable {

    private static final long serialVersionUID = 1

    Shop shop
    WeChatFans fans

    boolean equals(other) {
        if (!(other instanceof ShopFans)) {
            return false
        }

        other.shop?.id == shop?.id &&
                other.fans?.id == fans?.id
    }

    int hashCode() {
        def builder = new HashCodeBuilder()
        if (shop) builder.append(shop.id)
        if (fans) builder.append(fans.id)
        builder.toHashCode()
    }
}
