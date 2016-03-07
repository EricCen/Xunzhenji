/*
 * Copyright (c) 2016 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.shop

import net.xunzhenji.wechat.WeChatFans

/**
 * Created by Irene on 2016-02-03.
 */
class StockMove {
    enum MoveDirection {
        In, Out, Reset
    }

    enum Status {
        Created, Received
    }

    ShopProduct product
    MoveDirection direction
    Warehouse warehouse
    BigDecimal quantity
    BigDecimal weight

    WeChatFans creator
    WeChatFans receiver

    Date dateCreated
    Date lastUpdated

    static constraints = {
        weight nullable: true
        creator nullable: true
        receiver nullable: true
    }

    String toString(){
        if(dateCreated){
            return "${product}${direction}${warehouse}${quantity}${product?.quantityUnit}${weight}${product?.weightUnit}@${dateCreated?.format("MM-dd HH:mm")}"
        }else{
            return super.toString()
        }

    }
}
