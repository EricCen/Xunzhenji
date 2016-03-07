/*
 * Copyright (c) 2016 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.shop

import net.xunzhenji.workflow.MiaoXinProcess

/**
 * Created by Irene on 2016-02-03.
 */
class Procurement {
    Date procurementTime
    ShopProduct product
    BigDecimal quantity
    BigDecimal weight
    BigDecimal price
    Source source

    static hasOne = [workflow: MiaoXinProcess]

    Date dateCreated
    Date lastUpdated

    String toString(){
        if(procurementTime){
            return "${procurementTime?.format("MM-dd")}采购${product.name}${quantity}${product.quantityUnit}"
        }else{
            return super.toString()
        }
    }
}
