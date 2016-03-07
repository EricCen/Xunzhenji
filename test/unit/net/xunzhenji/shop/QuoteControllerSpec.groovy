package net.xunzhenji.shop

import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import spock.lang.Specification

@TestFor(QuoteController)
@Mock(Quote)
class QuoteControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'

        def shop = new Shop(name: "里仁洞店")
        def shopProduct = new ShopProduct(name: "灵山鸡")
        params["shop.id"] = 1
        params['shopProduct.id'] = 1
        params['productUnit'] = ProductUnit.Jin
        params['price'] = 15
        params['quantity'] = 120
    }

    void "Test the index action returns the correct model"() {

        when: "The index action is executed"
        controller.index()

        then: "The model is correct"
        !model.quoteInstanceList
        model.quoteInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when: "The create action is executed"
        controller.create()

        then: "The model is correctly created"
        model.quoteInstance != null
    }

    void "Test the save action correctly persists an instance"() {

        when: "The save action is executed with an invalid instance"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'POST'
        def quote = new Quote()
        quote.validate()
        controller.save(quote)

        then: "The create view is rendered again with the correct model"
        model.quoteInstance != null
        view == 'create'

        when: "The save action is executed with a valid instance"
        response.reset()
        populateValidParams(params)
        quote = new Quote(params)

        controller.save(quote)

        then: "A redirect is issued to the show action"
        response.redirectedUrl == '/quote/show/1'
        controller.flash.message != null
        Quote.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when: "The show action is executed with a null domain"
        controller.show(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the show action"
        populateValidParams(params)
        def quote = new Quote(params)
        controller.show(quote)

        then: "A model is populated containing the domain instance"
        model.quoteInstance == quote
    }

    void "Test that the edit action returns the correct model"() {
        when: "The edit action is executed with a null domain"
        controller.edit(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the edit action"
        populateValidParams(params)
        def quote = new Quote(params)
        controller.edit(quote)

        then: "A model is populated containing the domain instance"
        model.quoteInstance == quote
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when: "Update is called for a domain instance that doesn't exist"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'PUT'
        controller.update(null)

        then: "A 404 error is returned"
        response.redirectedUrl == '/quote/index'
        flash.message != null


        when: "An invalid domain instance is passed to the update action"
        response.reset()
        def quote = new Quote()
        quote.validate()
        controller.update(quote)

        then: "The edit view is rendered again with the invalid instance"
        view == 'edit'
        model.quoteInstance == quote

        when: "A valid domain instance is passed to the update action"
        response.reset()
        populateValidParams(params)
        quote = new Quote(params).save(flush: true)
        controller.update(quote)

        then: "A redirect is issues to the show action"
        response.redirectedUrl == "/quote/show/$quote.id"
        flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when: "The delete action is called for a null instance"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'DELETE'
        controller.delete(null)

        then: "A 404 is returned"
        response.redirectedUrl == '/quote/index'
        flash.message != null

        when: "A domain instance is created"
        response.reset()
        populateValidParams(params)
        def quote = new Quote(params).save(flush: true)

        then: "It exists"
        Quote.count() == 1

        when: "The domain instance is passed to the delete action"
        controller.delete(quote)

        then: "The instance is deleted"
        Quote.count() == 0
        response.redirectedUrl == '/quote/index'
        flash.message != null
    }
}
