/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

import org.apache.commons.lang.builder.HashCodeBuilder

/**
 * Created by Irene on 2015/12/10.
 */
class ShoppingCartProductOrder implements Serializable {
    private static final long serialVersionUID = 1

    ShoppingCart shoppingCart
    ProductOrder productOrder

    static mapping = {
        id composite: ['shoppingCart', 'productOrder']
        version false
    }

    boolean equals(other) {
        if (!(other instanceof ShoppingCartProductOrder)) {
            return false
        }

        other.shoppingCart?.id == shoppingCart?.id &&
                other.productOrder?.id == productOrder?.id
    }

    int hashCode() {
        def builder = new HashCodeBuilder()
        if (shoppingCart) builder.append(shoppingCart.id)
        if (productOrder) builder.append(productOrder.id)
        builder.toHashCode()
    }
}
