/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

function queryGroupsNearBy(productId){
    $.ajax({
        method: "GET",
        url: queryGroupsNearByLink,
        data: {productId:productId, size: 4},
        success:function(data){
            if(data.errorcode ==0) {
                render($("#tpl-groups-nearby"), $("#product_" + productId + " .groups-nearby"), data.model);
                $("#product_" + productId + " section.groups-nearby-block").show();
            }else{
                $("#product_" + productId + " section.groups-nearby-block").hide();
            }
        }
    });
}

function queryProductByCategory(elem){
    var categoryId = $(elem).attr("category-id");
    ajaxGet(queryProductByCategoryLink, {categoryId: categoryId}, function(data){

    });
}

function loadTab(elem, hash){
    $(elem).parent().find(".active").removeClass("active");
    $(elem).addClass("active");
    $(elem).parents(".row").find(".tab-content.active").removeClass("active");
    var activeTab = $(elem).parents(".row").find("." + hash);
    activeTab.addClass("active");
    if(!activeTab.html().trim()){
        var link = $(elem).attr("data-link");
        $(activeTab).load(link, {}, function(){
            $(elem).parents(".panel").scrollTo(elem);
        });
    }
}

function updateDistance(producerLatitude, producerLongitude) {
    var lat = latitude ? latitude : getCookie("latitude");
    var lnt = longitude ? longitude : getCookie("longitude");
    if (lat && lnt) {
        var distance = getDistance(lat, lnt, producerLatitude, producerLongitude);
        if(distance){
            $('.producer-distance').html('离您的位置直线距离约' + formatDistance(distance));
        }
    } else {
        if (postLocationCheckAction.length == 0) {
            postLocationCheckAction.push(updateDistance);
        }
    }
}

function initMap(activePanel, latitude, longitude) {
    getLocation();
    var center = new qq.maps.LatLng(latitude, longitude);
    var myOptions = {
        zoom: 13,
        center: center,
        mapTypeId: qq.maps.MapTypeId.HYBRID
    };
    var map = new qq.maps.Map($(activePanel).find(".map")[0], myOptions);
    var marker = new qq.maps.Marker({
        position: center,
        map: map
    });

    marker.setVisible(true);
    marker.setAnimation(qq.maps.MarkerAnimation.DOWN);
    var anchor = new qq.maps.Point(0, 39),
        size = new qq.maps.Size(42, 68),
        origin = new qq.maps.Point(0, 0),
        icon = new qq.maps.MarkerImage(locationPng, size, origin, anchor);
    marker.setIcon(icon);
}
