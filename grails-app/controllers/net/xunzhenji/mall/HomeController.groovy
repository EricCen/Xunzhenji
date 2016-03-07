package net.xunzhenji.mall

import grails.converters.JSON

class HomeController {
    def uploadService
    def HomePage homePage = HomePage.first()

    def index() {
        def products = Product.withCriteria {
            gt('homePageWeight', 0)
            order('homePageWeight', 'desc')
            maxResults(5)
        }
        [homePage: homePage, products:products]
    }

    def edit(){
        homePage.properties = params
        [homePage:homePage]
    }

    def save(params){
        homePage = homePage.refresh()

        if(params['image.id']){
            def ids
            if(params['image.id'] instanceof String[]){
                ids = params['image.id'].collect {it as Long}
            }else{
                ids = [params['image.id'] as Long]
            }

            def images = Image.findAllByIdInList(ids)
            homePage.images = images
        }

        homePage.properties = params
        homePage.save(flush:true)
        homePage.images.each{it.ownerClass = homePage.class.getName(); it.ownerId = homePage.id; it.save()}
        redirect(controller: "home", action: "edit")
    }
}
