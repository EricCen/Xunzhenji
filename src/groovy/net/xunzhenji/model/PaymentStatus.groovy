/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.model

/**
 * Created by Irene on 2015/9/2.
 */
enum PaymentStatus {
    UNPAID(0, "未付订"),
    PAID_FOR_DEPOSIT(10, "已付订"),
    PAID_FOR_FULLPRICE(20, "已付款"),
    PENDING_REFUND(30, "待退款"),
    REFUND_DEPOSIT(40, "已退订"),
    REFUND_FULLPRICE(50, "已退款"),
    UNPAID_CANCELLED(60, "已取消");

    def int id
    def String name

    PaymentStatus(id, name) {
        this.id = id
        this.name = name
    }

    public static PaymentStatus valueOf(int id) {
        PaymentStatus.values().find { it.id == id }
    }

    public static matchAndDo(int id, Closure closure) {
        def paymentStatus = valueOf(id)
        if (paymentStatus) closure.call(paymentStatus)
    }

    public static getSelectOptions() {
        def selectOptions = []
        PaymentStatus.values().each {
            def selectOption = [id  : it.id,
                                name: it.name]
            selectOptions.add(selectOption)
        }
        selectOptions.add(0, [id: -1, name: "全部状态"])

        return selectOptions
    }
}