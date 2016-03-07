/*
 * Copyright (c) 2016 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.shop

/**
 * Created by Irene on 2016-01-30.
 */
enum ProductUnit {
    Jin("斤"),
    Zhi("只"),
    Piece("件")

    String name

    def ProductUnit(name) {
        this.name = name
    }

    String toString() {
        "${name}"
    }
}