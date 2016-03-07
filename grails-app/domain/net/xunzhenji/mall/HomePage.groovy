package net.xunzhenji.mall
/**
 *
 * Created by: Kevin
 * Created time : 2015/5/7 17:09
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */
class HomePage {
    def String title
    def String content
    static hasMany = [images: net.xunzhenji.mall.Image]

    static mapping = {
        content type: "text"
    }
    static constraints = {
        content nullable: true
    }

}
