%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<script>
    var homeLink = '${createLink(controller: "h5", action: "home")}';
    var jsApiLink = '${createLink(controller: "session", action: "bindWxJsApi")}';
    var locationLink = '${createLink(controller: "location", action: "update")}';
    var updateShoppingCartLink = '${createLink(controller: "h5", action: 'updateShoppingCart')}';
    var initSessionLink = '${createLink(controller: "session", action: "initSession")}';
    var queryShoppingCartLink = '${createLink(controller: "h5", action: "queryShoppingCart")}'
    var queryOrdersLink = '${createLink(controller: 'h5', action: 'queryOrders')}';
    var confirmOrderLink = '${createLink(controller: 'h5', action: 'confirmOrder')}';
    var refundLink = '${createLink(controller: 'h5', action: 'refund')}';
    var validateMobileLink = '${createLink(controller: "captcha", action: "genMobileCode")}';
    var checkCodeLink = '${createLink(controller: "captcha", action: "checkMobileCode")}';
    var checkRandomCodeLink = '${createLink(controller: "captcha", action: "checkRandomCode")}';
    var checkMobileCodeLink = '${createLink(controller: "captcha", action: "checkMobileCode")}';
    var addUserInfoLink = '${createLink(controller: "session", action: "addUserInfo")}';
    var userAuthLink = '${createLink(controller: "session", action: "auth")}'
    var querySuggestionLink = '${createLink(controller: "h5", action: "querySuggestion")}';
    var queryAboutLink = '${createLink(controller: "h5", action: "queryAbout")}';
    var submitSuggestionLink = '${createLink(controller: "h5", action: "submitSuggestion")}';
    var snsUserInfoLink = '${createLink(controller: "session", action: "snsapiUserInfo")}';
    var clientLogInfoLink = '${createLink(controller: "clientLog", action: "log")}'
    var getCityLink = '${createLink(controller: "address", action: "listSupportCities")}';
    var getDistrictLink = '${createLink(controller: "address", action: "getDistricts")}';
    var listAddressLink = '${createLink(controller: "address", action: "listAddress")}'
    var updateDefaultLink = '${createLink(controller: "h5", action: "useAddress")}';
    var deleteAddressLink = '${createLink(controller: "address", action: "deleteAddress")}';
    var payForShoppingCartLink = '${createLink(controller: "h5", action: "payForShoppingCart")}';
    var submitOrdersLink = '${createLink(controller: "h5", action: "submitOrders", absolute: true)}';
    var payLink = '${createLink(controller: "h5", action: "pay", absolute: true)}';
    var paymentSuccessLink = '${createLink(controller: "h5", action: "paymentSuccess", absolute: true)}';
    var convertLocationLink = '${createLink(controller: "location", action: "convertFromAddress")}';
    var editGroupLink = '${createLink(controller: "h5", action: "editGroupInfo")}';
    var queryGroupLink = '${createLink(controller: "h5", action: "queryMyGroup")}';
    var queryGroupsNearByLink = '${createLink(controller: "h5", action: "queryGroupsNearBy")}';
    var joinGroupLink = '${createLink(controller: "h5", action: "joinGroup")}';
    var quitGroupLink = '${createLink(controller: "h5", action: "quitGroup")}';
    var getLxGroupInfoLink = '${createLink(controller: "h5", action: "getLxGroupInfo")}';
    var queryLxGroupMembersLink = '${createLink(controller: "h5", action: "queryLxGroupMembers")}';
    var getLxGroupMemberInfoLink='${createLink(controller: "h5", action: "getLxGroupMemberInfo")}';
    var kickMemberOutOfGroupLink ='${createLink(controller: "h5", action: "kickMemberOut")}';
    var queryMyCommissionLink = '${createLink(controller: "h5", action: "queryMyCommission")}';
    var queryCommissionHistoryLink = '${createLink(controller: "h5", action: "queryCommissionHistory")}';
    var extractCommissionToAccountLink = '${createLink(controller: "h5", action: "extractCommissionToAccount")}';
    var extractCommissionToWeChatLink = '${createLink(controller: "h5", action: "extractCommissionToWeChat")}';
    var updateGroupAddressLink = '${createLink(controller: "h5", action: "updateGroupAddress")}';
    var queryLxGroupOrdersLink = '${createLink(controller: "h5", action: "queryLxGroupOrders")}';
    var queryOrderDetailLink = '${createLink(controller: "h5", action: "queryOrderDetail")}';
    var confirmDeliveryDateLink = '${createLink(controller: "h5", action: "confirmDeliveryDate")}';
    var queryLxGroupDeliveriesLink = '${createLink(controller: "h5", action: "queryLxGroupDeliveries")}';
    var queryLxGroupDeliveryDetailLink = '${createLink(controller: "h5", action: "queryLxGroupDeliveryDetail")}';
    var customerGotTheProductLink = '${createLink(controller: "h5", action: "customerGotTheProduct")}';
    var confirmArrivalLink = '${createLink(controller: "h5", action: "completeDelivery")}';
    var queryMyAccountLink = '${createLink(controller: "h5", action: "queryMyAccount")}';
    var depositLink = '${createLink(controller: "h5", action: "deposit", absolute: true)}';
    var depositSuccessLink = '${createLink(controller: "h5", action: "depositSuccess", absolute: true)}';
    var queryDepositRecordsLink = '${createLink(controller: "h5", action: "queryDepositRecords")}';
    var queryProductByCategoryLink = '${createLink(controller: "h5", action: "queryProductByCategory")}';
    var updateOrderAddressLink = '${createLink(controller: "h5", action: "updateOrderAddress")}';
    var shareToFriendsLink = '${createLink(controller: "h5", action: "shareToFriends")}';
    var shareToTimelineLink = '${createLink(controller: "h5", action: "shareToTimeline")}';
    var cancelShareToFriendsLink = '${createLink(controller: "h5", action: "cancelSharingToFriends")}';
    var cancelShareToTimelineLink = '${createLink(controller: "h5", action: "cancelSharingToTimeline")}';
    var confirmDeliveryLink = '${createLink(controller: "h5", action: "confirmDelivery")}';
    var alipayLink = '${createLink(controller: "h5", action: "alipay")}';
    var refreshOrderPrice = '${createLink(controller: "h5", action: "refreshOrderPrice")}';
    var wechatpayLink = '${createLink(controller: "h5", action: "processWechatPay")}';

    //asset
    var locationPng = '${assetPath(src: "location.png")}';

    //farm2shop
    var queryShopsLink = '${createLink(controller: "shop", action: "queryShops")}';
    var queryShopProductsLink = '${createLink(controller: "shop", action: "queryShopProducts")}';
    var submitOrderLink = '${createLink(controller: "shopOrder", action: "createOrder")}';
    var addProcurementLink = '${createLink(controller: "workflow", action: "addProcurement")}';
    var getProductListLink = '${createLink(controller: "shopProduct", action: "getProductList")}';
    var addSourceLink = '${createLink(controller: "workflow", action: "addSource")}';
    var addManufactureLink = '${createLink(controller: "workflow", action: "addManufacture")}';
    var addDeliveryLink = '${createLink(controller: "workflow", action: "addDelivery")}';
    var getManufactureList = '${createLink(controller: "workflow", action: "getManufactureList")}';
    var getDeliveryList = '${createLink(controller: "workflow", action: "getShopDeliveryList")}';
    var getProcurementList = '${createLink(controller: "workflow", action: "getProcurementList")}';
</script>