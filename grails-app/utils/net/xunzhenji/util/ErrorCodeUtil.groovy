/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.util

import grails.converters.JSON
import org.apache.log4j.LogManager
import org.springframework.validation.FieldError

class ErrorCodeUtil {
    def static log = LogManager.getLogger(ErrorCodeUtil)
    public static final int ERROR_CODE_NO_ERROR = 0;
    public static final int ERROR_CODE_INVALID_MOBILE_CODE = -1;
    public static final int ERROR_CODE_INVALID_RANDOM_CODE = -2;
    public static final int ERROR_CODE_ACTION_NOT_ALLOW = -3;
    public static final int ERROR_CODE_NO_ADDRESS_FOUND = -4;
    public static final int ERROR_CODE_NO_MOBILE_NUM = -5;
    public static final int ERROR_CODE_GENERATE_WX_PREORDER_FAIL = -6;
    public static final int ERROR_CODE_USER_NOT_YET_LOGIN = -7;
    public static final int ERROR_CODE_SHOPPINGCART_EMPTY = -8;
    public static final int ERROR_CODE_REFUND_FAILURE = -9;
    public static final int ERROR_CODE_NO_ORDER_FOUND = -10;
    public static final int ERROR_CODE_NO_AMOUNT_FOR_REFUND = -11;
    public static final int ERROR_CODE_FAIL_TO_GENERATE_PAY_BODY = -12;
    public static final int ERROR_CODE_FIELD_ERROR = -13;
    public static final int ERROR_CODE_NO_GROUP_FOUND = -14;
    public static final int ERROR_CODE_NO_MEMBER_IN_GROUP_FOUND = -15;
    public static final int ERROR_CODE_EXTRACT_COMMISSION_FAIL = -16;
    public static final int ERROR_CODE_LXGROUP_DOESNT_HAVE_DELIVER_DATE = -17;
    public static final int ERROR_CODE_NO_PAYMENT_FOUND = -18;
    public static final int ERROR_CODE_NO_LX_GROUP_NEARBY = -19;
    public static final int ERROR_CODE_MOBILE_IS_REGISTERED = -20;
    public static final int ERROR_CODE_WRONG_DELIVERY_DATE = -21;
    public static final int ERROR_CODE_CANNOT_PAYFOR_MISSING_INFO_ORDER = -22;
    public static final int ERROR_CODE_USER_NOT_YET_REGISTER = -23;

    public static final int ERROR_CODE_PAYMENT_FAIL = -22;

    public static final int ERROR_CODE_INVALID_PROMOTION_CODE = -23;

    public static final int ERROR_CODE_UNKNOWN = -999;

    def static logAndReturn = {err->
        log.error("code: ${err.errorcode}, ${err.errormsg}")
        return err as JSON
    }

    public static noError(){
        return [errorcode:ERROR_CODE_NO_ERROR, errormsg:"Ok"] as JSON
    }

    public static noError(model){
        return [errorcode:ERROR_CODE_NO_ERROR, errormsg:"Ok", model:model] as JSON
    }

    public static mobileIsRegistered(model){
        return [errorcode:ERROR_CODE_MOBILE_IS_REGISTERED, errormsg:"Mobile is registered", model:model] as JSON
    }

    public static invalidMobileCode(){
        logAndReturn([errorcode:ERROR_CODE_INVALID_MOBILE_CODE, errormsg:"Mobile code not match"])
    }

    public static noMobileNum(){
        logAndReturn([errorcode:ERROR_CODE_NO_MOBILE_NUM, errormsg:"No mobile num"])
    }

    public static invalidRandomCode(){
        logAndReturn([errorcode:ERROR_CODE_INVALID_RANDOM_CODE, errormsg:"Random code not match"])
    }

    public static actionNotAllow(){
        logAndReturn([errorcode:ERROR_CODE_ACTION_NOT_ALLOW, errormsg:"Action not allow"])
    }

    public static noAddressFound(){
        logAndReturn( [errorcode:ERROR_CODE_NO_ADDRESS_FOUND,
                       errormsg:"您还没有添加地址,可以在${link('#address-panel','左侧菜单->我的账号->地址薄')}里面添加。"])
    }

    public static link(anchor, value){
        "<a onclick=\"goto('${anchor}')\"><strong>${value}</strong></a>"
    }
    public static failToGenWxPreOrder(){
        logAndReturn(  [errorcode:ERROR_CODE_GENERATE_WX_PREORDER_FAIL, errormsg:"Generate WX pre-order fail"])
    }

    public static userNotYetLogin(){
        logAndReturn(  [errorcode:ERROR_CODE_USER_NOT_YET_LOGIN, errormsg:"User not yet login"])
    }

    public static shoppingCartEmpty(){
        return [errorcode:ERROR_CODE_SHOPPINGCART_EMPTY, errormsg:"Shopping cart empty"] as JSON
    }

    public static refundFail(){
        logAndReturn(  [errorcode:ERROR_CODE_REFUND_FAILURE, errormsg:"Refund failure"])
    }

    public static noOrderFound(){
        logAndReturn(  [errorcode:ERROR_CODE_NO_ORDER_FOUND, errormsg:"No order found"])
    }

    public static noAmountForRefund(){
        logAndReturn( [errorcode:ERROR_CODE_NO_ORDER_FOUND, errormsg:"No amount for refund"])
    }

    public static failToGeneratePayBody(){
        logAndReturn( [errorcode:ERROR_CODE_FAIL_TO_GENERATE_PAY_BODY, errormsg:"Fail to generate pay body"])
    }

    public static fieldError(errfield, errmsg){
        logAndReturn( [errorcode:ERROR_CODE_FIELD_ERROR, errfield: errfield, errormsg:errmsg])
    }

    public static fieldCode(FieldError e){
        def domain = e.objectName.substring(e.objectName.lastIndexOf('.') + 1)
        domain = domain.substring(0,1).toLowerCase() + domain.substring(1,domain.length())
        "${domain}.${e.field}.label"
    }

    public static unknownError(){
        logAndReturn( [errorcode:ERROR_CODE_UNKNOWN, errormsg:"Unknown error"])
    }

    public static noGroupFound(){
        logAndReturn( [errorcode:ERROR_CODE_NO_GROUP_FOUND, errormsg:"No group found"])
    }

    public static noMemberInGroupFound(){
        logAndReturn( [errorcode:ERROR_CODE_NO_MEMBER_IN_GROUP_FOUND, errormsg:"No member in group found"])
    }

    public static extractCommissionFail(){
        logAndReturn( [errorcode:ERROR_CODE_EXTRACT_COMMISSION_FAIL, errormsg:"Extract commission fail"])
    }

    public static lxGroupDoesntHaveDeliveryDate(){
        logAndReturn( [errorcode:ERROR_CODE_LXGROUP_DOESNT_HAVE_DELIVER_DATE, errormsg:"LxGroup doesn't have delivery date"])
    }

    public static wrongDeliveryDate(){
        logAndReturn( [errorcode:ERROR_CODE_WRONG_DELIVERY_DATE, errormsg:"Wrong delivery date"])
    }

    public static noPaymentFound(){
        logAndReturn( [errorcode:ERROR_CODE_NO_PAYMENT_FOUND, errormsg:"No payment found"])
    }

    public static noLxGroupNearby(){
        logAndReturn([errorcode:ERROR_CODE_NO_LX_GROUP_NEARBY, errormsg:"你附近还没有领鲜群，自己建一个吧!"])
    }

    public static paymentFail(){
        logAndReturn([errorcode:ERROR_CODE_PAYMENT_FAIL, errormsg:"支付失败"])
    }

    public static invalidPromotionCode(){
        logAndReturn([errorcode: ERROR_CODE_INVALID_PROMOTION_CODE, errormsg: "特权码无效"])
    }

    public static cannotPayForMissingInfoOrder() {
        logAndReturn([errorcode: ERROR_CODE_CANNOT_PAYFOR_MISSING_INFO_ORDER, errormsg: "支付失败"])
    }

    public static userNotYetRegister() {
        logAndReturn([errorcode: ERROR_CODE_USER_NOT_YET_REGISTER, errormsg: "用户还没有注册"])
    }
}
