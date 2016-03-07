package net.xunzhenji.mall

import grails.converters.JSON

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CategoryController {
    def uploadService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Category.list(params), model:[categoryInstanceCount: Category.count()]
    }

    def show(Category categoryInstance) {
        respond categoryInstance
    }

    def create() {
        respond new Category(params)
    }

    @Transactional
    def save(Category categoryInstance) {
        if (categoryInstance == null) {
            notFound()
            return
        }

        def deliverDaysInWeek = []
        (1..7).each{
            if(params["deliverDaysInWeek_"+it]){
                deliverDaysInWeek << it
            }
        }
        categoryInstance.deliverDaysInWeek = deliverDaysInWeek.join(",")
        categoryInstance.validate()
        if (categoryInstance.hasErrors()) {
            respond categoryInstance.errors, view:'create'
            return
        }

        categoryInstance.save flush:true

        if(categoryInstance.logo){
            categoryInstance.logo.ownerClass = categoryInstance.class.getName()
            categoryInstance.logo.ownerField = "logo"
            categoryInstance.logo.ownerId = categoryInstance.id
            categoryInstance.logo.save()
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'category.label', default: 'Category'), categoryInstance.id])
                redirect categoryInstance
            }
            '*' { respond categoryInstance, [status: CREATED] }
        }
    }

    def edit(Category categoryInstance) {
        respond categoryInstance
    }

    @Transactional
    def update(Category categoryInstance) {
        println params
        if (categoryInstance == null) {
            notFound()
            return
        }
        def deliverDaysInWeek = []
        (1..7).each{
            if(params["deliverDaysInWeek_"+it]){
                deliverDaysInWeek << it
            }
        }
        categoryInstance.deliverDaysInWeek = deliverDaysInWeek.join(",")

        if(categoryInstance.logo){
            categoryInstance.logo.ownerClass = categoryInstance.class.getName()
            categoryInstance.logo.ownerField = "logo"
            categoryInstance.logo.ownerId = categoryInstance.id
            categoryInstance.logo.save()
        }

        if (categoryInstance.hasErrors()) {
            respond categoryInstance.errors, view:'edit'
            return
        }

        categoryInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'category.label', default: 'Category'), categoryInstance.id])
                redirect categoryInstance
            }
            '*'{ respond categoryInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Category categoryInstance) {

        if (categoryInstance == null) {
            notFound()
            return
        }

        categoryInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'category.label', default: 'Category'), categoryInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'category.label', default: 'Category'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
