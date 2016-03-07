%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<div class="view" id="my-account-view">
    <header>
        <h1>我的账户</h1>
        <a id="close-my-account" class="close" onclick="backToHome(this);"><i class="fa fa-times"></i></a>
    </header>

    <div class="pages">
        <div data-title="我的账户" id="my-account-panel" class="panel detail-panel" panelload="initMyAccount();"></div>

        <div data-title="充值记录" id="deposit-records-panel" class="panel">
            <ul id="deposit-record-ul">
                <li>你暂时没有充值记录</li>
            </ul>
        </div>

        <div id="tpl-my-account" class="hidden">
            <div class="avatar-group">
                {{#headImgUrl}}
                <img class="avatar lazy" data-original="{{headImgUrl}}">
                {{/headImgUrl}}
                {{^headImgUrl}}
                <img class="avatar lazy" data-original="/assets/profile.png">
                {{/headImgUrl}}
                <div class="name-group">
                    <div><strong>{{name}}</strong></div>

                    <div class="grey">电话: {{phone}}</div>
                </div>
            </div>

            <div class="input-group">
                <div class="input-row">
                    <div>收货地址</div>

                    <div>
                        <ul class="list">
                            <li>
                                <a href="#address-panel" style="margin-right: 0px;" data-transition="slide-reveal"
                                   onclick='loadMyAccountAddress();'>
                                    <div class="show-address" address-id="{{addressId}}" style="display:none;">
                                        <span class="address-address">{{province}}{{city}}{{district}}{{address}}</span>
                                    </div>
                                    <span class="add-address-text" style="display:none;">添加地址</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="input-row">
                    <div>账户余额</div>

                    <div>
                        <ul class="list">
                            <li>
                                <a href="#deposit-records-panel" style="margin-right: 0px;"
                                   onclick='queryDepositRecords();'>
                                    <span class="balance">{{balance}} 元</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="input-row"  style="display: none;">
                    <div>优惠券</div>

                    <div>
                        <ul class="list">
                            <li>
                                <a style="margin-right: 0px;" data-transition="slide-reveal"
                                   onclick=''>
                                    <span>优惠券</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="input-group">
                    <div class="group-home-btns">
                        <div class="explorer-groups">
                            <a role="deposit" class="btn btn-block btn-red btn-lg btn-deposit"
                               onclick="deposit();">充值</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="tpl-deposit-record-ul" style="display: none;">
            {{#depositList}}
            <li class="deposit-record-row flex-group">
                <div class="deposit-amount grid">
                    <div class="col2-3">
                        <div>{{channel}}</div>

                        <div>+<span class="price">{{amount}}</span> <span class="remark">{{remark}}</span></div>
                    </div>

                    <div class="col1-3 deposit-time">{{date}}</div>
                </div>
            </li>
            {{/depositList}}
        </div>
    </div>
</div>
</div>