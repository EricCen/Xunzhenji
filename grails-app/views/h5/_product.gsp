<%@ page import="org.apache.commons.lang.StringUtils; net.xunzhenji.util.FormatUtil" %>
%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%
<div data-title="${product.title}" id="product_${product.id}" class="panel"
     thumb-url="${product?.banner?.thumbUrl}" desc="${product.shortIntroduction()}">
    <section class="row">
        <div class="slide owl-carousel owl-theme">
            <g:each in="${product.images?.sort{it.order}}" var="image" status="i">
                <div class="item" style="padding:0;"><img class="lazyOwl" data-src="${image.mobileUrl}"></div>
            </g:each>
        </div>
    </section>
    <section class="row">
        <div class="share-desc">${product.introduction}</div>
        <br>

        <div class="food-info">
            <div class="food-info-order">
                <div class="food-price-row center">
                    <div class="price-box center">
                    <span class="price-text">市场价</span>
                    <div class="price-weight">
                        <span class="price">${net.xunzhenji.util.FormatUtil.formatPrice(product.price)}</span>
                        <span class="food-unitComment">/${product.weight}克</span>
                    </div>
                    </div>
                </div>
                <g:if test="${product.region}">
                <div class="food-goodsRegion"><span>销售地区：</span>${product.region}</div>
                </g:if>
                <div class="food-goodsSettings"><span>送货：</span>${product.express} (送货到家 或 货到领鲜)</div>
                <div class="food-deliveryDate"><span>货到时间：</span>${FormatUtil.formatDayInWeekStr(product.category.deliverDaysInWeek)}</div>
                <div class="food-deliveryRemark">${product.remark}</div>

            </div>
        </div>
    </section>

    <section class="row">
        <div class="item-title">选择批次<span class="tip_text"
                                          onclick="showToast(this, '这是寻真记的创新预订方式，每提早一周预订，' +
                                                  '价格下降<strong>${net.xunzhenji.util.FormatUtil.removeRightZero(product.weeklyDiscount*100)}%</strong>，' +
                                                  '订金只需<strong>1元</strong>。产品确定能上市时，我们会提醒你支付余款。支付前订金可以随时退款，' +
                                                  '逾期不支付余款，订金也会自动退还。')">越早下订越划算 <i class="fa fa-question-circle"></i></span></div>
        <div class="list batch-list">
            <g:each in="${product.batchs.findAll{it.display}.sort{it.productionDate}}" var="batch">
                <div class="list-item-desced list-thumb">
                    <div class="batch-box">
                        <div class="title-box grid">
                            <h4 class="list-item-hd col2-3">${batch.title}<span class="discount">${batch.discountNumber() ? "(${batch.discountNumber()}折)" : ""}</span></h4>
                            <div class="col1-3">
                                <g:spinner value="0" tag="${"price=\""+batch.currentPrice()+"\""}" batchId="${batch.id}"/>
                            </div>
                        </div>

                        <div class="grid">
                            <div class="col2-3">
                                <g:if test="${batch.isAfterProduction()}">
                                    <div>${batch.productionSimpleDate()}上市 <g:if test="${batch.daysToProduction() >=0}"><span class="tip_text">(还剩${batch.daysToProduction()}天)</span></g:if></div>
                                </g:if>
                                <div>${batch.currentState()} </div>
                            </div>

                            <div class="col1-3">
                                <g:if test="${batch.isPresales()}">
                                    <div class="price-col">预售价:<span
                                            class="price">${net.xunzhenji.util.FormatUtil.formatPrice(batch.price)}</span>
                                    </div>

                                    <div class="price-col">订金:<strong><span
                                            class="price">${net.xunzhenji.util.FormatUtil.formatPrice(batch.product?.deposit)}</span>
                                    </strong>
                                    </div>
                                </g:if>
                                <g:else>
                                    <div class="price-col">售价:<span
                                            class="price">${net.xunzhenji.util.FormatUtil.formatPrice(batch.price)}</span>
                                    </div>
                                </g:else>
                            </div>
                        </div>
                    </div>
                </div>
            </g:each>
        </div>
    </section>

    <section class="row groups-nearby-block">
        <div class="item-title">附近的领鲜群</div>

        <div class="groups-nearby"></div>
    </section>

    <section class="row who-buy-it">
        <div class="item-title">谁也订了</div>

        <div class="buyers-nearby"></div>
    </section>
    <section class="row">
        <div class="detail-table-header grid">
            <div class="col2 active" data-link="$" onclick="loadTab(this, 'product-content');">详细情况</div>

            <div class="col2" data-link="${createLink(action: "producer", id: product.producer.id)}"
                 onclick="loadTab(this, 'producer-detail');">来自 <img data-original="${product.producer.head.thumbUrl}"
                                                                     class="img-circle lazy"
                                                                     style=" margin-top: -2px;"/></div>
        </div>

        <div class="tab-content product-content active">
            ${product.content}
        </div>
        <div class="tab-content producer-detail">
        </div>
    </section>

</div>

<g:each in="${product.batchs}" var="batch">
    <g:render template="batch" model="[batch: batch]"/>
</g:each>