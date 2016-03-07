/*
 * Copyright (c) 2016 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.shop

/**
 * Created by Irene on 2016-02-03.
 */
class Transit {
    Date transitTime
    String description

    ShopProduct product

    BigDecimal receiveQty
    BigDecimal receiveWeight

    BigDecimal productionRate

    Date dateCreated
    Date lastUpdated
}
