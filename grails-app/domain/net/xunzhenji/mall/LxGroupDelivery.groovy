/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

import org.apache.commons.lang.builder.HashCodeBuilder

/**
 * Created by Irene on 2015/10/9.
 */
class LxGroupDelivery implements Serializable{
    LxGroup lxGroup
    Delivery delivery

    static mapping = {
        id composite: ['lxGroup', 'delivery']
        version false
    }

    boolean equals(other) {
        if (!(other instanceof LxGroupDelivery)) {
            return false
        }

        other.lxGroup?.id == lxGroup?.id &&
                other.delivery?.id == delivery?.id
    }

    int hashCode() {
        def builder = new HashCodeBuilder()
        if (lxGroup) builder.append(lxGroup.id)
        if (delivery) builder.append(delivery.id)
        builder.toHashCode()
    }
}
