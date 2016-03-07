/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

import org.apache.commons.lang.builder.HashCodeBuilder

class LxGroupProductOrder implements Serializable{
    LxGroup lxGroup                 //many
    ProductOrder productOrder       //one

    static mapping = {
        id composite: ['lxGroup', 'productOrder']
        version false
    }

    boolean equals(other) {
        if (!(other instanceof LxGroupProductOrder)) {
            return false
        }

        other.productOrder?.id == productOrder?.id &&
                other.lxGroup?.id == lxGroup?.id
    }

    int hashCode() {
        def builder = new HashCodeBuilder()
        if (productOrder) builder.append(productOrder.id)
        if (lxGroup) builder.append(lxGroup.id)
        builder.toHashCode()
    }

    def static getLxGroupByOrder(order){
        LxGroupProductOrder.findByProductOrder(order)?.lxGroup
    }
}
