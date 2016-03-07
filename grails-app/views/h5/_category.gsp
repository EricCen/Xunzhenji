<%@ page import="net.xunzhenji.util.FormatUtil" %>
%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<div data-title="${category.name}" id="category_${category.id}" class="panel"
     thumb-url="${category?.logo?.mobileUrl}" desc="${category.introduction}">
    <ul id="product-list-ul" class="list">
        <g:each in="${category.products}" var="product">
            <li class="list-item-desced list-thumb">
                <a href="#product_${product.id}" class="grid">
                    <img data-original="${product.banner?.thumbUrl}" class="col1-3 lazy"/>

                    <div class="col2-3" style="padding-left: 10px;">
                        <h4 class="list-item-hd">${product.title}</h4>
                        <g:if test="${product.hasBatchsInPresales()}">
                            <div><span class="color-text red-text">火热预订中</span></div>
                            <div class="am-list-item-text">价格范围:<span class="price">${FormatUtil.formatPrice(product.minPrice())}</span> ～ <span class="price">${FormatUtil.formatPrice(product.price)}</span></div>
                        </g:if>
                        <g:else>
                            <div><span class="color-text green-text">现货发售</span></div>
                            <div class="am-list-item-text">售价:<span class="price">${product.price}</span></div>
                        </g:else>
                    </div>
                </a>
            </li>
        </g:each>
    </ul>
</div>