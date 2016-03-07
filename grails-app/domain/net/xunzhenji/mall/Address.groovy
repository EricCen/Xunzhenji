/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

class Address {
    def String name
    def City city
    def District district
    def String street
    def String address
    def String phone
    def boolean isDefault = false
    def boolean disable = false

    def Double latitude
    def Double longitude

    static belongsTo = [userInfo:UserInfo]

    static constraints = {
        street nullable: true
    }

    static mapping = {
        userInfo joinTable: [name: 'user_info',
                             key: 'user_info_id', column: 'id']
    }


    def String toString(){
        "${city}${district}${street ? street : ""}${address}"
    }

    def String toSimpleAddress(){
        "${street ? street : ""}${address}"
    }

    def String toFullAddress(){
        "${name} ${phone} ${toString()}"
    }
}
