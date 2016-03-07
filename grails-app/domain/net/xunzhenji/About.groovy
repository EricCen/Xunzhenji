package net.xunzhenji

import net.xunzhenji.mall.Image

class About {

    String content

    static hasMany = [images: Image]

    static constraints = {
        content nullable: true
    }

    static mapping = {
        content type: "text"
    }
}
