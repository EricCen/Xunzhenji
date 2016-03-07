/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

/**
 * Created by Irene on 2015/10/29.
 */
class DeliveryRouteUpdate {
    Express express
    String routeId
    String mailNo
    String orderId
    String acceptTime
    String acceptAddress
    String remark
    String opCode

    static belongsTo = [delivery: Delivery]
}
