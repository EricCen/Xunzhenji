%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<div id="confirm-order-panel" class="pay-container panel" data-title='收银台' panelload="initConfirmOrderPanel();">
    <div id="order-payment"></div>
</div>

<div id="tpl-order-payment" style="display: none;">
    <form id="order-payment-form" method="post" action="${createLink(action: "pay")}">
        <section class="row">
            <div class="address-cover"></div>

            <ul class="list">
                <li>
                    <a href="#address-panel" data-transition="slide-reveal" style="margin-right: 0px;" onclick='loadOrderAddress();'>
                        <div class="show-address" address-id="{{addressId}}" style="display:none;">
                            <div class="head-user-phone flex-group">
                                <div class="head-image">
                                    {{#headImageUrl}}
                                    <img class="lazy img-circle" data-original="{{headImageUrl}}">
                                    {{/headImageUrl}}
                                    {{^headImageUrl}}
                                    <img class="lazy img-circle" data-original="/assets/profile.png">
                                    {{/headImageUrl}}
                                </div>

                                <div>
                                    <div>
                                        <span class="receiver-name">收件人:</span>
                                        <span class="lxgroup-name" style="display: none">领鲜群:</span>
                                        <span class="address-name">{{name}}</span>
                                    </div>

                                    <div>电话: <span class="address-phone">{{phone}}</span></div>
                                </div>
                            </div>

                            <div>地址: <span class="address-address">{{province}}{{city}}{{district}}{{street}}{{address}}</span>
                            </div>
                        </div>
                        <span class="add-address-text" style="display:none;">添加地址</span>
                    </a>
                </li>
            </ul>
            <div class="address-cover"></div>
        </section>

        {{#hasDeliveryDates}}
        <section class="row grid">
            <div class="item-title">送货时间</div>

            <div class="product-list confirm-time-group">
                <div id="choose-time">
                    {{#deliverDateList}}
                    <input type="radio" id="lx_day_{{date}}" name="deliverDate" value="{{date}}" onchange="onSelectNearDay();">
                    <label for="lx_day_{{date}}">{{date}} 周{{dayInWeekStr}} {{remark}}</label>
                    {{/deliverDateList}}
                </div>
                <div id="select-time">
                    <select id="lx_day_further" name="deliverDate" onchange="onSelectFurtherDay();">
                        <option value="" class="default">选择更远时间</option>
                        {{#deliverDateList2}}
                        <option value="{{date}}">{{date}} 周{{dayInWeekStr}} {{remark}}</option>
                        {{/deliverDateList2}}
                    </select>
                </div>
            </div>
        </section>
        {{/hasDeliveryDates}}

        <section class="row">
            <div class="item-title">货物清单</div>
            <ul class="batch-list product-list order-list">
                {{#orderList}}
                <li class="list-item-desced grid">
                    <img data-original="{{imageUrl}}" class="lazy col1-3">

                    <div class="col2-3 info-box order-{{id}}">
                        <h4 class="list-item-hd">{{productTitle}}</h4>
                        <span class="batch-desc">{{batchTitle}} <span class="prod-date">{{productionDate}}上市</span>
                        </span>

                        <div style="overflow: hidden;">
                            {{#pendingPayForDeposit}}
                            <div><span>预售价:</span><span class="price presale-price">{{orderPrice}}</span></div>

                            <div><span>订金:</span><span class="price deposit">{{orderDeposit}}</span></div>
                            {{/pendingPayForDeposit}}
                            {{#pendingPayForFullPrice}}
                            <div>
                                <span>金额:</span><span class="price order-price">{{orderPrice}}</span>
                            </div>
                            {{/pendingPayForFullPrice}}
                            <div class="quantity">x {{quantity}}</div>
                        </div>
                    </div>
                    <input class="order-id" name="orderId" type="hidden" value="{{id}}"/>
                </li>
                {{/orderList}}
            </ul>

            <div class="current-price" total-current-price="{{totalCurrentPrice}}">总共: <span class="price">{{totalCurrentPrice}}</span>
            </div>
        </section>

        <section class="row grid payment-info">
            <div class="item-title">支付信息</div>

            {{#hasBalance}}
            <div class="product-list grid">
                <div class="title col2-3">
                    <input type="checkbox" id="useBalance" name="useBalance" checked="checked" onchange="recalcAmount();">
                    <label for="useBalance">使用余额支付<br><span class="account-balance" balance="{{balance}}">(账户有{{balance}}元)</span></label>
                </div>

                <div class="col1-3 content">-<span class="price used-balance">{{useBalance}}</span></div>
            </div>
            {{/hasBalance}}

            <div class="grid">
                <div class="title col1-3">支付金额</div>

                <div class="content col2-3">
                    <div><span class="price wx-pay-amount">{{wxPayAmount}}</span></div>
                </div>
            </div>

            <ul>
                <li class="title">
                    <input type="radio" id="weChatPay" name="paymentType" checked="checked" onchange="recalcAmount();" value="WECHAT">
                    <label for="weChatPay"><i class="icon-wechatpay"></i>微信支付</label>
                </li>
                <li class="title">
                    <input type="radio" id="aliPay" name="paymentType" onchange="recalcAmount();" value="ALIPAY">
                    <label for="aliPay"><i class="icon-alipay"></i>支付宝支付</label>
                </li>
            </ul>

            <div class="grid">
                <div class="title col1-3"><g:message code="promotionCode.label"/></div>

                <div class="content col2-3">
                    <input id="promotionCode1" order-ids="{{orderIds}}" type="text" placeholder="输入特权码"
                           value="{{promotionCode}}" />
                    <a onclick="refreshPrice(this)"><i class="fa fa-refresh btn-refresh"></i></a>
                </div>

                <div class="promotion-desc"></div>
            </div>
        </section>

        <section class="row">
            <div style="padding: 10px 5px;">
                <a role="pay" class="btn btn-block btn-red btn-lg" style="text-align: center" data-ignore="true"
                   onclick="wxPay();">提交订单</a>
            </div>
        </section>

        <section class="row">
            <div class="item-title">价格明细</div>
            {{#orderList}}
            <div class="price-detail-box order-{{id}}">
                <div class="price-detail-title">
                    <div><strong>{{productTitle}}</strong> {{batchTitle}}</div>
                </div>
                {{#pendingPayForDeposit}}
                <span class="step">今天付订</span>

                <div class="input-group">
                    <div class="input-row">
                        <div>订金:</div>

                        <div><span class="price">{{totalDeposit}}</span></div>
                    </div>
                </div>
                {{/pendingPayForDeposit}}

                {{#pendingPayForFullPrice}}
                <span class="step">今天付款</span>

                <div class="input-group">
                    {{/pendingPayForFullPrice}}
                    {{^pendingPayForFullPrice}}
                    <span class="step invalid">{{productionDate}}后付货款</span>

                    <div class="input-group invalid">
                        {{/pendingPayForFullPrice}}

                        <div class="input-row">
                            <div>原价:</div>

                            <div><span class="price">{{totalMarketPrice}}</span></div>
                        </div>


                        <div class="input-row">
                            <div>折扣:</div>
                            <div>-<span class="price discount">{{totalDiscount}}</span></div>
                        </div>

                        <div class="input-row">
                            <div>订金:</div>
                            <div>-<span class="price">{{totalDeposit}}</span></div>
                        </div>

                        <div class="input-row">
                            <div>小计:</div>

                            <div><span class="price order-price">{{totalPrice}}</span></div>
                        </div>
                    </div>
                </div>
                {{/orderList}}
                <div class="price-detail-box input-group">
                    <span class="step">今天付款</span>

                    <div class="input-row">
                        <div><strong>合计:</strong></div>

                        <div class="total-"><strong><span class="price total-price">{{totalCurrentPrice}}</span></strong></div>
                    </div>

                    {{#hasTotalFuturePrice}}
                    <span class="step invalid">未来付款</span>

                    <div class="invalid">
                        <div class="input-row">
                            <div><strong>合计:</strong></div>

                            <div><strong><span class="price">{{totalFuturePrice}}</span></strong></div>
                        </div>
                    </div>
                    {{/hasTotalFuturePrice}}
                </div>
            </div>
        </section>

        <section class="row">
            <div style="padding: 10px 5px;">
                <a role="pay" class="btn btn-block btn-green btn-lg" style="text-align: center" data-ignore="true"
                   onclick="wxPay();">支付订单</a>
            </div>
        </section>
    </form>
</div>