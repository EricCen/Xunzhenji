/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.promotion

import net.xunzhenji.mall.Product

/**
 * Created by Irene on 2015/12/2.
 */
class RandomLink {

    String linkCode

    static hasMany = [links : Link]
}
