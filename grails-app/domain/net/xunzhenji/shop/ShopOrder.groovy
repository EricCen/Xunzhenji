package net.xunzhenji.shop

class ShopOrder {
    Quote quote
    BigDecimal quantity

    DeliveryMan deliveryMan
    ShopOrderStatus shopOrderStatus

    static constraints = {
    }
}
