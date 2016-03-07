package net.xunzhenji.shop

import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import spock.lang.Specification

@TestFor(StockItemController)
@Mock(StockItem)
class StockItemControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when: "The index action is executed"
        controller.index()

        then: "The model is correct"
        !model.stockItemInstanceList
        model.stockItemInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when: "The create action is executed"
        controller.create()

        then: "The model is correctly created"
        model.stockItemInstance != null
    }

    void "Test the save action correctly persists an instance"() {

        when: "The save action is executed with an invalid instance"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'POST'
        def stockItem = new StockItem()
        stockItem.validate()
        controller.save(stockItem)

        then: "The create view is rendered again with the correct model"
        model.stockItemInstance != null
        view == 'create'

        when: "The save action is executed with a valid instance"
        response.reset()
        populateValidParams(params)
        stockItem = new StockItem(params)

        controller.save(stockItem)

        then: "A redirect is issued to the show action"
        response.redirectedUrl == '/stockItem/show/1'
        controller.flash.message != null
        StockItem.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when: "The show action is executed with a null domain"
        controller.show(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the show action"
        populateValidParams(params)
        def stockItem = new StockItem(params)
        controller.show(stockItem)

        then: "A model is populated containing the domain instance"
        model.stockItemInstance == stockItem
    }

    void "Test that the edit action returns the correct model"() {
        when: "The edit action is executed with a null domain"
        controller.edit(null)

        then: "A 404 error is returned"
        response.status == 404

        when: "A domain instance is passed to the edit action"
        populateValidParams(params)
        def stockItem = new StockItem(params)
        controller.edit(stockItem)

        then: "A model is populated containing the domain instance"
        model.stockItemInstance == stockItem
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when: "Update is called for a domain instance that doesn't exist"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'PUT'
        controller.update(null)

        then: "A 404 error is returned"
        response.redirectedUrl == '/stockItem/index'
        flash.message != null


        when: "An invalid domain instance is passed to the update action"
        response.reset()
        def stockItem = new StockItem()
        stockItem.validate()
        controller.update(stockItem)

        then: "The edit view is rendered again with the invalid instance"
        view == 'edit'
        model.stockItemInstance == stockItem

        when: "A valid domain instance is passed to the update action"
        response.reset()
        populateValidParams(params)
        stockItem = new StockItem(params).save(flush: true)
        controller.update(stockItem)

        then: "A redirect is issues to the show action"
        response.redirectedUrl == "/stockItem/show/$stockItem.id"
        flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when: "The delete action is called for a null instance"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'DELETE'
        controller.delete(null)

        then: "A 404 is returned"
        response.redirectedUrl == '/stockItem/index'
        flash.message != null

        when: "A domain instance is created"
        response.reset()
        populateValidParams(params)
        def stockItem = new StockItem(params).save(flush: true)

        then: "It exists"
        StockItem.count() == 1

        when: "The domain instance is passed to the delete action"
        controller.delete(stockItem)

        then: "The instance is deleted"
        StockItem.count() == 0
        response.redirectedUrl == '/stockItem/index'
        flash.message != null
    }
}
