/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

import grails.converters.JSON
import grails.transaction.Transactional
import net.xunzhenji.util.ErrorCodeUtil
import net.xunzhenji.util.ObjectUtils
import org.apache.commons.lang.time.DateFormatUtils

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class ProductController {
    def uploadService
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        params.order = "desc"
        respond Product.listOrderByHomePageWeight(params), model:[productInstanceCount: Product.count()]
    }

    def wap_show(Product productInstance) {
        respond productInstance
    }

    def show(Product productInstance) {
        respond productInstance
    }

    def create() {
        respond new Product(params)
    }

    @Transactional
    def save(Product productInstance) {
        if (productInstance == null) {
            notFound()
            return
        }

        ObjectUtils.updateImage(productInstance, params['image.id'])
        productInstance.content = productInstance.content?.replace("src=","data-original=")
        productInstance.weeklyDiscount = (params.weeklyDiscount as BigDecimal) / 100
        productInstance.save flush:true
        productInstance.images?.each{
            it.ownerClass = productInstance.class.getName()
            it.ownerId = productInstance.id;
            it.order = params["image_order_${it.id}"] ? params["image_order_${it.id}"] as int : 0
            it.save()
        }
        productInstance.banner?.ownerId = productInstance.id
        productInstance.banner?.ownerField = "banner"
        productInstance.banner?.save()

        if (productInstance.hasErrors()) {
            respond productInstance.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'product.label', default: 'Product'), productInstance.id])
                redirect productInstance
            }
            '*' { respond productInstance, [status: CREATED] }
        }
    }

    def edit(Product productInstance) {
        productInstance.content = productInstance.content.replace("data-original=","src=")
        respond productInstance
    }

    @Transactional
    def update(Product productInstance) {
        if (productInstance == null) {
            notFound()
            return
        }

        ObjectUtils.updateImage(productInstance, params['image.id'])
        productInstance.content = productInstance.content.replace("src=","data-original=")
        productInstance.weeklyDiscount = (params.weeklyDiscount as BigDecimal) / 100
        productInstance.save flush:true
        productInstance.images?.each{
            it.ownerClass = productInstance.class.getName()
            it.ownerId = productInstance.id;
            it.order = params["image_order_${it.id}"] ? params["image_order_${it.id}"] as int : 0
            it.save()
        }
        productInstance.banner?.ownerId = productInstance.id
        productInstance.banner?.ownerField = "banner"
        productInstance.banner?.save()

        if (productInstance.hasErrors()) {
            respond productInstance.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'product.label', default: 'Product'), productInstance.id])
                redirect productInstance
            }
            '*'{ respond productInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Product productInstance) {

        if (productInstance == null) {
            notFound()
            return
        }

        productInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'product.label', default: 'Product'), productInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'product.label', default: 'Product'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }


    def fileManager(){
        def product = Product.get(params.id)
        def images = product.images
        def fileList = []
        def currentUrl
        images.each{ image->
            if(!currentUrl) currentUrl=image.host
            def fileName = image.mobileFileName
            def createdDate = new Date(fileName.substring(0, fileName.indexOf('-')) as long)
            fileList << [is_dir:false,has_file:false,filesize:image.size, dir_path:"",
            is_photo:true, filetype:'jpg', filename:image.mobilePath,
                         datetime:DateFormatUtils.format(createdDate, 'yyyy-MM-dd HH:mm:ss')]
        }
        def ret = [current_url:currentUrl + "/",total_count:images.size(), file_list:fileList]
        render (ret as JSON)
    }

    @Transactional
    def updateHomePageWeight(){
        log.info("Update home page weight, id: ${params.id}, weight: ${params.homePageWeight}")
        def product = Product.get(params.id)
        if(product){
            product.homePageWeight = params.homePageWeight as int
        }
        redirect(action: "index")
    }
}
