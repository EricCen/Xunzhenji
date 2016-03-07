%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<div class="view" id="my-order-view">
    <header>
        <h1>订单管理</h1>
        <a id="close-order-view" class="close" onclick="backToHome(this);"><i class="fa fa-times"></i></a>
    </header>

    <div class="pages">

        <div data-title="订单列表" id="listOrder" panelload="initOrderList();" class="panel">

            <section class="row" style="border-bottom: none;">
                <ul class="nav nav-tabs">
                    <li id="tabAllStatus" role="presentation" query-status="allStatus"><a
                            onclick="queryOrders(this);">全部订单</a>
                    </li>
                </ul>
                <ul id="ul-order-status_list" class="nav nav-tabs">
                </ul>
            </section>
            <section class="row">
                <ul id="ul-list-order" class="product-list list">
                </ul>
            </section>
        </div>

        <div id="tpl-order-list" style="display: none;">
            {{#orderList}}
            <li class="list-item-desced order-{{orderId}}">
                <a href="#order-detail-panel" order-id="{{orderId}}" onclick="queryOrderDetail({{orderId}});">
                    <div>
                        <span class="order-status">状态:<span class="display-status {{status}}"></span> #{{orderId}}
                        </span>
                        <span class="order-last-update">最后更新:<span>{{lastUpdated}}</span></span>
                    </div>

                    <div class="grid">

                        <img class="lazy col1-3" data-original="{{productThumbUrl}}"/>

                        <div class="col2-3">
                            <div style="overflow: hidden">
                                <h4 class="list-item-hd">{{productTitle}}</h4>

                                <div><span class="batch-desc">{{batchDesc}} <span
                                        class="prod-date">{{productionDate}}上市</span>
                                </span></div>

                                <div>下单时间: {{orderDate}}</div>
                                {{#deliverDate}}
                                <div>发货时间: {{deliverDate}}</div>
                                {{/deliverDate}}
                            </div>

                            <div style="overflow: hidden">
                                <div><span>总价:</span><span class="price">{{orderPrice}}</span></div>

                                {{#orderDeposit}}
                                <div><span>订金:</span><span class="price">{{orderDeposit}}</span></div>
                                {{/orderDeposit}}

                                <div class="quantity">x {{quantity}}</div>
                            </div>
                        </div>

                    </div>
                </a>

                {{#hasAction}}
                <div class="action-group">
                    {{#refundable}}
                    <a class="button order-button gray refund-btn"
                       onclick="confirmRefund('{{orderId}}', '{{discount}}')">退款</a>
                    {{/refundable}}
                    {{#payable}}
                    <a class="button order-button green" orderId="{{orderId}}" onclick="payForOrder(this);">付款</a>
                    {{/payable}}
                </div>
                {{/hasAction}}
            </li>
            {{/orderList}}
        </div>

        <div id="tpl-order-status-list" style="display: none;">
            {{#statusList}}
            <li id="tab-{{statusName}}" role="presentation" query-status="{{statusName}}">
                <a onclick="queryOrders(this);">{{statusDesc}}</a>
            </li>
            {{/statusList}}
        </div>

        <div id="order-detail-panel" data-title="订单详情" class="product-detail panel" panelload="loadOrderDetail();">

        </div>

        <div id="tpl-order-detail-panel" class="hidden">
            <div class="status-group">
                <div class="status-box {{pending-payment}}">付订金</div>

                <div class="status-box {{pending-conf-deliver-time}}">付全款</div>

                <div class="status-box {{pending-delivery}}">确定收货时间</div>

                <div class="status-box {{pending-retrieval}}">发货中</div>

                <div class="status-box {{pending-comment}}">确认收货</div>
            </div>

            <div>
                <span class="order-status">状态:<span class="display-status {{status}}"></span></span>
                <span class="order-last-update">最后更新:<span>{{lastUpdated}}</span></span>
            </div>

            <section class="image-title grid">
                <img class="lazy col1-3" data-original="{{productThumbUrl}}"/>

                <div class="col2-3">
                    <div class="product-title">
                        <h4 class="list-item-hd">{{productTitle}}</h4>

                        <div>
                            <span class="batch-desc">{{batchDesc}} <span class="prod-date">{{productionDate}}上市</span>
                            </span>
                        </div>

                        <div>逢{{deliverDaysInWeek}}发货</div>
                    </div>
                </div>
            </section>

            <section>
                <div class="title"><span>订单信息</span></div>

                <div style="overflow: hidden">
                    <div class="grid">
                        <span class="col1-3 label">订单号</span>
                        <span class="col2-3 value">{{orderId}}</span>
                    </div>

                    <div class="grid">
                        <span class="col1-3 label">下单时间</span>
                        <span class="col2-3 value">{{orderDate}}</span>
                    </div>

                    <div class="grid">
                        <span class="col1-3 label">总价</span>
                        <span class="col2-3 value price">{{orderPrice}} {{#discount}}<span
                                class="discount">({{discountNumber}}折)</span>{{/discount}}</span>
                    </div>

                    {{#orderDeposit}}
                    <div class="grid">
                        <span class="col1-3 label">订金</span>
                        <span class="col2-3 value price">{{orderDeposit}}</span>
                    </div>
                    {{/orderDeposit}}

                    <div class="grid">
                        <span class="col1-3 label">数量</span>
                        <span class="col2-3 value">{{quantity}}件</span>
                    </div>

                </div>
            </section>

            <section>
                <div class="title"><span>支付信息</span></div>
                {{#depositPayTime}}
                <div class="grid">
                    <span class="col1-3 label">付订时间</span>
                    <span class="col2-3 value">{{depositPayTime}}</span>
                </div>
                {{/depositPayTime}}
                {{#depositPaymentNo}}
                <div class="grid">
                    <span class="col1-3 label">订金付款方式</span>
                    <span class="col2-3 value">{{depositPaymentType}}</span>
                </div>

                <div class="grid">
                    <span class="col1-3 label">订金金额</span>
                    <span class="col2-3 value price">{{depositAmount}}</span>
                </div>
                <div class="grid">
                    <span class="col1-3 label">订金单号</span>
                    <span class="col2-3 value">{{depositPaymentNo}}</span>
                </div>
                {{/depositPaymentNo}}
                {{#fullPricePayTime}}
                <div class="grid">
                    <span class="col1-3 label">付款时间</span>
                    <span class="col2-3 value">{{fullPricePayTime}}</span>
                </div>
                {{/fullPricePayTime}}
                {{#fullPricePaymentNo}}
                <div class="grid">
                    <span class="col1-3 label">付款方式</span>
                    <span class="col2-3 value">{{fullPricePaymentType}}</span>
                </div>

                <div class="grid">
                    <span class="col1-3 label">付款金额</span>
                    <span class="col2-3 value price">{{fullPriceAmount}}</span>
                </div>
                <div class="grid">
                    <span class="col1-3 label">付款单号</span>
                    <span class="col2-3 value">{{fullPricePaymentNo}}</span>
                </div>
                {{/fullPricePaymentNo}}

            </section>

            <section>
                <div class="title"><span>送货信息</span></div>

                <div class="grid">
                    <span class="col1-3 label">收件人</span>
                    <span class="col2-3 value address-receiver">{{to}}</span>
                </div>

                <div class="grid">
                    <span class="col1-3 label">电话</span>
                    <span class="col2-3 value address-mobile">{{phone}}</span>
                </div>

                <div class="grid">
                    <span class="col1-3 label">地址</span>
                    <span class="col2-3 value address-detail">{{address}}</span>
                </div>
                {{#isGroupon}}
                <div class="grid">
                    <span class="col1-3 label">使用领鲜群</span>
                    <span class="col2-3 value">是</span>
                </div>

                <div class="grid">
                    <span class="col1-3 label">群名称</span>
                    <span class="col2-3 value">{{groupName}}</span>
                </div>

                <div class="grid">
                    <span class="col1-3 label">群主微信号</span>
                    <span class="col2-3 value">{{weChatAccount}}</span>
                </div>

                <div class="grid">
                    <span class="col1-3 label">领鲜时间</span>
                    <span class="col2-3 value">{{groupDeliverDaysInWeek}}</span>
                </div>
                {{/isGroupon}}
                {{#deliverTimeEditable}}
                <form id="conf-deliver-time">
                    <div class="grid">
                        <span class="col1-3 label">到货时间</span>

                        <div class="input-group confirm-time-group">
                            <div id="choose-time">
                                {{#deliverDateList}}
                                <input type="radio" id="lx_day_{{date}}" name="deliverDate" value="{{date}}" onchange="onSelectNearDay();">
                                <label for="lx_day_{{date}}">{{date}} 周{{dayInWeek}} {{remark}}</label>
                                {{/deliverDateList}}
                            </div>
                            <div id="select-time">
                                <select id="lx_day_further" name="deliverDate" onchange="onSelectFurtherDay();">
                                    <option value="" class="default">选择更远时间</option>
                                    {{#deliverDateList2}}
                                    <option value="{{date}}">{{date}} 周{{dayInWeek}} {{remark}}</option>
                                    {{/deliverDateList2}}
                                </select>
                            </div>
                        </div>
                        <span class="col2-3 value deliverDate" style="display: none;"><span>{{deliverDate}}</span> <a
                                href="#" onclick="changeDeliveryDate();">更改</a></span>
                    </div>
                    <input type="hidden" name="orderId" value="{{orderId}}">
                </form>
                {{/deliverTimeEditable}}
                {{^deliverTimeEditable}}
                    {{#deliverDate}}
                        <div class="grid">
                            <span class="col1-3 label">到货时间</span>
                            <span class="col2-3 value deliverDate"><span>{{deliverDate}}</span></span>
                        </div>
                    {{/deliverDate}}
                {{/deliverTimeEditable}}
            </section>

            <div class="action-group">
                {{#refundable}}
                <a class="button refund-button gray refund-btn"
                   onclick="confirmRefund('{{orderId}}', '{{discount}}')">退款</a>
                {{/refundable}}
                {{#deliverTimeEditable}}
                <a class="button conf-time-button green" orderId="{{orderId}}"
                   onclick="confirmDeliveryDate(this);">确定收货时间</a>
                {{/deliverTimeEditable}}
                {{#deliveryConfirmable}}
                <a class="button conf-delivery-button green" orderId="{{orderId}}"
                   onclick="confirmDelivery(this);">确认收货</a>
                {{/deliveryConfirmable}}
                {{#addressChangable}}
                <a class="button chg-address-button" href="#address-panel" data-transition="slide-reveal"
                   orderId="{{orderId}}" onclick='loadChangeOrderAddress(this);'>修改送货地址</a>
                {{/addressChangable}}
                {{#payable}}
                <a class="button pay-button green" orderId="{{orderId}}"
                   onclick="payForOrder(this);">付款</a>
                {{/payable}}
            </div>
        </div>
    </div>
</div>