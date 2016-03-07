package net.xunzhenji.mall

/**
 *
 * Created by: Kevin
 * Created time : 2015/6/5 23:43
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */
class Product {
    String title
    String introduction
    String content
    BigDecimal price     //市场价
    BigDecimal deposit  //订金
    int weight = 1500  //净重
    int grossWeight = 3000 //毛重
    String origin
    int extraPeriod
    long quantityInStore = 0      //库存
    long salesVolume = 0           //已售
    long monthSales = 0            //月订单
    BigDecimal weeklyDiscount = 0.01
    Integer homePageWeight = 0
    Express express
    Image banner
    String region
    String remark

    static belongsTo = [category:Category, producer:Producer]

    static hasMany = [images:Image, batchs:Batch, orders: ProductOrder]

    static constraints = {
        express nullable: true
        banner nullable: true
        region nullable: true
        homePageWeight nullable: true
        remark nullable: true
    }

    static mapping = {
        content type: "text"
    }

    @Override
    public String toString(){
        "${title} : ${id}"
    }

    def minPrice(){
        return batchs?.max {it.price}?.price
    }

    def hasBatchsInPresales(){
        batchs?.find{it.isPresales()} != null
    }

    def shortIntroduction(){
        def shortIntro = introduction.replaceAll("<[^>]+>", "")
        if(shortIntro.length() > 50){
            return shortIntro.substring(0, 50) + "..."
        }else{
            return shortIntro
        }
    }
}
