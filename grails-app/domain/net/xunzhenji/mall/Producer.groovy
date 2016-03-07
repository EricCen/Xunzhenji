package net.xunzhenji.mall

/**
 *
 * Created by: Kevin
 * Created time : 2015/6/16 11:51
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */
class Producer {
    def String name
    def String introduction
    def String address
    def double latitude
    def double longitude
    def String phone
    def Image head

    static hasMany = [images:Image, products:Product]

    static constraints = {
        phone nullable: true
        head nullable: true
    }
}
