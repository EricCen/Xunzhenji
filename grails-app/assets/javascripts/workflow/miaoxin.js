/*
 * Copyright (c) 2016 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

/**
 * Created by Kevin on 2016/2/12.
 */
var pageManager;

$(function () {

    pageManager = {
        $container: $('.js_container'),
        _pageStack: [],
        _configs: [],
        _defaultPage: null,
        _isGo: false,
        default: function (defaultPage) {
            this._defaultPage = defaultPage;
            return this;
        },
        init: function () {
            var self = this;

            $(window).on('hashchange', function (e) {

                var _isBack = !self._isGo;
                self._isGo = false;
                if (!_isBack) {
                    return;
                }

                var url = location.hash.indexOf('#') === 0 ? location.hash : '#';
                var found = null;
                for (var i = 0, len = self._pageStack.length; i < len; i++) {
                    var stack = self._pageStack[i];
                    if (stack.config.url === url) {
                        found = stack;
                        break;
                    }
                }
                if (found) {
                    self.back();
                }
                else {
                    goDefault();
                }
            });

            function goDefault() {
                var url = location.hash.indexOf('#') === 0 ? location.hash : '#';
                var page = self._find('url', url) || self._find('name', self._defaultPage);
                self.go(page.name);
            }

            goDefault();

            return this;
        },
        push: function (config) {
            this._configs.push(config);
            return this;
        },
        go: function (to) {
            var config = this._find('name', to);
            if (!config) {
                return;
            }

            var html = $(config.template).html();
            var $html = $(html).addClass('slideIn').addClass(config.name);
            this.$container.append($html);
            this._pageStack.push({
                config: config,
                dom: $html
            });

            this._isGo = true;
            location.hash = config.url;

            if (!config.isBind) {
                this._bind(config);
            }

            return this;
        },
        currentPage: function(){
            var page = this._pageStack[this._pageStack.length - 1];
            return page.config.name;
        },
        back: function () {
            var stack = this._pageStack.pop();
            if (!stack) {
                return;
            }

            stack.dom.addClass('slideOut').on('animationend', function () {
                stack.dom.remove();
            }).on('webkitAnimationEnd', function () {
                stack.dom.remove();
            });

            this._isGo = true;
            location.hash = this._pageStack[this._pageStack.length-1].config.url;
            return this;
        },
        _find: function (key, value) {
            var page = null;
            for (var i = 0, len = this._configs.length; i < len; i++) {
                if (this._configs[i][key] === value) {
                    page = this._configs[i];
                    break;
                }
            }
            return page;
        },
        _bind: function (page) {
            var events = page.events || {};
            for (var t in events) {
                for (var type in events[t]) {
                    this.$container.on(type, t, events[t][type]);
                }
            }
            page.isBind = true;
        }
    };

    var home = {
        name: 'home',
        url: '#',
        template: '#tpl_home',
        events: {
            '.btn': {
                click: function (e) {
                    var id = $(this).data('id');
                    pageManager.go(id);
                }
            },
            '.btn_manufacture': {
                click: function (e) {
                    var processId = $(this).data('process-id');
                    $("#manufacture-process-id").val(processId);
                }
            },
            '.btn_delivery': {
                click: function (e) {
                    var processId = $(this).data('process-id');
                    $("#delivery-process-id").val(processId);
                }
            },
            '.btn_manufacture_list': {
                click: function (e) {
                    ajaxGet(getManufactureList, {}, function(data){
                        render($('#tpl_manufacture_list'), $('#manufacture_list'), data.model);
                    });
                }
            },
            '.btn_delivery_list': {
                click: function (e) {
                    ajaxGet(getDeliveryList, {}, function(data){
                        for(var date in data.model){
                            var deliveries = data.model[date];
                            var obj = {date: date, deliveries:deliveries};
                            var sum = 0;
                            for(i=0;i<deliveries.length;i++){
                               sum+=deliveries[i].weight;
                            }
                            obj.sum = sum.toFixed(2);
                            renderAppend($('#tpl_delivery_list'), $('#delivery_list'), obj);
                        }
                    });
                }
            },
            '.btn_procurement_list': {
                click: function (e) {
                    ajaxGet(getProcurementList, {}, function(data){
                        for(var date in data.model){
                            var procurements = data.model[date]
                            var obj = {date: date, procurements:procurements}
                            var sum = 0;
                            for(i=0;i<procurements.length;i++){
                                sum+=procurements[i].totalPrice;
                            }
                            obj.sum = sum.toFixed(2);
                            renderAppend($('#tpl_procurement_list'), $('#procurement_list'), obj);
                        }
                    });
                }
            }
        }
    };
    var procurement = {
        name: 'procurement',
        url: '#procurement',
        template: '#tpl_procurement'
    };
    var delivery = {
        name: 'delivery',
        url: '#delivery',
        template: '#tpl_delivery'
    };
    var manufacture = {
        name: 'manufacture',
        url: '#manufacture',
        template: '#tpl_manufacture'
    };
    var source = {
        name: 'source',
        url: '#source',
        template: '#tpl_source'
    };
    var mlist = {
        name: 'mlist',
        url: '#mlist',
        template: '#tpl_mlist'
    };
    var dlist = {
        name: 'dlist',
        url: '#dlist',
        template: '#tpl_dlist'
    };
    var plist = {
        name: 'plist',
        url: '#plist',
        template: '#tpl_plist'
    };
    pageManager.push(home)
        .push(procurement)
        .push(delivery)
        .push(manufacture)
        .push(source)
        .push(mlist)
        .push(dlist)
        .push(plist)
        .default('home')
        .init();
});

function render(template, target, data) {
    var rendered = Mustache.render(template.html(), data);
    target.html(rendered);
}

function renderAppend(template, target, data) {
    var rendered = Mustache.render(template.html(), data);
    target.append(rendered);
}

function renderPrepend(template, target, data) {
    var rendered = Mustache.render(template.html(), data);
    target.prepend(rendered);
}

function selectSource(elem) {
    var value = $(elem).val();
    if (value == "create") {
        pageManager.go("source");
    }
}

function addSource() {
    ajaxPost(addSourceLink, $(new_source_form).serialize(), function (data) {
        var newSource = data.model;
        $("#p_source option").first().after('<option selected value=' + newSource.id + '>' + newSource.name + '</option>');
        pageManager.back();
    });
}

function addProcurement() {
    var form = $("#new_procurement_form").serialize();

    ajaxPost(addProcurementLink, form, function (data) {
        var date = data.model.procurement.procurementTime;
        var weight = data.model.procurement.weight;
        var quantity = data.model.procurement.quantity;
        var initialManufactureQuantity = String(data.model.process.initialManufactureQuantity);
        var procuredQuantity = data.model.process.procuredQuantity;
        var manufactureStockWeight = data.model.process.manufactureStockWeight;
        var manufactureQuantity = data.model.process.manufactureQuantity;
        var id = data.model.procurement.id;
        var processId = data.model.process.id;

        var foundRecord;
        $.each(pageData.data, function () {
            if (this.id == processId) {
                foundRecord = this;
            }
        });

        var record;
        if (foundRecord) {
            record = foundRecord
        } else {
            record = pageData.data[0];
            record.id = processId;
            record.procurementTime = new Date(date).format("yy/MM/dd");
            ;

            record.procurements = [];
        }
        record.initialManufactureQuantity = initialManufactureQuantity;
        record.procuredQuantity = procuredQuantity;
        record.manufactureStockWeight = manufactureStockWeight;
        record.manufactureQuantity = manufactureQuantity;
        record.procurements = record.procurements ? record.procurements : Array();
        record.procurements.push({
            quantity: quantity,
            weight: weight
        });
        render($('#tpl_main_table'), $('#main_table'), pageData);
        pageManager.back();
    });
}

function addManufacture() {
    var form = $("#new_manufacture_form").serialize();
    ajaxPost(addManufactureLink, form, function (data) {
        var date = data.model.manufacture.manufactureTime;
        var quantity = data.model.manufacture.outputQuantity;
        var inputWeight = data.model.manufacture.inputWeight;
        var outputWeight = data.model.manufacture.outputWeight;
        var productionRate = data.model.manufacture.productionRate;
        var processId = data.model.process.id;
        var initialManufactureQuantity = data.model.process.initialManufactureQuantity;
        var procuredQuantity = data.model.process.procuredQuantity;
        var manufactureStockWeight = data.model.process.manufactureStockWeight;
        var manufactureQuantity = data.model.process.manufactureQuantity;

        var foundRecord;
        $.each(pageData.data, function () {
            if (this.id == processId) {
                foundRecord = this;
            }
        });

        var record;
        if (foundRecord) {
            record = foundRecord
        } else {
            record = pageData.data[0];
            record.id = processId;
        }
        if (!record.manufacture) {
            record.manufacture = {}
        }
        record.manufactureTime = new Date(date).format("yy/MM/dd");
        record.initialManufactureQuantity = initialManufactureQuantity;
        record.procuredQuantity = procuredQuantity;
        record.manufactureStockWeight = manufactureStockWeight;
        record.manufactureQuantity = manufactureQuantity;
        record.manufacture.quantity = quantity;
        record.manufacture.inputWeight = inputWeight;
        record.manufacture.outputWeight = outputWeight;
        record.manufacture.productionRate = productionRate * 100;
        render($('#tpl_main_table'), $('#main_table'), pageData);

        pageManager.back();
    });
}

function addShopDelivery() {
    var form = $("#new_delivery_form").serialize();
    ajaxPost(addDeliveryLink, form, function (data) {
        var date = data.model.delivery.deliveryTime;
        var totalWeight = data.model.delivery.totalWeight;
        var stockWeight = data.model.delivery.stockWeight;
        var stockMoveWeight = data.model.delivery.stockMoveWeight;
        var deliveredStockWeight = data.model.process.deliveredStockWeight;
        var productionRate = data.model.delivery.productionRate;
        var initialManufactureQuantity = data.model.process.initialManufactureQuantity;
        var procuredQuantity = data.model.process.procuredQuantity;
        var manufactureStockWeight = data.model.process.manufactureStockWeight;
        var manufactureQuantity = data.model.process.manufactureQuantity;

        var processId = data.model.process.id;

        var foundRecord;
        $.each(pageData.data, function () {
            if (this.id == processId) {
                foundRecord = this;
            }
        });

        var record;
        if (foundRecord) {
            record = foundRecord
        } else {
            record = pageData.data[0];
            record.id = processId;
        }
        if (!record.delivery) {
            record.delivery = {}
        }
        record.deliveryTime = new Date(date).format("yy/MM/dd");
        record.initialManufactureQuantity = initialManufactureQuantity;
        record.procuredQuantity = procuredQuantity;
        record.manufactureStockWeight = manufactureStockWeight;
        record.manufactureQuantity = manufactureQuantity;
        record.delivery.totalWeight = totalWeight;
        record.delivery.stockWeight = deliveredStockWeight;
        record.delivery.stockMoveWeight = stockMoveWeight;
        record.delivery.productionRate = productionRate;
        render($('#tpl_main_table'), $('#main_table'), pageData);

        pageManager.back();
    });
}

