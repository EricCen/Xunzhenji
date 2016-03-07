/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.promotion

/**
 * Created by Irene on 2015/12/2.
 */
class Link {
    String title
    String url
    String tinyCode

    static belongsTo = [RandomLink]

    static constraints = {
        title nullable: true
    }

    public String toString(){
        "${title}-${url}"
    }
}
