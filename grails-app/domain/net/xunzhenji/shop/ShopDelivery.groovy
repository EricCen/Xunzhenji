/*
 * Copyright (c) 2016 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.shop

/**
 * Created by Irene on 2016-02-03.
 */
class ShopDelivery {
    Date deliveryTime
    Shop shop
    ShopProduct product
    BigDecimal quantity
    BigDecimal weight

    Date dateCreated
    Date lastUpdated

    static constraints = {
        quantity nullable: true
        weight nullable: true
    }

    String toString(){
        if(deliveryTime){
            return "${deliveryTime?.format("MM-dd")}送出${weight}斤到${shop.name}"
        }else{
            return super.toString()
        }
    }
}
