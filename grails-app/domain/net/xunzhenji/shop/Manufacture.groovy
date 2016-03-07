/*
 * Copyright (c) 2016 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.shop

import net.xunzhenji.workflow.MiaoXinProcess

/**
 * Created by Irene on 2016-02-03.
 */
class Manufacture {
    Date manufactureTime

    ShopProduct inputProduct
    ShopProduct outputProduct

    BigDecimal inputQuantity
    BigDecimal outputQuantity
    BigDecimal inputWeight
    BigDecimal outputWeight

    BigDecimal productionRate
    MiaoXinProcess workflow

    Date dateCreated
    Date lastUpdated

    static constraints = {
        workflow nullable: true
        inputWeight nullable: true

        productionRate nullable: true
    }

    String toString(){
        if(manufactureTime){
            return "${manufactureTime.format("MM-dd")}生产${outputProduct.name}${outputWeight}${outputProduct.weightUnit}"
        }else{
            return super.toString()
        }
    }
}
