/*
 * Copyright (c) 2016 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.shop

/**
 * Created by Irene on 2016-01-30.
 */
enum ShopOrderStatus {
    Submitted(0, "已提交"),
    Confirmed(10, "已确认"),
    Delivered(30, "已交货"),
    ConfirmReceived(40, "已签收"),
    Paid(50, "已付款")

    long id
    String name

    def ShopOrderStatus(id, name) {
        this.id = id
        this.name = name
    }
}
