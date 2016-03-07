/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall


class PickupTime {

    def int dayOfWeek; // same as Calendar.java concept
//    def String startTime; // hh:mm
//    def String endTime; // hh:mm

    static belongsTo = LxGroup

    static daysMapping = [
            [index: Calendar.MONDAY, name: "一"],
            [index: Calendar.TUESDAY, name: "二"],
            [index: Calendar.WEDNESDAY, name: "三"],
            [index: Calendar.THURSDAY, name: "四"],
            [index: Calendar.FRIDAY, name: "五"],
            [index: Calendar.SATURDAY, name: "六"],
            [index: Calendar.SUNDAY, name: "日"]
    ]

    def toDayStr(){
        daysMapping.find{it.index == dayOfWeek}.name
    }
}
