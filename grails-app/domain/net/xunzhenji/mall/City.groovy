/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

class City {
    def String province
    def String name

    static hasMany = [districts:District]

    static constraints = {

    }

    static mapping = {
        version false
    }

    def String toString(){
        "${province}${name}"
    }
}
