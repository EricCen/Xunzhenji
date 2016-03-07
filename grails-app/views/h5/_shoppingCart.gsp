
%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%@ page import="net.xunzhenji.util.FormatUtil; net.xunzhenji.mall.Product" %>

<div title="购物车" id="shoppingcart" class="panel" data-load="initShoppingCart">
    <section class="row first-row">
        <div id="empty-shoppingcart" style="display: none;">购物车还是空的,快去购物吧!</div>
        <div id="full-shoppingcart" style="display: none;">
            <ul class="batch-list"></ul>
        </div>
    </section>
</div>

<div id="tpl-order-items" style="display: none;">
    {{#orders}}
    <li class="order-item grid">
    <div class="batch-thumb col1-3">
            <img class="lazy" style="width: 100%" data-original="{{imageUrl}}"/>
            {{#showSpinner}}
            <g:render template="spinner" />
            {{/showSpinner}}
            {{^showSpinner}}
            <div>{{quantity}}份</div>
            {{/showSpinner}}
        </div>

        <div class="batch-content col2-3">
            <a href="#product_{{productId}}">
                <h4 class="list-item-hd">{{productTitle}}</h4>
                <span class="batch-desc">{{batchTitle}} ({{productionDate}}上市)</span>

                <div style="overflow: hidden">
                    <span>预售价:</span>
                    <span class="price">{{unitPrice}}</span>
                </div>
                <div style="overflow: hidden">
                    <span>金额:</span>
                    <span class="total price">{{price}}</span>({{priceType}})
                </div>
            </a>
        </div>

        <input class="order-id" name="id" type="hidden" value="{{orderId}}"/>
    </li>
    {{/orders}}
</div>
