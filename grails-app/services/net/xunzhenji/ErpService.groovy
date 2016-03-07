/*
 * Copyright (c) 2016 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji

/**
 * Created by Irene on 2016-01-22.
 */
class ErpService {
    def odooService

    def createSaleOrder(partnerId, priceListId, userId, dateOrder, saleOrderLines) {
        def saleOrderId = odooService.createRecord("sale.order", [partner_id         : partnerId,
                                                                  pricelist_id       : priceListId,
                                                                  create_uid         : userId,
                                                                  partner_invoice_id : partnerId,
                                                                  user_id            : userId,
                                                                  partner_shipping_id: partnerId,
                                                                  date_order         : dateOrder,
                                                                  create_date        : dateOrder,
                                                                  write_date         : dateOrder
        ])

        saleOrderLines.each { orderLine ->
            odooService.createRecord("sale.order.line", [name           : orderLine.name,
                                                         order_id       : saleOrderId,
                                                         product_uom    : orderLine.productUom,
                                                         product_uom_qty: orderLine.productUosQty,
                                                         product_uos    : orderLine.productUos,
                                                         product_uos_qty: orderLine.productUosQty,
                                                         price_unit     : orderLine.priceUnit,
                                                         price_subtotal : (orderLine.priceUnit as float) * (orderLine.productUos as float),
                                                         product_id     : orderLine.productId,
                                                         delay          : orderLine.delay
            ])
        }

//        saleOrderLines.each { orderLine ->
//            createSaleOrderLine(saleOrderId, orderLine)
//        }
    }

    def createSaleOrderLine(saleOrderId, params) {
        odooService.createRecord("sale.order.line", [name           : params.name,
                                                     order_id       : saleOrderId,
                                                     product_uom    : params.productUom,
                                                     product_uom_qty: params.productUomQty,
                                                     product_uos_qty: 6,
                                                     product_uos    : params.productUos,
                                                     price_unit     : params.priceUnit,
                                                     price_subtotal : (params.priceUnit as float) * (params.productUos as float),
                                                     product_id     : params.productId,
                                                     delay          : params.delay
        ])
    }

    def listPartners() {
        odooService.authenticate()
        def partnerIds = odooService.listRecord("res.partner", [["is_company", "=", true]])

        return odooService.readRecord("res.partner", partnerIds)
    }

    def listPartnersWithCriteria(criteria) {
        odooService.authenticate()
        def partnerIds = odooService.listRecord("res.partner", criteria)

        return odooService.readRecord("res.partner", partnerIds)
    }
}
