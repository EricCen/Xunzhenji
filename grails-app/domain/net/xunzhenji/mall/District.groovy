/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

class District {
    def String name

    static belongsTo = [city:City]

    static constraints = {

    }

    static mapping = {
        version false
    }

    def String toString(){
        name
    }
}
