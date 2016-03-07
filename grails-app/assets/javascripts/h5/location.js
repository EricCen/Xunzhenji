/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

var latitude;
var longitude;
var speed;
var accuracy;

function getLocation() {
    wx.getLocation({
        success: function (res) {
            info("Get location success");
            latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
            longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
            speed = res.speed; // 速度，以米/每秒计
            accuracy = res.accuracy; // 位置精度
            updateLocation(latitude, longitude, speed, accuracy);
            setCookie('latitude', latitude, 1);
            setCookie('longitude', longitude, 1);
        }
    });
}

function updateLocation(latitude, longitude, speed, accuracy) {
    info("Start to update location, latitude: " + latitude + ", longitude: " + longitude)
    $.ajax({
        url: locationLink, async: true, type: 'get',
        data: {latitude: latitude, longitude: longitude, speed: speed, accuracy: accuracy},
        cache: false,
        dataType: 'json',
        success: function (data) {
            if (data.errorcode == 0) {
                while (postLocationCheckAction.length > 0) {
                    postLocationCheckAction.pop().call();
                }

                if (data.model && data.model.districtId) {
                    province = data.model.province;
                    city = data.model.city;
                    district = data.model.district;
                    districtId = data.model.districtId;
                    info("User location is " + province + city + district)
                }
            }
        },
        error: function () {
        }
    });
}

function toRad(d) {
    return d * Math.PI / 180;
}
function getDistance(lat1, lng1, lat2, lng2) {
    var dis = 0;
    var radLat1 = toRad(lat1);
    var radLat2 = toRad(lat2);
    var deltaLat = radLat1 - radLat2;
    var deltaLng = toRad(lng1) - toRad(lng2);
    var dis = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(deltaLat / 2), 2) + Math.cos(radLat1) * Math.cos(radLat2) * Math.pow(Math.sin(deltaLng / 2), 2)));
    return dis * 6378137;
}

function formatDistance(distance) {
    if (distance > 1000) {
        return Math.round(distance / 1000) + '公里';
    }
    return Math.round(distance) + '米';
}