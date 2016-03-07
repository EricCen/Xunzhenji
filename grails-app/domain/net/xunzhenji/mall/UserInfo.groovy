/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

import net.xunzhenji.security.Person
import net.xunzhenji.wechat.WeChatFans

class UserInfo {
    def String name
    def String mobile
    def WeChatFans weChatFans
    def Person person
    def Boolean isOrganizer = Boolean.FALSE
    def Address myDefaultAddress
    def Address groupDefaultAddress
    def Boolean useGroupAddressAsDefault = Boolean.TRUE
    def Date dateCreated

    BigDecimal balance = 0

    def UserInfo() {
        shoppingCart = new ShoppingCart(userInfo: this)
    }

    static belongsTo = LxGroup //我加入了的领鲜群

    static hasMany = [address: Address, orders: ProductOrder, payments:Payment, depositRecords : DepositRecord]

    static hasOne = [shoppingCart: ShoppingCart]

    static constraints = {
        name nullable: true
        mobile nullable: true
        weChatFans nullable: true
        person nullable: true
        address nullable: true
        myDefaultAddress nullable: true
        groupDefaultAddress nullable: true
        balance nullable: true
    }

    static mapping = {
        address lazy: false
        shoppingCart lazy: false

        weChatFans joinTable: [name: 'we_chat_fans',
                           key: 'id', column: 'we_chat_fans_id']
    }

    def createPerson(password) {

        //default to use mobile as username
        this.person = new Person(username: mobile, password: password, enabled: true, accountExpired: false, accountLocked: false, passwordExpired: false)
    }

    def getDefaultAddress() {
        if(useGroupAddressAsDefault){
            return groupDefaultAddress ? groupDefaultAddress : myDefaultAddress
        }else{
            return myDefaultAddress ? myDefaultAddress : groupDefaultAddress
        }
    }

    def getOrdersByDisplayStatus(displayStatus){
        ProductOrder.findAllByUserInfoAndDisplayStatus(this, displayStatus)
    }

    def headImageUrl(){
        return weChatFans?.headImgUrl
    }
    def String toString(){
        return "${name ? name : '未注册'}:${id}"
    }
}
