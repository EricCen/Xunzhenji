%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<div id="tpl-groups-nearby" style="display: none">
    <ul class="group-list">
        {{#groupsNearMyDefaultAddress}}
        <li>
            <div class="lx-group-item">
                <div group-id="{{groupId}}" my-group="{{isMyGroup}}">
                    {{#organizerHeadImgUrl}}
                    <img data-original="{{organizerHeadImgUrl}}" class="img-circle lazy"/>
                    {{/organizerHeadImgUrl}}
                    {{^organizerHeadImgUrl}}
                    <img data-original="/assets/profile.png" class="img-circle lazy"/>
                    {{/organizerHeadImgUrl}}
                </div>
                <div class="group-name">{{groupName}}（<{{distance}}米)</div>
                <div class="group-size">{{memberCount}}成员</div>
            </div>
        </li>
        {{/groupsNearMyDefaultAddress}}
        {{^groupsNearMyDefaultAddress}}
        <li>
            <div class="grid" style="padding: 10px">
                目前你的附近还没有领鲜群
            </div>
        </li>
        {{/groupsNearMyDefaultAddress}}
    </ul>
</div>

<div id="tpl-buyers-nearby" style="display: none">
    <ul class="buyer-list">
        {{#groupsNearMyDefaultAddress}}
        <li>
            <div class="lx-group-item">
                {{#organizerHeadImgUrl}}
                <img data-original="{{organizerHeadImgUrl}}" class="img-circle lazy"/>
                {{/organizerHeadImgUrl}}
                {{^organizerHeadImgUrl}}
                <img data-original="/assets/profile.png" class="img-circle lazy"/>
                {{/organizerHeadImgUrl}}
                <div class="group-name">{{groupName}}</div>
                <div class="distance"><{{distance}}米</div>
            </div>
        </li>
        {{/groupsNearMyDefaultAddress}}
        {{^groupsNearMyDefaultAddress}}
        <li>
            <div class="grid" style="padding: 10px">
                你可能是第一购买的人哦
            </div>
        </li>
        {{/groupsNearMyDefaultAddress}}
    </ul>
</div>

<div id="tpl-lxgroup-member-detail-panel" style="display: none;">
    <div class="avatar-group">
        {{#headImgUrl}}
        <img class="avatar lazy" data-original="{{headImgUrl}}">
        {{/headImgUrl}}
        {{^headImgUrl}}
        <img class="avatar lazy" data-original="/assets/profile.png">
        {{/headImgUrl}}
        <div class="lxgroup-name-group">
            <div><strong>{{name}}</strong></div>

            <div class="grey">电话: {{phone}}</div>

            <div class="grey">距离: <{{distance}}米</div>
        </div>
    </div>

    <div class="input-group">
        <div class="input-row">
            <div>地址</div>

            <div>{{address}}</div>
        </div>
    </div>

    <div class="group-home-btns">
        <div class="explorer-groups">
            <a class="btn btn-block grey btn-lg quit-group" group-id="{{groupId}}" member-id="{{memberId}}"
               onclick="kickMemberOutOfGroup(this);">踢出群</a>
        </div>
    </div>
</div>

<div id="tpl-my-commission-panel" style="display: none;">
    <section class="commission1">
        <div class="top-text"><i class="fa fa-calendar"></i>今天佣金</div>

        <div><span class="today-commission amount">{{todayCommission}}</span></div>
    </section>
    <section class="commission2">
        <div class="extractable-amt">
            <div class="label-text">可提取佣金</div>

            <div class="amount">{{extractableCommission}}</div>
        </div>

        <div class="grid">
            <div class="box col2">
                <div class="inner-box">
                    <div class="label-text">已确定佣金</div>

                    <div class="amount">{{realisedCommission}}</div>
                </div>
            </div>

            <div class="box col2">
                <div class="inner-box">
                    <div class="label-text">未确定佣金</div>

                    <div class="amount">{{unrealisedCommission}}</div>
                </div>
            </div>

            <div class="box col2">
                <div class="inner-box">
                    <div class="label-text">近一周佣金</div>

                    <div class="amount">{{oneWeekCommission}}</div>
                </div>
            </div>

            <div class="box col2">
                <div class="inner-box">
                    <div class="label-text">近一月佣金</div>

                    <div class="amount">{{oneMonthCommission}}</div>
                </div>
            </div>

            <div class="box col2">
                <div class="inner-box extracted-amt">
                    <div class="label-text">已提取佣金</div>

                    <div class="amount">{{extractedCommission}}</div>
                </div>
            </div>

            <div class="box col2">
                <div class="inner-box">
                    <div class="label-text">累计佣金</div>

                    <div class="amount">{{totalCommission}}</div>
                </div>
            </div>
        </div>
    </section>
    <section class="commission3">
        <a class="red" href="#commission-history-panel" data-transition="up" onclick="loadCommissionHistoryPanel();">查看佣金明细</a>
    </section>
    <section class="group-home-btns">
        <div class="explorer-groups">
            <a class="btn btn-block btn-lg transfer-to-account" onclick="extractCommissionToAccount();">转入消费账户</a>
            <a class="btn btn-block btn-lg extract" onclick="extractCommissionToWeChat()">提取</a>
        </div>
    </section>
</div>

<div id="tpl-commission-history-ul" style="display: none;">
    {{#commissionList}}
    <li class="commission-history-row flex-group">
        {{#buyerHeadImgUrl}}
        <div class="head-image"><img class="lazy img-circle" data-original="{{buyerHeadImgUrl}}"></div>
        {{/buyerHeadImgUrl}}
        {{^buyerHeadImgUrl}}
        <div class="head-image"><img class="lazy img-circle" data-original="/assets/profile.png"></div>
        {{/buyerHeadImgUrl}}

        <div class="product-amount">
            <div class="product">
                <div>{{product}} <span class="state">{{state}}</span></div>

                <div class="grey">{{dateCreated}}</div>
            </div>

            <div class="amount">{{amount}}</div>
        </div>
    </li>
    {{/commissionList}}
</div>

<div id="tpl-lxgroup-delivery-detail" style="display: none;">
    <section>
        <div class="grid">
            <img class="lazy col1-3 product-img" data-original="{{productImgUrl}}">

            <div class="col2-3 product-info">
                <div class="product-title">{{productTitle}} {{batchTitle}}</div>

                <div>
                    <span class="delivery-info">共{{totalQuantity}}件商品</span>
                    <span class="commission-info">佣金{{commission}}元</span>
                </div>
                {{#status}}
                <div class="success">已成团</div>
                {{/status}}
                {{^status}}
                <div class="fail">还差{{quantityLeft}}件商品就成团</div>
                {{/status}}
            </div>
        </div>
    </section>
    <section>
        <div><strong>订单列表</strong></div>
        <ul id="lxgroup-delivery-orders-list">
            {{#orderList}}
            <li class="list-item-desced order-{{orderId}}">
                <div>
                    <span class="order-status">状态:<span class="display-status {{status}}"></span> #{{id}}</span>
                </div>

                <div class="grid">
                    <img class="lazy img-circle col1-3" data-original="{{headImgUrl}}"/>

                    <div class="contact-info col2-3">
                        <div style="overflow: hidden">
                            <div>数量:{{quantity}}</div>

                            <div>
                                <span><i class="fa fa-user"></i>{{name}}</span> <span><i
                                    class="fa fa-phone"></i>{{mobile}}
                            </span>
                            </div>

                            <div><i class="fa fa-home"></i>{{address}}</div>
                        </div>
                    </div>
                </div>

                {{#hasAction}}
                <div class="action-group">
                    <a class="button order-button green customer-got-the-product" order-id="{{orderId}}" onclick="customerGotTheProduct(this);">确认领鲜</a>
                </div>
                {{/hasAction}}
            </li>
            {{/orderList}}
            {{^orderList}}
            <li>现在还没有顾客加入到这个群</li>
            {{/orderList}}
        </ul>
    </section>
</div>

<div id="tpl-lxgroup-delivery-list" class="hidden">
    {{#deliveryList}}
    <li class="list-item-desced delivery-{{deliveryId}}">
        <a href="#lxgroup-delivery-detail" delivery-id="{{deliveryId}}" onclick="initLxGroupDeliveryDetailPanel(this);">
            <section>
                <div class="grid">
                    <div class="col2">货到日期:<span>{{deliveryDate}}</span></div>

                    <div class="col2">状态:<span>{{deliveryStatus}}</span></div>
                </div>

                <div class="grid">
                    <div class="col2">商品总数: <span>{{orderCount}}</span></div>

                    <div class="col2">已付数量: <span>{{orderCount}}</span></div>
                </div>

                <div class="grid">
                    <img class="lazy col1-3" data-original="{{productImg}}"/>

                    <div class="contact-info col2-3">
                        <div style="overflow: hidden">
                            <h4 class="list-item-hd">{{productTitle}} {{batchTitle}}</h4>
                        </div>
                    </div>
                </div>
            </section>
        </a>
        {{#hasAction}}
        <div class="action-group">
            {{#confirmDelivery}}
            <a class="button order-button gray refund-btn"
               onclick="confirmDelivery('{{deliveryId}}')">确认收货</a>
            {{/confirmDelivery}}
        </div>
        {{/hasAction}}
    </li>
    {{/deliveryList}}
</div>


<div id="tpl-my-lxgroup-member-list-ul" style="display: none;">
    {{#members}}
    <li>
        <a data-title="{{name}}" member-id="{{id}}" group-id={{groupId}} onclick="enterLxGroupMemberDetail(this);">
            <div class="lxgroup-avatar-item">
                {{#headImgUrl}}
                <img class="avatar lazy" data-original="{{headImgUrl}}">
                {{/headImgUrl}}
                {{^headImgUrl}}
                <img class="avatar lazy" data-original="/assets/profile.png">
                {{/headImgUrl}}
                <div class="lxgroup-name-group">
                    <div>{{name}}</div>

                    <div class="grey">电话: {{phone}}</div>

                    <div class="grey">距离: <{{distance}}米</div>
                </div>
            </div>
        </a>
    </li>
    {{/members}}
</div>



<div id="tpl-edit-lxgroup" style="display: none;">
    <div class="indicator">
        <a class="button red next" style="z-index: 100;">1.填写群信息</a>
        <a class="button transparent next" style="z-index: 99;">2.邀请好友进群</a>
        <a class="button transparent next" style="z-index: 98;">3.进入群管理</a>
    </div>

    <g:form class="lx-group-form" action="saveLxGroup">
        <div class="input-group">
            <div class="input-row">
                <div class="groupName-field">群名</div>

                <div>
                    <input type="text" required="required" placeholder="输入群名，例如:{{name}}的领鲜群" name="groupName"
                           required="required" class="groupName"
                           value="{{name}}" onfocus='showToast(this, "认识您的顾客可以通过群名找到您的群");'>
                </div>
            </div>

            <div class="input-row">
                <div class="phone-field">手机号码</div>

                <div>
                    <input type="tel" class="phoneNumber" name="phone" pattern="^\d{11}$" required="required"
                           class="phone-field"
                           placeholder="填写联系手机号码" oninvalid="invalidMobile(event);" title="11位手机号码"
                           value="{{phone}}" onfocus='showToast(this, "手机号码会告诉顾客，让他们在必要时找到您");'>
                </div>
            </div>

            <div class="input-row">
                <div class="wechatAccount-field">微信号</div>

                <div>
                    <input type="text" required="required" placeholder="请输入微信号" name="wechatAccount"
                           class="wechatAccount"
                           value="{{wechatAccount}}" onfocus='showToast(this, "微信号也会告诉客户，方便你通过微信联系顾客们");'>
                </div>
            </div>

            <div class="input-row">
                <div class="address-field">领货地址<i class="fa fa-question-circle"
                                                  onclick='showToast(this, "领货地址可以是住宅、商铺或者大家都知道的地方，物流会发货到这里，客户也会到这里取货");'></i>
                </div>

                <div class="show-address" style="display: none;">
                    <a href="#address-panel" data-transition="slide-reveal" class="chevron" onclick='loadLxGroupAddress();'>
                        <span class="address-address">{{address}}</span>
                    </a>
                </div>

                <div class="add-address-text">
                    <a href="#address-panel"  data-transition="slide-reveal" class="chevron" onclick='loadLxGroupAddress();'>
                        <span style="padding: 5px" class="address-field">添加地址</span>
                    </a>
                </div>
                <input type="hidden" class="addressId" name="address.id" value="{{addressId}}">
            </div>

            <div class="input-row">
                <div>送货服务</div>

                <div>
                    <input type="checkbox" id="deliveryService" name="deliverable"
                           onchange='showToast(this, "提供送货服务能使你的领鲜群更具竞争力");' style="display: none;"/>
                    <label for="deliveryService" style="top: -15px;"></label>
                </div>
            </div>

            <div class="input-row">
                <div>领货有礼</div>

                <div>
                    <input type="checkbox" id="giftForRetrieval" name="giftForRetrieval"
                           onchange='showToast(this, "群主为来领货的顾客提供小礼品。");' style="display: none;"/>
                    <label for="giftForRetrieval" style="top: -15px;"></label>
                </div>
            </div>

            <div class="input-row">
                <div>领货有折</div>

                <div>
                    <input type="checkbox" id="discountForRetrieval" name="discountForRetrieval"
                           onchange='showToast(this, "群主为来领货的顾客提供额外折扣。");' style="display: none;"/>
                    <label for="discountForRetrieval" style="top: -15px;"></label>
                </div>
            </div>

            <div role="availableTime" class="input-row">
                <div>领货时间<i class="fa fa-question-circle"
                            onclick='showToast(this, "根据实际情况选择你有空代收货和顾客上门领货的日子，通常快递在中午或下午送货到领货地点");'></i></div>

                <div>
                    <% def weeks = [
                            [index: 2, name: "一"],
                            [index: 3, name: "二"],
                            [index: 4, name: "三"],
                            [index: 5, name: "四"],
                            [index: 6, name: "五"],
                            [index: 7, name: "六"],
                            [index: 1, name: "日"],
                    ] %>
                    <g:each in="${weeks}" var="week">
                        <input type="checkbox" id="check_${week.index}" name="availableTime_${week.index}"
                               style="display: none;"/>
                        <label for="check_${week.index}">周${week.name}</label>
                    </g:each>

                    <input type="checkbox" id="all_days" name="availableTime" style="display: none;"
                           onchange="selectAllDays();"/>
                    <label for="all_days">全周</label>
                </div>
            </div>
        </div>

        <div style="padding:0 15px">
            <div class="flex-item">
                <a role="saveGroup" class="btn btn-block btn-green btn-lg" onclick="saveLxGroup()">创建领鲜群</a>
            </div>
        </div>

        <div role="registerTerm" class="register-term" style="display: none;">注册即表示同意我们的<a href=""
                                                                                           role="buyers_agreement"
                                                                                           class="text-blue">服务条款使用守则</a>
        </div>
        <input type="hidden" class="organizer-id" name="organizer.id" value="{{organizerId}}">
        <input type="hidden" class="group-id" name="group.id" value="{{groupId}}">
    </g:form>
</div>
