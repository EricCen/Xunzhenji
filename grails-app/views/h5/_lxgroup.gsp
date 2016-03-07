%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<div class="view" id="lxgroup-view">
    <header>
        <h1>领鲜群</h1>
        <a id="close-lx-group" class="close" onclick="backToHome(this);"><i class="fa fa-times"></i></a>
    </header>

    <div class="pages">
        <div id="group-home-panel" class="panel" panelload="initGroupPage();" data-title="领鲜群">
            <div class="group-home-btns">
                <div class="explorer-groups">
                    <a class="btn btn-block btn-green btn-lg" onclick="showLxGroupMap();"><i
                            class="fa fa-map-o"></i>地图上看附近的领鲜群</a>
                </div>

                <div class="enter-my-group" style="display: none;">
                    <a href="#my-lxgroup-list" class="btn btn-block btn-green btn-lg" onclick="enterMyLxGroupList();"><i
                            class="fa fa-th-list"></i>我的领鲜群</a>
                </div>

                <div class="create-my-group" style="display: none;">
                    <a href="#edit-group-panel" class="btn btn-block btn-green btn-lg"
                       onclick="initEditGroupPanel();"><i
                            class="fa fa-plus"></i>创建领鲜群</a>
                </div>

                <div class="manage-my-group" style="display: none;">
                    <a href="#manage-group-panel" class="btn btn-block btn-green btn-lg"><i
                            class="fa fa-users"></i>管理我的领鲜群</a>
                </div>
            </div>
        </div>

        <div id="explorer-groups-nearby" data-title="身边的领鲜群" class="panel">
            <div id="lxgroup-map-container">
        </div>

            <div class="select-group-btns">
                <a class="btn" onclick="selectPrevGroup();"><</a>
                <a class="btn" onclick="selectNextGroup();">></a>
                <a class="btn join-group" onclick="joinGroup(this);" style="display: none;">加入</a>
                <a class="btn quit-group" onclick="quitGroup(this);" style="display: none;">退出</a>
        </div>
    </div>

        <div id="my-lxgroup-list" data-title="我的领鲜群" class="panel">
            <ul id="my-lxgroup-list-ul" class="list">
            </ul>
        </div>

        <div id="tpl-my-lxgroup-list-ul" style="display: none">
            {{#myLxGroups}}
            <li>
                <a data-title="{{name}}" group-id="{{groupId}}" onclick="enterLxGroupDetail(this);">
                    <div class="lxgroup-avatar-item">
                        {{#headImgUrl}}
                        <img class="avatar lazy" data-original="{{headImgUrl}}">
                        {{/headImgUrl}}
                        {{^headImgUrl}}
                        <img class="avatar lazy" data-original="/assets/profile.png">
                        {{/headImgUrl}}
                        <div class="lxgroup-name-group">
                            <div>{{name}}</div>

                            <div class="grey">微信号: {{weChatAccount}}</div>

                            <div class="grey">距离: <{{distance}}米</div>
                        </div>
                    </div>
                </a>
            </li>
            {{/myLxGroups}}
        </div>

        <div id="lxgroup-detail-panel" class="panel detail-panel"></div>

        <div id="tpl-lxgroup-detail-panel" class="hidden">
            <div class="avatar-group">
                {{#headImgUrl}}
                <img class="avatar lazy" data-original="{{headImgUrl}}">
                {{/headImgUrl}}
                {{^headImgUrl}}
                <img class="avatar lazy" data-original="/assets/profile.png">
                {{/headImgUrl}}
                <div class="lxgroup-name-group">
                <div><strong class="name">{{name}}</strong></div>

                <div class="grey">微信号: {{wechatAccount}}</div>

                <div class="grey">距离: <{{distance}}米</div>
                </div>
            </div>

            <div class="input-group">
                <div class="input-row">
                    <div>地址</div>

                    <div>{{address}}</div>
                </div>

                <div class="input-row">
                    <div>电话</div>

                    <div>{{phone}}</div>
                </div>

                <div class="input-row">
                    <div>领鲜时间</div>

                    <div>{{pickupTimes}}</div>
                </div>
                {{#deliverable}}
                <div class="input-row">
                    <div>送货服务</div>

                    <div>是</div>
                </div>
                {{/deliverable}}
            </div>

            <div class="group-home-btns">
                <div class="explorer-groups">
                    <a class="btn btn-block btn-green btn-lg join-group" onclick="joinGroup(this);"
                       group-id="{{groupId}}"
                       style="display: none;">加入</a>
                    <a class="btn btn-block grey btn-lg quit-group" group-id="{{groupId}}"
                       onclick="quitGroup(this);">退出</a>
                </div>
            </div>
        </div>

        <div data-title="管理领鲜群" id="manage-group-panel" class="panel">
            <ul class="list inset">
                <li>
                    <a href="#my-lxgroup-member-list" onclick="initGroupMemberPanel();">查看群成员信息</a>
                </li>
                <li>
                    <a href="#lxgroup-order-management" onclick="initOrderManagementPanel();">管理订单</a>
                </li>
                <li>
                    <a href="#my-commission-panel" onclick="loadMyCommissionPanel()">我的佣金</a>
                </li>
                <li>
                    <a href="#edit-group-panel" onclick="initEditGroupPanel();">我的群信息</a>
                </li>
                <li>
                    <a href="#invite-friends-panel" onclick="initInviteMyFriendsPanel();">邀请好友加入</a>
                </li>
            </ul>
        </div>

        <div id="edit-group-panel" data-title="编辑群信息" class="panel">
        </div>

        <div id="lxgroup-member-detail-panel" class="panel detail-panel">
        </div>

        <div id="lxgroup-order-management" data-title="订单管理" class="panel">
            <div class="filter-group">
                <form id="filter-form">
                    <div>
                        <input type="checkbox" id="filterOutstanding" name="filterOutstanding" checked="checked"
                               onchange="initOrderManagementPanel();">
                        <label for="filterOutstanding">只显示未完成状态</label>
                    </div>

                    <div>
                        <input type="checkbox" id="filterNonEmpty" name="filterNonEmpty" checked="checked"
                               onchange="initOrderManagementPanel();">
                        <label for="filterNonEmpty">只显示有订单的</label>
                    </div>
                </form>
            </div>

            <div>
                <ul id="lxgroup-delivery-list" class="product-list list">
                </ul>
            </div>
        </div>

        <div id="lxgroup-delivery-detail" data-tile="领鲜批次明细" class="panel">
        </div>

        <div id="my-commission-panel" data-title="我的佣金" class="panel">
        </div>

        <div id="commission-history-panel" data-title="佣金明细" class="panel">
            <ul id="commission-history-ul">
                <li>你现在还没有佣金记录.</li>
            </ul>
        </div>

        <div id="my-lxgroup-member-list" data-title="我的群成员" class="panel">
            <span class="no-member">你的领先群暂时没有群成员</span>
            <ul id="my-lxgroup-member-list-ul" class="list">

            </ul>
        </div>

        <div id="invite-friends-panel" data-title="邀请好友进群" class="panel"
             share-title="欢迎加入我的领鲜群！">
            <div class="indicator">
                <a class="button transparent next" style="z-index: 100;">1.填写群信息</a>
                <a class="button red next" style="z-index: 99;">2.邀请好友进群</a>
                <a class="button transparent next" style="z-index: 98;">3.进入群管理</a>
            </div>

            <div>
                方法:通过微信右上方菜单键，分享到朋友圈或者发送给朋友就能邀请好友加入您的群。
            </div>

            <div style="padding:30px 15px 30px 15px">
                <div class="flex-item">
                    <a href="#manage-group-panel" class="btn btn-block btn-green btn-lg">进入群管理</a>
                </div>
            </div>
        </div>
    </div>
</div>