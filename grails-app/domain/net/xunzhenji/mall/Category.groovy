package net.xunzhenji.mall

/**
 *
 * Created by: Kevin
 * Created time : 2015/6/14 21:00
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */
class Category {
    def String name
    def Image logo
    def String introduction
    def String deliverDaysInWeek  //每周发货时间,格式1,2,4,数值和Calendar一致

    static hasMany = [products: Product, specialDays: SpecialDay]

    static constraints = {
        logo nullable: true
    }

    def toDeliverDaysInWeekStr(){
        if(!deliverDaysInWeek) return ""
        def weeks=[
                [index: 2, name: "一"],
                [index: 3, name: "二"],
                [index: 4, name: "三"],
                [index: 5, name: "四"],
                [index: 6, name: "五"],
                [index: 7, name: "六"],
                [index: 1, name: "日"],
        ]
        return "周" + deliverDaysInWeek.split(",").collect{ day->
            weeks.find{it.index == day as int}.name
        }.join(",")

    }

    def toDeliverDaysInWeekArr(){
        deliverDaysInWeek.split(",").collect{it as int}
    }
    def String toString(){
        "${name}:${id}-${toDeliverDaysInWeekStr()}"
    }
}
