/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 *
 */

var provinces = new Object();
var provinceList = new Array();
var province,city, district, districtId;;
var returnPanel;
var returnCallback;

function loadAddress(){
    ajaxGet(listAddressLink, {}, function(data){
        render($("#tpl-address-row"), $("#address-rows"), data.model);
        if(data.model.addressList.length > 0){
            $(".add-address-btn a.confirm-btn").removeClass("invalid");
        }
    });
}

function loadOrderAddress(){
    returnPanel = "confirm-order-panel";
    returnCallback = function (addressId, orderIds) {
        updateDefaultAddress(addressId, orderIds);
    }
    loadAddress();
}

function loadMyAccountAddress(){
    returnPanel = "my-account-panel";
    returnCallback = function (addressId, orderIds) {
        updateDefaultAddress(addressId, orderIds);
    }
    loadAddress();
}

function loadLxGroupAddress(){
    returnPanel = "edit-group-panel";
    returnCallback = function (addressId,orderIds) {
        if(myGroupId){
            ajaxPost(updateGroupAddressLink, {addressId: addressId, groupId: groupId}, function(data){
                if(returnPanel){
                    $.afui.loadContent("#" + returnPanel, false, false, "slide", "#address-view");
                }else{
                    $.afui.loadContent("#main", false, false, "slide");
                }
            });
        }else{
            $.afui.loadContent("#" + returnPanel, false, false, "slide");
        }
    }
    loadAddress();
}

function loadChangeOrderAddress(elem){
    var orderId = $(elem).attr("orderId");

    returnPanel = "listOrder";
    returnCallback = function (addressId, orderIds) {
        updateOrderAddress(orderId, addressId);
    }
    loadAddress();
}

function removeAddressRow(id){
    var row = $('.address-list').find('[address-id='+id+']');
    row.remove();
    if($('.show-address').attr('address-id') == id){
        $('.show-address .address-name').html('');
        $('.show-address .address-phone').html('');
        $('.show-address .address-address').html('');
        $('.show-address').attr('address-id', '');
        $('.show-address').hide();
        $('.add-address-text').show();
    }

    if($("#address-rows .address-row").length == 0){
        $(".add-address-btn a.confirm-btn").addClass("invalid");
    }
}

function updateAddressRow(id, name, phone, province, city, district, districtId, street, address){
    var row = $('.address-list').find('[address-id='+id+']');
    $(row).attr('district-id',districtId);
    $(row).find('.address-name').html(name);
    $(row).find('.address-phone').html(phone);
    $(row).find('.address-address').attr('province', province).attr('city', city).attr('district',district).attr('street', street).attr('address', address);
    $(row).find('.address-detail').html(city + district +(street?street:"") + address);
}

function editAddress(){
    unloadAddressPanel();
    var row = $(event.target).parents('.address-row');
    var name = row.find('.address-name').text();
    var phone = row.find('.address-phone').text();
    var addressId = row.attr('address-id');
    var districtId = row.attr('district-id');
    var province = row.find('.address-address').attr('province');
    var city = row.find('.address-address').attr('city');
    var district = row.find('.address-address').attr('district');
    var street = row.find('.address-address').attr('street');
    var address = row.find('.address-address').attr('address');
    var latitude = row.attr('latitude');
    var longitude = row.attr('longitude');
    setAddressForm(addressId, districtId, name ,phone, city+district, street, address, latitude, longitude);
    getCities();
    validateAddressForm();
    $('[role=deleteAddress]').show();
}

function setAddressForm(addressId, districtId, name, phone, city, street, address, latitude, longitude){
    var form = $('.edit-address-form');
    form.find('#address_id').val(addressId);
    form.find('#district_id').val(districtId);
    if(name){
        form.find('#name').val(name);
    }else if(userName){
        form.find('#name').val(userName);
    }
    if(phone){
        form.find('#phone').val(phone);
    }else if(userMobile){
        form.find('#phone').val(userMobile);
    }
    form.find('#city').val(city);
    form.find('#street').val(street);
    form.find('#address').val(address);
    form.find('#latitude').val(latitude);
    form.find('#longitude').val(longitude);
}

function validateAddressForm(){
    var form = $('.edit-address-form');
    var name = form.find('#name').val();
    var phone = form.find('#phone').val();
    var district = form.find('#district_id').val();
    var address = form.find('#address').val();
    if(name&&phone&&district&&address){
        $('[role=selectLocation]').removeClass('invalid');
        return true;
    }else{
        $('[role=selectLocation]').addClass('invalid');
        return false;
    }
}

function clearAddressForm(){
    var form = $('.edit-address-form');
    var name = form.find('#name').val();
    var phone = form.find('#phone').val();
    if(districtId){
        setAddressForm('',districtId,name,phone,province+city+district,'','', '', '');
    }else{
        setAddressForm('','',name,phone,'','','', '', '');
    }
}

function selectAddress(event){
    updateDftAddress(event.currentTarget);
}

function updateDftAddress(elem) {
    $("#address-panel li.address-row .select-box").removeClass("is-dft").html('<i class="fa fa-circle-o"></i>');
    $(elem).addClass("is-dft").html('<i class="fa fa-check-circle"></i>');
}

function confirmAddress(){
    var addressRow = $("#address-panel li.address-row .select-box.is-dft").parents('.address-row');

    if(addressRow.length == 0 ){
        return
    }
    var addressId = addressRow.attr('address-id');
    var orderIds = $('#order-payment .order-id').val();
    var name = addressRow.find('.address-name').text();
    var phone = addressRow.find('.address-phone').text();
    var address = addressRow.find('.address-detail').text();
    $('#' + returnPanel + ' .show-address .address-name').html(name);
    $('#' + returnPanel + ' .show-address .address-phone').html(phone);
    $('#' + returnPanel + ' .show-address .address-address').html(address);
    $('#' + returnPanel + ' .show-address').attr('address-id', addressId);
    $('#' + returnPanel + ' input.addressId').val(addressId);
    $('#' + returnPanel + ' .show-address').show();
    $('#' + returnPanel + ' .add-address-text').hide();

    if(addressRow.find(".show-address").attr("is-group")){
        $('#' + returnPanel + ' .receiver-name').hide();
        $('#' + returnPanel + ' .lxgroup-name').show()
    }else{
        $('#' + returnPanel + ' .receiver-name').show();
        $('#' + returnPanel + ' .lxgroup-name').hide();
        var input = $('#' + returnPanel + ' input#promotionCode1');
        input.val("");
    }
    returnCallback.call(event, addressId, orderIds)
}

function updateDefaultAddress(addressId, orderIds){
    ajaxGet(updateDefaultLink, {addressId:addressId, orderIds:orderIds}, function(data){
        if(returnPanel){
            $.afui.loadContent("#" + returnPanel, false, true, "slide-reveal:dismiss");
        }else{
            $.afui.loadContent("#main", false, true, "slide-reveal:dismiss");
        }
        var input = $('#' + returnPanel + ' input#promotionCode1');
        refreshPrice($(input).parent().find("a"));
    });
}

function addAddress(){
    unloadAddressPanel();
    clearAddressForm();
    getCities();
    $('[role=deleteAddress]').hide();

    $.afui.loadContent("#addAddress", false, true, "slide");
}

function getCities(){
    if(!Object.keys(provinces).length){
        $.get(getCityLink, function(data){
            $.each(data, function(){
                if(!provinces[this.province]){
                    provinces[this.province] = new Object();
                }
                provinces[this.province][this.city] = {id:this.id, district: new Array()};
            });
            for (var key in provinces) {
                if (provinces.hasOwnProperty(key)) {
                    provinceList.push({name:key});
                }
            }
            render($('#tpl-provinces'), $(".list-group.provinces"), {provinceList:provinceList});
        });
    }
}

function clickProvince(evt){
    $('.cities').html('');
    province = $(evt.target).text();
    var cities = provinces[province];

    var cityList = new Array();
    for (var key in cities) {
        if (cities.hasOwnProperty(key)) {
            cityList.push({name:key, id:cities[key].id});
        }
    }
    render($('#tpl-cities'), $(".list-group.cities"), {cityList:cityList});
    $.afui.loadContent("#select-cities", false, true, "slide");
}

function clickCity(evt){
    city = $(evt.target).text();
    var cityId = $(evt.target).attr('id');
    var cityObject = provinces[province][city];
    $('.districts').html('');
    if(cityObject['district'].length>0){
        var districts = cityObject['district'];
        var districtList = new Array();
        for (var key in districts) {
            districtList.push(districts[key]);
        }
        render($('#tpl-districts'), $(".list-group.districts"), {districtList:districtList});
        $.afui.loadContent("#select-districts", false, true, "slide");
    }else{
        $.get(getDistrictLink+'?cityId='+cityId, function(data){
            var districts = cityObject['district'];
            var districtList = new Array();
            $.each(data, function(){
                districts.push({district:this.district, id:this.id});
                districtList.push(this);
            });
            render($('#tpl-districts'), $(".list-group.districts"), {districtList:districtList});
            $.afui.loadContent("#select-districts", false, true, "slide");
        });
    }
}

function clickDistrict(evt){
    district = $(evt.target).text();
    var districtId = $(evt.target).attr('id');
    $('#district_id').val(districtId);
    $('.city').val(province + city + district);
    $('.city').attr("province", province).attr("city", city).attr("district", district);
    validateAddressForm();
    $.afui.clearHistory()
    $.afui.loadContent("#addAddress", false, true, "slide");
}

function selectLocation(){
    if(!validateAddressForm()){return;}

    var latitude = $('.edit-address-form input#latitude').val();
    var longitude = $('.edit-address-form input#longitude').val();

    if(latitude && latitude) {
        loadAddressMap(parseFloat(latitude), parseFloat(longitude));
        $.afui.loadContent("#select-location", false, true, "slide");
        return;
    }
    var province = $('.city').attr("province");
    var city = $('.city').attr("city");
    var district = $('.city').attr("district");
    var street = $('#street').val();
    var address = $('#address').val();
    ajaxPost(convertLocationLink, {province:province, city:city, district: district, street:street, address:address}, function(data){
        var model = data.model;
        loadAddressMap(model.lat, model.lng);
    });
}

function loadAddressMap(lat, lng) {
    var container = $("#map-container");
    container.parents(".panel").css("padding", 0);
    container.html("");
    $('.edit-address-form input#latitude').val(lat);
    $('.edit-address-form input#longitude').val(lng);
    $("footer").hide();
    $.afui.setBackButtonVisibility(false);
    var map = new qq.maps.Map(container[0],{
        center: new qq.maps.LatLng(lat,lng),
        zoom: 16
    });
    qq.maps.event.addListener(map, 'center_changed', function() {
        var center = map.getCenter();
        var lat = center.getLat();
        var lng = center.getLng();
        $('.edit-address-form input#latitude').val(lat);
        $('.edit-address-form input#longitude').val(lng);
    });
    $("#menubadge").hide();
    $("a#save-address").show();
    $.afui.loadContent("#select-location", false, true, "slide");
}

function saveAddress(){
    if(!validateAddressForm()) return;

    var province = $('.city').attr("province");
    var city = $('.city').attr("city");
    var district = $('.city').attr("district");
    var street = $('#street').val();
    var address = $('#address').val();
    ajaxPost(convertLocationLink, {
        province: province,
        city: city,
        district: district,
        street: street,
        address: address
    }, function (data) {
        var model = data.model;
        $('.edit-address-form input#latitude').val(model.lat);
        $('.edit-address-form input#longitude').val(model.lng);

        $("#menubadge").show();
        $("a#save-address").hide();
        $.afui.setBackButtonVisibility(true);
        $.afui.clearHistory()

        var data = $('.edit-address-form').serialize();
        var url = $('.edit-address-form').attr('action');

        ajaxPost(url, data, function (data) {
            var model = data.model;
            if ($('.address-list').find('[address-id=' + model.id + ']').length) {
                updateAddressRow(model.id, model.name, model.phone, model.province, model.city, model.district, model.district_id, model.street, model.address);
            } else {
                $("#address-panel li.address-row .select-box").removeClass("is-dft").html('<i class="fa fa-circle-o"></i>');
                renderPrepend($("#tpl-address-row"), $("#address-rows"), {addressList: data.model})
            }

            $(".add-address-btn a.confirm-btn").removeClass("invalid");
            $.afui.loadContent("#address-panel", false, true, "slide");
            clearAddressForm();
        });
    });
}

function deleteAddress(){
    var addressId = $('.edit-address-form').find('#address_id').val();
    ajaxPost(deleteAddressLink, {id:addressId}, function(data){
        removeAddressRow(data.model.id);
        $.afui.loadContent("#address-panel", false, true, "slide");
        clearAddressForm();
        $('[role=deleteAddress]').hide();
        $.afui.clearHistory();
    });
}

function backToReturnPanel(elem){
    var view = $(elem).parent().closest(".view");
    view.removeClass("active");
    view.find(".panel").removeClass("active");

    $.afui.clearHistory();
    $.afui.loadContent("#"+ returnPanel, false, false, "slide-reveal:dismiss");
}

function loadAddressPanel(){
    $("#add-address").show();
    $("#close-address").show();
}

function unloadAddressPanel(){
    $("#add-address").hide();
    $("#close-address").hide();
}