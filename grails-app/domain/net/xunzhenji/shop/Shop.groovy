package net.xunzhenji.shop

class Shop {
    String name
    String parentName

    Boolean displayForSelect = Boolean.FALSE

    Date lastOrderTime
    Date dateCreated
    Date lastUpdated

    //statistics
    BigDecimal avgQty
    BigDecimal avgQtyOnWeekDay
    BigDecimal avgQtyOnWeekEnd

    static constraints = {
        parentName nullable: true
        lastOrderTime nullable: true
        name(unique: "parentName")

        avgQty nullable: true
        avgQtyOnWeekDay nullable: true
        avgQtyOnWeekEnd nullable: true
    }

    static mapping = {
        lastOrderTime type: "date"
    }

    static hasMany = [products: ShopProduct]

    String toString() {
        "${name}${parentName ? "(" + parentName + ")" : ""}"
    }
}
