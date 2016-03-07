/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

import org.apache.commons.lang.builder.HashCodeBuilder

class ProductOrderPayments implements Serializable {

    private static final long serialVersionUID = 1

    ProductOrder productOrder
    Payment payment

    static mapping = {
        id composite: ['productOrder', 'payment']
        version false
    }

    boolean equals(other) {
        if (!(other instanceof ProductOrderPayments)) {
            return false
        }

        other.productOrder?.id == productOrder?.id &&
                other.payment?.id == payment?.id
    }

    int hashCode() {
        def builder = new HashCodeBuilder()
        if (productOrder) builder.append(productOrder.id)
        if (payment) builder.append(payment.id)
        builder.toHashCode()
    }
}
