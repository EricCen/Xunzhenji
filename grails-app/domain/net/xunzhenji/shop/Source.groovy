/*
 * Copyright (c) 2016 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.shop
/**
 * Created by Irene on 2016-02-04.
 */
class Source {
    String name
    String phone
    String address
    String remark

    static constraints = {
        phone nullable: true
        remark nullable: true
    }

    String toString(){
        "${name}"
    }
}
