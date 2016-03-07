package net.xunzhenji.datacollect

import net.xunzhenji.util.FormatUtil
import net.xunzhenji.wechat.WeChatFans

/**
 *
 * Created by: Kevin
 * Created time : 2015/5/7 16:15
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */
class FansLocation {
    def String openId
    def Date createTime
    def double latitude
    def double longitude
    def double locationPrecision
    def String address
    def String formattedAddress
    def String rough
    def String city
    def String district
    def String nation
    def String province
    def String street
    def String streetNumber


    static belongsTo = [weChatFans:WeChatFans]

    static constraints = {
        openId size: 0..40
        address nullable: true
        formattedAddress nullable: true
        rough nullable: true
        city nullable: true
        district nullable: true
        nation nullable: true
        province nullable: true
        street nullable: true
        streetNumber nullable: true
    }

    static mapping = {
    }

    String toString() {
        "${address}@${FormatUtil.formatDatetime(createTime)}"
    }

}
