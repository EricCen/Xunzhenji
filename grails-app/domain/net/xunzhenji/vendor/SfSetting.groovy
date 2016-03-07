/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.vendor

/**
 * Created by Irene on 2015/10/26.
 */
class SfSetting {
    def String serverAddress
    def String clientCode
    def String checkword
    def String expressType
    def String fromCompany
    def String fromContact
    def String fromTel
    def String fromAddress
    def String payMethod
    def String custId
    def String shipperCode
    def String addedServiceCode

    def static constraints = {
        addedServiceCode nullable: true
    }

    def host(){
        serverAddress.substring(0, serverAddress.indexOf("/", 10) + 1)
    }

    def path(){
        serverAddress.substring(serverAddress.indexOf("/", 10))
    }
}
