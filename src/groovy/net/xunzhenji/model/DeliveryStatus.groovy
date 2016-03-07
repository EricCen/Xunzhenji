/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.model


public enum DeliveryStatus {
    INSTORE(0, "未发货"),
    CONFIRM_DELIVER_DATE(5, "已确认发货时间"),
    PROCESSING(10, "发货中"),
    DELIVERING(15, "派件中"),
    ARRIVED_AT_ORGANIZER(20, "已代收"),
    CUSTOMER_GOT_THE_PRODUCT(25, "已领货"),
    DELIVERED(30, "已签收"),
    COMMENTED(40, "已评价")

    def int id
    def String name
    DeliveryStatus(id, name){
        this.id = id
        this.name = name
    }

    public static DeliveryStatus valueOf(int id) {
        DeliveryStatus.values().find { it.id == id }
    }

    public static getSelectOptions() {
        def selectOptions = []
        DeliveryStatus.values().each {
            def selectOption = [id  : it.id,
                                name: it.name]
            selectOptions.add(selectOption)
        }
        selectOptions.add(0, [id: -1,name: "全部状态"])

        return selectOptions
    }

    def static outstandingStatus(){
        [INSTORE, CONFIRM_DELIVER_DATE, PROCESSING, DELIVERING]
    }
}