/*
 * Copyright (c) 2016 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.workflow

import net.xunzhenji.shop.ShopProduct
import net.xunzhenji.shop.Warehouse

/**
 * The configuration of the workflow
 * Created by Irene on 2016-02-13.
 */
class MiaoXinWorkflow {
    String name
    Warehouse manufactureWarehouse
    Warehouse deliveryWarehouse

    ShopProduct manufactureProduct
    ShopProduct deliveryProduct

    def manufactureWarehouseInputQuantity() {
        manufactureWarehouse.getQuantityByProduct(manufactureProduct)
    }

    def manufactureWarehouseInputWeight() {
        manufactureWarehouse.getWeightByProduct(manufactureProduct)
    }

    def deliveryWarehouseQuantity() {
        deliveryWarehouse.getQuantityByProduct(deliveryProduct)
    }

    def deliveryWarehouseWeight() {
        deliveryWarehouse.getWeightByProduct(deliveryProduct)
    }

    def currentManufactureWarehouseQuantity(){
        manufactureWarehouse.getQuantityByProduct(manufactureProduct)
    }

    def currentDeliveryWarehouseWeight(){
        deliveryWarehouse.getWeightByProduct(deliveryProduct)
    }

    String toString(){
        "${name}"
    }
}
