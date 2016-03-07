/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

var myGroupId; //我的领鲜群Id，不是我所在的领先群
var groupsNearMyDefaultAddress;
var lxGroupMap;
var myLat, myLng;

function saveLxGroup() {
    if (!validateLxGroupForm()) {
        return;
    }
    var url = $('#edit-group-panel .lx-group-form').attr('action');
    var data = $('#edit-group-panel .lx-group-form').serialize();

    ajaxPost(url, data, function (data) {
            if (data.model.groupId) myGroupId = data.model.groupId;
            $.afui.loadContent("#invite-friends-panel", false, false, "slide");
            var thumbUrl = data.model.headImgUrl ? data.model.headImgUrl : "http://xunzhenji.net/assets/logo.png";
            $("#invite-friends-panel").attr("thumb-url", thumbUrl)
                .attr("desc", "我的领鲜群位于" + data.model.address);

            $("#edit-group-panel").attr("data-title", "编辑领鲜群");
            $("[role=saveGroup]").text("保存群信息");
            $("#edit-group-panel .group-id").val(myGroupId); //to avoid duplicated save when back to save page
            $("#edit-group-panel .organizer-id").val(data.model.organizerId);
        }, function () {
            if (data.errorcode == -13) {
                $(".field-error").removeClass("field-error");
                $('.' + data.errfield + '-field').addClass("field-error").focus();
                showToast($("#manage-group-panel")[0], data.errormsg)
            }
        }
    );
}

function validateLxGroupForm() {
    var groupName = $("#edit-group-panel input.groupName").val();
    var phone = $("#edit-group-panel input.phoneNumber").val();
    var wechatAccount = $("#edit-group-panel input.wechatAccount").val();
    ;
    var address = $("#edit-group-panel input.addressId").val();

    if (groupName && phone && wechatAccount && address) {
        $("#edit-group-panel .groupName-field").removeClass("invalid");
        $("#edit-group-panel .phone-field").removeClass("invalid");
        $("#edit-group-panel .wechatAccount-field").removeClass("invalid");
        $("#edit-group-panel .address-field").removeClass("invalid");
        return true;
    } else {
        if (!groupName) {
            $("#edit-group-panel .groupName-field").addClass("invalid");
            showToastWithHideToggle($("#edit-group-panel .groupName-field"), "没有填写群名", false);
        }
        if (!phone) {
            $("#edit-group-panel .phone-field").addClass("invalid");
            showToastWithHideToggle($("#edit-group-panel .groupName-field"), "没有填写电话", false);
        }
        if (!wechatAccount) {
            $("#edit-group-panel .wechatAccount-field").addClass("invalid");
            showToastWithHideToggle($("#edit-group-panel .groupName-field"), "没有填写微信号", false);
        }
        if (!address) {
            $("#edit-group-panel .address-field").addClass("invalid");
            showToastWithHideToggle($("#edit-group-panel .groupName-field"), "没有选择地址", false);
        }
        return false;
    }
}

function initInviteMyFriendsPanel() {
    ajaxGet(getLxGroupInfoLink, {groupId: myGroupId}, function (data) {
        var thumbUrl = data.model.headImgUrl ? data.model.headImgUrl : "http://xunzhenji.net/assets/logo.png";
        $("#invite-friends-panel").attr("thumb-url", thumbUrl)
            .attr("desc", "我的领鲜群位于" + data.model.address);
    })
}

function initGroupPage() {
    ajaxGet(queryGroupLink, {}, function (data) {
        var model = data.model;

        if (model.myGroupId) myGroupId = model.myGroupId;

        if (model.isOrganizer) {
            $(".manage-my-group").show();
            $(".create-my-group").hide();
        } else {
            $(".create-my-group").show();
            $(".manage-my-group").hide();
        }
        if (model.isGroupMember) {
            $(".enter-my-group").show();
        } else {
            $(".explorer-groups").show();
        }
        render($("#tpl-edit-lxgroup"), $("#edit-group-panel"), data.model);
    }, function (data) {
        if (data.errorcode == -7) {
            popup("还没登录哦", "客官，你还没有登录。你打开菜单，就可以找到登录或注册按钮。", function () {
                $.afui.loadContent("#main", false, true, "slide");
                $.afui.drawer.show("#main-left-menu", "left", "reveal");
            });
        }
    });
}

function initEditGroupPanel() {
    ajaxGet(editGroupLink, {groupId: myGroupId}, function (data) {
        if (myGroupId) {
            $("#edit-group-panel").attr("data-title", "编辑领鲜群");
            $("[role=saveGroup]").text("保存群信息");
        } else {
            $("#edit-group-panel").attr("data-title", "创建领鲜群");
            $("[role=saveGroup]").text("创建领鲜群");
        }
        render($("#tpl-edit-lxgroup"), $("#edit-group-panel"), data.model);

        if (data.model.address) {
            $("#edit-group-panel .show-address").show();
            $("#edit-group-panel .add-address-text").hide();
        } else {
            $("#edit-group-panel .show-address").hide();
            $("#edit-group-panel .add-address-text").show();
        }
        if (data.model.deliverable) {
            $("#edit-group-panel #deliveryService").attr("checked", "checked");
        }
        if (data.model.pickupTimes) {
            var days = data.model.pickupTimes.split(",");
            for (i in days) {
                $("#edit-group-panel #check_" + days[i]).attr("checked", "checked");
            }
            if (days.length == 7) {
                $("#edit-group-panel #all_days").attr("checked", "checked");
            }
        }
    });
}

function selectAllDays() {
    if ($('#all_days')[0].checked) {
        $('input[id^=check]').each(function () {
            this.checked = true;
        })
    } else {
        $('input[id^=check]').each(function () {
            this.checked = false;
        })
    }
}

function showLxGroupMap(elem) {
    ajaxGet(queryGroupsNearByLink, {}, function (data) {
        groupsNearMyDefaultAddress = data.model.groupsNearMyDefaultAddress;
        myLat = data.model.lat;
        myLng = data.model.lng;
        loadLxGroupMap(myLat, myLng, groupsNearMyDefaultAddress);
        $(".select-group-btns .join-group").hide();
        $(".select-group-btns .quit-group").hide();
        $.afui.loadContent("#explorer-groups-nearby", false, true, "slide");
    }, function (data) {
        if (data.errorcode == -4) {
            showToast($(elem), data.errormsg);
        }else if (data.errorcode == -19) {
            showToast($(elem), data.errormsg);
        }
    });
}


function findItemByImage(img) {
    var container = $("#lxgroup-map-container");
    var imgs = container.find("[n=targetElement] img.csssprite");
    var imageIdx = 0, counter = 0;
    $(imgs).each(function () {
        if (this == $(img)[0]) {
            imageIdx = counter;
        }
        counter++;
    });
    if (imageIdx == 0) {
        return null; // home, no item
    }
    return groupsNearMyDefaultAddress[imageIdx - 1];
}

function handleClickEvent(imgs, url) {
    var image;
    var imageIdx = 0, counter = 0;
    $(imgs).each(function () {
        if ($(this).attr("selected")) {
            removeSelected(this);
        }
        if (url == $(this).attr("src")) {
            addSelected(this);
            image = this;
            imageIdx = counter;
        }
        counter++;
    });

    var latlng = imageIdx == 0 ? null : groupsNearMyDefaultAddress[imageIdx - 1]; //remove the home image
    showToastByLatLngItem(latlng);
}

function showToastByLatLngItem(item) {
    if (item == null) {
        showToast($(".select-group-btns"), "这是您家的位置。", "/assets/home.png", 8000);
    } else {
        var text = "我是{{groupName}}群主，微信号是：{{wechatAccount}}." +
            "我就在您家附近{{distance}}米以内，欢迎加入我的群。";
        text = Mustache.render(text, item);
        showToast($(".select-group-btns"), text, item.organizerHeadImgUrl ? item.organizerHeadImgUrl : "/assets/profile.png", 8000);
    }
}

function loadLxGroupMap(lat, lng) {
    var container = $("#lxgroup-map-container");
    container.html("");
    var center = new qq.maps.LatLng(lat, lng);
    lxGroupMap = new qq.maps.Map(container[0], {
        center: center,
        zoom: 17
    });
    setTimeout(function () {
        var anchor = new qq.maps.Point(20, 20),
            size = new qq.maps.Size(40, 40),
            origin = new qq.maps.Point(0, 0);
        var homeIcon = new qq.maps.MarkerImage("/assets/home.png", size, origin, anchor, size);
        var markers = new Array();
        markers.push(new qq.maps.Marker({
            icon: homeIcon,
            position: center,
            animation: qq.maps.MarkerAnimation.DROP,
            map: lxGroupMap
        }));
        $(groupsNearMyDefaultAddress).each(function () {
            var image = this.organizerHeadImgUrl ? this.organizerHeadImgUrl : "/assets/profile.png";
            var icon = new qq.maps.MarkerImage(image, size, origin, anchor, size);
            markers.push(new qq.maps.Marker({
                icon: icon,
                position: new qq.maps.LatLng(this.lat, this.lng),
                animation: qq.maps.MarkerAnimation.DROP,
                map: lxGroupMap
            }));
        });

        $(markers).each(function (i) {
            qq.maps.event.addListener(markers[i], 'click', function (evt) {
                handleClickEvent(container.find("[n=targetElement] img.csssprite"), evt.target.icon.url);
            });
        });

        setTimeout(function () {
            var container = $("#lxgroup-map-container");
            var imgs = container.find("[n=targetElement] img.csssprite");
            $(imgs).each(function () {
                var item = findItemByImage(this);
                if (item) {
                    $(this).attr("group-id", item.groupId);
                    $(this).parent().addClass("img-circle");
                    if (item.isMyGroup) {
                        $(this).parent().addClass("lxgroup-member");
                    }
                }
            });
        }, 1000)
    }, 500);

}

function removeSelected(elem) {
    $(elem).attr("selected", false);
    $(elem).css("opacity", 0.8);
    $(elem).parent().css("z-index", 0);
    $(elem).parent().animate({top: "+=10px"});
}

function addSelected(elem) {
    $(elem).attr("selected", true);
    $(elem).css("opacity", 1);
    $(elem).parent().css("z-index", 10);
    $(elem).parent().animate({top: "-=10px"});

    var item = findItemByImage(elem);
    if (item) {
        $(elem).css("group-id", item.groupId);
        $(".select-group-btns .join-group").attr("group-id", item.groupId);
        $(".select-group-btns .quit-group").attr("group-id", item.groupId);
        if (item.isMyGroup) {
            $(".select-group-btns .join-group").hide();
            $(".select-group-btns .quit-group").show();
        } else {
            $(".select-group-btns .join-group").show();
            $(".select-group-btns .quit-group").hide();
        }

        //change map center
        lxGroupMap.panTo(new qq.maps.LatLng(item.lat, item.lng));
    } else {
        $(".select-group-btns .join-group").hide();
        $(".select-group-btns .quit-group").hide();
        lxGroupMap.panTo(new qq.maps.LatLng(myLat, myLng));
    }
}

function selectNextGroup() {
    var container = $("#lxgroup-map-container");
    var imgs = container.find("[n=targetElement] img.csssprite");
    var selectedIdx = -1;
    var counter = 0;
    $(imgs).each(function () {
        if ($(this).attr("selected")) {
            selectedIdx = counter;
            removeSelected(this);
        }
        counter++;
    });
    var nextSelectedIdx = selectedIdx + 1 >= imgs.length ? 0 : selectedIdx + 1;
    var image = $(imgs[nextSelectedIdx]);

    var item = findItemByImage(image);
    showToastByLatLngItem(item)
    addSelected(image[0]);
}

function selectPrevGroup() {
    var container = $("#lxgroup-map-container");
    var imgs = container.find("[n=targetElement] img.csssprite");
    var selectedIdx = -1;
    var counter = 0;
    $(imgs).each(function () {
        if ($(this).attr("selected")) {
            selectedIdx = counter;
            removeSelected(this);
        }
        counter++;
    });
    var nextSelectedIdx = selectedIdx - 1 >= 0 ? selectedIdx - 1 : imgs.length - 1;
    var image = $(imgs[nextSelectedIdx]);
    var item = findItemByImage(image);
    showToastByLatLngItem(item)
    addSelected(image[0]);
}

function joinGroup(elem) {
    var groupId = $(elem).attr("group-id");
    toggleLxGroup(joinGroupLink, groupId, function () {
        $("#lxgroup-map-container [group-id=" + groupId + "]").parent().addClass("lxgroup-member");
        $(".select-group-btns .join-group").hide();
        $(".select-group-btns .quit-group").show();
        $("#group-home-panel .enter-my-group").show();
        $(".group-home-btns .quit-group").show();
        $(".group-home-btns .join-group").hide();
    });
}

function quitGroup(elem) {
    var groupId = $(elem).attr("group-id");
    toggleLxGroup(quitGroupLink, groupId, function () {
        $("#lxgroup-map-container [group-id=" + groupId + "]").parent().removeClass("lxgroup-member");
        $(".select-group-btns .join-group").show();
        $(".select-group-btns .quit-group").hide();
        $(".group-home-btns .quit-group").hide();
        $(".group-home-btns .join-group").show();
    });
}

function toggleLxGroup(url, groupId, closure) {
    ajaxPost(url, {groupId: groupId}, function (data) {
        closure.call();
    });
}

function kickMemberOutOfGroup(elem) {
    var groupId = $(elem).attr("group-id");
    var memberId = $(elem).attr("member-id");
    var memberName = $("#lxgroup-detail-panel .name").text();

    $.afui.popup({
        title: "确认",
        message: "你确定要把群成员" + memberName + "踢出群吗?",
        cancelText: "取消",
        cancelCallback: function () {
        },
        doneText: "确定",
        doneCallback: function () {
            $.ajax({
                method: "POST",
                url: kickMemberOutOfGroupLink,
                data: {groupId: groupId, memberId: memberId},
                async: true,
                success: function (data) {
                    if (data.errorcode == 0) {
                        $("#lxgroup-member-detail-panel .quit-group").hide();
                        $("#my-lxgroup-member-list-ul a[member-id=" + memberId + "]").parent().remove();
                        $.afui.goBack();
                        if ($("#my-lxgroup-member-list-ul").children().size() == 0) {
                            $("#my-lxgroup-member-list .no-member").show();
                        }
                    }
                }
            });
        },
        cancelOnly: false
    });
}

function enterMyLxGroupList() {
    ajaxGet(queryGroupLink, {}, function (data) {
        render($("#tpl-my-lxgroup-list-ul"), $("#my-lxgroup-list-ul"), data.model);
    });
}

function enterLxGroupDetail(elem) {
    ajaxGet(getLxGroupInfoLink, {groupId: $(elem).attr("group-id")}, function (data) {
        render($("#tpl-lxgroup-detail-panel"), $("#lxgroup-detail-panel"), data.model);
        $.afui.loadContent("#lxgroup-detail-panel", false, true, "slide");
    });
}

function initGroupMemberPanel() {
    ajaxGet(queryLxGroupMembersLink, {groupId: myGroupId}, function (data) {
        render($("#tpl-my-lxgroup-member-list-ul"), $("#my-lxgroup-member-list-ul"), data.model);
        $("#my-lxgroup-member-list .no-member").hide();
    });
}

function enterLxGroupMemberDetail(elem) {
    ajaxGet(getLxGroupMemberInfoLink, {
        memberId: $(elem).attr("member-id"),
        groupId: $(elem).attr("group-id")
    }, function (data) {
        render($("#tpl-lxgroup-member-detail-panel"), $("#lxgroup-member-detail-panel"), data.model);
        $.afui.loadContent("#lxgroup-member-detail-panel", false, true, "slide");
    });
}

function loadMyCommissionPanel() {
    ajaxGet(queryMyCommissionLink, {}, function (data) {
        render($("#tpl-my-commission-panel"), $("#my-commission-panel"), data.model);
        var extractableAmt = parseFloat($("#my-commission-panel .extractable-amt>.amount").text());
        if (extractableAmt == 0) {
            $("#my-commission-panel a.transfer-to-account").addClass("dim");
            $("#my-commission-panel a.extract").addClass("dim");
        } else {
            $("#my-commission-panel a.transfer-to-account").removeClass("dim");
            $("#my-commission-panel a.extract").removeClass("dim");
        }
    });
}

function loadCommissionHistoryPanel() {
    ajaxGet(queryCommissionHistoryLink, {}, function (data) {
        if (data.model.commissionList.length > 0) {
            render($("#tpl-commission-history-ul"), $("#commission-history-ul"), data.model);
            $("#commission-history-ul .product-amount>.amount").each(function () {
                var value = parseFloat($(this).text());
                if (value > 0) {
                    $(this).text("+￥" + value).addClass("plus");
                } else if (value < 0) {
                    $(this).text("-￥" + (-1*value)).addClass("minus");
                }
            });
            $("#commission-history-ul .product-amount .state").each(function () {
                var value = $(this).text();
                if (value == '已确定' || value == '可提取') {
                    $(this).addClass("confirm");
                } else if (value == '已提取' || value == '已取消') {
                    $(this).addClass("done");
                }
            });
        }
    });
}

function extractCommissionToAccount() {
    var extractableAmt = parseFloat($("#my-commission-panel .extractable-amt>.amount").text());
    if (extractableAmt == 0) return;

    ajaxPost(extractCommissionToAccountLink, {}, function (data) {
        showToast($("a.transfer-to-account"), "已成功将" + data.model.extractedAmount + "元到转入消费账户");
        changeValueTo($("#my-commission-panel .extractable-amt>.amount"), extractableAmt, 0);
        var extractedCommission = parseFloat($("#my-commission-panel .extracted-amt>.amount").text());
        changeValueTo($("#my-commission-panel .extracted-amt>.amount"), extractedCommission, data.model.extractedCommission);
    });
}

function extractCommissionToWeChat() {
    var extractableAmt = parseFloat($("#my-commission-panel .extractable-amt>.amount").text());
    if (extractableAmt == 0) return;

    ajaxPost(extractCommissionToWeChatLink, {}, function (data) {
        showToast($("a.transfer-to-account"), "已成功将" + data.model.extractedAmount + "元到转入微信钱包");
        changeValueTo($("#my-commission-panel .extractable-amt>.amount"), extractableAmt, 0);
        var extractedCommission = parseFloat($("#my-commission-panel .extracted-amt>.amount").text());
        changeValueTo($("#my-commission-panel .extracted-amt>.amount"), extractedCommission, data.model.extractedCommission);
    });
}

function changeValueTo(elem, from, to) {
    var step = (to - from) / 5;
    if (step > 5) step = Math.round(step);
    var counter = from;
    var end = 5;
    for (i = 0; i < end; i++) {
        setTimeout(function () {
            counter += step;
            $(elem).text(Math.round(counter));
        }, i * 100);
    }
    setTimeout(function () {
        $(elem).text(to);
    }, end * 100);
}

function initOrderManagementPanel() {
    var filterForm = $("#filter-form").serialize();
    filterForm += "&groupId=" + myGroupId;
    ajaxGet(queryLxGroupDeliveriesLink, filterForm, function (data) {
        render($("#tpl-lxgroup-delivery-list"), $("#lxgroup-delivery-list"), data.model);
    });
}

function initLxGroupDeliveryDetailPanel(elem){
    var deliveryId = $(elem).attr("delivery-id");
    ajaxGet(queryLxGroupDeliveryDetailLink, {deliveryId: deliveryId}, function (data) {
        render($("#tpl-lxgroup-delivery-detail"), $("#lxgroup-delivery-detail"), data.model);
    });
}

function customerGotTheProduct(elem){
    var orderId = $(elem).attr("order-id");
    ajaxGet(customerGotTheProductLink, {orderId: orderId}, function (data) {
        $("#lxgroup-delivery-orders-list li.order-" + orderId + " a.customer-got-the-product").hide();
    });
}