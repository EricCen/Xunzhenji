/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.model

/**
 * Created by Irene on 2015/9/19.
 */
enum MarkerLocation {
    TopLeft("topleft", "左上"),
    TopRight("topright", "右下"),
    BottomLeft("bottomleft", "左上"),
    BottomRight("bottomright", "右下"),
    None("none","不添加")

    String id
    String name
    MarkerLocation(String id, String name){
        this.id = id
        this.name = name
    }

    static MarkerLocation findById(id){
        values().find{it.id == id}
    }
}