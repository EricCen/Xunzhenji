/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.delivery

import net.xunzhenji.mall.Delivery
import net.xunzhenji.mall.LxGroupProductOrder
import org.apache.commons.lang.builder.HashCodeBuilder

/**
 * Created by Irene on 2015/12/5.
 */
class DeliveryRouteInfo implements Serializable {
    Delivery delivery
    RouteInfo routeInfo


    boolean equals(other) {
        if (!(other instanceof DeliveryRouteInfo)) {
            return false
        }

        other.delivery?.id == delivery?.id &&
                other.routeInfo?.id == routeInfo?.id
    }

    int hashCode() {
        def builder = new HashCodeBuilder()
        if (delivery) builder.append(delivery.id)
        if (routeInfo) builder.append(routeInfo.id)
        builder.toHashCode()
    }
}
