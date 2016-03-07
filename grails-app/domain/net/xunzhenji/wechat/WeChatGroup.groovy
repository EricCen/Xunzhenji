package net.xunzhenji.wechat
// Î¢ÐÅ·Ö×é

class WeChatGroup {
    def String wechatGroupId
    def String name
    def String description
    def int fansCount = 0

    static hasMany = [weChatFans:WeChatFans]
    static belongsTo = [weChatContext:WeChatContext]

    static constraints = {
        wechatGroupId nullable: true, unique: true
        description nullable: true
    }

    String toString() {
        name
    }
}
