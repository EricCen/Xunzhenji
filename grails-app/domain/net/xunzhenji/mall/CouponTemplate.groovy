package net.xunzhenji.mall

class CouponTemplate {
    def Product product
    def String title
    def String content
    def String bubbleContent
    def BigDecimal amount

    static constraints = {
    }

    static mapping = {
        content type: "text"
    }
}
