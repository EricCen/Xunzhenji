/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

import net.xunzhenji.model.DeliveryStatus
import org.apache.commons.lang.builder.HashCodeBuilder

class DeliveryProductOrders implements Serializable {

    Delivery delivery
    ProductOrder productOrder


    static mapping = {
        id composite: ['delivery', 'productOrder']
        version false
    }

    boolean equals(other) {
        if (!(other instanceof LxGroupProductOrder)) {
            return false
        }

        other.productOrder?.id == productOrder?.id &&
                other.delivery?.id == delivery?.id
    }

    int hashCode() {
        def builder = new HashCodeBuilder()
        if (productOrder) builder.append(productOrder.id)
        if (delivery) builder.append(delivery.id)
        builder.toHashCode()
    }

    def static Delivery getDeliveryByOrder(ProductOrder order){
        DeliveryProductOrders.findByProductOrder(order)?.delivery
    }

}